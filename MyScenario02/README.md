uses 7 machines
	1 controller
	6 servers
		All machines are minimally installed
		only controller is registered with RedHat
		install vim on controller
		three nics and three hard drives per machine
	Root user on all machines
	no otheuseraddr users on any machine 
	
1) install ansible on controller
	a) use 2.9
2) create user ansible on controller
3) set password for ansible on controller
4) allow user ansible on controller to not have to use a password for sudo 
	a) do not add to default file; add a new file to additional default directory
5) create ssh keys for user ansible on controller
6) create all playbooks in /home/ansible/playbooks
7) create all scripts in /home/ansible/scripts
8) create all templates in /home/ansible/templates
9) modify file on controller to resolve all servers using short or long hostnames
10) create ansible configuration file at /home/ansible/
	a) set inventory to /home/ansible/inventory/inventory.ini
	b) use ansible for default ansible connections
	c) do not do default privilege escalation
	d) use sudo for privilege escalation
	e) use root for privileged user
	f) do not use a password for privilege escalation
	g) verify host keys
	h) keeping existing roles path add /home/ansible/roles
11) create inventory file 
	a) server01 is in dev_db
	b) server02 is in dev_proxy and dev_webservers
	c) server03 is in dev_webservers
	d) server04 is in prod_db
	e) server05 is in prod_proxy and prod_webservers
	f) server06 is in prod_webservers
	g) all dev servers in dev group and prod in prod group
12) create script to copy ssh keys from all servers to localhost called copy_keys.sh
13) create a playbook called setuprepo.yaml to do the following on the controller
	a) mount the iso file loop mounted to /var/ftp/repo
		1) may have to make the iso file
	b) install ftp server (vsftp)
	c) allow anonymous downloads
		1) no template.  Use direct editing
	d) ensure firewall is installed and allows ftp
	e) ensure that ftp is started at run time
	f) use handler to restart service if modifying configuration file
	g) /var/ftp/repo should be on vgftp and lvftp using sdb
	h) all mounts should be persistent
	