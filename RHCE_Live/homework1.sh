#!/bin/bash

ansible all -m raw -a "dnf install -y python3"
