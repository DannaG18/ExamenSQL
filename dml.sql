INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico) 
VALUES (001, "Danna", "Alvarez", 3182010789, "Cra 17a #5-27 Florida Blanca", "dannag.alvarezr@gmail.com"),
        (002, "Gabriela", "Alvarez", 3182010789, "Cra 17a #5-27 Florida Blanca", "dannag.alvarezr@gmail.com"),
        (003, "DannaG", "Alvarez", 3182010789, "Cra 17a #5-27 Florida Blanca", "dannag.alvarezr@gmail.com");

INSERT INTO categorias (id_categoria, descripcion, estado)
VALUES (001, "Este es un ejemplo de categoría 1", 1),
        (002, "Este es un ejemplo de categoría 2", 1),
        (003, "Este es un ejemplo de categoría 3", 1);

INSERT INTO compras (id_compra, id_cliente, fecha, medio_pago,comentario, estado)
VALUES (001, 001, "2024-09-18", "e", "Es un excelente producto", 1),
        (002, 002, "2024-09-18", "t", "Es un excelente producto", 1),
        (003, 003, "2024-09-18", "t", "Es un excelente producto", 1);

INSERT INTO productos (id_producto, nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES (001, "Camisa", 001, "K231D", 50.00, 100, 1),
        (002, "Pantalon", 001, "K238D", 80.00, 100, 2),
        (003, "Vestido", 001, "K131D", 90.00, 100, 1);

INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado)
VALUES (001, 001, 100, 5560.00, 1),
        (002, 001, 50, 5560.00, 1);

--Productos y categorias

SELECT p.id_producto, p.nombre, p.id_categoria
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria; 

--compras x cliente

SELECT c.id_compra, c.id_cliente
FROM compras c;

--productos en una compra especifica

SELECT cp.id_compra, cp.id_producto
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto;

--add new producto

INSERT INTO productos (id_producto, nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado)
VALUES (001, "Camisa", 001, "K231D", 50.00, 100, 1);

--UPDATE producto

UPDATE productos
SET cantidad_stock = 50
WHERE id_producto = 001;

--compras cliente especifico

SELECT c.id_compra, c.id_cliente
FROM compras c
WHERE c.id_cliente = 001;

--correos clientes

SELECT c.nombre, c.correo_electronico
FROM clientes c;

--cantidad de productos comprados X compra

SELECT cp.id_compra, cp.cantidad
FROM compras_productos cp;

--compras en rango de fechas
SELECT c.id_compra
FROM compras c 
WHERE c.fecha BETWEEN "2024-05-18" AND "2024-10-12";

--FUNCIONES AGREGADAS

--cantidad de productos por categoria

SELECT COUNT(p.id_producto) AS cantidad_producto, c.id_categoria
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria
GROUP BY id_categoria; 

--total de ventas x cliente

SELECT SUM(cp.total) AS total_compras, c.id_cliente
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY c.id_cliente;

--promedio de productos por categoria

SELECT AVG(id_producto) AS promedio_productos, p.id_categoria
FROM productos p
GROUP BY id_categoria;

--primera y ultima compra registrada

SELECT MIN(c.fecha) AS primera_compra, MAX(c.fecha) AS ultima_compra
FROM compras c;

--ingresos x venta

SELECT SUM(total) AS Ingresos
FROM compras_productos
GROUP BY total;

--compras por cada medio de pago

SELECT COUNT(c.id_compra) AS cantidad_compras, c.medio_pago
FROM compras c
GROUP BY medio_pago;

--total de productos vendidos por cada producto 

SELECT SUM(cp.cantidad) AS total_venta_p, cp.id_producto, p.nombre
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto
GROUP BY cp.id_producto;

--promedio de cantidad de productos comprados por compra 

SELECT AVG(cp.cantidad) AS total_venta_p, cp.id_compra
FROM compras_productos cp
GROUP BY cp.id_compra;

-- productos con el stock más bajo 

SELECT MIN(cantidad_stock) AS stock_mas_bajo, id_producto
FROM productos p
GROUP BY id_producto;

-- total de productos comprados y el total gastado por cliente 

