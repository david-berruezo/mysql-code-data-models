CREATE DATABASE temp_relaciones_uno_a_uno_cascada CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use temp_relaciones_uno_a_uno_cascada;


CREATE TABLE user (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
)ENGINE = INNODB;


CREATE TABLE admins (
  user_id int(11) NOT NULL AUTO_INCREMENT,
  `e-mail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (user_id)
  )ENGINE = INNODB;


ALTER TABLE user add CONSTRAINT FK_user_admin_user_id FOREIGN KEY (id) REFERENCES admins (user_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE admins add CONSTRAINT FK_admin_user_id FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE ON UPDATE CASCADE;

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO user VALUES(1,'user','Berruezin23');
INSERT INTO user VALUES(2,'editor','Berruezin23');
INSERT INTO user VALUES(3,'admin','Berruezin23');

INSERT INTO admins VALUES(1,'davidberruezo@davidberruezo.com');
INSERT INTO admins VALUES(2,'hola@davidberruezo.com');
INSERT INTO admins VALUES(3,'adios@davidberruezo.com');

# Test delete on cascade
SET FOREIGN_KEY_CHECKS = 1;
delete from user where id = 3;
SET FOREIGN_KEY_CHECKS = 0;


INSERT INTO user VALUES(3,'admin','Berruezin23');
INSERT INTO admins VALUES(3,'adios@davidberruezo.com');

SET FOREIGN_KEY_CHECKS = 1;
