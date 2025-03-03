-- BASIC CONFIGURATION

SET client_encoding = 'UTF8';

-- TABLES

CREATE TABLE coffee_variety (
    coffee_variety_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE cultural_work_tasks (
    cultural_work_tasks_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cultural_works_id integer NOT NULL,
    plot_id integer NOT NULL,
    reminder_owner boolean NOT NULL,
    reminder_collaborator boolean NOT NULL,
    collaborator_user_id integer NOT NULL,
    owner_user_id integer NOT NULL,
    status_id integer,
    task_date date,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE cultural_works (
    cultural_works_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL,
    description character varying(255)
);

CREATE TABLE farm (
    farm_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(100) NOT NULL,
    area numeric(10,2) NOT NULL,
    area_unit_id integer NOT NULL,
    status_id integer NOT NULL
);

CREATE TABLE flowering (
    flowering_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    plot_id integer NOT NULL,
    flowering_date date NOT NULL,
    harvest_date date,
    status_id integer NOT NULL,
    flowering_type_id integer NOT NULL
);

CREATE TABLE flowering_type (
    flowering_type_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE health_checks (
    health_checks_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    check_date date NOT NULL,
    recommendation_id integer NOT NULL,
    prediction character varying(150) NOT NULL,
    cultural_work_tasks_id integer NOT NULL,
    status_id integer DEFAULT 35 NOT NULL
);

CREATE TABLE invitation (
    invitation_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email character varying(150) NOT NULL,
    suggested_role character varying(50) NOT NULL,
    status_id integer DEFAULT 24 NOT NULL,
    farm_id integer NOT NULL,
    inviter_user_id integer NOT NULL,
    date timestamp NOT NULL
);

CREATE TABLE notification_type (
    notification_type_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE notifications (
    notifications_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    message character varying(255),
    date timestamp NOT NULL,
    user_id integer NOT NULL,
    invitation_id integer,
    notification_type_id integer,
    farm_id integer,
    status_id integer NOT NULL
);

CREATE TABLE permission (
    permission_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    description character varying(200) NOT NULL,
    name character varying(50) UNIQUE
);

CREATE TABLE plot (
    plot_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(100) NOT NULL,
    longitude NUMERIC(11, 8),
    latitude NUMERIC(11, 8),
    altitude character varying(45),
    coffee_variety_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer
);

CREATE TABLE recommendation (
    recommendation_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    recommendation character varying(255) NOT NULL,
    name character varying(45) NOT NULL
);

CREATE TABLE role (
    role_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL UNIQUE
);

CREATE TABLE role_permission (
    role_id integer NOT NULL,
    permission_id integer NOT NULL,
    PRIMARY KEY (role_id, permission_id)
);

CREATE TABLE status (
    status_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(45) NOT NULL,
    status_type_id integer NOT NULL
);

CREATE TABLE status_type (
    status_type_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE transaction (
    transaction_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    plot_id integer NOT NULL,
    description character varying(50),
    transaction_type_id integer NOT NULL,
    transaction_date date NOT NULL,
    status_id integer NOT NULL,
    value numeric(15, 2) NOT NULL,
    transaction_category_id integer NOT NULL,
    creador_id integer
);

CREATE TABLE transaction_category (
    transaction_category_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL,
    transaction_type_id integer NOT NULL
);

CREATE TABLE transaction_type (
    transaction_type_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE unit_of_measure (
    unit_of_measure_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL,
    abbreviation character varying(10) NOT NULL UNIQUE,
    unit_of_measure_type_id integer NOT NULL
);

CREATE TABLE unit_of_measure_type (
    unit_of_measure_type_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE user_role_farm (
    user_role_farm_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer DEFAULT 22,
    UNIQUE(user_id, role_id, farm_id)
);

CREATE TABLE users (
    user_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name character varying(100) NOT NULL,
    email character varying(150) NOT NULL UNIQUE,
    password_hash character varying(255) NOT NULL,
    verification_token character varying(255),
    session_token character varying(255),
    status_id integer NOT NULL,
    fcm_token character varying(255)
);

-- FOREIGN KEYS

ALTER TABLE ONLY cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_cultural_works FOREIGN KEY (cultural_works_id) REFERENCES cultural_works(cultural_works_id);

ALTER TABLE ONLY cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_plot FOREIGN KEY (plot_id) REFERENCES plot(plot_id);

ALTER TABLE ONLY cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_status FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE cultural_work_tasks 
    ADD CONSTRAINT fk_cultural_work_tasks_collaborator_user 
    FOREIGN KEY (collaborator_user_id) REFERENCES users(user_id);

ALTER TABLE cultural_work_tasks 
    ADD CONSTRAINT fk_cultural_work_tasks_owner_user 
    FOREIGN KEY (owner_user_id) REFERENCES users(user_id);

ALTER TABLE ONLY user_role_farm
    ADD CONSTRAINT fk_farm FOREIGN KEY (farm_id) REFERENCES farm(farm_id) ON DELETE CASCADE;

ALTER TABLE ONLY farm
    ADD CONSTRAINT fk_farm_area_unit_id FOREIGN KEY (area_unit_id) REFERENCES unit_of_measure(unit_of_measure_id);

ALTER TABLE ONLY flowering
    ADD CONSTRAINT fk_flowering_plot_id FOREIGN KEY (plot_id) REFERENCES plot(plot_id) ON DELETE CASCADE;

ALTER TABLE ONLY flowering
    ADD CONSTRAINT fk_flowering_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY flowering
    ADD CONSTRAINT fk_flowering_type_id FOREIGN KEY (flowering_type_id) REFERENCES flowering_type(flowering_type_id);

ALTER TABLE ONLY health_checks
    ADD CONSTRAINT fk_health_checks_cultural_work_tasks FOREIGN KEY (cultural_work_tasks_id) REFERENCES cultural_work_tasks(cultural_work_tasks_id);

ALTER TABLE ONLY health_checks
    ADD CONSTRAINT fk_health_checks_recommendation FOREIGN KEY (recommendation_id) REFERENCES recommendation(recommendation_id);

ALTER TABLE ONLY health_checks
    ADD CONSTRAINT fk_health_checks_status FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY invitation
    ADD CONSTRAINT fk_invitation_farm_id FOREIGN KEY (farm_id) REFERENCES farm(farm_id) ON DELETE CASCADE;

ALTER TABLE ONLY invitation
    ADD CONSTRAINT fk_invitation_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY invitation
    ADD CONSTRAINT fk_invitation_user FOREIGN KEY (inviter_user_id) REFERENCES users(user_id);

ALTER TABLE ONLY notifications
    ADD CONSTRAINT fk_notifications_notification_type_id FOREIGN KEY (notification_type_id) REFERENCES notification_type(notification_type_id) ON DELETE CASCADE;

ALTER TABLE ONLY notifications
    ADD CONSTRAINT fk_notifications_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY notifications
    ADD CONSTRAINT fk_notifications_user_id FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY notifications
    ADD CONSTRAINT fk_notifications_farm_id FOREIGN KEY (farm_id) REFERENCES farm(farm_id);

ALTER TABLE ONLY plot
    ADD CONSTRAINT fk_plot_coffee_variety_id FOREIGN KEY (coffee_variety_id) REFERENCES coffee_variety(coffee_variety_id);

ALTER TABLE ONLY plot
    ADD CONSTRAINT fk_plot_farm_id FOREIGN KEY (farm_id) REFERENCES farm(farm_id) ON DELETE CASCADE;

ALTER TABLE ONLY plot
    ADD CONSTRAINT fk_plot_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY user_role_farm
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE;

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT fk_role_permission_permission_id FOREIGN KEY (permission_id) REFERENCES permission(permission_id) ON DELETE CASCADE;

ALTER TABLE ONLY role_permission
    ADD CONSTRAINT fk_role_permission_role_id FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE;

ALTER TABLE ONLY user_role_farm
    ADD CONSTRAINT fk_status FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY plot
    ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY status
    ADD CONSTRAINT fk_status_status_type_id FOREIGN KEY (status_type_id) REFERENCES status_type(status_type_id);

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_transaction_plot_id FOREIGN KEY (plot_id) REFERENCES plot(plot_id) ON DELETE CASCADE;

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_transaction_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_transaction_transaction_category_id FOREIGN KEY (transaction_category_id) REFERENCES transaction_category(transaction_category_id);

ALTER TABLE ONLY transaction
    ADD CONSTRAINT fk_transaction_transaction_type_id FOREIGN KEY (transaction_type_id) REFERENCES transaction_type(transaction_type_id);

ALTER TABLE transaction 
    ADD CONSTRAINT fk_transaction_creador 
    FOREIGN KEY (creador_id) REFERENCES users(user_id);

ALTER TABLE ONLY transaction_category
    ADD CONSTRAINT fk_transaction_type FOREIGN KEY (transaction_type_id) REFERENCES transaction_type(transaction_type_id) ON DELETE CASCADE;

ALTER TABLE ONLY unit_of_measure
    ADD CONSTRAINT fk_unit_of_measure_unit_of_measure_type_id FOREIGN KEY (unit_of_measure_type_id) REFERENCES unit_of_measure_type(unit_of_measure_type_id);

ALTER TABLE ONLY user_role_farm
    ADD CONSTRAINT fk_user_role_farm_farm_id FOREIGN KEY (farm_id) REFERENCES farm(farm_id) ON DELETE CASCADE;

ALTER TABLE ONLY user_role_farm
    ADD CONSTRAINT fk_user_role_farm_role_id FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE;

ALTER TABLE ONLY user_role_farm
    ADD CONSTRAINT fk_user_role_farm_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

ALTER TABLE ONLY user_role_farm
    ADD CONSTRAINT fk_user_role_farm_user_id FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_users_status_id FOREIGN KEY (status_id) REFERENCES status(status_id);

-- Create audit schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS audit;

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
    operation CHAR(1) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for farm
CREATE TABLE IF NOT EXISTS audit.farm_audit (
    audit_id SERIAL PRIMARY KEY,
    farm_id INTEGER,
    name VARCHAR(100),
    area NUMERIC(10,2),
    area_unit_id INTEGER,
    status_id INTEGER,
    operation CHAR(1) NOT NULL,
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
    operation CHAR(1) NOT NULL,
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
    operation CHAR(1) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for plot
CREATE TABLE IF NOT EXISTS audit.plot_audit (
    audit_id SERIAL PRIMARY KEY,
    plot_id INTEGER,
    name VARCHAR(100),
    longitude NUMERIC(11, 8),
    latitude NUMERIC(11, 8),
    altitude VARCHAR(45),
    coffee_variety_id INTEGER,
    farm_id INTEGER,
    status_id INTEGER,
    operation CHAR(1) NOT NULL,
    user_id INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for role_permission
CREATE TABLE IF NOT EXISTS audit.role_permission_audit (
    audit_id SERIAL PRIMARY KEY,
    role_id INTEGER,
    permission_id INTEGER,
    operation CHAR(1) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for transaction
CREATE TABLE IF NOT EXISTS audit.transaction_audit (
    audit_id SERIAL PRIMARY KEY,
    transaction_id INTEGER,
    plot_id INTEGER,
    description VARCHAR(50),
    transaction_type_id INTEGER,
    transaction_date DATE,
    status_id INTEGER,
    value BIGINT,
    transaction_category_id INTEGER,
    creador_id INTEGER,
    operation CHAR(1) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit table for users
CREATE TABLE IF NOT EXISTS audit.users_audit (
    audit_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    name VARCHAR(100),
    email VARCHAR(150),
    password_hash VARCHAR(255),
    verification_token VARCHAR(255),
    session_token VARCHAR(50),
    status_id INTEGER,
    fcm_token VARCHAR(255),
    operation CHAR(1) NOT NULL,
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
            NEW.owner_user_id, NEW.status_id, NEW.task_date, NEW.created_at, 'I'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.cultural_work_tasks_audit (
            cultural_work_tasks_id, cultural_works_id, plot_id, 
            reminder_owner, reminder_collaborator, collaborator_user_id, 
            owner_user_id, status_id, task_date, created_at, operation
        ) VALUES (
            NEW.cultural_work_tasks_id, NEW.cultural_works_id, NEW.plot_id,
            NEW.reminder_owner, NEW.reminder_collaborator, NEW.collaborator_user_id,
            NEW.owner_user_id, NEW.status_id, NEW.task_date, NEW.created_at, 'U'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.cultural_work_tasks_audit (
            cultural_work_tasks_id, cultural_works_id, plot_id, 
            reminder_owner, reminder_collaborator, collaborator_user_id, 
            owner_user_id, status_id, task_date, created_at, operation
        ) VALUES (
            OLD.cultural_work_tasks_id, OLD.cultural_works_id, OLD.plot_id,
            OLD.reminder_owner, OLD.reminder_collaborator, OLD.collaborator_user_id,
            OLD.owner_user_id, OLD.status_id, OLD.task_date, OLD.created_at, 'D'
        );
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION log_farm_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.farm_audit (
            farm_id, name, area, area_unit_id, status_id, operation
        ) VALUES (
            NEW.farm_id, NEW.name, NEW.area, NEW.area_unit_id, NEW.status_id, 'I'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.farm_audit (
            farm_id, name, area, area_unit_id, status_id, operation
        ) VALUES (
            NEW.farm_id, NEW.name, NEW.area, NEW.area_unit_id, NEW.status_id, 'U'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.farm_audit (
            farm_id, name, area, area_unit_id, status_id, operation
        ) VALUES (
            OLD.farm_id, OLD.name, OLD.area, OLD.area_unit_id, OLD.status_id, 'D'
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
            NEW.cultural_work_tasks_id, NEW.status_id, 'I'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.health_checks_audit (
            health_checks_id, check_date, recommendation_id, prediction, 
            cultural_work_tasks_id, status_id, operation
        ) VALUES (
            NEW.health_checks_id, NEW.check_date, NEW.recommendation_id, NEW.prediction,
            NEW.cultural_work_tasks_id, NEW.status_id, 'U'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.health_checks_audit (
            health_checks_id, check_date, recommendation_id, prediction, 
            cultural_work_tasks_id, status_id, operation
        ) VALUES (
            OLD.health_checks_id, OLD.check_date, OLD.recommendation_id, OLD.prediction,
            OLD.cultural_work_tasks_id, OLD.status_id, 'D'
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
            NEW.status_id, NEW.flowering_type_id, 'I'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.flowering_audit (
            flowering_id, plot_id, flowering_date, harvest_date, 
            status_id, flowering_type_id, operation
        ) VALUES (
            NEW.flowering_id, NEW.plot_id, NEW.flowering_date, NEW.harvest_date,
            NEW.status_id, NEW.flowering_type_id, 'U'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.flowering_audit (
            flowering_id, plot_id, flowering_date, harvest_date, 
            status_id, flowering_type_id, operation
        ) VALUES (
            OLD.flowering_id, OLD.plot_id, OLD.flowering_date, OLD.harvest_date,
            OLD.status_id, OLD.flowering_type_id, 'D'
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
    -- Get current user ID from session if available
    BEGIN
        val_user_id := NULLIF(current_setting('app.current_user', true), '')::INTEGER;
    EXCEPTION
        WHEN OTHERS THEN
            val_user_id := NULL;
    END;

    -- Log based on operation type
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.plot_audit (
            plot_id, name, longitude, latitude, altitude,
            coffee_variety_id, farm_id, status_id, operation, user_id
        ) VALUES (
            NEW.plot_id, NEW.name, NEW.longitude, NEW.latitude, NEW.altitude,
            NEW.coffee_variety_id, NEW.farm_id, NEW.status_id, 'I', val_user_id
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.plot_audit (
            plot_id, name, longitude, latitude, altitude,
            coffee_variety_id, farm_id, status_id, operation, user_id
        ) VALUES (
            NEW.plot_id, NEW.name, NEW.longitude, NEW.latitude, NEW.altitude,
            NEW.coffee_variety_id, NEW.farm_id, NEW.status_id, 'U', val_user_id
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.plot_audit (
            plot_id, name, longitude, latitude, altitude,
            coffee_variety_id, farm_id, status_id, operation, user_id
        ) VALUES (
            OLD.plot_id, OLD.name, OLD.longitude, OLD.latitude, OLD.altitude,
            OLD.coffee_variety_id, OLD.farm_id, OLD.status_id, 'D', val_user_id
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
            NEW.role_id, NEW.permission_id, 'I'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.role_permission_audit (
            role_id, permission_id, operation
        ) VALUES (
            NEW.role_id, NEW.permission_id, 'U'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.role_permission_audit (
            role_id, permission_id, operation
        ) VALUES (
            OLD.role_id, OLD.permission_id, 'D'
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
            NEW.creador_id, 'I'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.transaction_audit (
            transaction_id, plot_id, description, transaction_type_id,
            transaction_date, status_id, value, transaction_category_id,
            creador_id, operation
        ) VALUES (
            NEW.transaction_id, NEW.plot_id, NEW.description, NEW.transaction_type_id,
            NEW.transaction_date, NEW.status_id, NEW.value, NEW.transaction_category_id,
            NEW.creador_id, 'U'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.transaction_audit (
            transaction_id, plot_id, description, transaction_type_id,
            transaction_date, status_id, value, transaction_category_id,
            creador_id, operation
        ) VALUES (
            OLD.transaction_id, OLD.plot_id, OLD.description, OLD.transaction_type_id,
            OLD.transaction_date, OLD.status_id, OLD.value, OLD.transaction_category_id,
            OLD.creador_id, 'D'
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
            NEW.session_token, NEW.status_id, NEW.fcm_token, 'I'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.users_audit (
            user_id, name, email, password_hash, verification_token,
            session_token, status_id, fcm_token, operation
        ) VALUES (
            NEW.user_id, NEW.name, NEW.email, NEW.password_hash, NEW.verification_token,
            NEW.session_token, NEW.status_id, NEW.fcm_token, 'U'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.users_audit (
            user_id, name, email, password_hash, verification_token,
            session_token, status_id, fcm_token, operation
        ) VALUES (
            OLD.user_id, OLD.name, OLD.email, OLD.password_hash, OLD.verification_token,
            OLD.session_token, OLD.status_id, OLD.fcm_token, 'D'
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

-- INDEXES

CREATE INDEX idx_cultural_work_tasks_collaborator_user ON cultural_work_tasks (collaborator_user_id);

CREATE INDEX idx_cultural_work_tasks_owner_user ON cultural_work_tasks (owner_user_id);

CREATE INDEX fk_flowering_plot1_idx ON flowering USING btree (plot_id);

CREATE INDEX fk_flowering_status1_idx ON flowering USING btree (status_id);

CREATE INDEX fk_invitation_farm1_idx ON invitation USING btree (farm_id);

CREATE INDEX fk_notifications_notification_type1_idx ON notifications USING btree (notification_type_id);

CREATE INDEX fk_notifications_user1_idx ON notifications USING btree (user_id);

CREATE INDEX fk_plot_coffee_variety1_idx ON plot USING btree (coffee_variety_id);

CREATE INDEX fk_plot_farm1_idx ON plot USING btree (farm_id);

CREATE INDEX fk_role_permissions_permissions1_idx ON role_permission USING btree (permission_id);

CREATE INDEX fk_role_permissions_roles1_idx ON role_permission USING btree (role_id);

CREATE INDEX fk_transaction_plot_id_idx ON transaction USING btree (plot_id);

CREATE INDEX fk_transaction_status_id_idx ON transaction USING btree (status_id);

CREATE INDEX fk_transaction_transaction_category_id_idx ON transaction USING btree (transaction_category_id);

CREATE INDEX fk_transaction_transaction_type_id_idx ON transaction USING btree (transaction_type_id);

CREATE INDEX fk_user_role_farm_farm1_idx ON user_role_farm USING btree (farm_id);

CREATE INDEX fk_user_role_farm_roles1_idx ON user_role_farm USING btree (role_id);

CREATE INDEX fk_user_role_farm_user1_idx ON user_role_farm USING btree (user_id);

CREATE INDEX idx_farm_area_unit_id ON farm USING btree (area_unit_id);

CREATE INDEX idx_status_status_type_id ON status USING btree (status_type_id);

CREATE INDEX idx_unit_of_measure_unit_of_measure_type_id ON unit_of_measure USING btree (unit_of_measure_type_id);

CREATE INDEX idx_users_status_id ON users USING btree (status_id);

CREATE INDEX ix_status_status_id ON status USING btree (status_id);

CREATE INDEX ix_status_type_status_type_id ON status_type USING btree (status_type_id);

CREATE INDEX ix_transaction_category_id ON transaction_category USING btree (transaction_category_id);

CREATE INDEX ix_transaction_type_id ON transaction_type USING btree (transaction_type_id);