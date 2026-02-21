# MySQL - Code & Data Models

Colección de **modelos de datos**, **consultas SQL** y **funciones MySQL** orientados a casos prácticos reales. Este repositorio sirve como referencia y recurso de aprendizaje para comprender el diseño de bases de datos relacionales, relaciones entre tablas y consultas aplicadas a plataformas como **WordPress** y **PrestaShop**.

---

## Tabla de Contenidos

- [Sobre el Proyecto](#sobre-el-proyecto)
- [Contenido del Repositorio](#contenido-del-repositorio)
  - [01 - Car Sales (Modelo E-R)](#01---car-sales-modelo-e-r)
  - [02 - MySQL Functions](#02---mysql-functions)
  - [03 - PrestaShop Queries](#03---prestashop-queries)
  - [04 - Relaciones entre Tablas](#04---relaciones-entre-tablas)
  - [05 - WordPress Queries](#05---wordpress-queries)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Requisitos](#requisitos)
- [Cómo Usar](#cómo-usar)
- [Conceptos Cubiertos](#conceptos-cubiertos)
- [Recursos](#recursos)
- [Autor](#autor)

---

## Sobre el Proyecto

Este repositorio reúne ejemplos prácticos de SQL organizados por temática. Desde el diseño de un modelo Entidad-Relación completo hasta consultas específicas para los CMS más utilizados en el desarrollo web (WordPress y PrestaShop). Es ideal para desarrolladores que necesitan una referencia rápida o quieren profundizar en el manejo de bases de datos MySQL.

---

## Contenido del Repositorio

### 01 - Car Sales (Modelo E-R)

📁 `car-sales/`

Modelo de base de datos completo para un sistema de **venta de coches**. Incluye el diagrama Entidad-Relación (ER) y el código SQL para la creación de las tablas.

- Diagrama ER del modelo de datos
- Scripts de creación de tablas (`CREATE TABLE`)
- Relaciones entre entidades (clientes, vehículos, ventas, etc.)
- Datos de ejemplo para pruebas

### 02 - MySQL Functions

📁 `mysql-functions/`

Ejemplos de **funciones nativas de MySQL** con casos de uso prácticos.

- Funciones de cadena (`CONCAT`, `SUBSTRING`, `REPLACE`, `TRIM`, etc.)
- Funciones numéricas (`ROUND`, `CEIL`, `FLOOR`, `MOD`, etc.)
- Funciones de fecha (`NOW`, `DATE_FORMAT`, `DATEDIFF`, `DATE_ADD`, etc.)
- Funciones de agregación (`COUNT`, `SUM`, `AVG`, `MAX`, `MIN`)
- Funciones de control de flujo (`IF`, `CASE`, `IFNULL`, `COALESCE`)

### 03 - PrestaShop Queries

📁 `prestashop-queries/`

Consultas SQL orientadas al esquema de base de datos de **PrestaShop**. Útiles para obtener información directamente de la base de datos del CMS.

- Consultas sobre productos, categorías y atributos
- Consultas sobre pedidos y clientes
- Consultas sobre stock e inventario
- Queries adaptadas a la estructura de tablas de PrestaShop (con prefijo `ps_`)

### 04 - Relaciones entre Tablas

📁 `relations-one-to-one-one-to-many-many-to-many/`

Ejemplos completos de los tres tipos de **relaciones** en bases de datos relacionales, incluyendo las restricciones de integridad referencial.

| Relación | Descripción | Ejemplo |
|---|---|---|
| **One-to-One** | Una fila se relaciona con exactamente una fila de otra tabla | Un `usuario` tiene un `perfil` |
| **One-to-Many** | Una fila se relaciona con múltiples filas de otra tabla | Una `categoría` tiene muchos `productos` |
| **Many-to-Many** | Múltiples filas se relacionan entre sí mediante tabla intermedia | Muchos `estudiantes` cursan muchas `asignaturas` |

Cada ejemplo incluye:

- Creación de tablas con `FOREIGN KEY`
- Restricciones `ON UPDATE CASCADE` y `ON DELETE CASCADE`
- Opciones de restricción: `RESTRICT`, `SET NULL`, `NO ACTION`
- Scripts de inserción de datos de prueba

### 05 - WordPress Queries

📁 `wordpress-queries/`

Consultas SQL específicas para el esquema de base de datos de **WordPress**. Útiles para extraer información directamente de la base de datos sin pasar por la API de WordPress.

- Consultas sobre posts, páginas y custom post types (`wp_posts`)
- Consultas sobre taxonomías y términos (`wp_terms`, `wp_term_taxonomy`, `wp_term_relationships`)
- Consultas sobre meta datos (`wp_postmeta`, `wp_usermeta`)
- Consultas sobre usuarios (`wp_users`)
- Consultas sobre opciones del sitio (`wp_options`)

---

## Estructura del Proyecto

```
mysql-code-data-models/
├── car-sales/                                          # Modelo ER y SQL de venta de coches
├── mysql-functions/                                    # Funciones MySQL con ejemplos
├── prestashop-queries/                                 # Consultas SQL para PrestaShop
├── relations-one-to-one-one-to-many-many-to-many/      # Relaciones 1:1, 1:N, N:M
├── wordpress-queries/                                  # Consultas SQL para WordPress
└── README.md
```

---

## Requisitos

- **MySQL** >= 5.7 o **MariaDB** >= 10.3
- Un cliente MySQL: [MySQL Workbench](https://www.mysql.com/products/workbench/), [phpMyAdmin](https://www.phpmyadmin.net/), [DBeaver](https://dbeaver.io/) o terminal `mysql`

---

## Cómo Usar

1. **Clonar el repositorio**

```bash
git clone https://github.com/david-berruezo/mysql-code-data-models.git
cd mysql-code-data-models
```

2. **Ejecutar los scripts SQL**

Desde terminal:

```bash
# Crear una base de datos de prueba
mysql -u root -p -e "CREATE DATABASE test_models;"

# Ejecutar un script SQL
mysql -u root -p test_models < car-sales/create_tables.sql
```

Desde MySQL Workbench o phpMyAdmin:

- Abre el archivo `.sql` de la carpeta que quieras explorar
- Ejecuta el script contra tu base de datos de prueba

3. **Explorar y experimentar**

Cada carpeta contiene scripts independientes. Puedes ejecutarlos en cualquier orden y modificar las consultas para experimentar con diferentes escenarios.

---

## Conceptos Cubiertos

| Categoría | Temas |
|---|---|
| **Diseño de BD** | Modelo Entidad-Relación (ER), normalización, claves primarias y foráneas |
| **DDL** | `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, constraints |
| **DML** | `INSERT`, `UPDATE`, `DELETE`, `SELECT` |
| **Joins** | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN` |
| **Relaciones** | One-to-One, One-to-Many, Many-to-Many, tablas intermedias |
| **Integridad Referencial** | `ON DELETE CASCADE`, `ON UPDATE CASCADE`, `RESTRICT`, `SET NULL` |
| **Funciones** | String, numéricas, fecha, agregación, control de flujo |
| **CMS Queries** | WordPress (wp_posts, wp_postmeta, wp_terms), PrestaShop (ps_product, ps_orders) |

---

## Recursos

- [MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)
- [MySQL Tutorial](https://www.mysqltutorial.org/)
- [WordPress Database Description](https://codex.wordpress.org/Database_Description)
- [PrestaShop Database Structure](https://devdocs.prestashop-project.org/8/development/components/database/)
- [SQL Style Guide](https://www.sqlstyle.guide/)

---

## Autor

**David Berruezo** — Software Engineer | Fullstack Developer

- GitHub: [@david-berruezo](https://github.com/david-berruezo)
- Website: [davidberruezo.com](https://www.davidberruezo.com)
