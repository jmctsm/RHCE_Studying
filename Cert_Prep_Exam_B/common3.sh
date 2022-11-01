#!/bin/bash

USERINFO="-e ansible_user=root -e ansible_password=password"

ansible all -m ping $USERINFO

ansible all -m shell -a "rm -rf /etc/yum.repos.d/*" $USERINFO

ansible all -m yum_repository -a "name=BaseOS file=BaseOS description=BaseOS baseurl=ftp://control.example.com/repo/BaseOS gpgcheck=no enabled=yes" $USERINFO

ansible all -m yum_repository -a "name=AppStream file=AppStream description=AppStream baseurl=ftp://control.example.com/repo/AppStream gpgcheck=no enabled=yes" $USERINFO

ansible all -m lineinfile -a "path=/etc/hosts line='192.168.43.100 control.example.com control' state=present" $USERINFO

ansible all -m shell -a "dnf repolist" $USERINFO

ansible all -m shell -a "cat /etc/hosts" $USERINFO
