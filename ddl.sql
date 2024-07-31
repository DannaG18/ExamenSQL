CREATE DATABASE IF NOT EXISTS miscompras;
USE miscompras;

CREATE TABLE IF NOT EXISTS clientes(
    id VARCHAR(20),
    nombre VARCHAR(40),
    apellidos VARCHAR(100),
    celular DECIMAL(10,0),
    dirección VARCHAR(80),
    correo_electronico VARCHAR(100),
    CONSTRAINT pk_id_clientes PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS categorias(
    id_categoria INT(11),
    descripcion VARCHAR(45),
    estado TINYINT,
    CONSTRAINT pk_id_categorias PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS compras (
    id_compra INT(11),
    id_cliente VARCHAR(20),
    fecha DATETIME,
    medio_pago CHAR(1),
    comentario VARCHAR(300),
    estado CHAR(1),
    CONSTRAINT pk_id_compras PRIMARY KEY (id_compra),
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes (id)
);

CREATE TABLE IF NOT EXISTS productos(
    id_producto INT(11),
    nombre VARCHAR(45),
    id_categoria INT(11),
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(10,2),
    cantidad_stock INT(11),
    estado TINYINT,
    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_id_categoria FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria) 
);

CREATE TABLE IF NOT EXISTS compras_productos (
    id_compra INT(11),
    id_producto INT(11),
    cantidad INT(11),
    total DECIMAL(16,2),
    estado TINYINT,
    CONSTRAINT fk_id_compras_productos_c FOREIGN KEY (id_compra) REFERENCES compras (id_compra),
    CONSTRAINT fk_id_compras_productos_p FOREIGN KEY (id_producto) REFERENCES productos (id_producto) 
);