CREATE DATABASE clientesYPedidos;

Use clientesYPedidos;

-- Se crean las tablas
CREATE TABLE clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    direccion VARCHAR(80) NOT NULL,
    telefono BIGINT NOT NULL
);

CREATE TABLE pedidos (
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    FOREIGN KEY(cliente_id) REFERENCES clientes(id_cliente),
    fecha DATE,
    total FLOAT
);

-- Se insertan los valores correspondientes en cada tabla
INSERT INTO clientes (nombre, direccion, telefono)
VALUES	('Lore', 'Calle 2', 56911188345),
		('Agustin', 'Las Flores 34', 56936485922),
        ('Benito', 'Pasaje Sol 700', 56923785600),
        ('Carmen', 'Villa Alemana 23', 56936759884),
        ('Diego', 'Condominio Andalue 56', 56923700001);

INSERT INTO pedidos (cliente_id, fecha, total) VALUES
(1, '2025-10-15', 150.50),
(1, '2025-11-17', 300.00),
(2, '2025-11-18', 55.75),
(3, '2025-11-18', 450.00),
(1, '2025-11-20', 120.99),
(3, '2025-11-21', 800.00),
(4, '2025-11-21', 25.00),
(4, '2025-11-22', 90.00),
(4, '2025-11-23', 120.00),
(5, '2025-11-28', 50.00),
(1, '2025-12-01', 200.00);

-- Se extraen los clientes con sus respectivos pedidos
SELECT c.nombre, p.id_pedido, p.fecha, p.total
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.cliente_id;

-- Se extraen los pedidos realizados por el cliente id_cliente = 1
SELECT
	c.nombre AS nombre_cliente,
    p.id_pedido,
    p.fecha,
    p.total
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id_cliente 
WHERE c.id_cliente = 1;

-- Se calcula el total de todos los pedidos de cada cliente
SELECT
    c.nombre AS nombre_cliente,
    SUM(p.total) AS total_gastado
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.cliente_id
GROUP BY c.nombre;

-- Se elimina el cliente id_cliente = 5 y sus pedidos
DELETE FROM pedidos
WHERE cliente_id = 5;

DELETE FROM clientes
WHERE id_cliente = 5;

-- Se visualiza cada tabla para ver que se hayan eliminado correctamente
SELECT * FROM clientes;

SELECT * FROM pedidos;

-- Se visualizan los 3 clientes que tienen mas pedidos en orden descendente
SELECT
    c.nombre AS nombre_cliente,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.cliente_id
GROUP BY c.nombre
ORDER BY cantidad_pedidos DESC
LIMIT 3;


