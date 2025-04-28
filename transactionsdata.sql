INSERT INTO transaction_types (transaction_type_id, name) VALUES 
(1, 'Ingreso'),
(2, 'Gasto');

INSERT INTO transaction_categories (transaction_category_id, name, transaction_type_id) VALUES 
(1, 'Venta de café', 1),
(2, 'Otros', 1),
(3, 'Pagos a colaboradores', 2),
(4, 'Fertilizantes', 2),
(5, 'Plaguicidas/herbicidas', 2),
(6, 'Otros', 2);

INSERT INTO transaction_states (transaction_state_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

SELECT setval(pg_get_serial_sequence('transaction_types', 'transaction_type_id'), 
              (SELECT COALESCE(MAX(transaction_type_id), 0) + 1 FROM transaction_types), false);

SELECT setval(pg_get_serial_sequence('transaction_categories', 'transaction_category_id'), 
              (SELECT COALESCE(MAX(transaction_category_id), 0) + 1 FROM transaction_categories), false);

SELECT setval(pg_get_serial_sequence('transaction_states', 'transaction_state_id'), 
              (SELECT COALESCE(MAX(transaction_state_id), 0) + 1 FROM transaction_states), false);