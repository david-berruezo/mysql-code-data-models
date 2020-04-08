/*
 * Borramos un producto de prestashop 
 */
 
use prestashop;

# Remove product
DELETE FROM ps_product
WHERE id_product = 8;

DELETE FROM ps_product_shop
WHERE id_product = 8;

DELETE FROM ps_feature_product
WHERE id_product = 8;

DELETE FROM ps_product_lang
WHERE id_product = 8;

DELETE FROM ps_category_product
WHERE id_product = 8;

DELETE FROM ps_product_tag
WHERE id_product = 8;

DELETE FROM ps_tag
WHERE id_product = 8;

DELETE FROM ps_image
WHERE id_product = 8;

DELETE FROM ps_image_lang
WHERE id_product = 8;

DELETE FROM ps_image_shop
WHERE id_product = 8;

DELETE FROM ps_specific_price
WHERE id_product = 8;

DELETE FROM ps_specific_price_priority
WHERE id_product = 8;

DELETE FROM ps_product_carrier
WHERE id_product = 8;

DELETE FROM ps_cart_product
WHERE id_product = 8;

DELETE FROM ps_product_attachment
WHERE id_product = 8;

DELETE FROM ps_product_country_tax
WHERE id_product = 8;

DELETE FROM ps_product_download
WHERE id_product = 8;

DELETE FROM ps_product_group_reduction_cache
WHERE id_product = 8;

DELETE FROM ps_product_sale
WHERE id_product = 8;

DELETE FROM ps_product_supplier
WHERE id_product = 8;

DELETE FROM ps_product_supplier
WHERE id_product = 8;

DELETE FROM ps_warehouse_product_location
WHERE id_product = 8;

DELETE FROM ps_stock
WHERE id_product = 8;

DELETE FROM ps_stock_available
WHERE id_product = 8;

DELETE FROM ps_stock_mvt
WHERE id_product = 8;

DELETE FROM ps_customization
WHERE id_product = 8;

DELETE FROM ps_customization_field
WHERE id_product = 8;

DELETE FROM ps_supply_order_detail
WHERE id_product = 8;

DELETE FROM ps_attribute_impact
WHERE id_product = 8;

DELETE FROM ps_product_attribute
WHERE id_product = 8;

DELETE FROM ps_product_attribute_shop
WHERE id_product = 8;

DELETE FROM ps_product_attribute_combination
WHERE id_product = 8;

DELETE FROM ps_product_attribute_image
WHERE id_product = 8;

DELETE FROM ps_attribute_impact
WHERE id_product = 8;

DELETE FROM ps_attribute_lang
WHERE id_product = 8;

DELETE FROM ps_attribute_group
WHERE id_product = 8;

DELETE FROM ps_attribute_group_lang
WHERE id_product = 8;

DELETE FROM ps_attribute_group_shop
WHERE id_product = 8;

DELETE FROM ps_attribute_shop
WHERE id_product = 8;

DELETE FROM ps_product_attribute
WHERE id_product = 8;

DELETE FROM ps_product_attribute_shop
WHERE id_product = 8;

DELETE FROM ps_product_attribute_combination
WHERE id_product = 8;

DELETE FROM ps_product_attribute_image
WHERE id_product = 8;

DELETE FROM ps_stock_available
WHERE id_product = 8;

DELETE FROM ps_manufacturer
WHERE id_product = 8;

DELETE FROM ps_manufacturer_lang
WHERE id_product = 8;

DELETE FROM ps_manufacturer_shop
WHERE id_product = 8;

DELETE FROM ps_supplier
WHERE id_product = 8;

DELETE FROM ps_supplier
WHERE id_product = 8;

DELETE FROM ps_supplier_lang
WHERE id_product = 8;

DELETE FROM ps_supplier_shop
WHERE id_product = 8;

DELETE FROM ps_customization
WHERE id_product = 8;

DELETE FROM ps_customization_field
WHERE id_product = 8;

DELETE FROM customization_field_lang
WHERE id_product = 8;

DELETE FROM customized_data
WHERE id_product = 8;

DELETE FROM feature
WHERE id_product = 8;

DELETE FROM feature_lang
WHERE id_product = 8;

DELETE FROM feature_product
WHERE id_product = 8;

DELETE FROM feature_shop
WHERE id_product = 8;

DELETE FROM feature_value
WHERE id_product = 8;

DELETE FROM feature_value_lang
WHERE id_product = 8;

DELETE FROM pack
WHERE id_product = 8;

DELETE FROM search_index
WHERE id_product = 8;

DELETE FROM search_word
WHERE id_product = 8;

DELETE FROM specific_price
WHERE id_product = 8;

DELETE FROM specific_price_priority
WHERE id_product = 8;

DELETE FROM specific_price_rule
WHERE id_product = 8;

DELETE FROM specific_price_rule_condition
WHERE id_product = 8;

DELETE FROM specific_price_rule_condition_group
WHERE id_product = 8;

