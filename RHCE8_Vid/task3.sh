#!/bin/bash

USERSTUFF="-e ansible_user=root -e ansible_password=password"

ansible all -m shell -a "rm -rf /etc/yum.repos.d/*" $USERSTUFF

ansible all -m yum_repository -a "name=BaseOS description=BaseOS file=BaseOS baseurl=ftp://control.example.com/repo/BaseOS gpgcheck=no enabled=yes" $USERSTUFF

ansible all -m yum_repository -a "name=AppStream description=AppStream file=AppStream baseurl=ftp://control.example.com/repo/AppStream gpgcheck=no enabled=yes" $USERSTUFF
