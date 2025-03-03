--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- Name: log_cultural_work_tasks_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_cultural_work_tasks_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
BEGIN
    -- Diagnóstico
    RAISE NOTICE 'Trigger activated for operation: %', TG_OP;

    -- Construir la consulta SQL según la operación
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.cultural_work_tasks_audit (cultural_work_tasks_id, cultural_works_id, plot_id, reminder_owner, reminder_collaborator, collaborator_user_id, owner_user_id, status_id, task_date, created_at, operation) VALUES ('
            || quote_literal(NEW.cultural_work_tasks_id) || ', '
            || quote_literal(NEW.cultural_works_id) || ', '
            || quote_literal(NEW.plot_id) || ', '
            || quote_literal(NEW.reminder_owner) || ', '
            || quote_literal(NEW.reminder_collaborator) || ', '
            || quote_literal(NEW.collaborator_user_id) || ', '
            || quote_literal(NEW.owner_user_id) || ', '
            || quote_literal(NEW.status_id) || ', '
            || quote_literal(NEW.task_date) || ', '
            || quote_literal(NEW.created_at) || ', ''I'')';

    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.cultural_work_tasks_audit (cultural_work_tasks_id, cultural_works_id, plot_id, reminder_owner, reminder_collaborator, collaborator_user_id, owner_user_id, status_id, task_date, created_at, operation) VALUES ('
            || quote_literal(NEW.cultural_work_tasks_id) || ', '
            || quote_literal(NEW.cultural_works_id) || ', '
            || quote_literal(NEW.plot_id) || ', '
            || quote_literal(NEW.reminder_owner) || ', '
            || quote_literal(NEW.reminder_collaborator) || ', '
            || quote_literal(NEW.collaborator_user_id) || ', '
            || quote_literal(NEW.owner_user_id) || ', '
            || quote_literal(NEW.status_id) || ', '
            || quote_literal(NEW.task_date) || ', '
            || quote_literal(NEW.created_at) || ', ''U'')';

    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.cultural_work_tasks_audit (cultural_work_tasks_id, cultural_works_id, plot_id, reminder_owner, reminder_collaborator, collaborator_user_id, owner_user_id, status_id, task_date, created_at, operation) VALUES ('
            || quote_literal(OLD.cultural_work_tasks_id) || ', '
            || quote_literal(OLD.cultural_works_id) || ', '
            || quote_literal(OLD.plot_id) || ', '
            || quote_literal(OLD.reminder_owner) || ', '
            || quote_literal(OLD.reminder_collaborator) || ', '
            || quote_literal(OLD.collaborator_user_id) || ', '
            || quote_literal(OLD.owner_user_id) || ', '
            || quote_literal(OLD.status_id) || ', '
            || quote_literal(OLD.task_date) || ', '
            || quote_literal(OLD.created_at) || ', ''D'')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecución de la consulta
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_cultural_work_tasks_changes() OWNER TO postgres;

--
-- Name: log_farm_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_farm_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
    val_farm_id TEXT;
    val_name TEXT;
    val_area TEXT;
    val_area_unit_id TEXT;
    val_status_id TEXT;
BEGIN
    -- Diagnóstico
    RAISE NOTICE 'Trigger activated for operation: %', TG_OP;

    -- Asegurarse de que todos los valores sean válidos
    val_farm_id := COALESCE(quote_literal(NEW.farm_id), 'NULL');
    val_name := COALESCE(quote_literal(NEW.name), 'NULL');
    val_area := COALESCE(quote_literal(NEW.area), 'NULL');
    val_area_unit_id := COALESCE(quote_literal(NEW.area_unit_id), 'NULL');
    val_status_id := COALESCE(quote_literal(NEW.status_id), 'NULL');

    -- Construir la consulta SQL según la operación
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.farm_audit (farm_id, name, area, area_unit_id, status_id, operation) VALUES ('
            || val_farm_id || ', '
            || val_name || ', '
            || val_area || ', '
            || val_area_unit_id || ', '
            || val_status_id || ', ''I'')';

    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.farm_audit (farm_id, name, area, area_unit_id, status_id, operation) VALUES ('
            || val_farm_id || ', '
            || val_name || ', '
            || val_area || ', '
            || val_area_unit_id || ', '
            || val_status_id || ', ''U'')';

    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.farm_audit (farm_id, name, area, area_unit_id, status_id, operation) VALUES ('
            || COALESCE(quote_literal(OLD.farm_id), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.name), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.area), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.area_unit_id), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.status_id), 'NULL') || ', ''D'')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecución de la consulta
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_farm_changes() OWNER TO postgres;

--
-- Name: log_flowering_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_flowering_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
BEGIN
    -- Construir la consulta SQL según la operación (INSERT, UPDATE, DELETE)
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.flowering_audit (flowering_id, plot_id, flowering_date, harvest_date, status_id, flowering_type_id, operation) VALUES ('
            || quote_literal(NEW.flowering_id) || ', '
            || quote_literal(NEW.plot_id) || ', '
            || quote_literal(NEW.flowering_date) || ', '
            || quote_literal(NEW.harvest_date) || ', '
            || quote_literal(NEW.status_id) || ', '
            || quote_literal(NEW.flowering_type_id) || ', ''I'')';

    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.flowering_audit (flowering_id, plot_id, flowering_date, harvest_date, status_id, flowering_type_id, operation) VALUES ('
            || quote_literal(NEW.flowering_id) || ', '
            || quote_literal(NEW.plot_id) || ', '
            || quote_literal(NEW.flowering_date) || ', '
            || quote_literal(NEW.harvest_date) || ', '
            || quote_literal(NEW.status_id) || ', '
            || quote_literal(NEW.flowering_type_id) || ', ''U'')';

    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.flowering_audit (flowering_id, plot_id, flowering_date, harvest_date, status_id, flowering_type_id, operation) VALUES ('
            || quote_literal(OLD.flowering_id) || ', '
            || quote_literal(OLD.plot_id) || ', '
            || quote_literal(OLD.flowering_date) || ', '
            || quote_literal(OLD.harvest_date) || ', '
            || quote_literal(OLD.status_id) || ', '
            || quote_literal(OLD.flowering_type_id) || ', ''D'')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecutar la consulta (puedes usar dblink si es necesario, o ejecutar directamente si la tabla de auditoría está en la misma base de datos)
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_flowering_changes() OWNER TO postgres;

--
-- Name: log_health_checks_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_health_checks_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
BEGIN
    -- Diagnóstico
    RAISE NOTICE 'Trigger activated for operation: %', TG_OP;

    -- Construir la consulta SQL según la operación
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.health_checks_audit (health_checks_id, check_date, recommendation_id, prediction, cultural_work_tasks_id, status_id, operation) VALUES ('
            || quote_literal(NEW.health_checks_id) || ', '
            || quote_literal(NEW.check_date) || ', '
            || quote_literal(NEW.recommendation_id) || ', '
            || quote_literal(NEW.prediction) || ', '
            || quote_literal(NEW.cultural_work_tasks_id) || ', '
            || quote_literal(NEW.status_id) || ', ''I'')';

    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.health_checks_audit (health_checks_id, check_date, recommendation_id, prediction, cultural_work_tasks_id, status_id, operation) VALUES ('
            || quote_literal(NEW.health_checks_id) || ', '
            || quote_literal(NEW.check_date) || ', '
            || quote_literal(NEW.recommendation_id) || ', '
            || quote_literal(NEW.prediction) || ', '
            || quote_literal(NEW.cultural_work_tasks_id) || ', '
            || quote_literal(NEW.status_id) || ', ''U'')';

    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.health_checks_audit (health_checks_id, check_date, recommendation_id, prediction, cultural_work_tasks_id, status_id, operation) VALUES ('
            || quote_literal(OLD.health_checks_id) || ', '
            || quote_literal(OLD.check_date) || ', '
            || quote_literal(OLD.recommendation_id) || ', '
            || quote_literal(OLD.prediction) || ', '
            || quote_literal(OLD.cultural_work_tasks_id) || ', '
            || quote_literal(OLD.status_id) || ', ''D'')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecución de la consulta
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_health_checks_changes() OWNER TO postgres;

--
-- Name: log_plot_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_plot_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
    val_plot_id TEXT;
    val_name TEXT;
    val_longitude TEXT;
    val_latitude TEXT;
    val_altitude TEXT;
    val_coffee_variety_id TEXT;
    val_farm_id TEXT;
    val_status_id TEXT;
    val_user_id TEXT;
BEGIN
    -- Obtener el ID del usuario desde la sesión
    BEGIN
        val_user_id := current_setting('app.current_user', true);  -- Devuelve NULL si no se ha configurado
    EXCEPTION
        WHEN OTHERS THEN
            val_user_id := 'NULL';  -- Si no se configura el usuario, lo deja como NULL
    END;

    -- Obtener los valores de la fila afectada
    val_plot_id := COALESCE(quote_literal(NEW.plot_id), 'NULL');
    val_name := COALESCE(quote_literal(NEW.name), 'NULL');
    val_longitude := COALESCE(quote_literal(NEW.longitude), 'NULL');
    val_latitude := COALESCE(quote_literal(NEW.latitude), 'NULL');
    val_altitude := COALESCE(quote_literal(NEW.altitude), 'NULL');
    val_coffee_variety_id := COALESCE(quote_literal(NEW.coffee_variety_id), 'NULL');
    val_farm_id := COALESCE(quote_literal(NEW.farm_id), 'NULL');
    val_status_id := COALESCE(quote_literal(NEW.status_id), 'NULL');

    -- Construir la consulta según el tipo de operación (INSERT, UPDATE, DELETE)
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.plot_audit (plot_id, name, longitude, latitude, altitude, coffee_variety_id, farm_id, status_id, operation, user_id) VALUES ('
            || val_plot_id || ', '
            || val_name || ', '
            || val_longitude || ', '
            || val_latitude || ', '
            || val_altitude || ', '
            || val_coffee_variety_id || ', '
            || val_farm_id || ', '
            || val_status_id || ', ''I'', '
            || quote_literal(val_user_id) || ')';
    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.plot_audit (plot_id, name, longitude, latitude, altitude, coffee_variety_id, farm_id, status_id, operation, user_id) VALUES ('
            || val_plot_id || ', '
            || val_name || ', '
            || val_longitude || ', '
            || val_latitude || ', '
            || val_altitude || ', '
            || val_coffee_variety_id || ', '
            || val_farm_id || ', '
            || val_status_id || ', ''U'', '
            || quote_literal(val_user_id) || ')';
    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.plot_audit (plot_id, name, longitude, latitude, altitude, coffee_variety_id, farm_id, status_id, operation, user_id) VALUES ('
            || COALESCE(quote_literal(OLD.plot_id), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.name), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.longitude), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.latitude), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.altitude), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.coffee_variety_id), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.farm_id), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.status_id), 'NULL') || ', ''D'', '
            || quote_literal(val_user_id) || ')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecutar la consulta
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_plot_changes() OWNER TO postgres;

--
-- Name: log_role_permission_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_role_permission_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
BEGIN
    -- Construir la consulta SQL
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.role_permission_audit (role_id, permission_id, operation) VALUES ('
            || quote_literal(NEW.role_id) || ', '
            || quote_literal(NEW.permission_id) || ', ''I'')';

    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.role_permission_audit (role_id, permission_id, operation) VALUES ('
            || quote_literal(NEW.role_id) || ', '
            || quote_literal(NEW.permission_id) || ', ''U'')';

    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.role_permission_audit (role_id, permission_id, operation) VALUES ('
            || quote_literal(OLD.role_id) || ', '
            || quote_literal(OLD.permission_id) || ', ''D'')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecutar en base de datos externa
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_role_permission_changes() OWNER TO postgres;

--
-- Name: log_transaction_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_transaction_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
BEGIN
    -- Diagnóstico
    RAISE NOTICE 'Trigger activated for operation: %', TG_OP;

    -- Construir la consulta SQL según la operación
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.transaction_audit (transaction_id, plot_id, description, transaction_type_id, transaction_date, status_id, value, transaction_category_id, creador_id, operation) VALUES ('
            || quote_literal(NEW.transaction_id) || ', '
            || quote_literal(NEW.plot_id) || ', '
            || quote_literal(NEW.description) || ', '
            || quote_literal(NEW.transaction_type_id) || ', '
            || quote_literal(NEW.transaction_date) || ', '
            || quote_literal(NEW.status_id) || ', '
            || quote_literal(NEW.value) || ', '
            || quote_literal(NEW.transaction_category_id) || ', '
            || quote_literal(NEW.creador_id) || ', ''I'')';

    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.transaction_audit (transaction_id, plot_id, description, transaction_type_id, transaction_date, status_id, value, transaction_category_id, creador_id, operation) VALUES ('
            || quote_literal(NEW.transaction_id) || ', '
            || quote_literal(NEW.plot_id) || ', '
            || quote_literal(NEW.description) || ', '
            || quote_literal(NEW.transaction_type_id) || ', '
            || quote_literal(NEW.transaction_date) || ', '
            || quote_literal(NEW.status_id) || ', '
            || quote_literal(NEW.value) || ', '
            || quote_literal(NEW.transaction_category_id) || ', '
            || quote_literal(NEW.creador_id) || ', ''U'')';

    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.transaction_audit (transaction_id, plot_id, description, transaction_type_id, transaction_date, status_id, value, transaction_category_id, creador_id, operation) VALUES ('
            || quote_literal(OLD.transaction_id) || ', '
            || quote_literal(OLD.plot_id) || ', '
            || quote_literal(OLD.description) || ', '
            || quote_literal(OLD.transaction_type_id) || ', '
            || quote_literal(OLD.transaction_date) || ', '
            || quote_literal(OLD.status_id) || ', '
            || quote_literal(OLD.value) || ', '
            || quote_literal(OLD.transaction_category_id) || ', '
            || quote_literal(OLD.creador_id) || ', ''D'')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecución de la consulta
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_transaction_changes() OWNER TO postgres;

--
-- Name: log_user_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_user_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql TEXT;
    val_user_id TEXT;
    val_name TEXT;
    val_email TEXT;
    val_password_hash TEXT;
    val_verification_token TEXT;
    val_session_token TEXT;
    val_status_id TEXT;
    val_fcm_token TEXT;
BEGIN
    -- Diagnóstico
    RAISE NOTICE 'Trigger activated for operation: %', TG_OP;

    -- Asegurarse de que todos los valores sean válidos
    val_user_id := COALESCE(quote_literal(NEW.user_id), 'NULL');
    val_name := COALESCE(quote_literal(NEW.name), 'NULL');
    val_email := COALESCE(quote_literal(NEW.email), 'NULL');
    val_password_hash := COALESCE(quote_literal(NEW.password_hash), 'NULL');
    val_verification_token := COALESCE(quote_literal(NEW.verification_token), 'NULL');
    val_session_token := COALESCE(quote_literal(NEW.session_token), 'NULL');
    val_status_id := COALESCE(quote_literal(NEW.status_id), 'NULL');
    val_fcm_token := COALESCE(quote_literal(NEW.fcm_token), 'NULL');

    -- Construir la consulta SQL según la operación
    IF TG_OP = 'INSERT' THEN
        sql := 'INSERT INTO audit.users_audit (user_id, name, email, password_hash, verification_token, session_token, status_id, fcm_token, operation) VALUES ('
            || val_user_id || ', '
            || val_name || ', '
            || val_email || ', '
            || val_password_hash || ', '
            || val_verification_token || ', '
            || val_session_token || ', '
            || val_status_id || ', '
            || val_fcm_token || ', ''I'')';

    ELSIF TG_OP = 'UPDATE' THEN
        sql := 'INSERT INTO audit.users_audit (user_id, name, email, password_hash, verification_token, session_token, status_id, fcm_token, operation) VALUES ('
            || val_user_id || ', '
            || val_name || ', '
            || val_email || ', '
            || val_password_hash || ', '
            || val_verification_token || ', '
            || val_session_token || ', '
            || val_status_id || ', '
            || val_fcm_token || ', ''U'')';

    ELSIF TG_OP = 'DELETE' THEN
        sql := 'INSERT INTO audit.users_audit (user_id, name, email, password_hash, verification_token, session_token, status_id, fcm_token, operation) VALUES ('
            || COALESCE(quote_literal(OLD.user_id), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.name), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.email), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.password_hash), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.verification_token), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.session_token), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.status_id), 'NULL') || ', '
            || COALESCE(quote_literal(OLD.fcm_token), 'NULL') || ', ''D'')';
    END IF;

    -- Diagnóstico de la consulta construida
    RAISE NOTICE 'Executing SQL: %', sql;

    -- Ejecución de la consulta
    BEGIN
        PERFORM dblink_exec('host=junction.proxy.rlwy.net port=15674 dbname=postgres user=postgres password=NtEdGgDlBFTGqdvtxSJDPFUuVILcBoVb', sql);

    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en dblink_exec: %', SQLERRM;
    END;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_user_changes() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: coffee_variety; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coffee_variety (
    coffee_variety_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.coffee_variety OWNER TO postgres;

--
-- Name: coffee_variety_coffee_variety_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coffee_variety_coffee_variety_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coffee_variety_coffee_variety_id_seq OWNER TO postgres;

--
-- Name: coffee_variety_coffee_variety_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coffee_variety_coffee_variety_id_seq OWNED BY public.coffee_variety.coffee_variety_id;


--
-- Name: cultural_work_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cultural_work_tasks (
    cultural_work_tasks_id integer NOT NULL,
    cultural_works_id integer NOT NULL,
    plot_id integer NOT NULL,
    reminder_owner boolean NOT NULL,
    reminder_collaborator boolean NOT NULL,
    collaborator_user_id integer NOT NULL,
    owner_user_id integer NOT NULL,
    status_id integer,
    task_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.cultural_work_tasks OWNER TO postgres;

--
-- Name: cultural_work_tasks_cultural_work_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cultural_work_tasks_cultural_work_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cultural_work_tasks_cultural_work_tasks_id_seq OWNER TO postgres;

--
-- Name: cultural_work_tasks_cultural_work_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cultural_work_tasks_cultural_work_tasks_id_seq OWNED BY public.cultural_work_tasks.cultural_work_tasks_id;


--
-- Name: cultural_works; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cultural_works (
    cultural_works_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.cultural_works OWNER TO postgres;

--
-- Name: cultural_works_cultural_works_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cultural_works_cultural_works_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cultural_works_cultural_works_id_seq OWNER TO postgres;

--
-- Name: cultural_works_cultural_works_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cultural_works_cultural_works_id_seq OWNED BY public.cultural_works.cultural_works_id;


--
-- Name: farm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.farm (
    farm_id integer NOT NULL,
    name character varying(100) NOT NULL,
    area numeric(10,2) NOT NULL,
    area_unit_id integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.farm OWNER TO postgres;

--
-- Name: farm_farm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.farm_farm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.farm_farm_id_seq OWNER TO postgres;

--
-- Name: farm_farm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.farm_farm_id_seq OWNED BY public.farm.farm_id;


--
-- Name: flowering_flowering_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flowering_flowering_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flowering_flowering_id_seq OWNER TO postgres;

--
-- Name: flowering; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flowering (
    flowering_id integer DEFAULT nextval('public.flowering_flowering_id_seq'::regclass) NOT NULL,
    plot_id integer NOT NULL,
    flowering_date date NOT NULL,
    harvest_date date,
    status_id integer NOT NULL,
    flowering_type_id integer NOT NULL
);


ALTER TABLE public.flowering OWNER TO postgres;

--
-- Name: flowering_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flowering_type (
    flowering_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.flowering_type OWNER TO postgres;

--
-- Name: flowering_type_flowering_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flowering_type_flowering_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flowering_type_flowering_type_id_seq OWNER TO postgres;

--
-- Name: flowering_type_flowering_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flowering_type_flowering_type_id_seq OWNED BY public.flowering_type.flowering_type_id;


--
-- Name: health_checks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_checks (
    health_checks_id integer NOT NULL,
    check_date date NOT NULL,
    recommendation_id integer NOT NULL,
    prediction character varying(150) NOT NULL,
    cultural_work_tasks_id integer NOT NULL,
    status_id integer DEFAULT 35 NOT NULL
);


ALTER TABLE public.health_checks OWNER TO postgres;

--
-- Name: health_checks_health_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_checks_health_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_checks_health_checks_id_seq OWNER TO postgres;

--
-- Name: health_checks_health_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_checks_health_checks_id_seq OWNED BY public.health_checks.health_checks_id;


--
-- Name: health_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_checks_id_seq OWNER TO postgres;

--
-- Name: health_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_checks_id_seq OWNED BY public.health_checks.health_checks_id;


--
-- Name: invitation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invitation (
    invitation_id integer NOT NULL,
    email character varying(150) NOT NULL,
    suggested_role character varying(50) NOT NULL,
    status_id integer DEFAULT 24 NOT NULL,
    farm_id integer NOT NULL,
    inviter_user_id integer NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE public.invitation OWNER TO postgres;

--
-- Name: invitation_invitation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invitation_invitation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invitation_invitation_id_seq OWNER TO postgres;

--
-- Name: invitation_invitation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invitation_invitation_id_seq OWNED BY public.invitation.invitation_id;


--
-- Name: notification_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_type (
    notification_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.notification_type OWNER TO postgres;

--
-- Name: notification_type_notification_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_type_notification_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_type_notification_type_id_seq OWNER TO postgres;

--
-- Name: notification_type_notification_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_type_notification_type_id_seq OWNED BY public.notification_type.notification_type_id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    notifications_id integer NOT NULL,
    message character varying(255),
    date timestamp without time zone,
    user_id integer NOT NULL,
    invitation_id integer,
    notification_type_id integer,
    farm_id integer,
    status_id integer
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notifications_id_seq OWNED BY public.notifications.notifications_id;


--
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission (
    permission_id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(50)
);


ALTER TABLE public.permission OWNER TO postgres;

--
-- Name: permission_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permission_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permission_permission_id_seq OWNER TO postgres;

--
-- Name: permission_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permission_permission_id_seq OWNED BY public.permission.permission_id;


--
-- Name: plot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plot (
    plot_id integer NOT NULL,
    name character varying(100) NOT NULL,
    longitude character varying(45),
    latitude character varying(45),
    altitude character varying(45),
    coffee_variety_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer
);


ALTER TABLE public.plot OWNER TO postgres;

--
-- Name: plot_plot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plot_plot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plot_plot_id_seq OWNER TO postgres;

--
-- Name: plot_plot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plot_plot_id_seq OWNED BY public.plot.plot_id;


--
-- Name: recommendation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendation (
    recommendation_id integer NOT NULL,
    recommendation character varying(255) NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.recommendation OWNER TO postgres;

--
-- Name: recommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendation_id_seq OWNER TO postgres;

--
-- Name: recommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendation_id_seq OWNED BY public.recommendation.recommendation_id;


--
-- Name: recommendation_recommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendation_recommendation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendation_recommendation_id_seq OWNER TO postgres;

--
-- Name: recommendation_recommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendation_recommendation_id_seq OWNED BY public.recommendation.recommendation_id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permission (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.role_permission OWNER TO postgres;

--
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_role_id_seq OWNER TO postgres;

--
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    status_id integer NOT NULL,
    name character varying(45) NOT NULL,
    status_type_id integer NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: status_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_status_id_seq OWNER TO postgres;

--
-- Name: status_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_status_id_seq OWNED BY public.status.status_id;


--
-- Name: status_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_type (
    status_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.status_type OWNER TO postgres;

--
-- Name: status_type_status_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_type_status_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_type_status_type_id_seq OWNER TO postgres;

--
-- Name: status_type_status_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_type_status_type_id_seq OWNED BY public.status_type.status_type_id;


--
-- Name: transaction_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_transaction_id_seq OWNER TO postgres;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction (
    transaction_id integer DEFAULT nextval('public.transaction_transaction_id_seq'::regclass) NOT NULL,
    plot_id integer NOT NULL,
    description character varying(50),
    transaction_type_id integer NOT NULL,
    transaction_date date NOT NULL,
    status_id integer NOT NULL,
    value bigint NOT NULL,
    transaction_category_id integer NOT NULL,
    creador_id integer
);


ALTER TABLE public.transaction OWNER TO postgres;

--
-- Name: transaction_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_category (
    transaction_category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    transaction_type_id integer NOT NULL
);


ALTER TABLE public.transaction_category OWNER TO postgres;

--
-- Name: transaction_category_transaction_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_category_transaction_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_category_transaction_category_id_seq OWNER TO postgres;

--
-- Name: transaction_category_transaction_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_category_transaction_category_id_seq OWNED BY public.transaction_category.transaction_category_id;


--
-- Name: transaction_type_transaction_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_type_transaction_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_type_transaction_type_id_seq OWNER TO postgres;

--
-- Name: transaction_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_type (
    transaction_type_id integer DEFAULT nextval('public.transaction_type_transaction_type_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.transaction_type OWNER TO postgres;

--
-- Name: unit_of_measure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_of_measure (
    unit_of_measure_id integer NOT NULL,
    name character varying(50) NOT NULL,
    abbreviation character varying(10) NOT NULL,
    unit_of_measure_type_id integer NOT NULL
);


ALTER TABLE public.unit_of_measure OWNER TO postgres;

--
-- Name: unit_of_measure_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_of_measure_type (
    unit_of_measure_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.unit_of_measure_type OWNER TO postgres;

--
-- Name: unit_of_measure_type_unit_of_measure_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_of_measure_type_unit_of_measure_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unit_of_measure_type_unit_of_measure_type_id_seq OWNER TO postgres;

--
-- Name: unit_of_measure_type_unit_of_measure_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_of_measure_type_unit_of_measure_type_id_seq OWNED BY public.unit_of_measure_type.unit_of_measure_type_id;


--
-- Name: unit_of_measure_unit_of_measure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_of_measure_unit_of_measure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unit_of_measure_unit_of_measure_id_seq OWNER TO postgres;

--
-- Name: unit_of_measure_unit_of_measure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_of_measure_unit_of_measure_id_seq OWNED BY public.unit_of_measure.unit_of_measure_id;


--
-- Name: user_role_farm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_farm (
    user_role_farm_id integer NOT NULL,
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer DEFAULT 22
);


ALTER TABLE public.user_role_farm OWNER TO postgres;

--
-- Name: user_role_farm_user_role_farm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_role_farm_user_role_farm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_farm_user_role_farm_id_seq OWNER TO postgres;

--
-- Name: user_role_farm_user_role_farm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_role_farm_user_role_farm_id_seq OWNED BY public.user_role_farm.user_role_farm_id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer DEFAULT nextval('public.users_user_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash character varying(255) NOT NULL,
    verification_token character varying(255),
    session_token character varying(50),
    status_id integer NOT NULL,
    fcm_token character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: cultural_work_tasks cultural_work_tasks_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_work_tasks ALTER COLUMN cultural_work_tasks_id SET DEFAULT nextval('public.cultural_work_tasks_cultural_work_tasks_id_seq'::regclass);


--
-- Name: farm farm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farm ALTER COLUMN farm_id SET DEFAULT nextval('public.farm_farm_id_seq'::regclass);


--
-- Name: flowering_type flowering_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flowering_type ALTER COLUMN flowering_type_id SET DEFAULT nextval('public.flowering_type_flowering_type_id_seq'::regclass);


--
-- Name: health_checks health_checks_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_checks ALTER COLUMN health_checks_id SET DEFAULT nextval('public.health_checks_id_seq'::regclass);


--
-- Name: invitation invitation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation ALTER COLUMN invitation_id SET DEFAULT nextval('public.invitation_invitation_id_seq'::regclass);


--
-- Name: notification_type notification_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_type ALTER COLUMN notification_type_id SET DEFAULT nextval('public.notification_type_notification_type_id_seq'::regclass);


--
-- Name: notifications notifications_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notifications_id SET DEFAULT nextval('public.notifications_notifications_id_seq'::regclass);


--
-- Name: permission permission_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission ALTER COLUMN permission_id SET DEFAULT nextval('public.permission_permission_id_seq'::regclass);


--
-- Name: plot plot_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plot ALTER COLUMN plot_id SET DEFAULT nextval('public.plot_plot_id_seq'::regclass);


--
-- Name: recommendation recommendation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation ALTER COLUMN recommendation_id SET DEFAULT nextval('public.recommendation_id_seq'::regclass);


--
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- Name: status status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status ALTER COLUMN status_id SET DEFAULT nextval('public.status_status_id_seq'::regclass);


--
-- Name: status_type status_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_type ALTER COLUMN status_type_id SET DEFAULT nextval('public.status_type_status_type_id_seq'::regclass);


--
-- Name: transaction_category transaction_category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_category ALTER COLUMN transaction_category_id SET DEFAULT nextval('public.transaction_category_transaction_category_id_seq'::regclass);


--
-- Name: unit_of_measure unit_of_measure_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure ALTER COLUMN unit_of_measure_id SET DEFAULT nextval('public.unit_of_measure_unit_of_measure_id_seq'::regclass);


--
-- Name: unit_of_measure_type unit_of_measure_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure_type ALTER COLUMN unit_of_measure_type_id SET DEFAULT nextval('public.unit_of_measure_type_unit_of_measure_type_id_seq'::regclass);


--
-- Name: user_role_farm user_role_farm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm ALTER COLUMN user_role_farm_id SET DEFAULT nextval('public.user_role_farm_user_role_farm_id_seq'::regclass);


--
-- Name: coffee_variety coffee_variety_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coffee_variety
    ADD CONSTRAINT coffee_variety_pkey PRIMARY KEY (coffee_variety_id);


--
-- Name: cultural_works cultural_works_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_works
    ADD CONSTRAINT cultural_works_pkey PRIMARY KEY (cultural_works_id);


--
-- Name: farm farm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farm
    ADD CONSTRAINT farm_pkey PRIMARY KEY (farm_id);


--
-- Name: flowering flowering_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT flowering_pkey PRIMARY KEY (flowering_id);


--
-- Name: flowering_type flowering_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flowering_type
    ADD CONSTRAINT flowering_type_pkey PRIMARY KEY (flowering_type_id);


--
-- Name: health_checks health_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT health_checks_pkey PRIMARY KEY (health_checks_id);


--
-- Name: notification_type notification_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_type
    ADD CONSTRAINT notification_type_pkey PRIMARY KEY (notification_type_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notifications_id);


--
-- Name: permission permission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_name_key UNIQUE (name);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);


--
-- Name: plot plot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT plot_pkey PRIMARY KEY (plot_id);


--
-- Name: recommendation recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (recommendation_id);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_permission role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (status_id);


--
-- Name: status_type status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_pkey PRIMARY KEY (status_type_id);


--
-- Name: transaction_category transaction_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT transaction_category_pkey PRIMARY KEY (transaction_category_id);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);


--
-- Name: transaction_type transaction_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_type
    ADD CONSTRAINT transaction_type_pkey PRIMARY KEY (transaction_type_id);


--
-- Name: unit_of_measure unique_abbreviation; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unique_abbreviation UNIQUE (abbreviation);


--
-- Name: cultural_work_tasks unique_cultural_work_tasks_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT unique_cultural_work_tasks_id UNIQUE (cultural_work_tasks_id);


--
-- Name: unit_of_measure unit_of_measure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (unit_of_measure_id);


--
-- Name: unit_of_measure_type unit_of_measure_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure_type
    ADD CONSTRAINT unit_of_measure_type_pkey PRIMARY KEY (unit_of_measure_type_id);


--
-- Name: user_role_farm user_role_farm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT user_role_farm_pkey PRIMARY KEY (user_role_farm_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: fk_flowering_plot1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_flowering_plot1_idx ON public.flowering USING btree (plot_id);


--
-- Name: fk_flowering_status1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_flowering_status1_idx ON public.flowering USING btree (status_id);


--
-- Name: fk_invitation_farm1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_invitation_farm1_idx ON public.invitation USING btree (farm_id);


--
-- Name: fk_notifications_notification_type1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_notifications_notification_type1_idx ON public.notifications USING btree (notification_type_id);


--
-- Name: fk_notifications_user1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_notifications_user1_idx ON public.notifications USING btree (user_id);


--
-- Name: fk_plot_coffee_variety1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_plot_coffee_variety1_idx ON public.plot USING btree (coffee_variety_id);


--
-- Name: fk_plot_farm1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_plot_farm1_idx ON public.plot USING btree (farm_id);


--
-- Name: fk_role_permissions_permissions1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_role_permissions_permissions1_idx ON public.role_permission USING btree (permission_id);


--
-- Name: fk_role_permissions_roles1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_role_permissions_roles1_idx ON public.role_permission USING btree (role_id);


--
-- Name: fk_transaction_plot_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_transaction_plot_id_idx ON public.transaction USING btree (plot_id);


--
-- Name: fk_transaction_status_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_transaction_status_id_idx ON public.transaction USING btree (status_id);


--
-- Name: fk_transaction_transaction_category_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_transaction_transaction_category_id_idx ON public.transaction USING btree (transaction_category_id);


--
-- Name: fk_transaction_transaction_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_transaction_transaction_type_id_idx ON public.transaction USING btree (transaction_type_id);


--
-- Name: fk_user_role_farm_farm1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_user_role_farm_farm1_idx ON public.user_role_farm USING btree (farm_id);


--
-- Name: fk_user_role_farm_roles1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_user_role_farm_roles1_idx ON public.user_role_farm USING btree (role_id);


--
-- Name: fk_user_role_farm_user1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_user_role_farm_user1_idx ON public.user_role_farm USING btree (user_id);


--
-- Name: idx_farm_area_unit_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_farm_area_unit_id ON public.farm USING btree (area_unit_id);


--
-- Name: idx_status_status_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_status_status_type_id ON public.status USING btree (status_type_id);


--
-- Name: idx_unit_of_measure_unit_of_measure_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_unit_of_measure_unit_of_measure_type_id ON public.unit_of_measure USING btree (unit_of_measure_type_id);


--
-- Name: idx_users_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_status_id ON public.users USING btree (status_id);


--
-- Name: ix_status_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_status_status_id ON public.status USING btree (status_id);


--
-- Name: ix_status_type_status_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_status_type_status_type_id ON public.status_type USING btree (status_type_id);


--
-- Name: ix_transaction_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transaction_category_id ON public.transaction_category USING btree (transaction_category_id);


--
-- Name: ix_transaction_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_transaction_type_id ON public.transaction_type USING btree (transaction_type_id);


--
-- Name: cultural_work_tasks cultural_work_tasks_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER cultural_work_tasks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.cultural_work_tasks FOR EACH ROW EXECUTE FUNCTION public.log_cultural_work_tasks_changes();


--
-- Name: farm farm_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER farm_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.farm FOR EACH ROW EXECUTE FUNCTION public.log_farm_changes();


--
-- Name: health_checks health_checks_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER health_checks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.health_checks FOR EACH ROW EXECUTE FUNCTION public.log_health_checks_changes();


--
-- Name: flowering log_flowering_changes; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER log_flowering_changes AFTER INSERT OR DELETE OR UPDATE ON public.flowering FOR EACH ROW EXECUTE FUNCTION public.log_flowering_changes();


--
-- Name: plot plot_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER plot_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.plot FOR EACH ROW EXECUTE FUNCTION public.log_plot_changes();


--
-- Name: role_permission role_permission_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER role_permission_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.role_permission FOR EACH ROW EXECUTE FUNCTION public.log_role_permission_changes();


--
-- Name: transaction transaction_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER transaction_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.transaction FOR EACH ROW EXECUTE FUNCTION public.log_transaction_changes();


--
-- Name: users users_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER users_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.log_user_changes();


--
-- Name: cultural_work_tasks fk_cultural_work_tasks_cultural_works; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_cultural_works FOREIGN KEY (cultural_works_id) REFERENCES public.cultural_works(cultural_works_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cultural_work_tasks fk_cultural_work_tasks_plot; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_plot FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cultural_work_tasks fk_cultural_work_tasks_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_role_farm fk_farm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_farm FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON DELETE CASCADE;


--
-- Name: farm fk_farm_area_unit_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farm
    ADD CONSTRAINT fk_farm_area_unit_id FOREIGN KEY (area_unit_id) REFERENCES public.unit_of_measure(unit_of_measure_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: flowering fk_flowering_plot_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flowering fk_flowering_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: flowering fk_flowering_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_type_id FOREIGN KEY (flowering_type_id) REFERENCES public.flowering_type(flowering_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: health_checks fk_health_checks_cultural_work_tasks; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_cultural_work_tasks FOREIGN KEY (cultural_work_tasks_id) REFERENCES public.cultural_work_tasks(cultural_work_tasks_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: health_checks fk_health_checks_recommendation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_recommendation FOREIGN KEY (recommendation_id) REFERENCES public.recommendation(recommendation_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: health_checks fk_health_checks_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: invitation fk_invitation_farm_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: invitation fk_invitation_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: invitation fk_invitation_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: invitation fk_invitation_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_user FOREIGN KEY (inviter_user_id) REFERENCES public.users(user_id);


--
-- Name: notifications fk_notifications_notification_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_notification_type_id FOREIGN KEY (notification_type_id) REFERENCES public.notification_type(notification_type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notifications fk_notifications_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notifications fk_notifications_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: plot fk_plot_coffee_variety_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_coffee_variety_id FOREIGN KEY (coffee_variety_id) REFERENCES public.coffee_variety(coffee_variety_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: plot fk_plot_farm_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: plot fk_plot_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_role_farm fk_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;


--
-- Name: role_permission fk_role_permission_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_permission_id FOREIGN KEY (permission_id) REFERENCES public.permission(permission_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: role_permission fk_role_permission_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_role_farm fk_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- Name: plot fk_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON DELETE RESTRICT;


--
-- Name: status fk_status_status_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT fk_status_status_type_id FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: transaction fk_transaction_plot_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transaction fk_transaction_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: transaction fk_transaction_transaction_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_category_id FOREIGN KEY (transaction_category_id) REFERENCES public.transaction_category(transaction_category_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: transaction fk_transaction_transaction_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_type_id FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: transaction_category fk_transaction_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT fk_transaction_type FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: unit_of_measure fk_unit_of_measure_unit_of_measure_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT fk_unit_of_measure_unit_of_measure_type_id FOREIGN KEY (unit_of_measure_type_id) REFERENCES public.unit_of_measure_type(unit_of_measure_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_role_farm fk_user_role_farm_farm_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_role_farm fk_user_role_farm_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_role_farm fk_user_role_farm_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_role_farm fk_user_role_farm_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users fk_users_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notifications notifications_farm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_farm_id_fkey FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id);


--
-- Name: notifications notifications_notification_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_notification_type_id_fkey FOREIGN KEY (notification_type_id) REFERENCES public.notification_type(notification_type_id);


--
-- Name: notifications notifications_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- PostgreSQL database dump complete
--

