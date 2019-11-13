/*
 * Base de datos de venta de coches
 * para un concesionario normal 
 * faltarian 4 tablas del model
 * modelo: http://www.databaseanswers.org/data_models/car_sales/index.htm
 */
 
drop database car_sales;

CREATE DATABASE car_sales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use car_sales;

# Consumidores clientes
create table customers(
	customerId int(10) not null auto_increment,
	customerPhone varchar(32),
    emailAddress varchar(128),
    primary key (customerId)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='customers'; 

# Direcciones
create table addresses(
	addressId int(10) not null auto_increment,
    customerId int(10),
	address_line_1 varchar(128),
    address_line_2 varchar(128),
    primary key (addressId),
    foreign key (customerId) references customers (customerId) on update cascade on delete cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='addresses'; 

# Modelos de coches
create table cars_models(
	model_code int(10) not null auto_increment,
	manufacturer_code int(10),
    model_name varchar(255),
	primary key (model_code)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='cars_models';

# Fabricantes de coches
create table cars_manufacturers(
	manufacturer_shortname varchar(50),
    manufacturer_fullname varchar(255),
    primary key (manufacturer_shortname)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='cars_manufacturers';

# Categoria de vehiculos
create table vehicles_categories(
	vehicle_category_code int(10) not null auto_increment,
    vehicle_category_description varchar(255),
    primary key (vehicle_category_code)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='vehicle_categories';


# Caracteristicas en los coches vendidos
# Pienso uno dos tablas M:N
create table cars_for_sale(
	cars_for_saleId int(10) not null auto_increment, 
    manufacturer_shortname varchar(50),
    model_code int(10),
    vehicle_category_code int(10),
	initial_price int(10),
	registration_year DATE,
    primary key (cars_for_saleId),
    foreign key (model_code) references cars_models(model_code) on update cascade on delete cascade,
	foreign key (manufacturer_shortname) references cars_manufacturers(manufacturer_shortname) on update cascade on delete cascade,
	foreign key (vehicle_category_code) references vehicles_categories(vehicle_category_code) on update cascade on delete cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='cars_for_sale';


# Caracteristicas de los vehiculos
create table car_features(
	car_featureId int(10) not null auto_increment,
    car_feature_description varchar(255),
    primary key (car_featureId)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='features'; 

# Preferencias del cliente
# sobre caracteristicas del vehiculo
create table customer_preferences(
	customer_preferences_id int(10) not null auto_increment,
    car_featureId int(10) not null,
    customerId int(10) not null,
	primary key (customer_preferences_id),
    foreign key (car_featureId) references car_features(car_featureId) on update cascade on delete cascade,
	foreign key (customerId) references customers(customerId) on update cascade on delete cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='customer_preferences';

# Caracteristicas en los coches vendidos
# Pienso uno dos tablas M:N
create table features_on_cars_for_sale(
	cars_for_saleId int(10),
	car_featureId int(10),
    foreign key (cars_for_saleId) references cars_for_sale(cars_for_saleId) on update cascade on delete cascade,
	foreign key (car_featureId) references car_features(car_featureId) on update cascade on delete cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='features_on_cars_for_sale';


create table payment_status(
	payment_status_code int(10) not null auto_increment,
    payment_status_description varchar(255),
    primary key (payment_status_code)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='payment_status';



create table car_sold(
	car_sold_id int(10) not null auto_increment,
    cars_for_saleId int(10),
    customerId int(10),
    date_sold date,
    primary key (car_sold_id),
	foreign key (cars_for_saleId) references cars_for_sale(cars_for_saleId) on update cascade on delete cascade,
    foreign key (customerId) references customers(customerId) on update cascade on delete cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='payment_status';


create table customer_payments(
	customer_payment_id int(10) not null auto_increment,
    cars_sold_id int(10),
    customerId int(10),
    payment_status_code int(10),
	customer_payment_date_due date,
    customer_payment_date_made date,
    actual_payment_amont decimal(10,2),
	primary key (customer_payment_id),
	foreign key (cars_sold_id) references car_sold(car_sold_id) on update cascade on delete cascade,
    foreign key (customerId) references customers(customerId) on update cascade on delete cascade,
	foreign key (payment_status_code) references payment_status(payment_status_code) on update cascade on delete cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='customer_payments';





