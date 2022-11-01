install control and 5 managed servers
set up SSH to allow root SSH
setup python on the MS
 adhoc
put keys on MS from control
 adhoc
setup inventory as file, web, ftp, even, and odd
odd uses password for sudo
even uses nopasswd
setup repo on local server and subscribe others to it
 adhoc
setup even to subscribe to subscripton manager
each MS needs three disks
	OS and two blank
setup three vgs on MS
setup three lvols on MS
extend one lvols
use extents of 8, 16, 32
create swap space on non LVM and LVM space on 
	non on odd
	LVM on even

setup web
	use /web
	change config with ansible
	selinux
	webpage should show all MS and control and IPs in opposite format than hosts (hostname IP)
ftp
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
	domain
	
changed tuned profile

change network name to mgmt
setup another NIC for prod

use vault for all passwords