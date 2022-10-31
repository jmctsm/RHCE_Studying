#!/bin/bash

USERSTUFF="-e ansible_user=root -e ansible_password=password"

ansible all -m lineinfile -a "state=present line='192.168.43.100 control.example.com control' path=/etc/hosts" $USERSTUFF

ansible all -m yum -a "name=python3 state=latest" $USERSTUFF

ansible all -m user -a "name=ansible state=present" $USERSTUFF

ansible all -m shell -a "echo password | passwd --stdin ansible" $USERSTUFF

ansible all -m copy -a "content='ansible ALL=(ALL) NOPASSWD:ALL' dest=/etc/sudoers.d/ansible validate='visudo -cf %s'" $USERSTUFF

ansible all -m authorized_key -a "state=present user=ansible key=\"{{ lookup('file', '/home/ansible/.ssh/id_rsa.pub')}}\"" $USERSTUFF

ansible all -m ping