DELETE FROM stock
WHERE id_product = 8;

DELETE FROM stock_available
WHERE id_product = 8;

DELETE FROM stock_mvt
WHERE id_product = 8;

DELETE FROM warehouse
WHERE id_product = 8;

# Categories
SELECT a.`id_category`, `name`, `description`, sa.`position` AS `position`, `active` , sa.position position
FROM `ps_category` a 
LEFT JOIN `ps_category_lang` b ON (b.`id_category` = a.`id_category` AND b.`id_lang` = 1 AND b.`id_shop` = 1)
LEFT JOIN `ps_category_shop` sa ON (a.`id_category` = sa.`id_category` AND sa.id_shop = 1)  
WHERE 1   AND `id_parent` = 2 
ORDER BY sa.`position` ASC

# Attribute list
SELECT SQL_CALC_FOUND_ROWS b.*, a.*
FROM `ps_attribute_group` a 
LEFT JOIN `ps_attribute_group_lang` b ON (b.`id_attribute_group` = a.`id_attribute_group` AND b.`id_lang` = 1)
WHERE 1 ORDER BY a.`position` ASC

# Attribute list send parameters
SELECT SQL_CALC_FOUND_ROWS b.*, a.*
FROM `ps_attribute` a 
LEFT JOIN `ps_attribute_lang` b ON (b.`id_attribute` = a.`id_attribute` AND b.`id_lang` = 1)
WHERE 1  AND a.`id_attribute_group` = 1 
ORDER BY a.`position` ASC

# Querie to get references
SELECT DISTINCT(psp.id_product),psp.reference as referencia_producto_simple,psa.reference as referencia_producto_compuesto
FROM sillamaniaes_dos.ps_product as psp
LEFT JOIN ps_product_attribute as psa
ON psp.id_product = psa.id_product
ORDER BY psp.id_product ASC;

SELECT DISTINCT(psp.reference) FROM sillamaniaes_dos.ps_product as psp
UNION ALL SELECT psa.reference FROM sillamaniaes_dos.ps_product_attribute as psa;


# Query better products
# statsbestproducts module function getData
SELECT SQL_CALC_FOUND_ROWS p.reference, p.id_product, pl.name,
ROUND(AVG(od.product_price / o.conversion_rate), 2) as avgPriceSold,
IFNULL(stock.quantity, 0) as quantity,
IFNULL(SUM(od.product_quantity), 0) AS totalQuantitySold,
ROUND(IFNULL(IFNULL(SUM(od.product_quantity), 0) / (1 + LEAST(TO_DAYS('01/09/2018'), TO_DAYS(NOW())) - GREATEST(TO_DAYS('31/09/2018'), TO_DAYS(product_shop.date_add))), 0), 2) as averageQuantitySold,
ROUND(IFNULL(SUM((od.product_price * od.product_quantity) / o.conversion_rate), 0), 2) AS totalPriceSold,
(
	SELECT IFNULL(SUM(pv.counter), 0)
	FROM '._DB_PREFIX_.'page pa
	LEFT JOIN '._DB_PREFIX_.'page_viewed pv ON pa.id_page = pv.id_page
	LEFT JOIN '._DB_PREFIX_.'date_range dr ON pv.id_date_range = dr.id_date_range
	WHERE pa.id_object = p.id_product AND pa.id_page_type = '.(int)Page::getPageTypeByName('product').'
	AND dr.time_start BETWEEN '01/09/2018'
	AND dr.time_end BETWEEN '31/09/2018'
) AS totalPageViewed,
product_shop.active
FROM '._DB_PREFIX_.'product p
'.Shop::addSqlAssociation('product', 'p').'
LEFT JOIN '._DB_PREFIX_.'product_lang pl ON (p.id_product = pl.id_product AND pl.id_lang = '.(int)$this->getLang().' '.Shop::addSqlRestrictionOnLang('pl').')
LEFT JOIN '._DB_PREFIX_.'order_detail od ON od.product_id = p.id_product
LEFT JOIN '._DB_PREFIX_.'orders o ON od.id_order = o.id_order
'.Shop::addSqlRestriction(Shop::SHARE_ORDER, 'o').'
'.Product::sqlStock('p', 0).'
WHERE o.valid = 1
AND o.invoice_date BETWEEN '.$date_between.'
GROUP BY od.product_id;


