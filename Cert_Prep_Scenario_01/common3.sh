#!/bin/bash

USERSTUFF="-e ansible_user=root -e ansible_password=password"

ansible all -m shell -a "rm -rf /etc/yum.repos.d/*.repo" $USERSTUFF

ansible all -m shell -a "ls /etc/yum.repos.d/" $USERSTUFF

ansible all -m yum_repository -a "name=BaseOS file=BaseOS description=BaseOS baseurl=ftp://control.example.com/repo/BaseOS gpgcheck=no enabled=1" $USERSTUFF

ansible all -m yum_repository -a "name=AppStream file=AppStream description=AppStream baseurl=ftp://control.example.com/repo/AppStream gpgcheck=no enabled=1" $USERSTUFF

ansible all -m shell -a "dnf repolist" $USERSTUFF
