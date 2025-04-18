BEGIN;

-- Inserción de variedades de café
INSERT INTO coffee_variety (coffee_variety_id, name) VALUES 
(1, 'Castillo'),
(2, 'Borbon'),
(3, 'Caturra'),
(4, 'Colombia'),
(5, 'Tipica'),
(6, 'Tabi');

-- Inserción de estados de parcela
INSERT INTO plot_status (status_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

-- Actualización de secuencias
SELECT setval(pg_get_serial_sequence('coffee_variety', 'coffee_variety_id'),
              (SELECT COALESCE(MAX(coffee_variety_id), 0) + 1 FROM coffee_variety), false);

SELECT setval(pg_get_serial_sequence('plot_status', 'status_id'), 
              (SELECT COALESCE(MAX(status_id), 0) + 1 FROM plot_status), false);

COMMIT;