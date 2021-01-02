yum remove -y ftp vsftpd \
 && userdel -r ftp1 \
 | userdel -r ftp2 \
 | userdel -r ftp3 \
 | userdel -r ftp4 \
 | userdel -r ftpuser \
 | rm -rf /home/ftpusrs \
 | rm -rf /etc/vsftpd
