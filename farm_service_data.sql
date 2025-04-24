BEGIN;

-- Inserción de unidades de área
INSERT INTO area_units (unit_of_measure_id, name, abbreviation) VALUES 
(3, 'Metro cuadrado', 'm²'),
(4, 'Kilómetro cuadrado', 'km²'),
(5, 'Hectárea', 'ha');

-- Inserción de estados de finca
INSERT INTO farm_status (status_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

-- Actualización de secuencias
SELECT setval(pg_get_serial_sequence('farm_status', 'status_id'), 
              (SELECT COALESCE(MAX(status_id), 0) + 1 FROM farm_status), false);

SELECT setval(pg_get_serial_sequence('area_units', 'area_unit_id'), 
              (SELECT COALESCE(MAX(area_unit_id), 0) + 1 FROM area_units), false);

COMMIT;