#!/bin/bash

for sname in $(cat /etc/ansible/hosts)
do
ssh-copy-id ansible@$sname
done