BEGIN;

-- Create audit schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS audit;

-- Create an ENUM type for audit operations
CREATE TYPE audit.operation_type AS ENUM ('INSERT', 'UPDATE', 'DELETE');

-- Audit table for cultural_work_tasks
CREATE TABLE IF NOT EXISTS audit.cultural_work_tasks_audit (
    audit_id SERIAL PRIMARY KEY,
    cultural_work_tasks_id INTEGER,
    cultural_works_id INTEGER,
    plot_id INTEGER,
    reminder_owner BOOLEAN,
    reminder_collaborator BOOLEAN,
    collaborator_user_id INTEGER,
    owner_user_id INTEGER,
    status_id INTEGER,
    task_date DATE,
    created_at TIMESTAMP,
    operation audit.operation_type NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for farm
CREATE TABLE IF NOT EXISTS audit.farm_audit (
    audit_id SERIAL PRIMARY KEY,
    farm_id INTEGER,
    name VARCHAR(255),
    area NUMERIC(10,2),
    area_unit_id INTEGER,
    status_id INTEGER,
    operation audit.operation_type NOT NULL,
    old_name VARCHAR(255),
    old_area NUMERIC(10,2),
    old_area_unit_id INTEGER,
    old_status_id INTEGER,
    modified_by_user_id INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for health_checks
CREATE TABLE IF NOT EXISTS audit.health_checks_audit (
    audit_id SERIAL PRIMARY KEY,
    health_checks_id INTEGER,
    check_date DATE,
    recommendation_id INTEGER,
    prediction VARCHAR(150),
    cultural_work_tasks_id INTEGER,
    status_id INTEGER,
    operation audit.operation_type NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for flowering
CREATE TABLE IF NOT EXISTS audit.flowering_audit (
    audit_id SERIAL PRIMARY KEY,
    flowering_id INTEGER,
    plot_id INTEGER,
    flowering_date DATE,
    harvest_date DATE,
    status_id INTEGER,
    flowering_type_id INTEGER,
    operation audit.operation_type NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for plot
CREATE TABLE IF NOT EXISTS audit.plot_audit (
    audit_id SERIAL PRIMARY KEY,
    plot_id INTEGER,
    name VARCHAR(255),
    longitude NUMERIC(11, 8),
    latitude NUMERIC(11, 8),
    altitude NUMERIC(10, 2),
    coffee_variety_id INTEGER,
    farm_id INTEGER,
    status_id INTEGER,
    operation audit.operation_type NOT NULL,
    old_name VARCHAR(255),
    old_longitude NUMERIC(11, 8),
    old_latitude NUMERIC(11, 8),
    old_altitude NUMERIC(10, 2),
    old_coffee_variety_id INTEGER,
    old_farm_id INTEGER,
    old_status_id INTEGER,
    modified_by_user_id INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for role_permission
CREATE TABLE IF NOT EXISTS audit.role_permission_audit (
    audit_id SERIAL PRIMARY KEY,
    role_id INTEGER,
    permission_id INTEGER,
    operation audit.operation_type NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for transaction
CREATE TABLE IF NOT EXISTS audit.transaction_audit (
    audit_id SERIAL PRIMARY KEY,
    transaction_id INTEGER,
    plot_id INTEGER,
    description varchar(255),
    transaction_type_id INTEGER,
    transaction_date DATE,
    status_id INTEGER,
    value numeric(15,2),
    transaction_category_id INTEGER,
    creador_id INTEGER,
    operation audit.operation_type NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for users
CREATE TABLE IF NOT EXISTS audit.users_audit (
    audit_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    name VARCHAR(255),
    email VARCHAR(150),
    password_hash VARCHAR(255),
    verification_token VARCHAR(255),
    session_token varchar(255),
    status_id INTEGER,
    fcm_token VARCHAR(255),
    operation audit.operation_type NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- FUNCTIONS

CREATE OR REPLACE FUNCTION log_cultural_work_tasks_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.cultural_work_tasks_audit (
            cultural_work_tasks_id, cultural_works_id, plot_id, 
            reminder_owner, reminder_collaborator, collaborator_user_id, 
            owner_user_id, status_id, task_date, created_at, operation
        ) VALUES (
            NEW.cultural_work_tasks_id, NEW.cultural_works_id, NEW.plot_id,
            NEW.reminder_owner, NEW.reminder_collaborator, NEW.collaborator_user_id,
            NEW.owner_user_id, NEW.status_id, NEW.task_date, NEW.created_at, 'INSERT'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.cultural_work_tasks_audit (
            cultural_work_tasks_id, cultural_works_id, plot_id, 
            reminder_owner, reminder_collaborator, collaborator_user_id, 
            owner_user_id, status_id, task_date, created_at, operation
        ) VALUES (
            NEW.cultural_work_tasks_id, NEW.cultural_works_id, NEW.plot_id,
            NEW.reminder_owner, NEW.reminder_collaborator, NEW.collaborator_user_id,
            NEW.owner_user_id, NEW.status_id, NEW.task_date, NEW.created_at, 'UPDATE'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.cultural_work_tasks_audit (
            cultural_work_tasks_id, cultural_works_id, plot_id, 
            reminder_owner, reminder_collaborator, collaborator_user_id, 
            owner_user_id, status_id, task_date, created_at, operation
        ) VALUES (
            OLD.cultural_work_tasks_id, OLD.cultural_works_id, OLD.plot_id,
            OLD.reminder_owner, OLD.reminder_collaborator, OLD.collaborator_user_id,
            OLD.owner_user_id, OLD.status_id, OLD.task_date, OLD.created_at, 'DELETE'
        );
    END IF;
    
    RETURN NEW;
END;
$$;

-- Función mejorada para auditar cambios en farm
CREATE OR REPLACE FUNCTION log_farm_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    val_user_id INTEGER;
BEGIN
    -- Obtener el ID del usuario actual desde la sesión si está disponible
    BEGIN
        val_user_id := NULLIF(current_setting('app.current_user', true), '')::INTEGER;
    EXCEPTION
        WHEN OTHERS THEN
            val_user_id := NULL;
    END;

    -- Registrar según el tipo de operación
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.farm_audit (
            farm_id, name, area, area_unit_id, status_id, operation, modified_by_user_id
        ) VALUES (
            NEW.farm_id, NEW.name, NEW.area, NEW.area_unit_id, NEW.status_id, 'INSERT', val_user_id
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.farm_audit (
            farm_id, name, area, area_unit_id, status_id, 
            old_name, old_area, old_area_unit_id, old_status_id,
            operation, modified_by_user_id
        ) VALUES (
            NEW.farm_id, NEW.name, NEW.area, NEW.area_unit_id, NEW.status_id,
            OLD.name, OLD.area, OLD.area_unit_id, OLD.status_id,
            'UPDATE', val_user_id
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.farm_audit (
            farm_id, name, area, area_unit_id, status_id, operation, modified_by_user_id
        ) VALUES (
            OLD.farm_id, OLD.name, OLD.area, OLD.area_unit_id, OLD.status_id, 'DELETE', val_user_id
        );
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION log_health_checks_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.health_checks_audit (
            health_checks_id, check_date, recommendation_id, prediction, 
            cultural_work_tasks_id, status_id, operation
        ) VALUES (
            NEW.health_checks_id, NEW.check_date, NEW.recommendation_id, NEW.prediction,
            NEW.cultural_work_tasks_id, NEW.status_id, 'INSERT'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.health_checks_audit (
            health_checks_id, check_date, recommendation_id, prediction, 
            cultural_work_tasks_id, status_id, operation
        ) VALUES (
            NEW.health_checks_id, NEW.check_date, NEW.recommendation_id, NEW.prediction,
            NEW.cultural_work_tasks_id, NEW.status_id, 'UPDATE'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.health_checks_audit (
            health_checks_id, check_date, recommendation_id, prediction, 
            cultural_work_tasks_id, status_id, operation
        ) VALUES (
            OLD.health_checks_id, OLD.check_date, OLD.recommendation_id, OLD.prediction,
            OLD.cultural_work_tasks_id, OLD.status_id, 'DELETE'
        );
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION log_flowering_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.flowering_audit (
            flowering_id, plot_id, flowering_date, harvest_date, 
            status_id, flowering_type_id, operation
        ) VALUES (
            NEW.flowering_id, NEW.plot_id, NEW.flowering_date, NEW.harvest_date,
            NEW.status_id, NEW.flowering_type_id, 'INSERT'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.flowering_audit (
            flowering_id, plot_id, flowering_date, harvest_date, 
            status_id, flowering_type_id, operation
        ) VALUES (
            NEW.flowering_id, NEW.plot_id, NEW.flowering_date, NEW.harvest_date,
            NEW.status_id, NEW.flowering_type_id, 'UPDATE'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.flowering_audit (
            flowering_id, plot_id, flowering_date, harvest_date, 
            status_id, flowering_type_id, operation
        ) VALUES (
            OLD.flowering_id, OLD.plot_id, OLD.flowering_date, OLD.harvest_date,
            OLD.status_id, OLD.flowering_type_id, 'DELETE'
        );
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION log_plot_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    val_user_id INTEGER;
BEGIN
    -- Obtener el ID del usuario actual desde la sesión si está disponible
    BEGIN
        val_user_id := NULLIF(current_setting('app.current_user', true), '')::INTEGER;
    EXCEPTION
        WHEN OTHERS THEN
            val_user_id := NULL;
    END;

    -- Registrar según el tipo de operación
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.plot_audit (
            plot_id, name, longitude, latitude, altitude,
            coffee_variety_id, farm_id, status_id, operation, modified_by_user_id
        ) VALUES (
            NEW.plot_id, NEW.name, NEW.longitude, NEW.latitude, NEW.altitude,
            NEW.coffee_variety_id, NEW.farm_id, NEW.status_id, 'INSERT', val_user_id
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.plot_audit (
            plot_id, name, longitude, latitude, altitude,
            coffee_variety_id, farm_id, status_id,
            old_name, old_longitude, old_latitude, old_altitude,
            old_coffee_variety_id, old_farm_id, old_status_id,
            operation, modified_by_user_id
        ) VALUES (
            NEW.plot_id, NEW.name, NEW.longitude, NEW.latitude, NEW.altitude,
            NEW.coffee_variety_id, NEW.farm_id, NEW.status_id,
            OLD.name, OLD.longitude, OLD.latitude, OLD.altitude,
            OLD.coffee_variety_id, OLD.farm_id, OLD.status_id,
            'UPDATE', val_user_id
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.plot_audit (
            plot_id, name, longitude, latitude, altitude,
            coffee_variety_id, farm_id, status_id, operation, modified_by_user_id
        ) VALUES (
            OLD.plot_id, OLD.name, OLD.longitude, OLD.latitude, OLD.altitude,
            OLD.coffee_variety_id, OLD.farm_id, OLD.status_id, 'DELETE', val_user_id
        );
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION log_role_permission_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.role_permission_audit (
            role_id, permission_id, operation
        ) VALUES (
            NEW.role_id, NEW.permission_id, 'INSERT'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.role_permission_audit (
            role_id, permission_id, operation
        ) VALUES (
            NEW.role_id, NEW.permission_id, 'UPDATE'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.role_permission_audit (
            role_id, permission_id, operation
        ) VALUES (
            OLD.role_id, OLD.permission_id, 'DELETE'
        );
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION log_transaction_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.transaction_audit (
            transaction_id, plot_id, description, transaction_type_id,
            transaction_date, status_id, value, transaction_category_id,
            creador_id, operation
        ) VALUES (
            NEW.transaction_id, NEW.plot_id, NEW.description, NEW.transaction_type_id,
            NEW.transaction_date, NEW.status_id, NEW.value, NEW.transaction_category_id,
            NEW.creador_id, 'INSERT'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.transaction_audit (
            transaction_id, plot_id, description, transaction_type_id,
            transaction_date, status_id, value, transaction_category_id,
            creador_id, operation
        ) VALUES (
            NEW.transaction_id, NEW.plot_id, NEW.description, NEW.transaction_type_id,
            NEW.transaction_date, NEW.status_id, NEW.value, NEW.transaction_category_id,
            NEW.creador_id, 'UPDATE'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.transaction_audit (
            transaction_id, plot_id, description, transaction_type_id,
            transaction_date, status_id, value, transaction_category_id,
            creador_id, operation
        ) VALUES (
            OLD.transaction_id, OLD.plot_id, OLD.description, OLD.transaction_type_id,
            OLD.transaction_date, OLD.status_id, OLD.value, OLD.transaction_category_id,
            OLD.creador_id, 'DELETE'
        );
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION log_user_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.users_audit (
            user_id, name, email, password_hash, verification_token,
            session_token, status_id, fcm_token, operation
        ) VALUES (
            NEW.user_id, NEW.name, NEW.email, NEW.password_hash, NEW.verification_token,
            NEW.session_token, NEW.status_id, NEW.fcm_token, 'INSERT'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.users_audit (
            user_id, name, email, password_hash, verification_token,
            session_token, status_id, fcm_token, operation
        ) VALUES (
            NEW.user_id, NEW.name, NEW.email, NEW.password_hash, NEW.verification_token,
            NEW.session_token, NEW.status_id, NEW.fcm_token, 'UPDATE'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.users_audit (
            user_id, name, email, password_hash, verification_token,
            session_token, status_id, fcm_token, operation
        ) VALUES (
            OLD.user_id, OLD.name, OLD.email, OLD.password_hash, OLD.verification_token,
            OLD.session_token, OLD.status_id, OLD.fcm_token, 'DELETE'
        );
    END IF;
    
    RETURN NEW;
END;
$$;

-- TRIGGERS

CREATE TRIGGER cultural_work_tasks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON cultural_work_tasks FOR EACH ROW EXECUTE FUNCTION log_cultural_work_tasks_changes();

CREATE TRIGGER farm_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON farm FOR EACH ROW EXECUTE FUNCTION log_farm_changes();

CREATE TRIGGER health_checks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON health_checks FOR EACH ROW EXECUTE FUNCTION log_health_checks_changes();

CREATE TRIGGER log_flowering_changes AFTER INSERT OR DELETE OR UPDATE ON flowering FOR EACH ROW EXECUTE FUNCTION log_flowering_changes();

CREATE TRIGGER plot_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON plot FOR EACH ROW EXECUTE FUNCTION log_plot_changes();

CREATE TRIGGER role_permission_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON role_permission FOR EACH ROW EXECUTE FUNCTION log_role_permission_changes();

CREATE TRIGGER transaction_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON transaction FOR EACH ROW EXECUTE FUNCTION log_transaction_changes();

CREATE TRIGGER users_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON users FOR EACH ROW EXECUTE FUNCTION log_user_changes();

COMMIT;