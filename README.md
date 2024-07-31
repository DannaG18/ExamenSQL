

**Consultas Básicas** 

Consultar todos los productos y sus categorías 

```sql
SELECT p.id_producto, p.nombre, p.id_categoria
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria;

+-------------+----------+--------------+
| id_producto | nombre   | id_categoria |
+-------------+----------+--------------+
|           1 | Camisa   |            1 |
|           2 | Pantalon |            1 |
|           3 | Vestido  |            1 |
+-------------+----------+--------------+
```

Consultar todas las compras y los clientes que las realizaron 

```sql
SELECT c.id_compra, c.id_cliente
FROM compras c;

+-----------+------------+
| id_compra | id_cliente |
+-----------+------------+
|         1 | 1          |
|         2 | 2          |
|         3 | 3          |
+-----------+------------+
```

Consultar los productos comprados en una compra específica 

```sql
SELECT cp.id_compra, cp.id_producto
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto;

+-----------+-------------+
| id_compra | id_producto |
+-----------+-------------+
|         1 |           1 |
+-----------+-------------+
```

Agregar un nuevo producto 

```sql
INSERT INTO productos (id_producto, nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES (001, "Camisa", 001, "K231D", 50.00, 100, 1);
```

Actualizar el stock de un producto 

```sql
UPDATE productos
SET cantidad_stock = 50
WHERE id_producto = 001;
```

Consultar todas las compras de un cliente específico 

```slq
SELECT c.id_compra, c.id_cliente
FROM compras c
WHERE c.id_cliente = 001;
```

Consultar todos los clientes y sus correos electrónicos 

```
SELECT c.nombre, c.correo_electronico
FROM clientes c;
```

Consultar la cantidad total de productos comprados en cada compra 

```sql
SELECT cp.id_compra, cp.cantidad
FROM compras_productos cp;
```

Consultar las compras realizadas en un rango de fechas 

```sql
SELECT c.id_compra
FROM compras c 
WHERE c.fecha BETWEEN "2024-05-18" AND "2024-10-12";
```

**Consultas usando funciones agregadas** 

Contar la cantidad de productos por categoría 

```sql
SELECT COUNT(p.id_producto) AS cantidad_producto, c.id_categoria
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria
GROUP BY id_categoria; 
```

Calcular el precio total de ventas por cada cliente 

```sql
SELECT SUM(cp.total) AS total_compras, c.id_cliente
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY c.id_cliente;
```

Calcular el precio promedio de los productos por categoría 

```sql
SELECT AVG(id_producto) AS promedio_productos, p.id_categoria
FROM productos p
GROUP BY id_categoria;
```

Encontrar la fecha de la primera y última compra registrada 

```sql
SELECT MIN(c.fecha) AS primera_compra, MAX(c.fecha) AS ultima_compra
FROM compras c;
```

Calcular el total de ingresos por ventas 

```sql
SELECT SUM(total) AS Ingresos
FROM compras_productos
GROUP BY total;
```

Contar la cantidad de compras realizadas por cada medio de pago 

```sql
SELECT COUNT(c.id_compra) AS cantidad_compras, c.medio_pago
FROM compras c
GROUP BY medio_pago;
```

Calcular el total de productos vendidos por cada producto 

```sql
SELECT SUM(cp.cantidad) AS total_venta_p, cp.id_producto, p.nombre
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto
GROUP BY cp.id_producto;
```

Obtener el promedio de cantidad de productos comprados por compra 

```SQL
SELECT AVG(cp.cantidad) AS total_venta_p, cp.id_compra
FROM compras_productos cp
GROUP BY cp.id_compra;
```

Encontrar los productos con el stock más bajo 



```sql
SELECT MIN(cantidad_stock) AS stock_mas_bajo, id_producto
FROM productos p
GROUP BY id_producto;
```

Calcular el total de productos comprados y el total gastado por cliente 

```sql
SELECT SUM(cp.id_producto) AS total_productos, SUM(cp.total) AS total_gasto, c.id_cliente
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY c.id_cliente;
```

**Consultas usando join**

Consultar todos los productos con sus categorías 

```sql
SELECT p.id_producto, p.id_categoria
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto;
```

Consultar todas las compras y los clientes que las realizaron 

```sql
SELECT cp.id_compra, c.id_cliente
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN clientes cl ON cl.id = c.id_cliente;
```

Consultar los productos comprados en cada compra 