SELECT SUM(cp.id_producto) AS total_productos, SUM(cp.total) AS total_gasto, c.id_cliente
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN clientes cl ON cl.id = c.id_cliente
GROUP BY c.id_cliente;

--CONSULTAS CON JOIN

-- productos con sus categorías Consultar todas las compras y los clientes que las realizaron 
SELECT p.id_producto, p.id_categoria, cp.id_compra, c.id_cliente
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN clientes cl ON cl.id = c.id_cliente; 

-- productos comprados en cada compra

SELECT cp.id_compra, cp.id_producto, p.nombre
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto; 

-- compras realizadas por un cliente específico 
SELECT c.id_compra, c.id_cliente
FROM compras c
WHERE c.id_cliente = 002;

-- total gastado por cada cliente

SELECT SUM(cp.total) AS gasto, c.id_cliente
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
GROUP BY c.id_cliente;

-- stock disponible de productos y su categoria 

SELECT p.id_producto, p.cantidad_stock, p.id_categoria, c.descripcion
FROM productos p
INNER JOIN categorias c ON c.id_categoria = p.id_categoria;

--  detalles de compras junto con la información del cliente y el producto

SELECT c.id_compra, c.id_cliente, c.fecha, c.medio_pago, c.comentario, c.estado, cp.id_producto, cl.nombre, cl.apellidos, cl.celular, cl.dirección, cl.correo_electronico, p.nombre, p.id_categoria, p.codigo_barras, p.cantidad_stock, p.estado, cp.cantidad, cp.total, cp.estado
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
INNER JOIN productos p ON p.id_producto = cp.id_producto
INNER JOIN clientes cl ON cl.id = c.id_cliente;

-- productos que han sido comprados por más de una cantidad específica

SELECT p.id_producto, p.nombre
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto
WHERE cp.cantidad > 50;

-- productos vendidos x categoría
SELECT SUM(cp.cantidad) AS total_productos, p.id_categoria
FROM compras_productos cp
INNER JOIN productos p ON p.id_producto = cp.id_producto
GROUP BY p.id_categoria;

-- clientes con compras en un rango de fechas

SELECT c.id_cliente, cp.id_compra
FROM compras_productos cp
INNER JOIN compras c ON c.id_compra = cp.id_compra
WHERE c.fecha BETWEEN "2024-07-20" AND "2024-10-01"; 

--  total gastado por cada cliente junto con la cantidad total de productos comprados 

SELECT c.id_cliente, SUM(cp.total) AS total_gasto, SUM(cp.cantidad) AS cantidad_comprada
FROM compras_productos cp 
INNER JOIN compras c ON c.id_compra = cp.id_compra
GROUP BY c.id_cliente;

-- productos que nunca han sido comprados

SELECT p.id_producto, p.nombre
FROM productos p
LEFT JOIN compras_productos cp ON p.id_producto = cp.id_producto
WHERE cp.id_producto IS NULL;

-- clientes con mas de una compra y total gastado

SELECT c.id AS id_cliente, c.nombre, c.apellidos, COUNT(co.id_compra) AS numero_compras, SUM(cp.total) AS total_gastado
FROM clientes c
INNER JOIN compras co ON c.id = co.id_cliente
INNER JOIN compras_productos cp ON co.id_compra = cp.id_compra
GROUP BY c.id, c.nombre, c.apellidos
HAVING COUNT(co.id_compra) > 1;

-- producto más vendido por cateoria

SELECT c.id_categoria, c.descripcion AS categoria, p.id_producto, p.nombre AS producto, SUM(cp.cantidad) AS total_vendido
FROM productos p
JOIN compras_productos cp ON p.id_producto = cp.id_producto
JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.id_categoria, p.id_producto
ORDER BY c.id_categoria, total_vendido DESC;

-- SUBCONSULTAS 
-- productos que tienen un precio de venta superior al precio promedio de todos los productos 
SELECT p.id_producto, p.nombre, p.precio_venta, p.cantidad_stock, p.estado
FROM productos p
WHERE p.precio_venta > (SELECT AVG(precio_venta) FROM productos);
