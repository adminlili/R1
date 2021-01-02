#!/bin/bash

yum update -y
yum makecache -y

yum install -y vsftpd ftp

cp /etc/vsftpd/vsftpd.conf vsftpd.conf.bak
cp vsftpd_pattern1.conf /etc/vsftpd/vsftpd.conf

# allowed users for ftp
cp user_list /etc/vsftpd/user_list

# not allowed users for ftp
cp ftpusers /etc/vsftpd/ftpusers

chmod +x add_ftp_user.sh
./add_ftp_user.sh

echo "STEP 2: selinux config"

sed 's/SELINUX="permissive"|"enforcing"|"disabled"/SELINUX=disabled/' /etc/selinux/config

setenforce 0

systemctl stop firewalld
systemctl enable vsftpd
systemctl start vsftpd

