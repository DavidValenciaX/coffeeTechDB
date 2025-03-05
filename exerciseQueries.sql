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

-- Comandos VACUUM, VACUUM FULL, ANALYZE, VERBOSE

-- ANALYZE sirve para actualizar estadísticas sin recuperar espacio
ANALYZE farm;

-- Actualiza las estadísticas con una salida detallada
ANALYZE VERBOSE farm;

-- VACUUM Limpia la tabla eliminando las filas marcadas como “muertas” y ANALYZE actualiza las estadísticas de la tabla
VACUUM ANALYZE farm;

-- ejecuta comando VACUUM con estadísticas detalladas gracias al VERBOSE
VACUUM VERBOSE farm;

-- Realiza la limpieza de la tabla (VACUUM), actualiza las estadísticas (ANALYZE) y ofrece una salida detallada (VERBOSE)
VACUUM VERBOSE ANALYZE farm;

-- Realiza la limpieza profunda de la tabla (VACUUM FULL), actualiza las estadísticas (ANALYZE)
VACUUM FULL ANALYZE farm;

-- Realiza la limpieza profunda de la tabla (VACUUM FULL), y ofrece una salida detallada (VERBOSE)
VACUUM FULL VERBOSE farm;

-- Realiza la limpieza profunda de la tabla (VACUUM FULL), actualiza las estadísticas (ANALYZE) y ofrece una salida detallada (VERBOSE)
VACUUM FULL VERBOSE ANALYZE farm;

-- consultar indices
SELECT * FROM pg_indexes WHERE tablename = 'farm';

-- Rebuild a specific index by name
REINDEX INDEX idx_farm_status_id;

-- consultar estado del indice 
SELECT indexrelid::regclass AS indice,
       indisvalid,
       indisready,
       indislive
FROM pg_index
WHERE indexrelid = 'idx_farm_status_id'::regclass;

-- Comandos begin, commit y rollback

-- Test 1: Basic transaction with COMMIT
-- Begin a transaction
BEGIN;

-- Insert a new farm
INSERT INTO farm (name, area, area_unit_id, status_id) 
VALUES ('Finca La Esperanza', 25.5, 3, 22);

-- See that the farm is visible within the transaction
SELECT * FROM farm WHERE name = 'Finca La Esperanza';

-- Commit the changes to make them permanent
COMMIT;

-- Verify the farm still exists after commit
SELECT * FROM farm WHERE name = 'Finca La Esperanza';


-- Test 2: Transaction with ROLLBACK
-- Begin a transaction
BEGIN;

-- Insert another farm
INSERT INTO farm (name, area, area_unit_id, status_id) 
VALUES ('Finca Temporal', 10.0, 3, 22);

-- See that the farm is visible within the transaction
SELECT * FROM farm WHERE name = 'Finca Temporal';

-- Rollback the transaction - discard all changes
ROLLBACK;

-- Verify the farm no longer exists after rollback
SELECT * FROM farm WHERE name = 'Finca Temporal';

-- Habilitar la extensión pg_stat_statements
-- 1. Buscar el archivo de configuración postgresql.conf
-- Regularmente está en la carpeta de instalación de PostgreSQL, en la subcarpeta data
-- Por ejemplo C:\Program Files\PostgreSQL\16\data\postgresql.conf

-- 2. Abrir el archivo postgresql.conf con un editor de texto

-- 3. Buscar la línea que contiene shared_preload_libraries
-- shared_preload_libraries = 'pg_stat_statements'
-- pg_stat_statements.max = 10000  # Número máximo de declaraciones rastreadas
-- pg_stat_statements.track = all  # Rastrea todas las consultas
-- pg_stat_statements.track_utility = on  # Rastrea consultas de utilidad

-- 4. Guardar el archivo postgresql.conf y reiniciar el servicio de PostgreSQL
-- Ejecutar servicios.msc, buscar el servicio de PostgreSQL
-- En sistemas Windows, el servicio de PostgreSQL generalmente se llama:
-- postgresql-x64-[versión]
-- Por ejemplo:
-- postgresql-x64-16 (para PostgreSQL 16)
-- postgresql-x64-15 (para PostgreSQL 15)
-- click derecho en el servicio y seleccionar Reiniciar

-- 5. Verificar que la extensión pg_stat_statements está habilitada
SELECT * FROM pg_stat_statements;

-- Debe haberse creado antes la extensión pg_stat_statements con el comando:
-- CREATE EXTENSION pg_stat_statements;