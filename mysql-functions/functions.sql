# create database
# CREATE DATABASE temp_crud_demo_two CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


# Show all tables
show tables;

# Show tables and views
show full tables;
 
# start by  dymanic
show tables like 'dynamic%';
show tables like 'dynamic_advantages%';

# start by dymanic full
show full tables  like 'dynamic%';
 
show table status like 'dynamic%';

# end by es
show tables like '%es';
 
# start by dymanic and end by es
show tables from hghoteles where tables_in_hghoteles like '%es' and tables_in_hghoteles like 'dynamic%';
 
# show tables as view 
SHOW FULL TABLES WHERE table_type = 'VIEW';

# mysql from mysql 
SHOW TABLES IN mysql LIKE 'time%';

describe dynamic_home; 

desc dynamic_home; 

show columns from dynamic_home;

# Printeamos todas las columnas 
show full columns from dynamic_banners;
show full columns from dynamic_bannertype;
show full columns from dynamic_pages;
 
# procecdure
CREATE DEFINER=`sillamaniaes2com`@`%` PROCEDURE `new_procedure`()
BEGIN
SELECT DISTINCT (fp.id_product)
        FROM ps_feature_product as fp
        left join ps_product_sort as pss
        on pss.id_product = fp.id_product
        left join ps_feature_lang as fl
        on fl.id_feature = fp.id_feature
        left join ps_feature_value_lang as fvl
        on fvl.id_feature_value = fp.id_feature_value
        left join ps_category_product as cp
        on fp.id_product = cp.id_product
        left join ps_category_lang as cl
        on cl.id_category = cp.id_category
        left join ps_product as psp
        on psp.id_product = cp.id_product
        left join ps_product_lang as pspl
        on pspl.id_product = psp.id_product
        where cp.id_category = 7 AND fp.id_feature = 51 AND pss.product_index IS NOT NULL
        OR cp.id_category = 7 AND fp.id_feature = 52 AND pss.product_index IS NOT NULL
        OR cp.id_category = 7 AND fp.id_feature = 50 AND pss.product_index IS NOT NULL
        OR cp.id_category = 7 AND fp.id_feature = 80 AND pss.product_index IS NOT NULL;
END