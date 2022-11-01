#!/bin/bash

USERINFO="-e ansible_user=root -e ansible_password=password"

ansible all -m yum -a "name=python3 state=latest" $USERINFO

ansible all -m user -a "name=ansible state=present" $USERINFO

ansible all -m shell -a "echo password | passwd --stdin ansible" $USERINFO

ansible all -m authorized_key -a "user=ansible key=\"{{ lookup('file', '/home/ansible/.ssh/id_rsa.pub') }}\" state=present" $USERINFO

ansible all -m copy -a "content='ansible ALL=(ALL) NOPASSWD:ALL' dest=/etc/sudoers.d/ansible validate='visudo -cf %s'" $USERINFO

ansible all -m ping
