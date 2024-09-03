#!/bin/bash

ansible-playbook -i inventory.yml secure_configuration.yml
sleep 5
ansible-playbook -i inventory.yml common_packages.yml
sleep 5
ansible-playbook -i inventory.yml patching_playbook.yml