#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ

/bin/systemctl daemon-reload
/bin/systemctl stop jenkins.service >/dev/null 2>&1 || : 
/bin/systemctl disable jenkins.service >/dev/null 2>&1 || : 

groupdel -f jenkins >/dev/null 2>&1 || : 
userdel -f -r jenkins >/dev/null 2>&1 || : 

set -e

getent group jenkins >/dev/null || /usr/sbin/groupadd -r jenkins
getent passwd jenkins >/dev/null || /usr/sbin/useradd -r -d /var/lib/jenkins \
-g jenkins -s /usr/sbin/nologin -c "Jenkins Automation Server" jenkins

sleep 1
if getent group jenkins >/dev/null && getent passwd jenkins >/dev/null ; then
    chown -R jenkins:jenkins /var/lib/jenkins
    chown -R jenkins:jenkins /var/log/jenkins
    chown -R jenkins:jenkins /var/cache/jenkins
else
    echo -e "Group:\n$(getent group jenkins)"
    echo
    echo -e "User:\n$(getent passwd jenkins)"
    echo
fi

exit 0

#/sbin/chkconfig --add jenkins
#/sbin/service jenkins stop > /dev/null 2>&1
#/sbin/chkconfig --del jenkins
#/sbin/service jenkins condrestart > /dev/null 2>&1

#update-rc.d jenkins defaults >/dev/null
#invoke-rc.d jenkins start || exit 1
#invoke-rc.d jenkins stop || exit 1
#update-rc.d jenkins remove >/dev/null



