BEGIN;

-- Inserción de tipos de unidades de medida
INSERT INTO unit_of_measure_type (unit_of_measure_type_id, name) VALUES 
(1, 'Longitud'),
(2, 'Área'),
(3, 'Masa'),
(4, 'Densidad'),
(5, 'Temperatura'),
(6, 'Precipitación');

-- Inserción de unidades de medida
INSERT INTO unit_of_measure (unit_of_measure_id, name, abbreviation, unit_of_measure_type_id) VALUES 
(1, 'Metro', 'm', 1),
(2, 'Kilómetro', 'km', 1),
(3, 'Hectárea', 'ha', 2),
(4, 'Plantas por hectárea', 'pl/ha', 4),
(5, 'Kilogramos', 'kg', 3),
(6, 'Grados Celsius', '°C', 5),
(7, 'Milímetros', 'mm', 6),
(8, 'Metro cuadrado', 'm²', 2),
(9, 'Kilómetro cuadrado', 'km²', 2);

-- Inserción de estados de finca
INSERT INTO farm_status (farm_status_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');


-- Actualización de secuencias
SELECT setval(pg_get_serial_sequence('farm_status', 'farm_status_id'), 
              (SELECT COALESCE(MAX(farm_status_id), 0) + 1 FROM farm_status), false);

SELECT setval(pg_get_serial_sequence('unit_of_measure_type', 'unit_of_measure_type_id'), 
              (SELECT COALESCE(MAX(unit_of_measure_type_id), 0) + 1 FROM unit_of_measure_type), false);

SELECT setval(pg_get_serial_sequence('unit_of_measure', 'unit_of_measure_id'), 
              (SELECT COALESCE(MAX(unit_of_measure_id), 0) + 1 FROM unit_of_measure), false);

COMMIT;