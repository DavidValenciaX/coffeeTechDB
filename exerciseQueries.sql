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
WHERE farm_id = 165;

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
WHERE farm_id = 165;

-- 8. Verificar que se ha creado el registro de auditoría para la actualización
SELECT * FROM audit.farm_audit WHERE operation = 'UPDATE';

-- 9. Eliminar la finca que hemos estado modificando
DELETE FROM farm 
WHERE farm_id = 165;

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


-- Vistas
--Creacion de vista
CREATE VIEW farm_info AS
SELECT farm_id, name, area
FROM farm;

CREATE VIEW farm_with_status AS
SELECT f.farm_id, f.name, s.name AS status_name
FROM farm f
JOIN status s ON f.status_id = s.status_id;


-- Ver las vistas:
SELECT * FROM farm_info;
SELECT * FROM farm_with_status;

--Backups 

--Crear el backup
pg_dump -U postgres -h localhost -p 5432 -F c -b -v -f backup_db.sql CoffeeTech
--Eliminar la base de datos
psql -U postgres -h localhost -p 5432 -d postgres -c "DROP DATABASE \"CoffeeTech\";"

--Crear db
psql -U postgres -h localhost -p 5432 -d postgres -c "CREATE DATABASE \"CoffeeTechRestore\";"

--Restaurar db
pg_restore -U postgres -h localhost -p 5432 -d CoffeeTechRestore -v backup_db.sql

-- ver la tabla farm
psql -U postgres -h localhost -p 5432 -d CoffeeTechRestore
\dt

--Ingresar dato para pasar a linux
psql -U postgres -h localhost -p 5432 -d CoffeeTechRestore -c "INSERT INTO farm (name, area, area_unit_id, status_id) 
VALUES ('Finca de coffeTech Restaurado', 15, 3, 22);"

--Crear backup para linux
pg_dump -U postgres -h localhost -p 5432 -F c -b -v -f backup_db_linux.sql CoffeeTechRestore

--Pasar el backup a la VM

scp -P 22 backup_db.sql root@0.0.0.0:/home/natalia


--Crear base de datos en linux
sudo -u postgres createdb CoffeeTechRestore

--Restaurar datos:
sudo -u postgres pg_restore -d CoffeeTechRestore -v backup_db.sql

-- Ver la tabla farm
sudo -u postgres psql -d CoffeeTechRestore
\dt
sudo -u postgres psql -d CoffeeTechRestore -c "SELECT * FROM farm ORDER BY farm_id DESC;"


-- Crear backup de linux

sudo -u postgres pg_dump -F p -b -v -f ~/backup_CoffeeTechRestoreLinux.sql CoffeeTechRestore

-- pasar a windows el backup

scp -P 22 natalia@173.212.224.226:/home/natalia/backup_CoffeeTechRestoreLinux.sql "C:/Users/natyr/Documents/Universidad/10no Semestre/Mantenimiento y pruebas de software/coffeeTechDB/"

--restaurar backup de linux en windows

psql -U postgres -h localhost -p 5432 -d postgres -c "CREATE DATABASE \"CoffeeTechRestoreLinux\";"

psql -U postgres -h localhost -p 5432 -d CoffeeTechRestoreLinux -f backup_CoffeeTechRestoreLinux.sql

-- Verificar tablas