```sql
SELECT cp.id_compra, cp.id_producto, p.nombre
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto; 
```

Consultar las compras realizadas por un cliente específico 

```sql
SELECT c.id_compra, c.id_cliente
FROM compras c
WHERE c.id_cliente = 002;
```

Consultar el total gastado por cada cliente 

```sql
SELECT SUM(cp.total) AS gasto, c.id_cliente
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
GROUP BY c.id_cliente;
```

Consultar el stock disponible de productos y su categoría 

```sql
SELECT p.id_producto, p.cantidad_stock, p.id_categoria, c.descripcion
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria;
```

Consultar los detalles de compras junto con la información del cliente y el producto 

```sql
SELECT c.id_compra, c.id_cliente, c.fecha, c.medio_pago, c.comentario, c.estado, cp.id_producto, cl.nombre, cl.apellidos, cl.celular, cl.dirección, cl.correo_electronico, p.nombre, p.id_categoria, p.codigo_barras, p.cantidad_stock, p.estado, cp.cantidad, cp.total, cp.estado
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN productos p ON p.id_producto = cp.id_producto
INNER JOIN clientes cl ON cl.id = c.id_cliente;
```

Consultar los productos que han sido comprados por más de una cantidad específica 

```sql
SELECT p.id_producto, p.nombre
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto
WHERE cp.cantidad > 50;
```

Consultar la cantidad total de productos vendidos por categoría 

```sql
SELECT SUM(cp.cantidad) AS total_productos, p.id_categoria
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto
GROUP BY p.id_categoria;
```

Consultar los clientes que han realizado compras en un rango de fechas específico 

```sql
SELECT c.id_cliente, cp.id_compra
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
WHERE c.fecha BETWEEN "2024-07-20" AND "2024-10-01"; 
```

Consultar el total gastado por cada cliente junto con la cantidad total de productos comprados 

```sql
SELECT c.id_cliente, SUM(cp.total) AS total_gasto, SUM(cp.cantidad) AS cantidad_comprada
FROM compras_productos cp 
INNER JOIN compras c ON c.id_compra = cp.id_compra
GROUP BY c.id_cliente;
```

Consultar los productos que nunca han sido comprados 

```sql
SELECT p.id_producto, p.nombre
FROM productos p
LEFT JOIN compras_productos cp ON p.id_producto = cp.id_producto
WHERE cp.id_producto IS NULL;
```

Consultar los clientes que han realizado más de una compra y el total gastado por ellos

```sql
SELECT c.id AS id_cliente, c.nombre, c.apellidos, COUNT(co.id_compra) AS numero_compras, SUM(cp.total) AS total_gastado
FROM clientes c
INNER JOIN compras co ON c.id = co.id_cliente
INNER JOIN compras_productos cp ON co.id_compra = cp.id_compra
GROUP BY c.id, c.nombre, c.apellidos
HAVING COUNT(co.id_compra) > 1;
```

 Consultar los productos más vendidos por categoría 

```sql
SELECT c.id_categoria, c.descripcion AS categoria, p.id_producto, p.nombre AS producto, SUM(cp.cantidad) AS total_vendido
FROM productos p
JOIN compras_productos cp ON p.id_producto = cp.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, p.id_producto
ORDER BY c.id_categoria, total_vendido DESC;
```

Consultar las compras realizadas por clientes de una ciudad específica y el total gastado 

```

```

Consultar los proveedores que han suministrado productos y la cantidad total suministrada 

```

```

**Subconsultas** 

Consultar los productos que tienen un precio de venta superior al precio promedio de todos los productos 

```sql
SELECT p.id_producto, p.nombre, p.precio_venta, p.cantidad_stock, p.estado
FROM productos p
WHERE p.precio_venta > (SELECT AVG(precio_venta) FROM productos);
```

Consultar los clientes que han gastado más del promedio general en sus compras Consultar las categorías que tienen más de 5 productos 

```

```

Consultar los productos más vendidos (top 5) por categoría 

Consultar los clientes que han realizado compras en los últimos 30 días 

Consultar las compras y sus productos para un cliente específico, mostrando solo las compras más recientes 

Consultar las categorías que tienen productos con un stock por debajo del promedio general Consultar los productos que han sido comprados por todos los clientes 

Consultar las compras que tienen más productos que el promedio de productos por compra 

Consultar los productos que se han vendido menos de la cantidad promedio de productos vendidos 