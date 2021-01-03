CREATE DATABASE vsftpd;
GRANT SELECT ON vsftpd.* TO 'vsftpd'@'localhost' IDENTIFIED BY '123L45p67#';

USE vsftpd;
CREATE TABLE `users` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`username` VARCHAR( 30 ) NOT NULL ,
`password` VARCHAR( 50 ) NOT NULL ,
UNIQUE (`username`)
) ENGINE = MYISAM ;

INSERT INTO users (username, password)
VALUES('ftp1', md5('passwd1'));

INSERT INTO users (username, password)
VALUES('ftp2', md5('passwd2'));

INSERT INTO users (username, password)
VALUES('ftpuser', md5('passwd3'));

INSERT INTO users (username, password)
VALUES('ftp3', md5('passwd11'));

INSERT INTO users (username, password)
VALUES('ftp4', md5('passwd22'));

INSERT INTO users (username, password)
VALUES('ftpuser2', md5('passwd33'));


exit
