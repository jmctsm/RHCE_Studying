#!/bin/bash

ansible ansible2 -m package_facts | grep -A 9 -E ".*samba.*\:|.*mariadb-server.*\:" > packages-out.txt
