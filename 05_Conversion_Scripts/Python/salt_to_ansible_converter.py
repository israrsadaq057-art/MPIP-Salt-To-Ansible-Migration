#!/usr/bin/env python3
# salt_to_ansible_converter.py
# Israr Sadaq - Network Engineer
# Converts Salt states to Ansible playbooks
# Works for most common Salt modules

import os
import yaml
import sys
from pathlib import Path

def parse_salt_state(state_file):
    """Read a .sls file and return the data"""
    try:
        with open(state_file, 'r') as f:
            data = yaml.safe_load(f)
        return data
    except Exception as e:
        print(f"Error reading {state_file}: {e}")
        return None

def convert_pkg_installed(name, config):
    """pkg.installed -> apt/yum"""
    pkg_name = config.get('name', name)
    if isinstance(pkg_name, list):
        return {
            'name': f'Install packages: {", ".join(pkg_name)}',
            'package': {'name': pkg_name, 'state': 'present'}
        }
    else:
        return {
            'name': f'Install {pkg_name}',
            'package': {'name': pkg_name, 'state': 'present'}
        }

def convert_service_running(name, config):
    """service.running -> systemd"""
    service_name = config.get('name', name)
    return {
        'name': f'Ensure {service_name} is running',
        'systemd': {'name': service_name, 'state': 'started', 'enabled': True}
    }

def convert_file_managed(name, config):
    """file.managed -> template or copy"""
    dest = config.get('name', name)
    source = config.get('source', '')
    
    if '.j2' in source or 'template' in str(config):
        return {
            'name': f'Configure {dest}',
            'template': {
                'src': source.replace('salt://', ''),
                'dest': dest
            }
        }
    else:
        return {
            'name': f'Copy {dest}',
            'copy': {
                'src': source.replace('salt://', ''),
                'dest': dest
            }
        }

def convert_user_present(name, config):
    """user.present -> user module"""
    return {
        'name': f'Create user {name}',
        'user': {
            'name': name,
            'state': 'present',
            'groups': config.get('groups', '').split(',') if 'groups' in config else [],
            'shell': config.get('shell', '/bin/bash')
        }
    }

def convert_cmd_run(name, config):
    """cmd.run -> command module"""
    return {
        'name': f'Run command: {name}',
        'command': config.get('cmd', name)
    }

def convert_cron_present(name, config):
    """cron.present -> cron module"""
    return {
        'name': f'Add cron job: {name}',
        'cron': {
            'name': name,
            'job': config['cmd'],
            'minute': config.get('minute', '*'),
            'hour': config.get('hour', '*'),
            'day': config.get('day', '*'),
            'month': config.get('month', '*'),
            'weekday': config.get('weekday', '*')
        }
    }

# Mapping table
conversion_map = {
    'pkg.installed': convert_pkg_installed,
    'service.running': convert_service_running,
    'file.managed': convert_file_managed,
    'user.present': convert_user_present,
    'cmd.run': convert_cmd_run,
    'cron.present': convert_cron_present,
}

def convert_salt_state(salt_file, ansible_roles_dir):
    """Convert one Salt state to Ansible role"""
    salt_data = parse_salt_state(salt_file)
    if not salt_data:
        return False
    
    # Determine role name from path
    role_name = salt_file.parent.name
    if role_name == 'init.sls':
        role_name = salt_file.parent.parent.name
    
    role_dir = Path(ansible_roles_dir) / role_name / 'tasks'
    role_dir.mkdir(parents=True, exist_ok=True)
    
    tasks = []
    for state_name, state_config in salt_data.items():
        for module, config in state_config.items():
            if module in conversion_map:
                task = conversion_map[module](state_name, config)
                tasks.append(task)
    
    if tasks:
        task_file = role_dir / 'main.yml'
        with open(task_file, 'w') as f:
            yaml.dump(tasks, f, default_flow_style=False)
        print(f"✅ Converted: {salt_file} -> {role_name}")
        return True
    else:
        print(f"⚠️ Skipped: {salt_file} (no convertible modules)")
        return False

def main():
    salt_path = '/srv/salt'  # Change this for testing
    ansible_roles = './06_Ansible_Roles'
    
    if not os.path.exists(salt_path):
        print(f"Salt path not found: {salt_path}")
        print("Using current directory for testing...")
        salt_path = './03_Salt_Analysis/Salt_States'
    
    print("="*50)
    print("Salt to Ansible Converter - Israr Sadaq")
    print("="*50)
    
    converted = 0
    failed = 0
    
    for sls_file in Path(salt_path).rglob('*.sls'):
        if sls_file.name == 'top.sls':
            continue
        if convert_salt_state(sls_file, ansible_roles):
            converted += 1
        else:
            failed += 1
    
    print("="*50)
    print(f"Done. Converted: {converted}, Failed: {failed}")
    print("="*50)

if __name__ == "__main__":
    main()
