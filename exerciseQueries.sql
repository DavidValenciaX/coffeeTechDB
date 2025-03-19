--conectarse al psql
psql -U postgres -h localhost -p 5432 -d "coffeeTechDB"


-- 1. Configurar el usuario actual para la auditoría (simulando una sesión)
SET "app.current_user" = '0';

-- 2. Insertar un nuevo registro en la tabla farm
INSERT INTO farm (name, area, area_unit_id, status_id) VALUES ('Finca El Paraíso', 15, 3, 22);

-- 3. Verificar que se ha creado el registro de auditoría para la inserción
SELECT * FROM audit.farm_audit WHERE operation = 'INSERT' ORDER BY timestamp desc;

-- 4. Actualizar el registro de la finca
UPDATE farm 
SET name = 'Finca El Paraíso Renovado', 
    area = 17.8
WHERE farm_id = 161;

-- 5. Verificar que se ha creado el registro de auditoría para la actualización
SELECT * FROM audit.farm_audit WHERE operation = 'UPDATE' ORDER BY timestamp desc;

-- 6. Cambiar a otro usuario
SET "app.current_user" = "2";

-- 7. Actualizar el mismo registro de la finca
UPDATE farm 
SET name = 'Finca El Paraíso Orgánica', 
    area = 20.3,
    area_unit_id = 2,
    status_id = 23
WHERE farm_id = 161;

-- 8. Verificar que se ha creado el registro de auditoría para la actualización
SELECT * FROM audit.farm_audit WHERE operation = 'UPDATE';

-- 9. Eliminar la finca que hemos estado modificando
DELETE FROM farm 
WHERE farm_id = 161;

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

--eliminar index
DROP INDEX idx_farm_area_unit_id;


--crear index
CREATE INDEX idx_farm_area_unit_id ON public.farm USING btree (area_unit_id);

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
--ver las vistas que tengo creada
SELECT table_name FROM information_schema.views WHERE table_schema = 'public';


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

--eliminar vista:
DROP VIEW farm_info;




-- ===================================================
-- BACKUP AND RESTORE OPERATIONS IN POSTGRESQL
-- ===================================================

-- Crear backup completo de la base de datos
-- pg_dump: Herramienta para respaldo de bases PostgreSQL
--   -U postgres: Usuario de la base de datos con permisos suficientes
--   -h localhost: Dirección del servidor PostgreSQL (local)
--   -p 5432: Puerto estándar de PostgreSQL
--   -F c: Formato personalizado (custom) que permite restauración selectiva
--   -b: Incluye objetos grandes (BLOBs) en el respaldo
--   -v: Modo verbose para ver el progreso del respaldo
--   -f backup_db.sql: Nombre del archivo de salida para el respaldo
pg_dump -U postgres -h localhost -p 5432 -F c -b -v -f backup_db.sql "coffeeTechDB"

-- Eliminar la base de datos original para simular un escenario de recuperación
-- ADVERTENCIA: Esta operación elimina TODOS los datos permanentemente
--   psql: Cliente de línea de comandos de PostgreSQL
--   -d postgres: Conecta a la base de datos postgres (sistema)
--   -c: Ejecuta el comando SQL especificado
psql -U postgres -h localhost -p 5432 -d postgres -c "DROP DATABASE \"coffeeTechDB\";"

-- Crear una nueva base de datos vacía para la restauración
-- Este comando crea una base de datos limpia donde restauraremos el backup
psql -U postgres -h localhost -p 5432 -d postgres -c "CREATE DATABASE \"coffeeTechRestore\";"

-- Restaurar la base de datos desde el archivo de backup
-- pg_restore: Herramienta para restaurar backups hechos con pg_dump
--   -d CoffeeTechRestore: Base de datos destino de la restauración
--   -v: Modo verbose para ver el progreso detallado
--   backup_db.sql: Archivo de backup a restaurar
pg_restore -U postgres -h localhost -p 5432 -d coffeeTechRestore -v backup_db.sql

-- Verificar la restauración conectándose a la base y listando tablas
-- \dt: Comando de PostgreSQL que lista todas las tablas en la base actual
psql -U postgres -h localhost -p 5432 -d coffeeTechRestore
\dt

-- Insertar un registro de prueba para verificar la funcionalidad
-- Este comando inserta datos después de la restauración para confirmar
-- que la base de datos está operativa y acepta nuevos registros
psql -U postgres -h localhost -p 5432 -d CoffeeTechRestore -c "INSERT INTO farm (name, area, area_unit_id, status_id) 
VALUES ('Finca de coffeTech Restaurado', 15, 3, 22);"

-- Crear backup específico para migración a Linux
-- Se especifica un nombre diferente para el archivo de backup
-- para distinguirlo del backup original
pg_dump -U postgres -h localhost -p 5432 -F c -b -v -f backup_db_linux.sql CoffeeTechRestore

-- Transferir el archivo de backup a una máquina virtual Linux
-- scp: Secure Copy Protocol para transferir archivos entre sistemas
--   -P 22: Puerto SSH (22 es el puerto predeterminado)
--   backup_db.sql: Archivo local a transferir
--   root@0.0.0.0:/home/natalia: Destino (usuario@ip:ruta)
--   NOTA: Reemplazar 0.0.0.0 con la IP real de la máquina virtual

--Conectarse al VPS
ssh natalia@173.212.224.226
contraseña es:   nataliaeisisporsiempre

scp -P 22 backup_db.sql natalia@173.212.224.226:/home/natalia

--ver bases de datos:
sudo -u postgres psql -l

--Eliminar base de datos:
sudo -u postgres dropdb "CoffeeTechRestore"


-- En el sistema Linux: Crear una base de datos para la restauración
-- sudo -u postgres: Ejecuta el comando como usuario postgres
-- createdb: Comando de PostgreSQL para crear bases de datos
sudo -u postgres createdb CoffeeTechRestore

-- En el sistema Linux: Restaurar los datos desde el backup
-- Utiliza pg_restore pero con la sintaxis de Linux
sudo -u postgres pg_restore -d CoffeeTechRestore -v backup_db.sql

-- En el sistema Linux: Verificar la restauración
-- Primero conecta a la base de datos y lista las tablas
sudo -u postgres psql -d CoffeeTechRestore
\dt

-- En el sistema Linux: Consultar datos de la tabla farm
-- Ordena por farm_id en orden descendente para ver registros nuevos primero
sudo -u postgres psql -d CoffeeTechRestoreLinux -c "SELECT * FROM farm ORDER BY farm_id DESC;"


-- Crear backup de linux

sudo -u postgres pg_dump -F p -b -v -f ~/backup_CoffeeTechRestoreLinux.sql CoffeeTechRestore

-- pasar a windows el backup

scp -P 22 natalia@173.212.224.226:/home/natalia/backup_CoffeeTechRestoreLinux.sql "C:/Users/natyr/Documents/Universidad/10no Semestre/Mantenimiento y pruebas de software/coffeeTechDB/"

--restaurar backup de linux en windows

psql -U postgres -h localhost -p 5432 -d postgres -c "CREATE DATABASE \"CoffeeTechRestoreLinux\";"

psql -U postgres -h localhost -p 5432 -d CoffeeTechRestoreLinux -f backup_CoffeeTechRestoreLinux.sql

-- Verificar tablas