# Products query by category
# Category class function getProducts
SELECT p.*, product_shop.*, stock.out_of_stock, IFNULL(stock.quantity, 0) AS quantity'.(Combination::isFeatureActive() ? ', IFNULL(product_attribute_shop.id_product_attribute, 0) AS id_product_attribute,
					product_attribute_shop.minimal_quantity AS product_attribute_minimal_quantity' : '').', pl.`description`, pl.`description_short`, pl.`available_now`,
					pl.`available_later`, pl.`link_rewrite`, pl.`meta_description`, pl.`meta_keywords`, pl.`meta_title`, pl.`name`, image_shop.`id_image` id_image,
					il.`legend` as legend, m.`name` AS manufacturer_name, cl.`name` AS category_default,
					DATEDIFF(product_shop.`date_add`, DATE_SUB("'.date('Y-m-d').' 00:00:00",
					INTERVAL '.(int) $nbDaysNewProduct.' DAY)) > 0 AS new, product_shop.price AS orderprice
				FROM `'._DB_PREFIX_.'category_product` cp
				LEFT JOIN `'._DB_PREFIX_.'product` p
					ON p.`id_product` = cp.`id_product`
				'.Shop::addSqlAssociation('product', 'p').
                (Combination::isFeatureActive() ? ' LEFT JOIN `'._DB_PREFIX_.'product_attribute_shop` product_attribute_shop
				ON (p.`id_product` = product_attribute_shop.`id_product` AND product_attribute_shop.`default_on` = 1 AND product_attribute_shop.id_shop='.(int) $context->shop->id.')':'').'
				'.Product::sqlStock('p', 0).'
				LEFT JOIN `'._DB_PREFIX_.'category_lang` cl
					ON (product_shop.`id_category_default` = cl.`id_category`
					AND cl.`id_lang` = '.(int) $idLang.Shop::addSqlRestrictionOnLang('cl').')
				LEFT JOIN `'._DB_PREFIX_.'product_lang` pl
					ON (p.`id_product` = pl.`id_product`
					AND pl.`id_lang` = '.(int) $idLang.Shop::addSqlRestrictionOnLang('pl').')
				LEFT JOIN `'._DB_PREFIX_.'image_shop` image_shop
					ON (image_shop.`id_product` = p.`id_product` AND image_shop.cover=1 AND image_shop.id_shop='.(int)$context->shop->id.')
				LEFT JOIN `'._DB_PREFIX_.'image_lang` il
					ON (image_shop.`id_image` = il.`id_image`
					AND il.`id_lang` = '.(int) $idLang.')
				LEFT JOIN `'._DB_PREFIX_.'manufacturer` m
					ON m.`id_manufacturer` = p.`id_manufacturer`
				WHERE product_shop.`id_shop` = '.(int) $context->shop->id.'
					AND cp.`id_category` = '.(int) $this->id
                    .($active ? ' AND product_shop.`active` = 1' : '')
                    .($front ? ' AND product_shop.`visibility` IN ("both", "catalog")' : '')
                    .($idSupplier ? ' AND p.id_supplier = '.(int)$idSupplier : '');


# Count orders and sum total paid in period time
SELECT COUNT(o.id_order) as orderCount, SUM(o.total_paid_real / o.conversion_rate) as orderSum
FROM ps_orders as o
LEFT JOIN ps_address a
ON o.id_address_delivery = a.id_address
WHERE o.valid = 1
AND o.invoice_date >= "2016-12-18"
AND o.invoice_date <= "2016-12-19";

# Count orders
SELECT count(*) as totalPedidos
FROM ps_orders as orders
where orders.date_add >= "2016-12-18"
AND orders.date_add < "2016-12-19"

# Query products by invoice dates
SELECT o.id_order,product_id as idproducto,pd.name,od.product_reference,cl.name as nombrecategoria
FROM ps_orders as o
LEFT JOIN ps_order_detail as od 
ON od.id_order = o.id_order
LEFT JOIN ps_product_lang as pd 
ON pd.id_product = od.product_id
LEFT JOIN ps_address as a 
ON o.id_address_delivery = a.id_address
LEFT JOIN ps_category_product as cp 
ON cp.id_product = od.product_id
LEFT JOIN ps_category_lang as cl 
ON cl.id_category = cp.id_category
WHERE o.valid = 1
AND o.invoice_date >= "2016-12-01"
AND o.invoice_date <= "2017-01-15"
AND pd.id_lang = 1;

# address delivery between invoice_date
SELECT o.date_add,o.total_paid_tax_incl
FROM ps_orders as o
LEFT JOIN ps_address a
ON o.id_address_delivery = a.id_address
WHERE o.valid = 1
AND o.invoice_date >= "2016-12-01"
AND o.invoice_date <= "2017-01-31"

# get order detail from dates
SELECT DISTINCT statelang.name as nombreestado,orders.id_order,pais_lang.name as pais,direccion.city,orders.reference,orders.total_paid,customer.firstname,customer.lastname,customer.email,orders.id_customer,orderhistory.date_add,orderhistory.id_order_state 
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
LEFT JOIN ps_customer as customer
ON orders.id_customer = customer.id_customer
LEFT JOIN ps_address as direccion
ON direccion.id_customer = customer.id_customer
LEFT JOIN ps_country as pais
ON direccion.id_country = pais.id_country
LEFT JOIN ps_country_lang as pais_lang
ON pais_lang.id_country = pais.id_country
LEFT JOIN ps_order_state_lang as statelang
ON statelang.id_order_state = orders.current_state
where orders.date_add >= "2016-11-01"
AND orders.date_add < "2017-01-13"
AND orders.current_state = orderhistory.id_order_state
and pais_lang.id_lang = 1
AND statelang.id_lang = 1
GROUP BY (orders.id_order)
order by orders.id_order ASC;

# Money in cash
SELECT COUNT(o.id_order) as orderCount, SUM(o.total_paid_real / o.conversion_rate) as orderSum
FROM ps_orders as o
LEFT JOIN ps_address a 
ON o.id_address_delivery = a.id_address
WHERE o.valid = 1
AND o.invoice_date >= '2016-12-01'
AND o.invoice_date <= '2017-01-08';
#AND a.id_country = 6

SELECT o.id_order,o.date_add as fecha
FROM ps_orders as o
LEFT JOIN ps_address a 
ON o.id_address_delivery = a.id_address
WHERE o.valid = 1
AND o.invoice_date >= '2016-12-01'
AND o.invoice_date <= '2017-01-08';


# Orders
# Total product numbers
SELECT SUM(od.product_quantity) as products
FROM ps_orders o
LEFT JOIN ps_order_detail od ON od.id_order = o.id_order
LEFT JOIN ps_address a ON o.id_address_delivery = a.id_address
WHERE o.valid = 1
AND o.invoice_date >= '2016-12-01'
AND o.invoice_date <= '2017-01-08';


# Average orders
# Half quantity of orders
SELECT DISTINCT orders.id_order,orders.reference,orders.total_paid,orders.id_customer,orderhistory.date_add,orderhistory.id_order_state 
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
where orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 2
OR 
orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 4
GROUP BY (orders.id_order);
#order by orders.id_order ASC;

# All orders
SELECT count(*) as totalPedidos
FROM ps_orders as orders
where orders.date_add >= "2016-12-01"
AND orders.date_add < "2017-01-08";

# Average products bought by order
# Average products quantity by all orders
SELECT detalle.product_quantity,orders.id_order,orders.reference,orders.total_paid,orders.id_customer,orderhistory.date_add,orderhistory.id_order_state 
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
LEFT JOIN ps_order_detail as detalle 
ON detalle.id_order = orderhistory.id_order
where orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 2

# Better categories
# Las mejores categorias
#SELECT COUNT(o.id_order) as orderCount, SUM(o.total_paid_real / o.conversion_rate) as orderSum
SELECT SUM(orderdetail.total_price_tax_incl) as totalPrecio,COUNT(orderdetail.product_id) as productosPorPedido,o.id_order,categorylang.name as nombrecategoria
FROM ps_orders as o
LEFT JOIN ps_address a
ON o.id_address_delivery = a.id_address
LEFT JOIN ps_order_detail as orderdetail
ON orderdetail.id_order = o.id_order
LEFT JOIN ps_category_product as categoryproduct
ON categoryproduct.id_product = orderdetail.product_id
LEFT JOIN ps_category_lang as categorylang
ON categorylang.id_category = categoryproduct.id_category
WHERE o.valid = 1
AND categorylang.id_lang = 1
AND o.invoice_date >= "2016-12-01"
AND o.invoice_date <= "2017-01-10"
GROUP BY o.id_order,categorylang.name;


# Number total discounts
SELECT SUM(od.product_quantity) as products
FROM ps_orders o
LEFT JOIN ps_order_detail od ON od.id_order = o.id_order
LEFT JOIN ps_address a ON o.id_address_delivery = a.id_address
WHERE o.valid = 1
AND o.invoice_date >= '2016-12-01'
AND o.invoice_date <= '2017-01-10'
AND o.total_discounts > 0;

# Top 15 products
SELECT product_id as idproducto,pd.name,od.product_reference,cl.name as nombrecategoria
FROM ps_orders as o
LEFT JOIN ps_order_detail as od 
ON od.id_order = o.id_order
LEFT JOIN ps_product_lang as pd 
ON pd.id_product = od.product_id
LEFT JOIN ps_address as a 
ON o.id_address_delivery = a.id_address
LEFT JOIN ps_category_product as cp 
ON cp.id_product = od.product_id
LEFT JOIN ps_category_lang as cl 
ON cl.id_category = cp.id_category
WHERE o.valid = 1
AND o.invoice_date >= '2016-12-01'
AND o.invoice_date <= '2017-01-10'
AND pd.id_lang = 1;
#AND o.total_discounts > 0;


# Customers buy second time
# pd.name
# LEFT JOIN ps_product_lang as pd 
# ON pd.id_product = od.product_id
# LEFT JOIN ps_order_detail as od 
# ON od.id_order = o.id_order

SELECT o.id_order,cu.firstname,cu.lastname,cu.email,o.total_paid_tax_incl
FROM ps_orders as o
LEFT JOIN ps_address as a 
ON o.id_address_delivery = a.id_address
LEFT JOIN ps_customer as cu 
ON cu.id_customer = o.id_customer
WHERE o.valid = 1
AND o.invoice_date >= '2016-12-01'
AND o.invoice_date <= '2017-01-10';


# Better discounts
# ROUND(SUM(o.total_paid_real) / o.conversion_rate,2) as ca
SELECT COUNT(ocr.id_cart_rule) as total,cr.code, ocr.name 
FROM ps_order_cart_rule as ocr
LEFT JOIN ps_orders as o 
ON o.id_order = ocr.id_order
LEFT JOIN ps_cart_rule as cr 
ON cr.id_cart_rule = ocr.id_cart_rule
WHERE o.valid = 1
AND o.invoice_date <= "2017-01-09"
GROUP BY ocr.id_cart_rule;

SELECT SQL_CALC_FOUND_ROWS p.reference, p.id_product, pl.name,
ROUND(AVG(od.product_price / o.conversion_rate), 2) as avgPriceSold,
IFNULL(stock.quantity, 0) as quantity,
IFNULL(SUM(od.product_quantity), 0) AS totalQuantitySold,
ROUND(IFNULL(IFNULL(SUM(od.product_quantity), 0) / (1 + LEAST(TO_DAYS('.$array_date_between[1].'), TO_DAYS(NOW())) - GREATEST(TO_DAYS('.$array_date_between[0].'), TO_DAYS(product_shop.date_add))), 0), 2) as averageQuantitySold,
ROUND(IFNULL(SUM((od.product_price * od.product_quantity) / o.conversion_rate), 0), 2) AS totalPriceSold,
(
SELECT IFNULL(SUM(pv.counter), 0)
	FROM '._DB_PREFIX_.'page pa
	LEFT JOIN '._DB_PREFIX_.'page_viewed pv ON pa.id_page = pv.id_page
	LEFT JOIN '._DB_PREFIX_.'date_range dr ON pv.id_date_range = dr.id_date_range
	WHERE pa.id_object = p.id_product AND pa.id_page_type = '.(int)Page::getPageTypeByName('product').'
AND dr.time_start BETWEEN '.$date_between.'
AND dr.time_end BETWEEN '.$date_between.'
) AS totalPageViewed,
product_shop.active
FROM '._DB_PREFIX_.'product p
'.Shop::addSqlAssociation('product', 'p').'
LEFT JOIN '._DB_PREFIX_.'product_lang pl ON (p.id_product = pl.id_product AND pl.id_lang = '.(int)$this->getLang().' '.Shop::addSqlRestrictionOnLang('pl').')
LEFT JOIN '._DB_PREFIX_.'order_detail od ON od.product_id = p.id_product
LEFT JOIN '._DB_PREFIX_.'orders o ON od.id_order = o.id_order
'.Shop::addSqlRestriction(Shop::SHARE_ORDER, 'o').'
'.Product::sqlStock('p', 0).'
WHERE o.valid = 1
AND o.invoice_date BETWEEN '.$date_between.'
GROUP BY od.product_id';



SELECT SQL_CALC_FOUND_ROWS ca.`id_category`, CONCAT(parent.name, \' > \', calang.`name`) as name,
IFNULL(SUM(t.`totalQuantitySold`), 0) AS totalQuantitySold,
ROUND(IFNULL(SUM(t.`totalPriceSold`), 0), 2) AS totalPriceSold,
ROUND(IFNULL(SUM(t.`totalWholeSalePriceSold`), 0), 2) AS totalWholeSalePriceSold,
(
	SELECT IFNULL(SUM(pv.`counter`), 0)
	FROM `'._DB_PREFIX_.'page` p
	LEFT JOIN `'._DB_PREFIX_.'page_viewed` pv ON p.`id_page` = pv.`id_page`
	LEFT JOIN `'._DB_PREFIX_.'date_range` dr ON pv.`id_date_range` = dr.`id_date_range`
	LEFT JOIN `'._DB_PREFIX_.'product` pr ON CAST(p.`id_object` AS UNSIGNED INTEGER) = pr.`id_product`
	LEFT JOIN `'._DB_PREFIX_.'category_product` capr2 ON capr2.`id_product` = pr.`id_product`
	WHERE capr.`id_category` = capr2.`id_category`
	AND p.`id_page_type` = 1
	AND dr.`time_start` BETWEEN '.$date_between.'
	AND dr.`time_end` BETWEEN '.$date_between.'
) AS totalPageViewed,
(
    SELECT COUNT(id_category) FROM '._DB_PREFIX_.'category WHERE `id_parent` = ca.`id_category`
) AS hasChildren
FROM `'._DB_PREFIX_.'category` ca
LEFT JOIN `'._DB_PREFIX_.'category_lang` calang ON (ca.`id_category` = calang.`id_category` AND calang.`id_lang` = '.(int)$id_lang.Shop::addSqlRestrictionOnLang('calang').')
LEFT JOIN `'._DB_PREFIX_.'category_lang` parent ON (ca.`id_parent` = parent.`id_category` AND parent.`id_lang` = '.(int)$id_lang.Shop::addSqlRestrictionOnLang('parent').')
LEFT JOIN `'._DB_PREFIX_.'category_product` capr ON ca.`id_category` = capr.`id_category`
LEFT JOIN (
	SELECT pr.`id_product`, t.`totalQuantitySold`, t.`totalPriceSold`, t.`totalWholeSalePriceSold`
	FROM `'._DB_PREFIX_.'product` pr
	LEFT JOIN (
		SELECT pr.`id_product`, pa.`wholesale_price`,
			IFNULL(SUM(cp.`product_quantity`), 0) AS totalQuantitySold,
			IFNULL(SUM(cp.`product_price` * cp.`product_quantity`), 0) / o.conversion_rate AS totalPriceSold,
			IFNULL(SUM(
				CASE
					WHEN cp.`original_wholesale_price` <> "0.000000"
					THEN cp.`original_wholesale_price` * cp.`product_quantity`
					WHEN pa.`wholesale_price` <> "0.000000"
					THEN pa.`wholesale_price` * cp.`product_quantity`
					WHEN pr.`wholesale_price` <> "0.000000"
					THEN pr.`wholesale_price` * cp.`product_quantity`
				END
			), 0) / o.conversion_rate AS totalWholeSalePriceSold
		FROM `'._DB_PREFIX_.'product` pr
		LEFT OUTER JOIN `'._DB_PREFIX_.'order_detail` cp ON pr.`id_product` = cp.`product_id`
		LEFT JOIN `'._DB_PREFIX_.'orders` o ON o.`id_order` = cp.`id_order`
		LEFT JOIN `'._DB_PREFIX_.'product_attribute` pa ON pa.`id_product_attribute` = cp.`product_attribute_id`
		'.Shop::addSqlRestriction(Shop::SHARE_ORDER, 'o').'
		WHERE o.valid = 1
		AND o.invoice_date BETWEEN '.$date_between.'
		GROUP BY pr.`id_product`
	) t ON t.`id_product` = pr.`id_product`
) t	ON t.`id_product` = capr.`id_product`
'.(($categories) ? 'WHERE ca.id_category IN ('.implode(', ', $categories).')' : '').'
'.$onlyChildren.'
GROUP BY ca.`id_category`
HAVING ca.`id_category` != 1';


# Total benefits
# Total euros payed
SELECT SUM(orders.total_paid)
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
where orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 2

# Total products best selled
# Every products by oder
SELECT count(*) 
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
LEFT JOIN ps_order_detail as detalle 
ON detalle.id_order = orderhistory.id_order
where orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 2;


# Orders arrive late 11 days
SELECT DISTINCT orders.id_order,orders.reference,orders.total_paid,orders.id_customer,orderhistory.date_add,orderhistory.id_order_state 
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
where orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 2
OR 
orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 4
order by orders.id_order ASC;

# Total products selled by discount
SELECT count(*)
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
LEFT JOIN ps_order_detail as detalle 
ON detalle.id_order = orderhistory.id_order
where orders.date_add >= "2016-01-01"
AND orders.date_add <= "2017-01-05"
AND orderhistory.id_order_state = 2
AND orders.total_discounts = 0;


# Recurrent boughts
select * from ps_orders as orders
LEFT JOIN ps_customer as customers 
ON orders.id_customer = customers.id_customer
ORDER BY orders.id_order ASC;

# Benefits by category
SELECT categorylang.name,detalle.product_quantity,orders.id_order,orders.reference,orders.total_paid,orders.id_customer,orderhistory.date_add,orderhistory.id_order_state 
from ps_order_history as orderhistory 
LEFT JOIN ps_orders as orders 
ON orders.id_order = orderhistory.id_order  
LEFT JOIN ps_order_detail as detalle 
ON detalle.id_order = orderhistory.id_order
LEFT JOIN ps_category_product as categoryproduct 
ON categoryproduct.id_product = detalle.product_id
LEFT JOIN ps_category_lang as categorylang 
ON categorylang.id_category = categoryproduct.id_category
where orders.date_add >= "2016-01-01"
AND orders.date_add < "2017-01-03"
AND orderhistory.id_order_state = 2
AND categorylang.id_lang = 2;


# Features
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,psp.available_date,
cl.link_rewrite as cat_rewrite, pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, 
GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
where fp.id_feature_value IN(3057,2254,2257,2259,2253);


# Features
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite, pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
where fp.id_feature_value = 3056 AND fp.id_feature_value = 2254

# Features
# 3057 	no uso
# 2254	
# 2257, soporte lumbar no
# 2259, profundidad asiento no regulable
# 2253, 
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,psp.available_date,cl.link_rewrite as cat_rewrite, 
pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, 
GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
where fp.id_feature_value = 3055 AND fp.id_feature_value = 2254

# Features
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite,
pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value,
GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor
FROM ps_feature_product as fp
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
where fp.id_feature_value IN(3055,2254);

# Features
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite, pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
where fp.id_feature_value = 3055 AND psp.active = 1 
or fp.id_feature_value = 2254 AND psp.active = 1 
GROUP BY fp.id_product;

# Features
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite, pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
where fp.id_feature_value = 3055 AND psp.active = 1 
OR fp.id_feature_value = 2254 AND psp.active = 1
GROUP BY fp.id_product;

# Features
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite, pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
where fp.id_feature = 89 AND psp.active = 1 
OR fp.id_feature = 71 AND psp.active = 1
GROUP BY fp.id_product;


# Features
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite, pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
where fp.id_feature_value = 3055 AND psp.active = 1 
OR fp.id_feature_value = 2254 AND psp.active = 1 
GROUP BY fp.id_product;


# Queries products by combination colors
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite,pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value,GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor,pss.product_index 
FROM ps_feature_product as fp
left join ps_product_sort as pss on pss.id_product = fp.id_product
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value
left join ps_category_product as cp on fp.id_product = cp.id_product
left join ps_category_lang as cl on cl.id_category = cp.id_category
left join ps_product as psp on psp.id_product = cp.id_product
left join ps_product_lang as pspl on pspl.id_product = psp.id_product
left join ps_product_attribute as pa on pa.id_product = psp.id_product
left join ps_product_attribute_combination as pac on pac.id_product_attribute = pa.id_product_attribute 
where cp.id_category = 4 AND fp.id_feature = 51 AND psp.active = 1
or cp.id_category = 4 AND fp.id_feature = 54 AND psp.active = 1
OR cp.id_category = 4 AND fp.id_feature = 80 AND psp.active = 1
GROUP BY fp.id_product
ORDER BY pss.product_index ASC;

# Queries products by combination colors
SELECT SUM(1) as contador,fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,
psp.reference,psp.available_date,cl.link_rewrite as cat_rewrite,pspl.link_rewrite,
GROUP_CONCAT(DISTINCT fp.id_feature SEPARATOR ",") as id_feature,GROUP_CONCAT(DISTINCT fp.id_feature_value SEPARATOR ",") as id_feature_value,
GROUP_CONCAT(DISTINCT fl.name SEPARATOR ",") as caracteristica,GROUP_CONCAT(DISTINCT fvl.value SEPARATOR ",") as caracteristica_valor,
pss.product_index
FROM ps_feature_product as fp
left join ps_product_sort as pss on pss.id_product = fp.id_product
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value
left join ps_category_product as cp on fp.id_product = cp.id_product
left join ps_category_lang as cl on cl.id_category = cp.id_category
left join ps_product as psp on psp.id_product = cp.id_product
left join ps_product_lang as pspl on pspl.id_product = psp.id_product
left join ps_product_attribute as pa on pa.id_product = psp.id_product
left join ps_product_attribute_combination as pac on pac.id_product_attribute = pa.id_product_attribute
where cp.id_category = 4 AND fp.id_feature = 51 AND psp.active = 1
OR cp.id_category = 4 AND fp.id_feature = 54 AND psp.active = 1
OR cp.id_category = 4 AND fp.id_feature = 80 AND psp.active = 1
GROUP BY fp.id_product
ORDER BY pss.product_index ASC;


/* filters contabilize */
SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,psp.available_date,cl.link_rewrite as cat_rewrite,
pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value,
GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor,pss.product_index 
FROM ps_feature_product as fp
left join ps_product_sort as pss on pss.id_product = fp.id_product
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value
left join ps_category_product as cp on fp.id_product = cp.id_product
left join ps_category_lang as cl on cl.id_category = cp.id_category
left join ps_product as psp on psp.id_product = cp.id_product
left join ps_product_lang as pspl on pspl.id_product = psp.id_product
left join ps_product_attribute as pa on pa.id_product = psp.id_product
left join ps_product_attribute_combination as pac on pac.id_product_attribute = pa.id_product_attribute 
where cp.id_category = 4 AND fp.id_feature = 51 AND psp.active = 1
or cp.id_category = 4 AND fp.id_feature = 54 AND psp.active = 1
OR cp.id_category = 4 AND fp.id_feature = 80 AND psp.active = 1
GROUP BY fp.id_product
ORDER BY pss.product_index ASC;

/* combination query */
    /*
    $sql='  SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,psp.available_date,cl.link_rewrite as cat_rewrite,';
    $sql.=' pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value,';
    $sql.=' GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor ';
    $sql.=' FROM ps_feature_product as fp';
    $sql.=' left join ps_feature_lang as fl';
    $sql.=' on fl.id_feature = fp.id_feature';
    $sql.=' left join ps_feature_value_lang as fvl';
    $sql.=' on fvl.id_feature_value = fp.id_feature_value';
    $sql.=' left join ps_category_product as cp';
    $sql.=' on fp.id_product = cp.id_product';
    $sql.=' left join ps_category_lang as cl';
    $sql.=' on cl.id_category = cp.id_category';
    $sql.=' left join ps_product as psp';
    $sql.=' on psp.id_product = cp.id_product';
    $sql.=' left join ps_product_lang as pspl';
    $sql.=' on pspl.id_product = psp.id_product';
    */

# query in functions

SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,psp.available_date,cl.link_rewrite as cat_rewrite,
pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value,
GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor,pss.product_index 
FROM ps_feature_product as fp
left join ps_product_sort as pss on pss.id_product = fp.id_product
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature
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
left join ps_product_attribute as pa
on pa.id_product = psp.id_product
left join ps_product_attribute_combination as pac
on pac.id_product_attribute = pa.id_product_attribute
where cp.id_category = 4 AND fp.id_feature = 51 AND psp.active = 1
or cp.id_category = 4 AND fp.id_feature = 54 AND psp.active = 1
OR cp.id_category = 4 AND fp.id_feature = 80 AND psp.active = 1
GROUP BY fp.id_product
ORDER BY pss.product_index ASC;    


# query features

SELECT SQL_CALC_FOUND_ROWS *  
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
cGROUP BY fp.id_product
ORDER BY pss.product_index ASC;


# query combinations

SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,
psp.available_date,cl.link_rewrite as cat_rewrite,pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value,GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor,pss.product_index 
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
where cp.id_category = 4 AND fp.id_feature = 51 AND psp.active = 1 AND pss.product_index IS NOT NULL
or cp.id_category = 4 AND fp.id_feature = 54 AND psp.active = 1 AND pss.product_index IS NOT NULL
GROUP BY fp.id_product
ORDER BY pss.product_index ASC;

# query by colors
SELECT SQL_CALC_FOUND_ROWS * 
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
where cp.id_category = 4 AND fp.id_feature = 50 AND psp.active = 1 AND pss.product_index IS NOT NULL
or cp.id_category = 4 AND fp.id_feature = 51 AND psp.active = 1 AND pss.product_index IS NOT NULL
or cp.id_category = 4 AND fp.id_feature = 80 AND psp.active=1 AND pss.product_index IS NOT NULL
GROUP BY fp.id_product
ORDER BY pss.product_index ASC;

SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,psp.available_date,
cl.link_rewrite as cat_rewrite, pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,
GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value, GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,
GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor,pss.product_index 
FROM ps_feature_product as fp 
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature 
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value 
left join ps_category_product as cp on fp.id_product = cp.id_product 
left join ps_category_lang as cl on cl.id_category = cp.id_category 
left join ps_product_sort as pss on pss.id_product = fp.id_product 
left join ps_product as psp on psp.id_product = cp.id_product 
left join ps_product_lang as pspl on pspl.id_product = psp.id_product 
left join ps_product_attribute as pa on pa.id_product = psp.id_product 
left join ps_product_attribute_combination as pac on pac.id_product_attribute = pa.id_product_attribute 
where cp.id_category = 4 AND psp.active = 1 AND pss.product_index IS NOT NULL 
GROUP BY fp.id_product 
ORDER BY pss.product_index ASC;


SELECT fp.id_product,psp.quantity,pspl.name,pspl.description,pspl.link_rewrite,psp.price,psp.wholesale_price,psp.reference,psp.available_date,
cl.link_rewrite as cat_rewrite,pspl.link_rewrite,GROUP_CONCAT(fp.id_feature SEPARATOR ",") as id_feature,GROUP_CONCAT(fp.id_feature_value SEPARATOR ",") as id_feature_value,
GROUP_CONCAT(fl.name SEPARATOR ",") as caracteristica,GROUP_CONCAT(fvl.value SEPARATOR ",") as caracteristica_valor,pss.product_index 
FROM ps_feature_product as fp
left join ps_feature_lang as fl on fl.id_feature = fp.id_feature
left join ps_feature_value_lang as fvl on fvl.id_feature_value = fp.id_feature_value
left join ps_category_product as cp on fp.id_product = cp.id_product
left join ps_category_lang as cl on cl.id_category = cp.id_category
left join ps_product_sort as pss on pss.id_product = fp.id_product
left join ps_product as psp on psp.id_product = cp.id_product
left join ps_product_lang as pspl on pspl.id_product = psp.id_product

left join ps_product_attribute as pa on pa.id_product = psp.id_product 
left join ps_product_attribute_combination as pac on pac.id_product_attribute = pa.id_product_attribute 

where cp.id_category = 4 AND fp.id_feature_value = 1458  AND psp.active = 1 AND pss.product_index IS NOT NULL
GROUP BY fp.id_product
ORDER BY pss.product_index ASC
LIMIT 1 , 10;