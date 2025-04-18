BEGIN;

-- Inserción de variedades de café
INSERT INTO coffee_variety (coffee_variety_id, name) VALUES 
(1, 'Castillo'),
(2, 'Borbon'),
(3, 'Caturra'),
(4, 'Colombia'),
(5, 'Tipica'),
(6, 'Tabi');

-- Inserción de tipos de estado
INSERT INTO status_type (status_type_id, name) VALUES 
(3, 'Plot');

-- Inserción de estados
INSERT INTO status (status_id, name, status_type_id) VALUES 
(7, 'Activo', 3),
(8, 'Inactivo', 3);

-- Actualización de secuencias
SELECT setval(pg_get_serial_sequence('coffee_variety', 'coffee_variety_id'),
              (SELECT COALESCE(MAX(coffee_variety_id), 0) + 1 FROM coffee_variety), false);

SELECT setval(pg_get_serial_sequence('status', 'status_id'), 
              (SELECT COALESCE(MAX(status_id), 0) + 1 FROM status), false);

SELECT setval(pg_get_serial_sequence('status_type', 'status_type_id'), 
              (SELECT COALESCE(MAX(status_type_id), 0) + 1 FROM status_type), false);

COMMIT;