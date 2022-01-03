#!/bin/bash

while true; do
        if [ `cat /etc/passwd | grep "^cubrid:" | wc -l` != 0 ]; then
                break;
        fi

        if [ `whoami` != "root" ]; then
                break;
        fi

        IP_D_CLASS=`hostname -I | awk -F '.' '{printf("%3s", $NF)}'`
        sed -i 's/\t/ /g' /etc/login.defs
        sed --in-place "s/UID_MIN    1000/UID_MIN   ${IP_D_CLASS//[[:space:]]/}01000/" /etc/login.defs
        sed --in-place "s/UID_MAX   60000/UID_MAX   ${IP_D_CLASS//[[:space:]]/}59999/" /etc/login.defs
        sed --in-place "s/GID_MIN    1000/GID_MIN   ${IP_D_CLASS//[[:space:]]/}01000/" /etc/login.defs
        sed --in-place "s/GID_MAX   60000/GID_MAX   ${IP_D_CLASS//[[:space:]]/}59999/" /etc/login.defs

				sed --in-place "s/FIRST_UID=1000/FIRST_UID=${IP_D_CLASS//[[:space:]]/}01000/" /etc/adduser.conf
        sed --in-place "s/LAST_UID=59999/LAST_UID=${IP_D_CLASS//[[:space:]]/}59999/" /etc/adduser.conf
        sed --in-place "s/FIRST_GID=1000/FIRST_GID=${IP_D_CLASS//[[:space:]]/}01000/" /etc/adduser.conf
        sed --in-place "s/LAST_GID=59999/LAST_GID=${IP_D_CLASS//[[:space:]]/}59999/" /etc/adduser.conf

        useradd cubrid

	# When volume is reused
	#  -  useradd: warning: the home directory already exists.
	#   - Not copying any file from skel directory into it.
	mkdir /home/cubrid
  cp /etc/skel/.* /home/cubrid
  chsh -s /bin/bash cubrid
	chown -R cubrid:cubrid /home/cubrid

        echo "cubrid:password" | chpasswd
        
        echo "cubrid    ALL=(ALL:ALL) ALL" >> /etc/sudoers

        break;
done
