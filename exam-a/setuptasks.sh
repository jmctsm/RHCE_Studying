#!/bin/bash

#ansible-playbook setupreposerver.yaml

USERINFO="-e ansible_user=root -e ansible_password=password"

ansible all -m shell -a "rm /etc/yum.repos.d/*.repo" $USERINFO
ansible all -m yum_repository -a "name=BaseOS file=BaseOS description=BaseOS baseurl=ftp://control.example.com/repo/BaseOS gpgcheck=no enabled=yes" $USERINFO
ansible all -m yum_repository -a "name=AppStream file=AppStream description=AppStream baseurl=http://control.example.com:8008/repo/AppStream gpgcheck=no enabled=yes" $USERINFO

ansible all -m lineinfile -a "line='192.168.43.100 control.example.com control' state=present path=/etc/hosts" $USERINFO

ansible all -m yum -a "name=python3 state=latest" $USERINFO
 
ansible all -m user -a "name=ansible state=present" $USERINFO

ansible all -m shell -a "echo password | passwd --stdin ansible" $USERINFO

ansible all -m authorized_key -a "user=ansible key=\"{{ lookup('file', '/home/ansible/.ssh/id_rsa.pub') }}\" state=present" $USERINFO

ansible all -m copy -a "content='ansible ALL=(ALL) NOPASSWD:ALL' dest=/etc/sudoers.d/ansible validate='visudo -cf %s'" $USERINFO

ansible server1.example.com -m hostname -a "name=server1.example.com"
ansible server2.example.com -m hostname -a "name=server2.example.com"

ansible all -m reboot -a "test_command=whoami"

ansible all -m ping
