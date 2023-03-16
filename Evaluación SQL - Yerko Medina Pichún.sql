#Creacion del schema
CREATE SCHEMA negocio;


#Usar el schema
USE negocio;



#Creacion de todas las tablas

CREATE TABLE Producto(
	id_producto INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_producto VARCHAR(50),
    precio_unitario DOUBLE,
    id_categoria INTEGER
);

CREATE TABLE Proveedor(
	id_proveedor INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_proveedor VARCHAR(50)
);

CREATE TABLE ProductoProveedor(
	id_producto_proveedor INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_producto INTEGER,
    id_proveedor INTEGER,
    cantidad_producto INTEGER,
    precio_unitario DOUBLE,
    fecha_compra DATE
);

CREATE TABLE Categoria(
	id_categoria INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_categoria VARCHAR(50)
);

CREATE TABLE Boleta(
	id_boleta INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fecha DATE,
    precio_total DOUBLE
);

CREATE TABLE BoletaProducto(
	id_boleta_producto INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_boleta INTEGER,
    id_producto INTEGER,
    cantidad_producto INTEGER,
    precio_total DOUBLE
);

CREATE TABLE InformeAnual(
	id_informe_anual INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    anio YEAR,
    ventas DECIMAL,
    costos DECIMAL,
    ganancias DECIMAL,
    productos_vendidos INTEGER
);

CREATE TABLE InformeAnualBoletas(
	id_informe_anual_boletas INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_informe_anual INTEGER,
    id_boleta INTEGER
);




#Relacionando todas las tablas correspondientes

ALTER TABLE ProductoProveedor
ADD CONSTRAINT fk_ProductoProveedor_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
ADD CONSTRAINT fk_ProductoProveedor_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor);

ALTER TABLE BoletaProducto
ADD CONSTRAINT fk_BoletaProducto_boleta FOREIGN KEY (id_boleta) REFERENCES Boleta (id_boleta),
ADD CONSTRAINT fk_BoletaProducto_producto FOREIGN KEY (id_producto) REFERENCES Producto (id_producto);

ALTER TABLE InformeAnualBoletas
ADD CONSTRAINT fk_InformeAnualBoletas_informeAnual FOREIGN KEY (id_informe_anual) REFERENCES InformeAnual(id_informe_anual),
ADD CONSTRAINT fk_InformeAnualBoletas_boletas FOREIGN KEY (id_boleta) REFERENCES Boleta(id_boleta);




#Insertando datos del Proveedor

INSERT INTO Proveedor(nombre_proveedor) VALUES('Lider'), ('Tottus'), ('Jumbo'), ('Alvi'), ('Acuenta');
#SELECT * FROM Proveedor;


#Insertando datos de las Categorias

INSERT INTO Categoria(nombre_categoria) VALUES('Frutas'),('Verduras'),('Carnes'),('Legumbres'),('Bebidas');
#SELECT * FROM Categoria;




#Insertando datos del Producto
INSERT INTO Producto (nombre_producto,precio_unitario,id_categoria) VALUES('Manzana',100,1),('Naranja',120,1),('Platano',300,1);

INSERT INTO Producto (nombre_producto,precio_unitario,id_categoria) VALUES('Ajo',50,2),('Cebolla',180,2),('Lechuga',240,2);

INSERT INTO Producto (nombre_producto,precio_unitario,id_categoria) VALUES('Vacuno',850,3),('Pollo',750,3),('Salmon',1000,3);

INSERT INTO Producto (nombre_producto,precio_unitario,id_categoria) VALUES('Porotos',200,4),('Lentejas',240,4),('Garbanzos',210,4);

INSERT INTO Producto (nombre_producto,precio_unitario,id_categoria) VALUES('Coca-cola',750,5),('Fanta',600,5),('Sprite',550,5);

#SELECT * FROM Producto;





#Insertando los datos de la tabla ProductoProveedor

