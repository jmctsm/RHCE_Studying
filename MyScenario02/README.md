00. uses 7 machines
    a. 1 controller
	b. 6 servers
       1. All machines are minimally installed
	   2. only controller is registered with RedHat
	   3. install vim on controller
	   4. three nics and three hard drives per machine
    c. Root user on all machines
    d. no otheuseraddr users on any machine 
	
01. install ansible on controller
   a. use 2.9
02. create user ansible on controller
03. set password for ansible on controller
04. allow user ansible on controller to not have to use a password for sudo 
   a. do not add to default file; add a new file to additional default directory
05. create ssh keys for user ansible on controller
06. create all playbooks in /home/ansible
07. create all scripts in /home/ansible/scripts
08. create all templates in /home/ansible/templates
09. variables are not to be kept in playbooks
10. modify file on controller to resolve all servers using short or long hostnames
11. create ansible configuration file at /home/ansible/
    a. set inventory to /home/ansible/inventory/inventory.ini
    b. use ansible for default ansible connections
    c. do not do default privilege escalation
    d. use sudo for privilege escalation
    e. use root for privileged user
    f. do not use a password for privilege escalation
    g. verify host keys
    h. keeping existing roles path add /home/ansible/roles
12. create inventory file 
    a. server01 is in dev_db
    b. server02 is in dev_proxy and dev_webservers
    c. server03 is in dev_webservers
    d. server04 is in prod_db
    e. server05 is in prod_proxy and prod_webservers
    f. server06 is in prod_webservers
    g. all dev servers in dev group and prod in prod group
    h. all db servers in group dbs
    i. all webservers in group webservers
    j. all proxy servers in group proxies
13. create script to copy ssh keys from all servers to localhost called copy_keys.sh
14. create a playbook called setuprepo.yaml to do the following on the controller
    a. mount the iso file loop mounted to /var/ftp/repo
       1. may have to make the iso file
    b. install ftp server (vsftp)
    c. allow anonymous downloads
       1. no template.  Use direct editing
    d. ensure firewall is installed and allows ftp
    e. ensure that ftp is started at run time
    f. use handler to restart service if modifying configuration file
    h. all mounts should be persistent
15. using ad-hoc commands in a script called system_setup.sh do the following on all hosts
    a. create ansible user with password of password	
       1. do this in one command
       2. use sha512 with no given salt
    b. copy ssh keys to ansible user
    c. allow ansible user to sudo via creating a new file and validating it
    d. verify connectivity with user ansible and a supplied module (not command or shell or raw)
16. create setup_repos.yml playbook for all hosts
    a. use ftp://controller.{{whatever domain you used}}/repo/BaseOS for url, 
       1. enable it
       2. disable gpgcheck
       3. name is BaseOS
       4. description is "Base OS Repo"
    b. use ftp://controller.{{whatever domain you used}}/repo/AppStream for url, 
       1. enable it
       2. disable gpgcheck
       3. name is AppStream
       4. description is "App Stream Repo"
    c. make sure that no other repo files are used on the system
    d. ensure that repos work by installing vim and python3
17. create a script called initial_setup.sh that runs on all hosts and installs python3 as if python was not already on the machine
18. create one storage playbook for webservers and dbs called storage.yml
    a. webservers
	   1. use all of /dev/sdb for vgweb
	   2. set extent to double of default
	   3. use half of vg for lvweb
	   4. format as ext4
	   5. mount to /web persistently
    b. dbs 
	   1. use all of /dev/sdb for vgdb
	   2. set extent to 4x of default
	   3. use half of vg for lvdb
	   4. format as xfs
	   5. mount to /db persistently
19. create requirements file to install geerlingguy.haproxy to /home/ansible/roles/
    a. statically set to latest version in requirements file
	b. set name to haproxy_role
20. use haproxy_role to install on all proxies that load balance between all servers 
    a. proxy for dev load balances dev
	b. proxy for prod load balances prod
	c. set load balancing to roundrobin
	d. playbook should be called proxy_setup.yml
21. create web_role in roles
    a. installs httpd on redhat webservers
	b. set document root to /web
	c. ensure that web pages can be served from this location (think security)
22. using web_role install web servers with an index.html page that shows a welcome page with the following 
    <welcome message>
	<List of group webservers (dev or prod)>
	Each webserver should show hostname, fqdn, memory, first 6 hard drives (none if none for a number), IP address, OS distro and version
	call playbook webserver_setup.yml
23. create ssh_role to apply to all servers running redhat 8.4 
    a. set motd to server name, all groups, and message to go away
	b. restart using handlers
	c. set motd to include admin that by default is admin@<domain_name>
	   1. playbook that runs should change this to something else
24. install mariadb on all database servers 
25. ensure that load balancing is working using a playbook run on the controller
26. create a playbook to configure controller as NTP server 
27. using rhel-system-roles, configure all hosts to use controller as the NTP source
    a. reboot and verify syncing
	   1. show message on if sync'd or not
	   2. if not then wait 3 minutes and see again
28. create playbook that guarantees one webserver is up in each environment while other reboots
20. create userslist.yml as follows where password is stored in an ansible vault that uses a keyfile to open
    users: 
	  - username: kelly
	    password: <ansible vault variable>
		supp_group: engineer
	  - username: emily
	    password: <ansible vault variable>
		supp_group: engineer
	  - username: drogon
	    password: <ansible vault variable>
		supp_group: manager
	  - username: sunfyre
	    password: <ansible vault variable>
		supp_group: manager
	  - username: jesse 
	    password: <ansible vault variable>
		supp_group: developer
	  - username: walt
	    password: <ansible vault variable>
		supp_group: developer
30. on dev servers create all users and set supplementary groups to theirs and wheel 
    a. using ansible user ssh key on controller set as SSH key for all users
	b. ensure all users can ssh in dev without a password
31. on prod servers create all users and make only managers be in group wheel
    a. using ansible user ssh key on controller set as SSH key for all users
	b. ensure all users can ssh in dev without a password
32. on all db servers, create following directories with specific ACLS (all files belong to group (GID))
    /db/manager 
	  only manager rwx
	  no other users allowed to see
	/db/engineer 
	  owned by engineer
	  full permissions by engineers
	  full permissions for managers
	  read only for developers
	/db/developer 
	  owned by developer
	  full permissions by developers
	  full permissions for managers
	  read only for engineer
33. add to /etc/hosts file for each server for all servers in its environment
34. create local facts on each server 
    file is custom
    section is environment
	key is type and value is either dev or prod
35. using custom keys 
    if environment type is dev install  tcpdump and mailx
	if environment type is prod install tcpdump and lsof
36. set all servers to use multi-user.target
	