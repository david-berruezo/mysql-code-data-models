CREATE DATABASE temp_relaciones_uno_a_varios_cascada CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use temp_relaciones_uno_a_varios_cascada;

# Consumidores clientes
create table customers(
	customerId int(10) not null auto_increment,
	customerPhone varchar(32),
    emailAddress varchar(128),
    PRIMARY KEY  (customerId)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='customers'; 

# Direcciones
create table addresses(
	addressId int(10) not null auto_increment,
    customerId int(10),
	address_line_1 varchar(128),
    address_line_2 varchar(128),
    PRIMARY KEY (addressId),
    FOREIGN KEY (customerId) 
    REFERENCES customers(customerId) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='addresses'; 


SET FOREIGN_KEY_CHECKS = 1;

insert into customers values (1,'615231533','davidberruezo@davidberruezo.com');
insert into customers values (2,'615231534','davidberruezo33@gmail.com');
insert into customers values (3,'615231535','davidberruezo@hotmail.com');

insert into addresses values (1,1,'vallirana','vallirana');
insert into addresses values (2,1,'malgrat','malgrat');
insert into addresses values (3,1,'rossello','rossello');


# Test delete on cascade
delete from customers where customerId=1;
