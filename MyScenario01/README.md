Servers needed
     install control and 6 managed servers
     	each MS meeds three disks
	     1 for OS 2 blank
	each MS needs three NICs
     set up SSH to allow root SSH
     hostnames will be ansible1 to 6 for MS.  domain will be example.com

inventory
     setup inventory as file, web, ftp, even, and odd
     odd uses password for sudo
     even uses nopasswd

Control
     setup repo server
          Base uses FTP and AppStream uses HTTP on a port other than 80 that is already allowed via selinux
	  anonymous access to ftp is fine

Managed Server setup
     remove all non approved repos (not pointing to control server)
     add repos to control server
     	use FQDN
	Base uses FTP
	AppStream uses HTTP on a different port
     setup py


Storage
  setup three vgs on MS
  setup three lvols on MS
  extend one lvols
  use extents of 8, 16, 32
  create swap space on non LVM and LVM space on 
	non LVM on odd
	LVM on even

setup web
	use /web
	change config with ansible
	selinux
	webpage should show all MS and control and IPs in opposite format than hosts (hostname IP)

setup ftp
	anonymous upload
	vsftpd.conf template
	sebool
	selinux
setup samba
	base install
setup NFS
	base install and
create users on MS5
	automount NFS for users and for shared files
	
add users to groups
set up shared folder
setup up ACLs
set each UID for each user as 123X
set groups as sales and accounting
set GID and Sticky

setup time for all servers
  set control as the ntp server
  print message if synchronized or not
  use rhel system roles for this

setup MS4 for graphical login
	ensure target is set
	
schedule an at job to logger
schedule cron to log at reboot and every 30 minutes to say hi

create role to set motd

use templating to create /etc/hosts for all hosts and push

set group vars and host vars as needed

use variables for nearly everything

use conditionals and most have to show green when just running commands

setup local facts to use for systems
	hostname
	domain (jmctsm.local)
	mariadb-server
	mariadb needs to start
	
changed tuned profile

change network name to mgmt
setup another NIC for prod
  
setup a file on each server using a template that lists 
	hostname
	all disks
	all nics
	total memory
	domain
	

use vault for all passwords
