#!/bin/bash

USERINFO="-e ansible_user=root -e ansible_password=password"

ansible all -m ping $USERINFO

ansible all -m user -a "name=automation state=present" $USERINFO
ansible all -m user -a "name=ansible state=absent" $USERINFO

ansible all -m authorized_key -a "user=automation state=present key=\"{{ lookup('file', '/home/automation/.ssh/id_rsa.pub') }}\"" $USERINFO

ansible all -m copy -a "content='automation ALL=(ALL) NOPASSWD:ALL' dest=/etc/sudoers.d/automation validate='visudo -cf %s'" $USERINFO

ansible all -m ping -e become=TRUE
