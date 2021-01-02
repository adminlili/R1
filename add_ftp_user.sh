#!/bin/bash

USERftp1="ftp1"
USERftp2="ftp2"
USERftp3="ftpuser"

PASSftp1="passwd1"
PASSftp2="passwd2"
PASSftp3="passwd3"

useradd  $USERftp1 -d /var/www --shell /sbin/nologin
useradd  $USERftp2 -d /var/www --shell /sbin/nologin
useradd  $USERftp3 -d /var/www --shell /sbin/nologin

echo -e "$PASSftp1\n$PASSftp1\n" | passwd ftp1
echo -e "$PASSftp2\n$PASSftp2\n" | passwd ftp2
echo -e "$PASSftp3\n$PASSftp3\n" | passwd ftpuser

#mkdir -p /home/ftpusrs/$USERftp{1,2,user}
#chown -r $USERftp1:ftp /home/ftpusrs/$USERftp1
#chown -r $USERftp2:ftp /home/ftpusrs/$USERftp2
#chown -r $USERftp3:ftp /home/ftpusrs/$USERftp3


