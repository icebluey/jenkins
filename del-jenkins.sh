#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ

/bin/systemctl daemon-reload 

invoke-rc.d jenkins stop >/dev/null 2>&1 || : 
update-rc.d jenkins remove >/dev/null 2>&1 || : 
sleep 1
/bin/systemctl stop jenkins.service >/dev/null 2>&1 || : 
/bin/systemctl disable jenkins.service >/dev/null 2>&1 || : 

groupdel -f jenkins >/dev/null 2>&1 || : 
userdel -f -r jenkins >/dev/null 2>&1 || : 

rm -fr /lib/systemd/system/jenkins.service
rm -fr /usr/lib/systemd/system/jenkins.service

rm -fr /etc/sysconfig/jenkins
rm -fr /etc/init.d/jenkins
rm -fr /etc/logrotate.d/jenkins
rm -fr /etc/default/jenkins

rm -fr /usr/lib/jenkins
rm -fr /usr/share/jenkins
rm -fr /var/log/jenkins
rm -fr /var/cache/jenkins
rm -fr /var/lib/jenkins

rm -f /usr/sbin/rcjenkins

/bin/systemctl daemon-reload 

