-- 1. Configurar el usuario actual para la auditoría (simulando una sesión)
SET "app.current_user" = '0';

-- 2. Insertar un nuevo registro en la tabla farm
INSERT INTO farm (name, area, area_unit_id, status_id) 
VALUES ('Finca El Paraíso', 15, 3, 22);

-- 3. Verificar que se ha creado el registro de auditoría para la inserción
SELECT * FROM audit.farm_audit WHERE operation = 'INSERT';

-- 4. Actualizar el registro de la finca
UPDATE farm 
SET name = 'Finca El Paraíso Renovado', 
    area = 17.8
WHERE name = 'Finca El Paraíso';

-- 5. Verificar que se ha creado el registro de auditoría para la actualización
SELECT * FROM audit.farm_audit WHERE operation = 'UPDATE';

-- 6. Cambiar a otro usuario
SET "app.current_user" = "2";

-- 7. Actualizar el mismo registro de la finca
UPDATE farm 
SET name = 'Finca El Paraíso Orgánica', 
    area = 20.3,
    area_unit_id = 2,
    status_id = 23
WHERE name = 'Finca El Paraíso Renovado';

-- 8. Verificar que se ha creado el registro de auditoría para la actualización
SELECT * FROM audit.farm_audit WHERE operation = 'UPDATE';

-- 9. Eliminar la finca que hemos estado modificando
DELETE FROM farm 
WHERE name = 'Finca El Paraíso Orgánica';

-- 10. Verificar que se ha creado el registro de auditoría para la eliminación
SELECT * FROM audit.farm_audit WHERE operation = 'DELETE';

-- 11. Consultar filas vivas y muertas

SELECT schemaname, relname AS table_name, n_live_tup AS filas_vivas, n_dead_tup AS filas_muertas, last_autovacuum, last_vacuum
FROM pg_stat_all_tables
WHERE schemaname NOT IN ('pg_toast', 'pg_catalog', 'information_schema')
ORDER BY n_dead_tup 
DESC
LIMIT 50;