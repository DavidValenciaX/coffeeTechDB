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