#!/bin/bash

USERINFO="-e ansible_user=root -e ansible_password=password"

ansible localhost -m file -a "path=/home/svcansible/.ssh/ state=directory owner=svcansible group=svcansible"

ansible localhost -m openssh_keypair -a "path=/home/svcansible/.ssh/id_rsa force=true type=rsa owner=svcansible group=svcansible"

ansible all -m ping $USERINFO

ansible all -m user -a "name=svcansible state=present" $USERINFO

ansible all -m authorized_key -a "user=svcansible key=\"{{ lookup('file', '/home/svcansible/.ssh/id_rsa.pub') }}\" state=present" $USERINFO

ansible all -m copy -a "content='svcansible ALL=(ALL) NOPASSWD: ALL' dest=/etc/sudoers.d/svcansible validate='visudo -cf %s'" $USERINFO

ansible all -m ping