INSERT INTO ProductoProveedor
(id_producto,id_proveedor,cantidad_producto,precio_unitario,fecha_compra) 
VALUES
(1,1,200,20,'2023-03-10'),
(2,2,150,40,'2023-03-11'),
(2,3,150,40,'2023-03-12'),
(3,3,120,90,'2023-03-12'),
(4,2,80,10,'2023-03-11'),
(5,4,210,40,'2023-03-13'),
(6,1,200,80,'2023-03-10'),
(7,5,100,400,'2023-03-15'),
(8,5,150,350,'2023-03-15'),
(9,3,100,550,'2023-03-12'),
(10,4,150,35,'2023-03-13'),
(11,4,115,45,'2023-03-13'),
(12,3,75,40,'2023-03-12'),
(13,1,250,450,'2023-03-10'),
(14,2,150,400,'2023-03-11'),
(15,1,150,350,'2023-03-10')
;

#SELECT * FROM ProductoProveedor;



#Insertando datos de la Boleta
INSERT INTO Boleta(fecha,precio_total)
VALUES
('2023-03-15',11380),
('2023-03-15',28290);




#Insertando datos de la tabla BoletaProducto

INSERT INTO
BoletaProducto (id_boleta,id_producto,cantidad_producto,precio_total)
VALUES(1,1,10,1000),
(1,4,8,400),
(1,5,3,540),
(1,9,3,3000),
(1,11,6,1440),
(1,10,8,1600),
(1,13,3,2250),
(1,14,1,600),
(1,15,1,550);

INSERT INTO
BoletaProducto (id_boleta,id_producto,cantidad_producto,precio_total)
VALUES(2,2,12,1440),
(2,8,4,3000),
(2,7,4,3400),
(2,13,15,11250),
(2,14,8,4800),
(2,15,8,4400);



#Insertando datos del Informe Anual
INSERT INTO InformeAnual (anio,ventas,costos,ganancias,productos_vendidos) VALUES 
('2023',39670,437925,-398255,94);

#SELECT * FROM InformeAnual;



#Insertando los datos del InformeAnualBoletas

INSERT INTO InformeAnualBoletas(id_informe_anual,id_boleta) 
VALUES (1,1),(1,2);


###############################
SHOW TABLES;

#Consultas básicas
SELECT * FROM Categoria;
SELECT * FROM Proveedor;


#PD: No sabía si las consultas con el * contaban como consultas básicas
#así que agregué estas otras 2, una con la sintaxis de "Tabla.columna" y la otra con "columna"
SELECT Producto.nombre_producto,Producto.precio_unitario FROM Producto;

#Las ganancias las muestra en negativo ya que solo agregué 2 boletas que suman 39670
#Pero los costos son más, ya que puse muchisimos productos que se compraron al Proveedor
#por lo tanto las ganancias quedan en negativo, se supone que se existieran más boletas se verían las ganancias en positivo
SELECT anio,ventas,costos,ganancias,productos_vendidos FROM InformeAnual;


#Consultas con INNER JOIN
SELECT nombre_producto AS producto ,nombre_categoria AS categoria FROM Producto
INNER JOIN Categoria ON Producto.id_categoria = Categoria.id_categoria;


#SELECT * FROM Producto;#nombre_producto
#SELECT * FROM Categoria;#nombre_categoria
#SELECT * FROM ProductoProveedor;#precio_unitario,cantidad_producto,fecha_compra
#SELECT * FROM Proveedor;#nombre_proveedor

SELECT 
Producto.nombre_producto AS producto,
Categoria.nombre_categoria AS categoria,
ProductoProveedor.precio_unitario,ProductoProveedor.cantidad_producto AS cantidad,ProductoProveedor.fecha_compra AS fecha,
Proveedor.nombre_proveedor AS proveedor
FROM ProductoProveedor
INNER JOIN Proveedor ON ProductoProveedor.id_proveedor = Proveedor.id_proveedor
INNER JOIN Producto ON ProductoProveedor.id_producto = Producto.id_producto
INNER JOIN Categoria ON Producto.id_categoria = Categoria.id_categoria ORDER BY categoria ASC;




