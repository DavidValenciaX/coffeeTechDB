BEGIN;

-- Inserción de tipos de estado
INSERT INTO status_type (status_type_id, name) VALUES 
(7, 'Transaction');

-- Inserción de estados
INSERT INTO status (status_id, name, status_type_id) VALUES 
(20, 'Activo', 7),
(21, 'Inactivo', 7);

-- Inserción de tipos de transacción
INSERT INTO transaction_type (transaction_type_id, name) VALUES 
(1, 'Ingreso'),
(2, 'Gasto');

-- Inserción de categorías de transacción
INSERT INTO transaction_category (transaction_category_id, name, transaction_type_id) VALUES 
(1, 'Venta de café', 1),
(2, 'Otros', 1),
(3, 'Pagos a colaboradores', 2),
(4, 'Fertilizantes', 2),
(5, 'Plaguicidas/herbicidas', 2),
(6, 'Otros', 2);

-- Actualización de secuencias
SELECT setval(pg_get_serial_sequence('status', 'status_id'), 
              (SELECT COALESCE(MAX(status_id), 0) + 1 FROM status), false);

SELECT setval(pg_get_serial_sequence('status_type', 'status_type_id'), 
              (SELECT COALESCE(MAX(status_type_id), 0) + 1 FROM status_type), false);

SELECT setval(pg_get_serial_sequence('transaction_category', 'transaction_category_id'), 
              (SELECT COALESCE(MAX(transaction_category_id), 0) + 1 FROM transaction_category), false);

SELECT setval(pg_get_serial_sequence('transaction_type', 'transaction_type_id'), 
              (SELECT COALESCE(MAX(transaction_type_id), 0) + 1 FROM transaction_type), false);

COMMIT;