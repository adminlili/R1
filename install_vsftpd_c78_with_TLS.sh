#!/bin/bash
echo  "--STEP 0--------------- HELLO! Let's Begin our configuration  --------------------------"
echo  "----------------- And we begin it from update our system!! :)  --------------------------"

yum update -y
yum makecache -y

yum install -y vsftpd ftp

echo "/sbin/nologin" >> /etc/shells

cp /etc/vsftpd/vsftpd.conf vsftpd.conf.bak
cp vsftpd_pattern1.conf /etc/vsftpd/vsftpd.conf

# allowed users for ftp
cp user_list /etc/vsftpd/user_list

# not allowed users for ftp
cp ftpusers /etc/vsftpd/ftpusers
cp virtual_users /etc/vsftpd/virtual_users

chmod +x add_ftp_user.sh
./add_ftp_user.sh

echo  "--STEP 1------------------------ disable SELINUX  ---------------------------------"

sed 's/SELINUX="permissive"|"enforcing"|"disabled"/SELINUX=disabled/' /etc/selinux/config

setenforce 0

systemctl stop firewalld
systemctl enable vsftpd
systemctl start vsftpd

echo  "--STEP 2------------------------- vsFTPd via TLS  ----------------------------------"

openssl req -x509 -days 3650 -nodes\
 -newkey rsa:2048 -keyout /etc/vsftpd/vsftpd.pem  -out /etc/vsftpd/vsftpd.pem \
 -subj "/C=UA/ST=Dnipro/L=Dnipro/O=Global Security/OU=IT Department/CN=ftp.lixhm.local/CN=ftp"

systemctl restart vsftpd

#echo  "--STEP 3-------------------------- Virtual Users  ----------------------------------"

#what_centos=cat /etc/centos-release | awk '{print $4}' | grep 7.
#if [ $what_centos -eq 0 ]; then
#   yum -y install compat
#fi

mv /etc/pam.d/vsftpd /etc/pam.d/vsftpd.bak
echo "auth required pam_userdb.so db=/etc/vsftpd/virtual_users account required pam_userdb.so
db=/etc/vsftpd/virtual_users session required pam_loginuid.so" > /etc/pam.d/vsftpd

db_load -T -t hash -f /etc/vsftpd/virtual_users /etc/vsftpd/virtual_users.db

systemctl restart vsftpd

echo  "--STEP 4----------------- Storing virtual users in database --------------------------"

yum -y install mariadb mariadb-server
systemctl enable mariadb
systemctl restart mariadb

PASSmysql1=123L45p67#
PASSmysql2=123L45p68#

echo -e "$PASSmysql1\n$PASSmysql1\n" | mysqladmin -uroot password

echo -e "source ftp_sql1.sql;" | mysql -uroot -p$PASSmysql1


echo  "--STEP 5----------------- Let's install the module pam_sql --------------------------"

#what_centos=cat /etc/centos-release | awk '{print $4}' | grep 7.
#if [ $what_centos -eq 0 ]; then
#   rpm -Uvh ftp://ftp.pbone.net/mirror/archive.fedoraproject.org/fedora/linux/releases/20/Everything/x86_64/os/Packages/p/pam_mysql-0.7-0.16.rc1.fc20.x86_64.rpm
#fi

mv /etc/pam.d/vsftpd /etc/pam.d/vsftpd.bak

echo "session optional pam_keyinit.so force revoke
auth required pam_mysql.so user=vsftpd passwd=$PASSmysql2 host=localhost db=vsftpd table=users usercolumn=username passwordcolumn=password crypt=3
account required pam_mysql.so user=vsftpd passwd=$PASSmysql2 host=localhost db=vsftpd table=users usercolumn=username passwordcolumn=password crypt=3
" > /etc/pam.d/vsftpd

systemctl restart vsftpd
systemctl status vsftpd

echo  "---------- Congratilations!!! Configuration of vsftpd service ended! -------------"
