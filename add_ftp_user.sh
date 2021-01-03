#!/bin/bash

USERftp1="ftp3"
USERftp2="ftp4"
USERftp3="ftpuser2"

PASSftp1="passwd11"
PASSftp2="passwd22"
PASSftp3="passwd33"

#useradd  $USERftp1 -d /home/$USERftp1 --shell /sbin/nologin
useradd  $USERftp1 -d /home/$USERftp1 --shell /bin/bash
useradd  $USERftp2 -d /home/$USERftp2 --shell /bin/bash
useradd  $USERftp3 -d /home/$USERftp3 --shell /bin/bash

chown -r :ftp /home/$USERftp{1,2,3}

echo -e "$PASSftp1\n$PASSftp1\n" | passwd ftp3
echo -e "$PASSftp2\n$PASSftp2\n" | passwd ftp4
echo -e "$PASSftp3\n$PASSftp3\n" | passwd ftpuser2

#mkdir -p /home/ftpusrs/$USERftp{1,2,user}
#chown -r $USERftp1:ftp /home/ftpusrs/$USERftp1
#chown -r $USERftp2:ftp /home/ftpusrs/$USERftp2
#chown -r $USERftp3:ftp /home/ftpusrs/$USERftp3


