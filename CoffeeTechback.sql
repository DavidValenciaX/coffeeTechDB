PGDMP                      }            railway    16.4 (Debian 16.4-1.pgdg120+2)    16.4 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    railway    DATABASE     r   CREATE DATABASE railway WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE railway;
                postgres    false                        3079    16389    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                   false            �           0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                        false    2            3           1255    16435 !   log_cultural_work_tasks_changes()    FUNCTION     �  CREATE FUNCTION public.log_cultural_work_tasks_changes() RETURNS trigger
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
 8   DROP FUNCTION public.log_cultural_work_tasks_changes();
       public          postgres    false            8           1255    16436    log_farm_changes()    FUNCTION     	  CREATE FUNCTION public.log_farm_changes() RETURNS trigger
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
 )   DROP FUNCTION public.log_farm_changes();
       public          postgres    false            @           1255    16437    log_flowering_changes()    FUNCTION     		  CREATE FUNCTION public.log_flowering_changes() RETURNS trigger
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
 .   DROP FUNCTION public.log_flowering_changes();
       public          postgres    false            A           1255    16438    log_health_checks_changes()    FUNCTION     .	  CREATE FUNCTION public.log_health_checks_changes() RETURNS trigger
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
 2   DROP FUNCTION public.log_health_checks_changes();
       public          postgres    false            B           1255    16439    log_plot_changes()    FUNCTION     (  CREATE FUNCTION public.log_plot_changes() RETURNS trigger
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
 )   DROP FUNCTION public.log_plot_changes();
       public          postgres    false            C           1255    16440    log_role_permission_changes()    FUNCTION     :  CREATE FUNCTION public.log_role_permission_changes() RETURNS trigger
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
 4   DROP FUNCTION public.log_role_permission_changes();
       public          postgres    false            D           1255    16441    log_transaction_changes()    FUNCTION     o  CREATE FUNCTION public.log_transaction_changes() RETURNS trigger
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
 0   DROP FUNCTION public.log_transaction_changes();
       public          postgres    false            E           1255    16442    log_user_changes()    FUNCTION     �  CREATE FUNCTION public.log_user_changes() RETURNS trigger
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
 )   DROP FUNCTION public.log_user_changes();
       public          postgres    false            �            1259    16443    coffee_variety    TABLE     x   CREATE TABLE public.coffee_variety (
    coffee_variety_id integer NOT NULL,
    name character varying(50) NOT NULL
);
 "   DROP TABLE public.coffee_variety;
       public         heap    postgres    false            �            1259    16446 $   coffee_variety_coffee_variety_id_seq    SEQUENCE     �   CREATE SEQUENCE public.coffee_variety_coffee_variety_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.coffee_variety_coffee_variety_id_seq;
       public          postgres    false    217            �           0    0 $   coffee_variety_coffee_variety_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.coffee_variety_coffee_variety_id_seq OWNED BY public.coffee_variety.coffee_variety_id;
          public          postgres    false    218            �            1259    16447    cultural_work_tasks    TABLE     �  CREATE TABLE public.cultural_work_tasks (
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
 '   DROP TABLE public.cultural_work_tasks;
       public         heap    postgres    false            �            1259    16451 .   cultural_work_tasks_cultural_work_tasks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cultural_work_tasks_cultural_work_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 E   DROP SEQUENCE public.cultural_work_tasks_cultural_work_tasks_id_seq;
       public          postgres    false    219            �           0    0 .   cultural_work_tasks_cultural_work_tasks_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.cultural_work_tasks_cultural_work_tasks_id_seq OWNED BY public.cultural_work_tasks.cultural_work_tasks_id;
          public          postgres    false    220            �            1259    16452    cultural_works    TABLE     �   CREATE TABLE public.cultural_works (
    cultural_works_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255)
);
 "   DROP TABLE public.cultural_works;
       public         heap    postgres    false            �            1259    16455 $   cultural_works_cultural_works_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cultural_works_cultural_works_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.cultural_works_cultural_works_id_seq;
       public          postgres    false    221            �           0    0 $   cultural_works_cultural_works_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.cultural_works_cultural_works_id_seq OWNED BY public.cultural_works.cultural_works_id;
          public          postgres    false    222            �            1259    16456    farm    TABLE     �   CREATE TABLE public.farm (
    farm_id integer NOT NULL,
    name character varying(100) NOT NULL,
    area numeric(10,2) NOT NULL,
    area_unit_id integer NOT NULL,
    status_id integer NOT NULL
);
    DROP TABLE public.farm;
       public         heap    postgres    false            �            1259    16459    farm_farm_id_seq    SEQUENCE     �   CREATE SEQUENCE public.farm_farm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.farm_farm_id_seq;
       public          postgres    false    223            �           0    0    farm_farm_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.farm_farm_id_seq OWNED BY public.farm.farm_id;
          public          postgres    false    224            �            1259    16460    flowering_flowering_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flowering_flowering_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.flowering_flowering_id_seq;
       public          postgres    false            �            1259    16461 	   flowering    TABLE     #  CREATE TABLE public.flowering (
    flowering_id integer DEFAULT nextval('public.flowering_flowering_id_seq'::regclass) NOT NULL,
    plot_id integer NOT NULL,
    flowering_date date NOT NULL,
    harvest_date date,
    status_id integer NOT NULL,
    flowering_type_id integer NOT NULL
);
    DROP TABLE public.flowering;
       public         heap    postgres    false    225            �            1259    16465    flowering_type    TABLE     x   CREATE TABLE public.flowering_type (
    flowering_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);
 "   DROP TABLE public.flowering_type;
       public         heap    postgres    false            �            1259    16468 $   flowering_type_flowering_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flowering_type_flowering_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.flowering_type_flowering_type_id_seq;
       public          postgres    false    227            �           0    0 $   flowering_type_flowering_type_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.flowering_type_flowering_type_id_seq OWNED BY public.flowering_type.flowering_type_id;
          public          postgres    false    228            �            1259    16469    health_checks    TABLE       CREATE TABLE public.health_checks (
    health_checks_id integer NOT NULL,
    check_date date NOT NULL,
    recommendation_id integer NOT NULL,
    prediction character varying(150) NOT NULL,
    cultural_work_tasks_id integer NOT NULL,
    status_id integer DEFAULT 35 NOT NULL
);
 !   DROP TABLE public.health_checks;
       public         heap    postgres    false            �            1259    16473 "   health_checks_health_checks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.health_checks_health_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.health_checks_health_checks_id_seq;
       public          postgres    false    229            �           0    0 "   health_checks_health_checks_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.health_checks_health_checks_id_seq OWNED BY public.health_checks.health_checks_id;
          public          postgres    false    230            �            1259    16474    health_checks_id_seq    SEQUENCE     }   CREATE SEQUENCE public.health_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.health_checks_id_seq;
       public          postgres    false    229            �           0    0    health_checks_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.health_checks_id_seq OWNED BY public.health_checks.health_checks_id;
          public          postgres    false    231            �            1259    16475 
   invitation    TABLE     C  CREATE TABLE public.invitation (
    invitation_id integer NOT NULL,
    email character varying(150) NOT NULL,
    suggested_role character varying(50) NOT NULL,
    status_id integer DEFAULT 24 NOT NULL,
    farm_id integer NOT NULL,
    inviter_user_id integer NOT NULL,
    date timestamp without time zone NOT NULL
);
    DROP TABLE public.invitation;
       public         heap    postgres    false            �            1259    16479    invitation_invitation_id_seq    SEQUENCE     �   CREATE SEQUENCE public.invitation_invitation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.invitation_invitation_id_seq;
       public          postgres    false    232            �           0    0    invitation_invitation_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.invitation_invitation_id_seq OWNED BY public.invitation.invitation_id;
          public          postgres    false    233            �            1259    16480    notification_type    TABLE     ~   CREATE TABLE public.notification_type (
    notification_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);
 %   DROP TABLE public.notification_type;
       public         heap    postgres    false            �            1259    16483 *   notification_type_notification_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notification_type_notification_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public.notification_type_notification_type_id_seq;
       public          postgres    false    234            �           0    0 *   notification_type_notification_type_id_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE public.notification_type_notification_type_id_seq OWNED BY public.notification_type.notification_type_id;
          public          postgres    false    235            �            1259    16484    notifications    TABLE       CREATE TABLE public.notifications (
    notifications_id integer NOT NULL,
    message character varying(255),
    date timestamp without time zone,
    user_id integer NOT NULL,
    invitation_id integer,
    notification_type_id integer,
    farm_id integer,
    status_id integer
);
 !   DROP TABLE public.notifications;
       public         heap    postgres    false            �            1259    16487 "   notifications_notifications_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notifications_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.notifications_notifications_id_seq;
       public          postgres    false    236            �           0    0 "   notifications_notifications_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.notifications_notifications_id_seq OWNED BY public.notifications.notifications_id;
          public          postgres    false    237            �            1259    16488 
   permission    TABLE     �   CREATE TABLE public.permission (
    permission_id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(50)
);
    DROP TABLE public.permission;
       public         heap    postgres    false            �            1259    16491    permission_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.permission_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.permission_permission_id_seq;
       public          postgres    false    238            �           0    0    permission_permission_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.permission_permission_id_seq OWNED BY public.permission.permission_id;
          public          postgres    false    239            �            1259    16492    plot    TABLE     /  CREATE TABLE public.plot (
    plot_id integer NOT NULL,
    name character varying(100) NOT NULL,
    longitude character varying(45),
    latitude character varying(45),
    altitude character varying(45),
    coffee_variety_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer
);
    DROP TABLE public.plot;
       public         heap    postgres    false            �            1259    16495    plot_plot_id_seq    SEQUENCE     �   CREATE SEQUENCE public.plot_plot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.plot_plot_id_seq;
       public          postgres    false    240            �           0    0    plot_plot_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.plot_plot_id_seq OWNED BY public.plot.plot_id;
          public          postgres    false    241            �            1259    16496    recommendation    TABLE     �   CREATE TABLE public.recommendation (
    recommendation_id integer NOT NULL,
    recommendation character varying(255) NOT NULL,
    name character varying(45) NOT NULL
);
 "   DROP TABLE public.recommendation;
       public         heap    postgres    false            �            1259    16499    recommendation_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.recommendation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.recommendation_id_seq;
       public          postgres    false    242            �           0    0    recommendation_id_seq    SEQUENCE OWNED BY     ^   ALTER SEQUENCE public.recommendation_id_seq OWNED BY public.recommendation.recommendation_id;
          public          postgres    false    243            �            1259    16500 $   recommendation_recommendation_id_seq    SEQUENCE     �   CREATE SEQUENCE public.recommendation_recommendation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.recommendation_recommendation_id_seq;
       public          postgres    false    242            �           0    0 $   recommendation_recommendation_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.recommendation_recommendation_id_seq OWNED BY public.recommendation.recommendation_id;
          public          postgres    false    244            �            1259    16501    role    TABLE     d   CREATE TABLE public.role (
    role_id integer NOT NULL,
    name character varying(50) NOT NULL
);
    DROP TABLE public.role;
       public         heap    postgres    false            �            1259    16504    role_permission    TABLE     j   CREATE TABLE public.role_permission (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);
 #   DROP TABLE public.role_permission;
       public         heap    postgres    false            �            1259    16507    role_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.role_role_id_seq;
       public          postgres    false    245            �           0    0    role_role_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;
          public          postgres    false    247            �            1259    16508    status    TABLE     �   CREATE TABLE public.status (
    status_id integer NOT NULL,
    name character varying(45) NOT NULL,
    status_type_id integer NOT NULL
);
    DROP TABLE public.status;
       public         heap    postgres    false            �            1259    16511    status_status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.status_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.status_status_id_seq;
       public          postgres    false    248            �           0    0    status_status_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.status_status_id_seq OWNED BY public.status.status_id;
          public          postgres    false    249            �            1259    16512    status_type    TABLE     r   CREATE TABLE public.status_type (
    status_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);
    DROP TABLE public.status_type;
       public         heap    postgres    false            �            1259    16515    status_type_status_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.status_type_status_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.status_type_status_type_id_seq;
       public          postgres    false    250            �           0    0    status_type_status_type_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.status_type_status_type_id_seq OWNED BY public.status_type.status_type_id;
          public          postgres    false    251            �            1259    16516    transaction_transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transaction_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.transaction_transaction_id_seq;
       public          postgres    false            �            1259    16517    transaction    TABLE     �  CREATE TABLE public.transaction (
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
    DROP TABLE public.transaction;
       public         heap    postgres    false    252            �            1259    16521    transaction_category    TABLE     �   CREATE TABLE public.transaction_category (
    transaction_category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    transaction_type_id integer NOT NULL
);
 (   DROP TABLE public.transaction_category;
       public         heap    postgres    false            �            1259    16524 0   transaction_category_transaction_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transaction_category_transaction_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 G   DROP SEQUENCE public.transaction_category_transaction_category_id_seq;
       public          postgres    false    254            �           0    0 0   transaction_category_transaction_category_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.transaction_category_transaction_category_id_seq OWNED BY public.transaction_category.transaction_category_id;
          public          postgres    false    255                        1259    16525 (   transaction_type_transaction_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transaction_type_transaction_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.transaction_type_transaction_type_id_seq;
       public          postgres    false                       1259    16526    transaction_type    TABLE     �   CREATE TABLE public.transaction_type (
    transaction_type_id integer DEFAULT nextval('public.transaction_type_transaction_type_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL
);
 $   DROP TABLE public.transaction_type;
       public         heap    postgres    false    256                       1259    16530    unit_of_measure    TABLE     �   CREATE TABLE public.unit_of_measure (
    unit_of_measure_id integer NOT NULL,
    name character varying(50) NOT NULL,
    abbreviation character varying(10) NOT NULL,
    unit_of_measure_type_id integer NOT NULL
);
 #   DROP TABLE public.unit_of_measure;
       public         heap    postgres    false                       1259    16533    unit_of_measure_type    TABLE     �   CREATE TABLE public.unit_of_measure_type (
    unit_of_measure_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);
 (   DROP TABLE public.unit_of_measure_type;
       public         heap    postgres    false                       1259    16536 0   unit_of_measure_type_unit_of_measure_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.unit_of_measure_type_unit_of_measure_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 G   DROP SEQUENCE public.unit_of_measure_type_unit_of_measure_type_id_seq;
       public          postgres    false    259            �           0    0 0   unit_of_measure_type_unit_of_measure_type_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.unit_of_measure_type_unit_of_measure_type_id_seq OWNED BY public.unit_of_measure_type.unit_of_measure_type_id;
          public          postgres    false    260                       1259    16537 &   unit_of_measure_unit_of_measure_id_seq    SEQUENCE     �   CREATE SEQUENCE public.unit_of_measure_unit_of_measure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.unit_of_measure_unit_of_measure_id_seq;
       public          postgres    false    258            �           0    0 &   unit_of_measure_unit_of_measure_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.unit_of_measure_unit_of_measure_id_seq OWNED BY public.unit_of_measure.unit_of_measure_id;
          public          postgres    false    261                       1259    16538    user_role_farm    TABLE     �   CREATE TABLE public.user_role_farm (
    user_role_farm_id integer NOT NULL,
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer DEFAULT 22
);
 "   DROP TABLE public.user_role_farm;
       public         heap    postgres    false                       1259    16542 $   user_role_farm_user_role_farm_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_role_farm_user_role_farm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.user_role_farm_user_role_farm_id_seq;
       public          postgres    false    262            �           0    0 $   user_role_farm_user_role_farm_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.user_role_farm_user_role_farm_id_seq OWNED BY public.user_role_farm.user_role_farm_id;
          public          postgres    false    263                       1259    16543    users_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false            	           1259    16544    users    TABLE     �  CREATE TABLE public.users (
    user_id integer DEFAULT nextval('public.users_user_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash character varying(255) NOT NULL,
    verification_token character varying(255),
    session_token character varying(50),
    status_id integer NOT NULL,
    fcm_token character varying(255)
);
    DROP TABLE public.users;
       public         heap    postgres    false    264            .           2604    16550 *   cultural_work_tasks cultural_work_tasks_id    DEFAULT     �   ALTER TABLE ONLY public.cultural_work_tasks ALTER COLUMN cultural_work_tasks_id SET DEFAULT nextval('public.cultural_work_tasks_cultural_work_tasks_id_seq'::regclass);
 Y   ALTER TABLE public.cultural_work_tasks ALTER COLUMN cultural_work_tasks_id DROP DEFAULT;
       public          postgres    false    220    219            0           2604    16551    farm farm_id    DEFAULT     l   ALTER TABLE ONLY public.farm ALTER COLUMN farm_id SET DEFAULT nextval('public.farm_farm_id_seq'::regclass);
 ;   ALTER TABLE public.farm ALTER COLUMN farm_id DROP DEFAULT;
       public          postgres    false    224    223            2           2604    16552     flowering_type flowering_type_id    DEFAULT     �   ALTER TABLE ONLY public.flowering_type ALTER COLUMN flowering_type_id SET DEFAULT nextval('public.flowering_type_flowering_type_id_seq'::regclass);
 O   ALTER TABLE public.flowering_type ALTER COLUMN flowering_type_id DROP DEFAULT;
       public          postgres    false    228    227            3           2604    16553    health_checks health_checks_id    DEFAULT     �   ALTER TABLE ONLY public.health_checks ALTER COLUMN health_checks_id SET DEFAULT nextval('public.health_checks_id_seq'::regclass);
 M   ALTER TABLE public.health_checks ALTER COLUMN health_checks_id DROP DEFAULT;
       public          postgres    false    231    229            5           2604    16554    invitation invitation_id    DEFAULT     �   ALTER TABLE ONLY public.invitation ALTER COLUMN invitation_id SET DEFAULT nextval('public.invitation_invitation_id_seq'::regclass);
 G   ALTER TABLE public.invitation ALTER COLUMN invitation_id DROP DEFAULT;
       public          postgres    false    233    232            7           2604    16555 &   notification_type notification_type_id    DEFAULT     �   ALTER TABLE ONLY public.notification_type ALTER COLUMN notification_type_id SET DEFAULT nextval('public.notification_type_notification_type_id_seq'::regclass);
 U   ALTER TABLE public.notification_type ALTER COLUMN notification_type_id DROP DEFAULT;
       public          postgres    false    235    234            8           2604    16556    notifications notifications_id    DEFAULT     �   ALTER TABLE ONLY public.notifications ALTER COLUMN notifications_id SET DEFAULT nextval('public.notifications_notifications_id_seq'::regclass);
 M   ALTER TABLE public.notifications ALTER COLUMN notifications_id DROP DEFAULT;
       public          postgres    false    237    236            9           2604    16557    permission permission_id    DEFAULT     �   ALTER TABLE ONLY public.permission ALTER COLUMN permission_id SET DEFAULT nextval('public.permission_permission_id_seq'::regclass);
 G   ALTER TABLE public.permission ALTER COLUMN permission_id DROP DEFAULT;
       public          postgres    false    239    238            :           2604    16558    plot plot_id    DEFAULT     l   ALTER TABLE ONLY public.plot ALTER COLUMN plot_id SET DEFAULT nextval('public.plot_plot_id_seq'::regclass);
 ;   ALTER TABLE public.plot ALTER COLUMN plot_id DROP DEFAULT;
       public          postgres    false    241    240            ;           2604    16559     recommendation recommendation_id    DEFAULT     �   ALTER TABLE ONLY public.recommendation ALTER COLUMN recommendation_id SET DEFAULT nextval('public.recommendation_id_seq'::regclass);
 O   ALTER TABLE public.recommendation ALTER COLUMN recommendation_id DROP DEFAULT;
       public          postgres    false    243    242            <           2604    16560    role role_id    DEFAULT     l   ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);
 ;   ALTER TABLE public.role ALTER COLUMN role_id DROP DEFAULT;
       public          postgres    false    247    245            =           2604    16561    status status_id    DEFAULT     t   ALTER TABLE ONLY public.status ALTER COLUMN status_id SET DEFAULT nextval('public.status_status_id_seq'::regclass);
 ?   ALTER TABLE public.status ALTER COLUMN status_id DROP DEFAULT;
       public          postgres    false    249    248            >           2604    16562    status_type status_type_id    DEFAULT     �   ALTER TABLE ONLY public.status_type ALTER COLUMN status_type_id SET DEFAULT nextval('public.status_type_status_type_id_seq'::regclass);
 I   ALTER TABLE public.status_type ALTER COLUMN status_type_id DROP DEFAULT;
       public          postgres    false    251    250            @           2604    16563 ,   transaction_category transaction_category_id    DEFAULT     �   ALTER TABLE ONLY public.transaction_category ALTER COLUMN transaction_category_id SET DEFAULT nextval('public.transaction_category_transaction_category_id_seq'::regclass);
 [   ALTER TABLE public.transaction_category ALTER COLUMN transaction_category_id DROP DEFAULT;
       public          postgres    false    255    254            B           2604    16564 "   unit_of_measure unit_of_measure_id    DEFAULT     �   ALTER TABLE ONLY public.unit_of_measure ALTER COLUMN unit_of_measure_id SET DEFAULT nextval('public.unit_of_measure_unit_of_measure_id_seq'::regclass);
 Q   ALTER TABLE public.unit_of_measure ALTER COLUMN unit_of_measure_id DROP DEFAULT;
       public          postgres    false    261    258            C           2604    16565 ,   unit_of_measure_type unit_of_measure_type_id    DEFAULT     �   ALTER TABLE ONLY public.unit_of_measure_type ALTER COLUMN unit_of_measure_type_id SET DEFAULT nextval('public.unit_of_measure_type_unit_of_measure_type_id_seq'::regclass);
 [   ALTER TABLE public.unit_of_measure_type ALTER COLUMN unit_of_measure_type_id DROP DEFAULT;
       public          postgres    false    260    259            D           2604    16566     user_role_farm user_role_farm_id    DEFAULT     �   ALTER TABLE ONLY public.user_role_farm ALTER COLUMN user_role_farm_id SET DEFAULT nextval('public.user_role_farm_user_role_farm_id_seq'::regclass);
 O   ALTER TABLE public.user_role_farm ALTER COLUMN user_role_farm_id DROP DEFAULT;
       public          postgres    false    263    262            U          0    16443    coffee_variety 
   TABLE DATA           A   COPY public.coffee_variety (coffee_variety_id, name) FROM stdin;
    public          postgres    false    217   ?�      W          0    16447    cultural_work_tasks 
   TABLE DATA           �   COPY public.cultural_work_tasks (cultural_work_tasks_id, cultural_works_id, plot_id, reminder_owner, reminder_collaborator, collaborator_user_id, owner_user_id, status_id, task_date, created_at) FROM stdin;
    public          postgres    false    219   ��      Y          0    16452    cultural_works 
   TABLE DATA           N   COPY public.cultural_works (cultural_works_id, name, description) FROM stdin;
    public          postgres    false    221   �      [          0    16456    farm 
   TABLE DATA           L   COPY public.farm (farm_id, name, area, area_unit_id, status_id) FROM stdin;
    public          postgres    false    223   ٠      ^          0    16461 	   flowering 
   TABLE DATA           v   COPY public.flowering (flowering_id, plot_id, flowering_date, harvest_date, status_id, flowering_type_id) FROM stdin;
    public          postgres    false    226   Ӧ      _          0    16465    flowering_type 
   TABLE DATA           A   COPY public.flowering_type (flowering_type_id, name) FROM stdin;
    public          postgres    false    227   e�      a          0    16469    health_checks 
   TABLE DATA           �   COPY public.health_checks (health_checks_id, check_date, recommendation_id, prediction, cultural_work_tasks_id, status_id) FROM stdin;
    public          postgres    false    229   ��      d          0    16475 
   invitation 
   TABLE DATA           u   COPY public.invitation (invitation_id, email, suggested_role, status_id, farm_id, inviter_user_id, date) FROM stdin;
    public          postgres    false    232   ��      f          0    16480    notification_type 
   TABLE DATA           G   COPY public.notification_type (notification_type_id, name) FROM stdin;
    public          postgres    false    234   �      h          0    16484    notifications 
   TABLE DATA           �   COPY public.notifications (notifications_id, message, date, user_id, invitation_id, notification_type_id, farm_id, status_id) FROM stdin;
    public          postgres    false    236   ]�      j          0    16488 
   permission 
   TABLE DATA           F   COPY public.permission (permission_id, description, name) FROM stdin;
    public          postgres    false    238   !�      l          0    16492    plot 
   TABLE DATA           s   COPY public.plot (plot_id, name, longitude, latitude, altitude, coffee_variety_id, farm_id, status_id) FROM stdin;
    public          postgres    false    240   {�      n          0    16496    recommendation 
   TABLE DATA           Q   COPY public.recommendation (recommendation_id, recommendation, name) FROM stdin;
    public          postgres    false    242   X�      q          0    16501    role 
   TABLE DATA           -   COPY public.role (role_id, name) FROM stdin;
    public          postgres    false    245   ��      r          0    16504    role_permission 
   TABLE DATA           A   COPY public.role_permission (role_id, permission_id) FROM stdin;
    public          postgres    false    246   �      t          0    16508    status 
   TABLE DATA           A   COPY public.status (status_id, name, status_type_id) FROM stdin;
    public          postgres    false    248   ��      v          0    16512    status_type 
   TABLE DATA           ;   COPY public.status_type (status_type_id, name) FROM stdin;
    public          postgres    false    250   ��      y          0    16517    transaction 
   TABLE DATA           �   COPY public.transaction (transaction_id, plot_id, description, transaction_type_id, transaction_date, status_id, value, transaction_category_id, creador_id) FROM stdin;
    public          postgres    false    253   U�      z          0    16521    transaction_category 
   TABLE DATA           b   COPY public.transaction_category (transaction_category_id, name, transaction_type_id) FROM stdin;
    public          postgres    false    254   ��      }          0    16526    transaction_type 
   TABLE DATA           E   COPY public.transaction_type (transaction_type_id, name) FROM stdin;
    public          postgres    false    257   ��      ~          0    16530    unit_of_measure 
   TABLE DATA           j   COPY public.unit_of_measure (unit_of_measure_id, name, abbreviation, unit_of_measure_type_id) FROM stdin;
    public          postgres    false    258   -�                0    16533    unit_of_measure_type 
   TABLE DATA           M   COPY public.unit_of_measure_type (unit_of_measure_type_id, name) FROM stdin;
    public          postgres    false    259   ��      �          0    16538    user_role_farm 
   TABLE DATA           a   COPY public.user_role_farm (user_role_farm_id, role_id, user_id, farm_id, status_id) FROM stdin;
    public          postgres    false    262   :�      �          0    16544    users 
   TABLE DATA           }   COPY public.users (user_id, name, email, password_hash, verification_token, session_token, status_id, fcm_token) FROM stdin;
    public          postgres    false    265   g�      �           0    0 $   coffee_variety_coffee_variety_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.coffee_variety_coffee_variety_id_seq', 1, false);
          public          postgres    false    218            �           0    0 .   cultural_work_tasks_cultural_work_tasks_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.cultural_work_tasks_cultural_work_tasks_id_seq', 148, true);
          public          postgres    false    220            �           0    0 $   cultural_works_cultural_works_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.cultural_works_cultural_works_id_seq', 1, false);
          public          postgres    false    222            �           0    0    farm_farm_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.farm_farm_id_seq', 160, true);
          public          postgres    false    224            �           0    0    flowering_flowering_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.flowering_flowering_id_seq', 99, true);
          public          postgres    false    225            �           0    0 $   flowering_type_flowering_type_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.flowering_type_flowering_type_id_seq', 2, true);
          public          postgres    false    228            �           0    0 "   health_checks_health_checks_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.health_checks_health_checks_id_seq', 1, false);
          public          postgres    false    230            �           0    0    health_checks_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.health_checks_id_seq', 316, true);
          public          postgres    false    231            �           0    0    invitation_invitation_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.invitation_invitation_id_seq', 66, true);
          public          postgres    false    233            �           0    0 *   notification_type_notification_type_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.notification_type_notification_type_id_seq', 2, true);
          public          postgres    false    235            �           0    0 "   notifications_notifications_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.notifications_notifications_id_seq', 441, true);
          public          postgres    false    237            �           0    0    permission_permission_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.permission_permission_id_seq', 28, true);
          public          postgres    false    239            �           0    0    plot_plot_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.plot_plot_id_seq', 83, true);
          public          postgres    false    241            �           0    0    recommendation_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.recommendation_id_seq', 11, true);
          public          postgres    false    243            �           0    0 $   recommendation_recommendation_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.recommendation_recommendation_id_seq', 1, false);
          public          postgres    false    244            �           0    0    role_role_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.role_role_id_seq', 1, false);
          public          postgres    false    247            �           0    0    status_status_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.status_status_id_seq', 6, true);
          public          postgres    false    249            �           0    0    status_type_status_type_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.status_type_status_type_id_seq', 11, true);
          public          postgres    false    251            �           0    0 0   transaction_category_transaction_category_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.transaction_category_transaction_category_id_seq', 6, true);
          public          postgres    false    255            �           0    0    transaction_transaction_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.transaction_transaction_id_seq', 73, true);
          public          postgres    false    252            �           0    0 (   transaction_type_transaction_type_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.transaction_type_transaction_type_id_seq', 2, true);
          public          postgres    false    256            �           0    0 0   unit_of_measure_type_unit_of_measure_type_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.unit_of_measure_type_unit_of_measure_type_id_seq', 6, true);
          public          postgres    false    260            �           0    0 &   unit_of_measure_unit_of_measure_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.unit_of_measure_unit_of_measure_id_seq', 10, true);
          public          postgres    false    261            �           0    0 $   user_role_farm_user_role_farm_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.user_role_farm_user_role_farm_id_seq', 233, true);
          public          postgres    false    263            �           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.users_user_id_seq', 112, true);
          public          postgres    false    264            H           2606    16568 "   coffee_variety coffee_variety_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.coffee_variety
    ADD CONSTRAINT coffee_variety_pkey PRIMARY KEY (coffee_variety_id);
 L   ALTER TABLE ONLY public.coffee_variety DROP CONSTRAINT coffee_variety_pkey;
       public            postgres    false    217            L           2606    16570 "   cultural_works cultural_works_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.cultural_works
    ADD CONSTRAINT cultural_works_pkey PRIMARY KEY (cultural_works_id);
 L   ALTER TABLE ONLY public.cultural_works DROP CONSTRAINT cultural_works_pkey;
       public            postgres    false    221            N           2606    16572    farm farm_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.farm
    ADD CONSTRAINT farm_pkey PRIMARY KEY (farm_id);
 8   ALTER TABLE ONLY public.farm DROP CONSTRAINT farm_pkey;
       public            postgres    false    223            S           2606    16575    flowering flowering_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT flowering_pkey PRIMARY KEY (flowering_id);
 B   ALTER TABLE ONLY public.flowering DROP CONSTRAINT flowering_pkey;
       public            postgres    false    226            U           2606    16580 "   flowering_type flowering_type_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.flowering_type
    ADD CONSTRAINT flowering_type_pkey PRIMARY KEY (flowering_type_id);
 L   ALTER TABLE ONLY public.flowering_type DROP CONSTRAINT flowering_type_pkey;
       public            postgres    false    227            W           2606    16582     health_checks health_checks_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT health_checks_pkey PRIMARY KEY (health_checks_id);
 J   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT health_checks_pkey;
       public            postgres    false    229            Z           2606    16584 (   notification_type notification_type_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.notification_type
    ADD CONSTRAINT notification_type_pkey PRIMARY KEY (notification_type_id);
 R   ALTER TABLE ONLY public.notification_type DROP CONSTRAINT notification_type_pkey;
       public            postgres    false    234            ^           2606    16586     notifications notifications_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notifications_id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public            postgres    false    236            `           2606    16588    permission permission_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.permission DROP CONSTRAINT permission_name_key;
       public            postgres    false    238            b           2606    16590    permission permission_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);
 D   ALTER TABLE ONLY public.permission DROP CONSTRAINT permission_pkey;
       public            postgres    false    238            f           2606    16592    plot plot_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT plot_pkey PRIMARY KEY (plot_id);
 8   ALTER TABLE ONLY public.plot DROP CONSTRAINT plot_pkey;
       public            postgres    false    240            h           2606    16594 "   recommendation recommendation_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (recommendation_id);
 L   ALTER TABLE ONLY public.recommendation DROP CONSTRAINT recommendation_pkey;
       public            postgres    false    242            j           2606    16596    role role_name_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);
 <   ALTER TABLE ONLY public.role DROP CONSTRAINT role_name_key;
       public            postgres    false    245            p           2606    16598 $   role_permission role_permission_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (role_id, permission_id);
 N   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_pkey;
       public            postgres    false    246    246            l           2606    16600    role role_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            postgres    false    245            t           2606    16602    status status_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (status_id);
 <   ALTER TABLE ONLY public.status DROP CONSTRAINT status_pkey;
       public            postgres    false    248            w           2606    16604    status_type status_type_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_pkey PRIMARY KEY (status_type_id);
 F   ALTER TABLE ONLY public.status_type DROP CONSTRAINT status_type_pkey;
       public            postgres    false    250            �           2606    16606 .   transaction_category transaction_category_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT transaction_category_pkey PRIMARY KEY (transaction_category_id);
 X   ALTER TABLE ONLY public.transaction_category DROP CONSTRAINT transaction_category_pkey;
       public            postgres    false    254            }           2606    16608    transaction transaction_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);
 F   ALTER TABLE ONLY public.transaction DROP CONSTRAINT transaction_pkey;
       public            postgres    false    253            �           2606    16610 &   transaction_type transaction_type_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.transaction_type
    ADD CONSTRAINT transaction_type_pkey PRIMARY KEY (transaction_type_id);
 P   ALTER TABLE ONLY public.transaction_type DROP CONSTRAINT transaction_type_pkey;
       public            postgres    false    257            �           2606    16612 #   unit_of_measure unique_abbreviation 
   CONSTRAINT     f   ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unique_abbreviation UNIQUE (abbreviation);
 M   ALTER TABLE ONLY public.unit_of_measure DROP CONSTRAINT unique_abbreviation;
       public            postgres    false    258            J           2606    16614 1   cultural_work_tasks unique_cultural_work_tasks_id 
   CONSTRAINT     ~   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT unique_cultural_work_tasks_id UNIQUE (cultural_work_tasks_id);
 [   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT unique_cultural_work_tasks_id;
       public            postgres    false    219            �           2606    16616 $   unit_of_measure unit_of_measure_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (unit_of_measure_id);
 N   ALTER TABLE ONLY public.unit_of_measure DROP CONSTRAINT unit_of_measure_pkey;
       public            postgres    false    258            �           2606    16618 .   unit_of_measure_type unit_of_measure_type_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.unit_of_measure_type
    ADD CONSTRAINT unit_of_measure_type_pkey PRIMARY KEY (unit_of_measure_type_id);
 X   ALTER TABLE ONLY public.unit_of_measure_type DROP CONSTRAINT unit_of_measure_type_pkey;
       public            postgres    false    259            �           2606    16620 "   user_role_farm user_role_farm_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT user_role_farm_pkey PRIMARY KEY (user_role_farm_id);
 L   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT user_role_farm_pkey;
       public            postgres    false    262            �           2606    16622    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    265            �           2606    16624    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    265            P           1259    16625    fk_flowering_plot1_idx    INDEX     O   CREATE INDEX fk_flowering_plot1_idx ON public.flowering USING btree (plot_id);
 *   DROP INDEX public.fk_flowering_plot1_idx;
       public            postgres    false    226            Q           1259    16626    fk_flowering_status1_idx    INDEX     S   CREATE INDEX fk_flowering_status1_idx ON public.flowering USING btree (status_id);
 ,   DROP INDEX public.fk_flowering_status1_idx;
       public            postgres    false    226            X           1259    16627    fk_invitation_farm1_idx    INDEX     Q   CREATE INDEX fk_invitation_farm1_idx ON public.invitation USING btree (farm_id);
 +   DROP INDEX public.fk_invitation_farm1_idx;
       public            postgres    false    232            [           1259    16628 '   fk_notifications_notification_type1_idx    INDEX     q   CREATE INDEX fk_notifications_notification_type1_idx ON public.notifications USING btree (notification_type_id);
 ;   DROP INDEX public.fk_notifications_notification_type1_idx;
       public            postgres    false    236            \           1259    16629    fk_notifications_user1_idx    INDEX     W   CREATE INDEX fk_notifications_user1_idx ON public.notifications USING btree (user_id);
 .   DROP INDEX public.fk_notifications_user1_idx;
       public            postgres    false    236            c           1259    16630    fk_plot_coffee_variety1_idx    INDEX     Y   CREATE INDEX fk_plot_coffee_variety1_idx ON public.plot USING btree (coffee_variety_id);
 /   DROP INDEX public.fk_plot_coffee_variety1_idx;
       public            postgres    false    240            d           1259    16631    fk_plot_farm1_idx    INDEX     E   CREATE INDEX fk_plot_farm1_idx ON public.plot USING btree (farm_id);
 %   DROP INDEX public.fk_plot_farm1_idx;
       public            postgres    false    240            m           1259    16632 $   fk_role_permissions_permissions1_idx    INDEX     i   CREATE INDEX fk_role_permissions_permissions1_idx ON public.role_permission USING btree (permission_id);
 8   DROP INDEX public.fk_role_permissions_permissions1_idx;
       public            postgres    false    246            n           1259    16633    fk_role_permissions_roles1_idx    INDEX     ]   CREATE INDEX fk_role_permissions_roles1_idx ON public.role_permission USING btree (role_id);
 2   DROP INDEX public.fk_role_permissions_roles1_idx;
       public            postgres    false    246            x           1259    16634    fk_transaction_plot_id_idx    INDEX     U   CREATE INDEX fk_transaction_plot_id_idx ON public.transaction USING btree (plot_id);
 .   DROP INDEX public.fk_transaction_plot_id_idx;
       public            postgres    false    253            y           1259    16635    fk_transaction_status_id_idx    INDEX     Y   CREATE INDEX fk_transaction_status_id_idx ON public.transaction USING btree (status_id);
 0   DROP INDEX public.fk_transaction_status_id_idx;
       public            postgres    false    253            z           1259    16636 *   fk_transaction_transaction_category_id_idx    INDEX     u   CREATE INDEX fk_transaction_transaction_category_id_idx ON public.transaction USING btree (transaction_category_id);
 >   DROP INDEX public.fk_transaction_transaction_category_id_idx;
       public            postgres    false    253            {           1259    16637 &   fk_transaction_transaction_type_id_idx    INDEX     m   CREATE INDEX fk_transaction_transaction_type_id_idx ON public.transaction USING btree (transaction_type_id);
 :   DROP INDEX public.fk_transaction_transaction_type_id_idx;
       public            postgres    false    253            �           1259    16638    fk_user_role_farm_farm1_idx    INDEX     Y   CREATE INDEX fk_user_role_farm_farm1_idx ON public.user_role_farm USING btree (farm_id);
 /   DROP INDEX public.fk_user_role_farm_farm1_idx;
       public            postgres    false    262            �           1259    16639    fk_user_role_farm_roles1_idx    INDEX     Z   CREATE INDEX fk_user_role_farm_roles1_idx ON public.user_role_farm USING btree (role_id);
 0   DROP INDEX public.fk_user_role_farm_roles1_idx;
       public            postgres    false    262            �           1259    16640    fk_user_role_farm_user1_idx    INDEX     Y   CREATE INDEX fk_user_role_farm_user1_idx ON public.user_role_farm USING btree (user_id);
 /   DROP INDEX public.fk_user_role_farm_user1_idx;
       public            postgres    false    262            O           1259    16641    idx_farm_area_unit_id    INDEX     N   CREATE INDEX idx_farm_area_unit_id ON public.farm USING btree (area_unit_id);
 )   DROP INDEX public.idx_farm_area_unit_id;
       public            postgres    false    223            q           1259    16642    idx_status_status_type_id    INDEX     V   CREATE INDEX idx_status_status_type_id ON public.status USING btree (status_type_id);
 -   DROP INDEX public.idx_status_status_type_id;
       public            postgres    false    248            �           1259    16643 +   idx_unit_of_measure_unit_of_measure_type_id    INDEX     z   CREATE INDEX idx_unit_of_measure_unit_of_measure_type_id ON public.unit_of_measure USING btree (unit_of_measure_type_id);
 ?   DROP INDEX public.idx_unit_of_measure_unit_of_measure_type_id;
       public            postgres    false    258            �           1259    16644    idx_users_status_id    INDEX     J   CREATE INDEX idx_users_status_id ON public.users USING btree (status_id);
 '   DROP INDEX public.idx_users_status_id;
       public            postgres    false    265            r           1259    16645    ix_status_status_id    INDEX     K   CREATE INDEX ix_status_status_id ON public.status USING btree (status_id);
 '   DROP INDEX public.ix_status_status_id;
       public            postgres    false    248            u           1259    16646    ix_status_type_status_type_id    INDEX     _   CREATE INDEX ix_status_type_status_type_id ON public.status_type USING btree (status_type_id);
 1   DROP INDEX public.ix_status_type_status_type_id;
       public            postgres    false    250            ~           1259    16647    ix_transaction_category_id    INDEX     n   CREATE INDEX ix_transaction_category_id ON public.transaction_category USING btree (transaction_category_id);
 .   DROP INDEX public.ix_transaction_category_id;
       public            postgres    false    254            �           1259    16648    ix_transaction_type_id    INDEX     b   CREATE INDEX ix_transaction_type_id ON public.transaction_type USING btree (transaction_type_id);
 *   DROP INDEX public.ix_transaction_type_id;
       public            postgres    false    257            �           2620    16649 5   cultural_work_tasks cultural_work_tasks_audit_trigger    TRIGGER     �   CREATE TRIGGER cultural_work_tasks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.cultural_work_tasks FOR EACH ROW EXECUTE FUNCTION public.log_cultural_work_tasks_changes();
 N   DROP TRIGGER cultural_work_tasks_audit_trigger ON public.cultural_work_tasks;
       public          postgres    false    307    219            �           2620    16650    farm farm_audit_trigger    TRIGGER     �   CREATE TRIGGER farm_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.farm FOR EACH ROW EXECUTE FUNCTION public.log_farm_changes();
 0   DROP TRIGGER farm_audit_trigger ON public.farm;
       public          postgres    false    312    223            �           2620    16651 )   health_checks health_checks_audit_trigger    TRIGGER     �   CREATE TRIGGER health_checks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.health_checks FOR EACH ROW EXECUTE FUNCTION public.log_health_checks_changes();
 B   DROP TRIGGER health_checks_audit_trigger ON public.health_checks;
       public          postgres    false    229    321            �           2620    16652    flowering log_flowering_changes    TRIGGER     �   CREATE TRIGGER log_flowering_changes AFTER INSERT OR DELETE OR UPDATE ON public.flowering FOR EACH ROW EXECUTE FUNCTION public.log_flowering_changes();
 8   DROP TRIGGER log_flowering_changes ON public.flowering;
       public          postgres    false    226    320            �           2620    16653    plot plot_audit_trigger    TRIGGER     �   CREATE TRIGGER plot_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.plot FOR EACH ROW EXECUTE FUNCTION public.log_plot_changes();
 0   DROP TRIGGER plot_audit_trigger ON public.plot;
       public          postgres    false    322    240            �           2620    16654 -   role_permission role_permission_audit_trigger    TRIGGER     �   CREATE TRIGGER role_permission_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.role_permission FOR EACH ROW EXECUTE FUNCTION public.log_role_permission_changes();
 F   DROP TRIGGER role_permission_audit_trigger ON public.role_permission;
       public          postgres    false    323    246            �           2620    16655 %   transaction transaction_audit_trigger    TRIGGER     �   CREATE TRIGGER transaction_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.transaction FOR EACH ROW EXECUTE FUNCTION public.log_transaction_changes();
 >   DROP TRIGGER transaction_audit_trigger ON public.transaction;
       public          postgres    false    253    324            �           2620    16656    users users_audit_trigger    TRIGGER     �   CREATE TRIGGER users_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.log_user_changes();
 2   DROP TRIGGER users_audit_trigger ON public.users;
       public          postgres    false    265    325            �           2606    16657 9   cultural_work_tasks fk_cultural_work_tasks_cultural_works    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_cultural_works FOREIGN KEY (cultural_works_id) REFERENCES public.cultural_works(cultural_works_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 c   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_cultural_works;
       public          postgres    false    219    221    3404            �           2606    16662 /   cultural_work_tasks fk_cultural_work_tasks_plot    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_plot FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_plot;
       public          postgres    false    240    3430    219            �           2606    16667 1   cultural_work_tasks fk_cultural_work_tasks_status    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 [   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_status;
       public          postgres    false    219    3444    248            �           2606    16672    user_role_farm fk_farm    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_farm FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_farm;
       public          postgres    false    3406    223    262            �           2606    16677    farm fk_farm_area_unit_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.farm
    ADD CONSTRAINT fk_farm_area_unit_id FOREIGN KEY (area_unit_id) REFERENCES public.unit_of_measure(unit_of_measure_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 C   ALTER TABLE ONLY public.farm DROP CONSTRAINT fk_farm_area_unit_id;
       public          postgres    false    3464    223    258            �           2606    16682    flowering fk_flowering_plot_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.flowering DROP CONSTRAINT fk_flowering_plot_id;
       public          postgres    false    226    3430    240            �           2606    16687     flowering fk_flowering_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public.flowering DROP CONSTRAINT fk_flowering_status_id;
       public          postgres    false    226    248    3444            �           2606    16692    flowering fk_flowering_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_type_id FOREIGN KEY (flowering_type_id) REFERENCES public.flowering_type(flowering_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 H   ALTER TABLE ONLY public.flowering DROP CONSTRAINT fk_flowering_type_id;
       public          postgres    false    226    227    3413            �           2606    16697 2   health_checks fk_health_checks_cultural_work_tasks    FK CONSTRAINT     �   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_cultural_work_tasks FOREIGN KEY (cultural_work_tasks_id) REFERENCES public.cultural_work_tasks(cultural_work_tasks_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 \   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT fk_health_checks_cultural_work_tasks;
       public          postgres    false    229    3402    219            �           2606    16702 -   health_checks fk_health_checks_recommendation    FK CONSTRAINT     �   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_recommendation FOREIGN KEY (recommendation_id) REFERENCES public.recommendation(recommendation_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 W   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT fk_health_checks_recommendation;
       public          postgres    false    229    3432    242            �           2606    16707 %   health_checks fk_health_checks_status    FK CONSTRAINT     �   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT fk_health_checks_status;
       public          postgres    false    229    3444    248            �           2606    16712     invitation fk_invitation_farm_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.invitation DROP CONSTRAINT fk_invitation_farm_id;
       public          postgres    false    232    3406    223            �           2606    16717    invitation fk_invitation_status    FK CONSTRAINT     �   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 I   ALTER TABLE ONLY public.invitation DROP CONSTRAINT fk_invitation_status;
       public          postgres    false    3444    248    232            �           2606    16722 "   invitation fk_invitation_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public.invitation DROP CONSTRAINT fk_invitation_status_id;
       public          postgres    false    248    3444    232            �           2606    16727    invitation fk_invitation_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_user FOREIGN KEY (inviter_user_id) REFERENCES public.users(user_id);
 G   ALTER TABLE ONLY public.invitation DROP CONSTRAINT fk_invitation_user;
       public          postgres    false    3476    232    265            �           2606    16732 3   notifications fk_notifications_notification_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_notification_type_id FOREIGN KEY (notification_type_id) REFERENCES public.notification_type(notification_type_id) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_notification_type_id;
       public          postgres    false    3418    236    234            �           2606    16737 (   notifications fk_notifications_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_status_id;
       public          postgres    false    248    3444    236            �           2606    16742 &   notifications fk_notifications_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_user_id;
       public          postgres    false    265    236    3476            �           2606    16747    plot fk_plot_coffee_variety_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_coffee_variety_id FOREIGN KEY (coffee_variety_id) REFERENCES public.coffee_variety(coffee_variety_id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_plot_coffee_variety_id;
       public          postgres    false    3400    217    240            �           2606    16752    plot fk_plot_farm_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;
 >   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_plot_farm_id;
       public          postgres    false    223    3406    240            �           2606    16757    plot fk_plot_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 @   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_plot_status_id;
       public          postgres    false    240    3444    248            �           2606    16762    user_role_farm fk_role    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_role;
       public          postgres    false    3436    262    245            �           2606    16767 0   role_permission fk_role_permission_permission_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_permission_id FOREIGN KEY (permission_id) REFERENCES public.permission(permission_id) ON UPDATE CASCADE ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT fk_role_permission_permission_id;
       public          postgres    false    3426    246    238            �           2606    16772 *   role_permission fk_role_permission_role_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT fk_role_permission_role_id;
       public          postgres    false    3436    246    245            �           2606    16777    user_role_farm fk_status    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 B   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_status;
       public          postgres    false    262    3444    248            �           2606    16782    plot fk_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON DELETE RESTRICT;
 ;   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_status_id;
       public          postgres    false    248    3444    240            �           2606    16787    status fk_status_status_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.status
    ADD CONSTRAINT fk_status_status_type_id FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.status DROP CONSTRAINT fk_status_status_type_id;
       public          postgres    false    250    248    3447            �           2606    16792 "   transaction fk_transaction_plot_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_plot_id;
       public          postgres    false    3430    253    240            �           2606    16797 $   transaction fk_transaction_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_status_id;
       public          postgres    false    3444    253    248            �           2606    16802 2   transaction fk_transaction_transaction_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_category_id FOREIGN KEY (transaction_category_id) REFERENCES public.transaction_category(transaction_category_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 \   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_transaction_category_id;
       public          postgres    false    254    3456    253            �           2606    16807 .   transaction fk_transaction_transaction_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_type_id FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_transaction_type_id;
       public          postgres    false    257    253    3459            �           2606    16812 (   transaction_category fk_transaction_type    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT fk_transaction_type FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.transaction_category DROP CONSTRAINT fk_transaction_type;
       public          postgres    false    257    254    3459            �           2606    16817 :   unit_of_measure fk_unit_of_measure_unit_of_measure_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT fk_unit_of_measure_unit_of_measure_type_id FOREIGN KEY (unit_of_measure_type_id) REFERENCES public.unit_of_measure_type(unit_of_measure_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 d   ALTER TABLE ONLY public.unit_of_measure DROP CONSTRAINT fk_unit_of_measure_unit_of_measure_type_id;
       public          postgres    false    259    258    3466            �           2606    16822 (   user_role_farm fk_user_role_farm_farm_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_farm_id;
       public          postgres    false    262    223    3406            �           2606    16827 (   user_role_farm fk_user_role_farm_role_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_role_id;
       public          postgres    false    3436    245    262            �           2606    16832 *   user_role_farm fk_user_role_farm_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 T   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_status_id;
       public          postgres    false    3444    262    248            �           2606    16837 (   user_role_farm fk_user_role_farm_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_user_id;
       public          postgres    false    262    265    3476            �           2606    16842    users fk_users_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_users_status_id;
       public          postgres    false    265    248    3444            �           2606    16847 (   notifications notifications_farm_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_farm_id_fkey FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id);
 R   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_farm_id_fkey;
       public          postgres    false    3406    223    236            �           2606    16852 5   notifications notifications_notification_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_notification_type_id_fkey FOREIGN KEY (notification_type_id) REFERENCES public.notification_type(notification_type_id);
 _   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_notification_type_id_fkey;
       public          postgres    false    236    234    3418            �           2606    16857 *   notifications notifications_status_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 T   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_status_id_fkey;
       public          postgres    false    248    3444    236            U   E   x�3�tN,.�����2�t�/J���2���%r�p:����&e&r�r�dd&'r�q�$&er��qqq Ot�      W   =  x��X[�ۺ�6W1�$���� ��۠��e�Z�J�� �C��x���k����������Q~���g���Q��+�Ώ?�	~�'֯����f�N�5܊�muU�"�/���������d��!&����c��@���d��z�� ט���3�RZ�S�k &�m+�c�,1�����ٺ�l	%�ooj$���S�Lm&�kl�Qތ���y7(��cB�f�So5�K�Wؿ��n.�²�v&��Z:r:B���8@���&���K�[�����V]�t;��>�Lu&F�SG�K�Ķ�e�LP�$�z�[�}K'젢�rp�~�s�>	�M �y��#eV0��Pa�t�$�(q�0"�@:��e��������DbdZ���7/��H�ϻfm�f��.��^�E�$����q�\��C����u̓^ QZ�I�ͥ���}#qDB] g]����3���!R���)�D����\u&��4[���������.p^)t��!��V�&�ڵXܸH/Ʉ��Pپ\J��H>��	IL�q�A�o����>�Oa*���A��n/�m3��LD^\�Q���֤���x�cP�
tv0��}_� e����߶�"yd�<2��vh�j�E��ҙ;S��5R�j]%կ�ȅ��/���kT���P�-�HR��$�GQ[�W�2�8'�!�"f���Ʉ�nn��tS���^$I�{��2�ePb�����d��٣9����6��Z&�����^t#���I� )��'E�g$�nN!��I���c&�#�{D��1=�O"��b�ιa�i���f9 �s��d�ت����k�d��T3��8;��&ۗ�Se���Z�c̭�yI'������%dG�l�����*f>��mXhQBy�EQ<+���b=�ӏ~�	�����<��R�)�ܥ}Lvw�O���Ғ�p?O�A��o���sD�����&�Ztg�ǣ[��q/����	�6�07��B�i��KK��d���������}(TJ�t�#>BG���� m�VԖv,zX��4��pu�ΰ�n�GdϠ������v�=��F�`ϣD���/oZ�p��;�t
������3Ս�H�������0��w}���lX%0���Բ2������֌���,�5���hR����+��9ıJ3L�?��㮶��{oౕ*�Æ)�'y	]�j>��{4��5TR��0��w-����ö�b8-4�V�zmõ����	�A�Qb�,q��簶�ূ�44"���s�+�� 6�� -(ş�u�׏$ibu
�Ғ�+�@�E��:�H*vL�4@m9��4s]���ж\�H��o�p�!��&��S����z�DǳQ����Y�MƼJ"[v@��uc�m cn��毌c��ö�rv���6�]5��v0m��y���OX?`�Ukxv�,�۾�웎�-_���N$W>Z�SΑqN]��z+2y!e�S��б�D�Ķ[�>W��J��]l�pNK�~��G����:J����'2{"��'	_%�����G�m��7�`��m�W���pA^BWw�&���E�o#�7���X�"�x%9�����
i�s\`s�b�E��*�ւ�M+����a��?�J�g��{:E��݃�䲅�as��GN�7Y��:a-'��H�����r����S'm=+u�}o������zI�U�>�a��!�tE�z&s����v��8n���l��e۰���pS�zn5�O�4��4� /�#�@�}"?�;�����TJ�H�PM2B�L�e����#R�����2�t!�F��� �c�v�|8Iq�� 	�[1���J)�����      Y   �   x�]P;N1�7���JpDAMKc9�����IV�HT�{1�,B�ʙ�؞���x���<��ᗧ]R8n�ȈЌ�g�'נF�]�B������<��@(�ycI��s�3�E�H�g

? ��X�lQu�6\x�A��Pa�hus���+�r�^�s�L�	hD�-�t蹫���`�v���gB�o2z���'�^�Jc��Ƴ�$5Z��R9w�*�[�L�<~u��s�+k�F      [   �  x��In�F�\zE�`�^�>:�1b'r|ҥ��4��c.c��yDn�5�1�\�!?!ŭ�i�!!����}Uvui��M�}G���@#�3�y@��EQ��$�p> ��Y��>J�'���p�������# �<Y��-�>��j��pœ��:I�ɢg�ҐgMj2Ԕ.�d����ĨT�=�}{��;�ށ�	�YѭHQ:Kc��\L�� =Fңw4]��d+��E�YN�A$V����]X8��d[7&���%be��*�� ���Y��"���d���V��>��$��Y��r��P�(�.c�0��m(�Mu�!(�%��� ��EkG`R�����n�o� &g>I���\��� ��
�:�~� e�QN� ��Qh%�QX%�M%� ��y����dҢngؓ'���!��a䜧y�Aˉ�+rվ`"���#�~����	�9�`�6��H����B�8�|e^�h8��7?�e�SM)k�.���G�9�Y~(s��-�H���v��f�#�`�����*�b8���Dʺ�Q\����s_��~��{���v��-��ֶ��34��-+9���y|�5�,)iC�5E��`.94�����V}*��4Ś
OMv,�/Eː,'c���31�S�Rs<�^�H�u �ǵ��
�4:Sh�GNjt��6Xt8���Js�Nl��X�0��\�R��>�IN�m�l��I}=��;���ݛWw �;�t.#�����[��l�[�MYdf��t���G�k6��	_>~������~>�6�u�����h�(�ic,_�>��-�ݘ�ˇ~ՙ
�'���T5ls,r(�^T]���Q\�}C?:�-G2tdT�f�Ll����P�ʴ(���`j�n�ԍ����Y؄�(g ����"��h��Z�{e����(K��'Pb��L��+7�+�bp����#�W+�n�Xu��:\�����p�������Wɭ��-|}0V�H+�h�n�.�Q0���i�����b��J}�D��}@#���Vk����jx2�Jp@�(��-�ȡ��?'�ց���! '~��I�I�-�uZ ��,^)�=ll:�R���P�8�ئa�*�ћ��~_UU��݆<�;�m��|��G��m�������E,s(w�H��g��6��L�n[l�ܻ��j���CvĿ���(!�!p���sa���")Xe��l�.=|�C�Vs������ņ���6�'+���=(��y�Z�9���+?b��3D����nNwŻaH���2��&7�jg �lr/J����`�1{s��)�2���oj��bY~����3W��/^��8��d:�-C yb؛�Εr�	�-J������Zja_kKW�˶Inѽ����.�=�p(hM5H����el�h�ɹ肗����S.�I�WY�,4'u�ݣ��5�c�fE��b82Ͷ.�_��Vl%<ZCF�(AY��iq"�D\J:wy:i�<)��~��s����m��i�h=+��������j�      ^   �  x��V[�� �6{�=��������:����t��G�s@
�N�Z�'��1:��-�v��J�q:����}y�aqK(y���V�R�V)����wH��XW��O��jN��B��5w^����Jv]�gdx�U9������8� ����$��0�d��h��rF��/EHKQ�/��l�q`s�ȏ�	�B�KsT�4�5��[#�YBR��^�6��㋲�ۥ�o�gh�c@L�9�����ڨ/m$xT��>L)�L���m"�.����)9%��8	9��u��<>'�q~��I2՞����ҙp(�U	q����&doX�R�l� �����u��#��*��t�`�u���۬�+A"K �4�;װ-�I�]4W��$��dp���1��E��Ln�G�,�kFL�8;I��G@B�ܹx�w��UU֗6����RL���\���ZӣSd]�#W�8�,�����)ANm�Vh�g�39Y�3:7��Y9�b*�J�ʻ��ˏ�T�#�U��*K�@@V��V_5��i��Qe��W��`6��V���r�:,��.��G�"P`Zo�K�*�E謴
m��@� �mҜ#��^��o`SE5�-AK���8�_W�O      _   "   x�3�(��K�,H��2���,ILN����� j�#      a   �  x���Kn�0���)|���p�\�E� �*`����h�@�=W�Ћ�zS������������B^\s� ��X?>�L�z'�G��c�O����ş�}]�.��q9�]J�ES 9	��߾���r�q/������+(�A@���}<���{����K��.��_D���xa	>/�NT$�]Y�U��.|=T��h��,~�������$!)��ϲ������x�:�逘h��*+ˣ4O�p��OC�� ��@��jfG�8w����8����*���4���NA���z���u��#�0B��P��m9`��k��P#÷��@�t�����9Fn��z�	�^�~��)�&�]�k#r�(vҷ���t� �h��E"�=S�a^�C�⯵K�L `�{��GD�-���|	�FBłL���%ī�G��F�j�f�~o1����0���<l�!�[�����0������pJ�?��ehw A
��5�y{�~�Sq,F��" �m�@^�rv ���".���N��A��OzN�I�V�ҊZ����I*�K�j��H�z��Tl�L�7��v	np	np	np	��%��%��%��%��%��G�Gh	q ����5�ϩ����`ѵ�2�^=&"h�{~���C��mw.6P�ׄ�|��[������5���)��p�WeO��N\½h�qo�]A�>�{d�uu���7�a�f.n9S��xs?��} ��AM7��vI��/�z)N�����k�]Sr�\f�86�q�v||����x�a�n�"�E��*��@PŁ@J�ς�9�ʁt*!ŗ��3���3���&=s�$l�p)B�.���d�$T�H�C�T�&���$��ԘT6�r�fl�\L8<{D��d�.i4�2r�Jyj���DI��V���h�g�n!����鉅����i��d�J�^��v
�_#�(���6\����`L3���P�Y\zA�������?�9�      d   A  x����n�FE�����ztu7Wd�E��.ZRf�aH����m�#Q�h��΀���zܺE�6�n��u_�ׇ/_�m����u���r�.���b9���mEVY��*��O>?��(7>6"������
���nҸ�����:'��T������r�����b�m����w���cP�b�)��0
�dz�c�Pj8�1x��:�Wϔ)p�r�Ϸ�rq ���U���&P�C�H�>D��xs͒���q�x�R�!��G�ɥ	��Zxy(K�k��1L�H�ލ�(�䑹Q_GӬ��y��̣��h��g��&�  S��p�cN�?R���~�P#mL�H��ح	�$�z��O@�O�f�f�F����Hǁ��y�*�5^Ό0�#�'!�2�����0����&��ub�%�<9��KO�oW��G<����!b/5W��{��ޮ��y���vG���3o��	V3[�Q����H�%�G��O#�� c�oT�Hrd��`>G�!�2&��s��HU���쵤�?�q�j�F	jb��A�����[�L)k�f�K���)�,�q�J�[s�l(�M+6��[RsY��!��8>��xI���>R-���޿v�ҷC�j��y
����xs��?�c	R���t�W�t�"�j���}�����~p.)Q�bw�Pc��p)̰>�~�T\��o��P
�_n/���Bi���Ў�OȟS$L��ɉMF�wH�lz�4�RjN⇪�A���z�Ť"�T-��~�c��ݲK��1;�QCT����$���2��[��9�V�9��x��:z�c�J,�]|�1>�p�\�"��P)Xn?��$6|<���DȤ�R����)T�6���-�?Ni�}O0o�PeV/�ۀ#���j5�m�ߖ�ݾ��CTD�^�R,��0��S��px���v��B�u��NLT�ɍ�:EE���W� �8x��a�C�9y���ߖ߻M�o���Mw���^�oH*{�ܫ�� ������
r��kY{�F���¹�G�z 2����0�{5@T��7����g�;�k\����f[�?`1�c�1a� �+0@�D}v!<�$QF��&�MX�m��K�V�+�~ٮ���f?� zJ'�j�%�2�c��>�hpY�E!�u0I	�8[P�3���ĩ!����ȅ��=��e�iYBރ7�`�қ<hp	�Jo4�r�\���H��aa�ڕ�3?1�Q&Z>X���ɍ��ϐ\�`�F3�sv�6ED��wL�?y���h#X/Ŝ�{��<��8p��Q(�ǜ0�A��T-�M2��M�jVܚ�8�>r�����s��F�e      f   b   x�Mͻ@P й���l0؍i��
�\e�������иS�LW�	xY��1�'f�L�@�2	��C���_5�BX@�vЬW�%Գ>�g�G]��7D.,      h      x��]͒$�q>�>EG���V ��_�$�
+L����I��L���l��{�!����O���7_�B~g���
��*T�������p�/@�!��?���a�[n�?n�K��a�i����zO��/�ˇ���ݲ\>��?o���7����>�X#J(|/�{�K�W® 
�Zy��b!�cҿ���O˗�K��얿/�˧M����q�����y���_�{���c�,֟��#���/���B��XH�R�@0J�� Gj���������2���T�uZ.�Y(�W1��ݒ�̵�x_��~�a�ۮA�X>eV����/�*Qu�|�z���n�g!+�+�& ���(�YXK�'Im]�JK_�����D�"���8'-KgiݨѬ(.���J�����9�5�I@�(>S�^����N*�rѧ
Ќ��G�C<xf�e!H�>�I6�%E]�������ӿ,�~�����x�XF�+��Ei�c�"�S�i�d0�
U� Ki.R�y����zc�g)�EJ� ���+i
��p�E�Q�=��uI�J��F4H�v���izF��&�cB��L�QH�����^����y��;ÁVU�P�~I�X�0x�}M�_��Tn�Tg�YĠz�X���N����o�6��E�f)������MX#��#טm	b膬J�Ю�*��Ⴁ�Msi��Q1�Y)W8�`%(9$�S,�&�	�J�X���#`g��s�7��Q��©�p0�p�\a�S0��g�0{Фx/�R�sb��5"�PpK߈GW�ն0� _�:߰��@!�ʣ���$ċ�vN	5�d^�!E:�=K�<ݖ�U�{*�߅�Z.���z%���`)�
��))+d�9S[��_?e�H��'|�&n�}H~��&8Gi.B�̌"{-�J@���Ц&�D���N����yBC�U�cgq��8�r4�W�4�!#�I���pGsF�/�D�pPs��E���P�_�?nǊU�"��������X�l�)j(Y]��u���OQW������)jC"B1�.�6¹0m\m�������� ���V%.)��'s�K�E���C�.Ω+d���k](�"�Xɋ�r�Ҽ),�	k�B0�J����sCX2JJ"I��V����C ����K;��m�+�2��f����j϶Bq�TA�
�~׷�t�����tB�I6���
z\�R�Ԭ�[
ŖI��Q� ȼ��³�� ����r��n�����n9H��	�P���a�b��Y���R"2��F
˦ϲ�eÐ,(.K�l�$�����N���<�h�=c��K����g����Iy��lU� ��,�`d�Q�S<��Þ�����A��bh`9���*o)�*�ls�X0\��,�˅�!u��3J�mX@�3-����'.�?c5®쬞7�@�X~��I�r�f��VYNɔ?���������mE]��1J�0i�)#
HW��XYq���i���R����X�(0�|!���P�
��x-��z)��P�z�ȵ�S,i&[�W��#�|���8�%�5K��t�FV��$\�)@�/Y��rF��6�>l���9���W�V��O_��xDs��9����J�q��r?�{
�6�C���e_�]ŝL����9H�H��1B�2�� j؏�]GT�"l��t�G�.JO��X�@��H�(�hie�9*6#����͸��
��;4��2(��4'W=�<�Ų!eN�+�pr���8���9&������l(ɵ��vy�B�!�p½���F�bO�Ӽ�Gs�xM�	E�p��9���,O���pv�&;�����<�e�},o�����)�tW�js����U�ݬ��i� a��rf�r�[�$�q9���M�ۂ��n$��X�M��(��JhN{u��" _�&x��Z�εP�Ĝ�V���M^��D�W�b(������wbaB�+*����\��%�m_~\��e��/ׇ H_}*��U����i��{^W�~{�*ٽ�T诟64H��Y�@M+,(�[���S��8�����AÇ�[��m���|zyH�~���3�噏���5%�!-��Ԧ�`+U݋�yTM��ܠ���y�P���}~*(	�&�S�����W_�gZd�/U�R��6���Ѓ�g�>�~��)1���^/�aE$��$Ƚ9�(�H��Hքޣ�I�{��B+��$̽H`��TH4a�I
@O,b�n$t';��p�{��B��&�$A�d��Zo���Z?����m���Q��}b����dѨ;Ҋ�W#�$B,�pIŏq�33�=\��4��:4g���lS*�e-c�K��g���4!c��F�j�K�;U5.�E
��  ���XgԛQI/Wl�R�Ǽڗ���l�g�qq��V9�H�L������2��)4^�8bC�K��4%Do����� ~6zЃ��_Շ���p�?ʳ�&U'�/�T���uчd���ݧ�����/g�E����/�=��rӞ����v��\J��q�@Gl��u?��*A�P�qC�X|>JP�8���	��P���$��AW9����P�l�<��E��m��Aj�*�Q�3I��۫�����i�:�yG��CUy���-�Z�{�L:�5��+
��-x�e�:�e�&�Uh6���!hb]�F��T�ːy��+��61b]�)G�BY�2�i�l�.�n��o~*�YIK�� �y��6��4��o?7,Ñ@{��.���лS���������<{[�kB�̈́u�����,�5^�E̪��0=<:0�S��םǄ��α�7�5�Y��>�no_�ڐj����ۥ��BM�R�<�NMO��1���Cu��T��V��{��E��xUנ:�{�G�}��+܈޹U/�;,}�gZ�|��Q�����DPa�}�b5%m�w��}T<6�{���Ƃ�h��57M\WX���������+�%f�L�4*Y���ԡ$�(ޥ��>��=8�
��o��w��E�ϧ4x�UR��N���C[�e���[��{T��G75�:��rkNgr��@�q}8���E��X>�<=Ӡ>-���.���.�*۾���[eAR]b醱��f���oJ��o�,&[4��ZV�(s����ۥ6?�����~]W�c���626�&3}��1���0V�Y�U�9����h�CRÊ���B�uٙ�O�itƩ�w|�if8р�����7�P�s��}.��jwoV�M���R�͒�3/�
�����Dԑ��mEԢ�|�������2v����~��w���*G��t�yg�*_?n�.�e��Q�!,);�eK������ɥīl���TDm��]S�v{f��������G����	4z>�v]�o����K�UE��M���I�16+^�%����j?����l7�!�e
V�t��{��� ��- 9��2)��tyR�����׫�v�y�rĤpN�Z�[UTS�L_�!��F`\�S29:5p|���u��s�m]�ql����(�>��:�h���]��c_�Q���W��������5�4�������Qǁ�8={_b|�R����L�[qGC�\&c�<�?G�p��|�J��$��r��6��j��X�%��
�XG����a+�Wx��� $&OM�>2z�&�~*q#�];����m+��|?2��N�n:�;p�筊����+U(/��
J�y@�O���	5����?7��/WF]�p����va��F�����q�8�r��5$e���>!O}f�Ȣ%���l���9�ð΅vW:Rp����>pU!�O!��s['E��dW��&�WT|b�&���^N�)�]��B�M�ed�p�'�*$!�nqt~S�k[]^���x3ֽ/M+�z�0	���}OԞ� J!�m��+̌�Gq��H�pq҂}����h/�5�P�z�x.��1�f.cv6�ck�2^�Jbe�=�V��t[�M0ko s��к:�%�U��!�ɉ����d���	��C8_���VC�]H<�'�o��Z_������X~�����h1g�媱Mr�I�B+ �
  ��qE�A����0��<���u�|U��|�:�"�0WgT��q��/��$Q��S�~�}��i�uk��.������tSL{#�U��H�3��bPޭ�ζL����P@	?O�,W��v�^b��̡��B�aڐm@� f���7�������^M�����dtb���fe��N4+��RҬ���n��9�����3������f��e~G�R�k�f�����Öw�wN�X��ʙ��sVeMZ	��i�>��̲
2�2���oD��
m���"�n�B����}���4�F�e���e�sR��t������h��B���d]���e���+if�CF���$!�W�����R����+c�w$齶��+�澲���5�i����H"�yP2֗�m�v$M�����43�lG�Z��
��2w3���G�拎e��&�aI,�Z��3��N�����>'�XIL;��������껷���)65������S����q�G�� 2�� xYH��е����9�1hu�ZRB�ߊ����|ܔ�~%��EI�dB�'��
�iUh�������n������!q%]�}���o���n���h�:4ȝ�~�Ui}�[�o�t�h��M�]�A���"(��Z�ZZ��W����s_�0шL}��4�y�Y�)h�~�:�4�j܈��n��CH�ok�,�\e��,4?����d������];�)�6�7J�͂����h}��H��p���9%�m˯kT�x ��h�oe�Աe5�zʑ�S8���~��l3�gu��]i[�ۧ.8,-kc;�|���W��a�N��߼�Q�������a�����C_{�,�q���9��� /@����ڸ�V����q'sn *�Gt�hM�P���{P��9�K�7�����~��$e�\iUxiP>28����5 �]έ,�s�	W�޼~���Y�U�"� fw�KѦ��C�kvM7}�����ۛ䫵v�ލ{���Э��C[[e��U��
�}~<)�"B���H��~�ʛQ�,4���1�3�W�Oʠ�J'�l��)�
�:�' ��zR�(��r�r�Ч���9���Gu�`�G��됪�b���S��>�r�_������>�c ����%�҈>�r2�~%�J�,"'�^�䔛"SS=�r�/b|���@2��Q�� .��`�ڤ������ t�\z��[�����u$�V���R��vҨ�𘍮2��ۥ�Z>���<"�"BEv������X����	u�{���z�7p������y72��V���t��M�zV��j�N��c��w�o^j���ut�r^�>���������7��]	Zz������/���Ӎk��������+�+E1�2ޅE^0>�ɣz�o)�ZC
��[�:�5�A�� +�w�t���l���N�s~�%
duFi'�E2h�{(|�,ԉ�Bi��y�"����@��#��ͬ
�n��yjt�q6f36��ރ���ݏ�m�rl\�����!�"D7}@���$��Zbk�L/����W�Iy�8��ÊA){^F��6����z��n,q|�VQY��������V +P�G�E��*�ڮ2�6H�Ϫ��WR���@��D8*��JȚo���ؐ��T�i�D-��t/��n�s����?����_1o�iZ���OU���=�D�E��Fi/�"Ї3��Ɠ�����Ev�����T�*�|�PJ�k=��U�4����дG7粢1�7i��a�λb�S�֣�A':_m��M������rGY��|,�2�֍���ܓ$:i�M��$(٩\��mg�%�p�ȴ�L@&ķ��ȸ�$�x��o��Y�����Q#�26�~u�T��\�Vܤ�(�f�$�&��z�[�[
kt\�jŝ�q��6��6��p�S�[*Q�P�@��-��!2!r�r��p ��C��'4��]KB�{c�XD�Z���|�_JŠp�ڼ��{������ɴ�le�ӍIm���iդo=��[���BW�B��eq��ux��M�/���Am�5�"F�agTQ�G�`t����J�V���i�>'�N�x<����}s��d$�7�R�HoM<tҮ�� ��&Nhy��\���ڈƕM4Wp�s�s����������n�bj���f�6�.�LT��_4�dt8��d���;�ʘ���K5�}��V��g�f�:�l��>�{��iU��eԏ���y��]�-�����[k���Ԣ�ڥܔhMH��9ʌ~��T�Ie�leR"�g?Y7T�p�4�tNq�T��(3�1Ɠq��g(��紅��K���56<��j��P� ��^����_�7�9ɱ\��1�#*�o{����9S��ĩ�W�f���]�\��&:ʷA�S��#��n��`�E��~��~,#4Dn)E���#��:I���c��c�!�v���-hYH�XNS�"8�Oz��������|jL���9�Z����/}��f�3s�4?͵}m�\��*��]o�ja�� �4�^��]��r��vL��1��HV�&�1�h��F�+���h��>xSN�����?���GT$�L�s�I���'�{������&X�P��ZH�O$2���oa_Y�nE��L�H��w�Wn��'��E�Ѽ0Zy�������4�2�R0BS�, L�zif��iR�*0��lV�����E��S��ݻ�B�G�      j   J  x���ۭ�0���)4AQ'��-:�֢!�dH�9@��]��-�����"?R$��}G?��\�^;99�G=�������Y�0��`�J�~?�g��FO�"['O���9{7k��N��XP/�(P��!zP�'da7���^7yn�j�ivT;)�=G����FR���a��$�0�l�qCQR�\��3��e�5��z�TO�� :D��-5�p��ޙ��*�>�2�<��?�|5����V5��T�\��~���189���J6+���/�6.ŰNH1}Z��ȣ�%Ő}
O�?�k{�3�íC�������̭MIQK_�1��m�l}���+��4�^���>�K���L�Y_9;ĭ|i`)c��O�!���Ńy����o������bώ�AL[,<�}�"Vu0dV"��f�q;�]�B���~���ն�Hyl�(�ƹ�cbm8�du��J���:5�PO#�=�騺�B�ۮP��
�Xi�V����&��l�{[���`�OH�-�P�E�3u���+�\cR�Ea��;[U]^P����0�@t�	�R�^P�Ƨl���9�+��,�`Nt�x�����!�a��      l   �  x��Wˎc�]����v�X|U�L�/I��(ӚXݚ�@�N��Q~![�XN��ډ@;�E����e��w/���q����s�RJ&ve_�}�"�)W2/)/�t�����B���r<��ﾞ_����^/��\4U�����̋����������c��Z�J3U+��4S�x3�����2,���q{�˒xX갬ˇ���eI�<<=<��Üȣ.�TT����q���[��C�C׷u���̷!��9`	䎇��n 'N\j�I�����hQˎp�7�	��~����<3�I�t�LU
�z������x:��.k=%ɬ�g�4�(���4GA��F�p�n�a,��G���n��K�C�>1��I��8�5В��3�������?�֔���"�K��+ ����?�~Շ�����a���;����`��VUY��j�H\)����:���s&��ڐv��,H�@:���|��y�ee�'�,n�9�n�cg�\cL�6Fl���gdb�q�L|X�:�����r�n���zˍ\����?�k�P���>��[�ARd7$囵̈́�ԍ}ԙ��q�`����(rh4)'�ʚ�aV��+^�Z�{����L]�.���=yM}�44]M�ԍ��S���� ~2�y�D�E��f���7�J7"��J5Kʣi�kf�;��#�M�C�l����0#���9[CĚ�P#T��i�"�$��7
�M	HT�E9_����!ԗ���D���X	�F�@ �(8���U�1��~�)̽���`j}l|Er΍)PMd�4f�t�tK�`T-�Q��BB�-t�E�����~���{1\�h	���f�ن�Aw/k�P�Q�@~��С4��Нf��cf}k�=������ç�����������:|�6�dcjHIJ��I��������9"����Q�����|��,�9	s@��S�!$��ʽ$�}6'���J�CH�.
��eOF Z�]&vC��S��|>�7ͯyn���b�b�QH-��ڊ�xA�ϗ��˷��}�V����ų��9/ˊ�����]�w�n�kk�|�za7\�bϱ����K`.�o�����u�;@�4���:�a���ϫ�0�����+�
�y`C���}�H�ΞS �%Ȗ
������1ja]�6n�X��l �
������E�#��
]8��cM�q�J�2Ftjnڟ������I�7���8
hsx��� �WCx9�������/����7�p�U�T=������@lw�E�� D��W�2u�����0��KK��[�Fi:�)�6<�QS���B�۷������y���G+ɨ���qKD�ơ��m] m����
j�����ٍ�˛�E����uYb����������鲁�:��o��t�̃���[�}d�xű�iy<]����+m_��n{-�}��81�������<|F�����a�	�@ �qXҨׅ7�&��U�o��ϻ���1��2�Ť�5^���H��-��r���X��w����x�0��H]���.n����Fq|߰�p:v�;&��u�j|6��n�c��m��w��u*���=>q~��w'������U��a��f{��z7�h��7��	�S��cý�g�Q����F�� z 3���N�Rjr<��x��⠆�`�2��8[|��I�,�<�h��v�!��
KMϫ��C�p��g�Y�Yx��)�Z6Dꗫl:k������ nB0      n   \  x�uS�n�0����B�y�A�*�a$p� �=j��A�2�4`����ܥՏeH����˙���F}��5u��瘬����hM�쵷)��p�Mq�d�S
�cMc�6���ZU�oϚSu� �#l��䀀"��]����C\�$O� �*�a�q~��U�>~1���y��昮h�"f
��>��p&��nI��HG���b��Ҽzb�~��v�%�#��Ą]d��Ll���rOI�z
(������w 26x�tXB}f�YI�5�O���B�9=�=E�f���J�;J6���pC'���n�ေ�U��b�F��7�_�����|�  �B_��͛���W�¿j�$��2;��b�Q��J�Yj��x�I�z6	=�rL��N�[��i!d�b�X���>\���l6�_b>�UM}�i�����Kαڲ�e1#�	����Z�~p�y��-����`Rv�����XV�@�L����V}������@�X$bP2qK�q�.����G ��)x;�D�w��zy����S
0�Y�!�?�
E�9Ug%6zO�mW���b!z�uAZ�\G�ʖ����� �k��n��m�4 ��       q   A   x�3�(�/�L-I,���2��/H-JL�/RHIUHN�-��2�tL����,.�K�e�%'r��qqq ���      r   r   x����0�V1���ý��:���ì���p�ь����)g���҉�Q�Oe��`t�N�@
��؍=��T�Ӫ��-�i�d�I�K�h��ӆ�7�V}GU�X�      t     x�U��n�0Eg�+��%�9m�.�������%Cr2��K�~(�!u�H�j679�[���^��h;k����N���*�X÷���(9Dl��*-|]��v�T +�@"�vJd�(D^�8]�+de6a��f�Ҭ�FO�TB����:���m����5�E.�H�<�tل��O�(\ �C^�t!�	�?���X�������q����`Ne�=J��_�ܓ�����S(�Eu(�N5�􇫼�����a�e�GX���(�����ꠤ�
m,$�R�yB�?}%��      v   �   x�%̻�0F���� R�3���ʆTY�K����x}(�g���Q�(G�p+��@�:�ט�V8	G��}/~�5.�B<[ȉ68�W�l���Vs���;�1�ECz����2�sh�Sa�3��AL���>#��c,�      y     x��V���6�����7�p�[.G[9�)�U$5���8p�t~�� �Ԭ)�4#��_7Z�!�&��O\)�f�����D�Dg�:����sy�ݸ���/� �40�g�X��D@�@��V^&9��� z�8��ʍS�)`�@�R{� &#߼�?��E��X�ܠ�,����.��X�+������ѐ�XHn�/R���.��95������EGaXF ��"S��k�%2%")�d+I*I�X��H��+i�����8�2����������(��ˀ���T��#"�8�� �?���!
!
�5)9(��I��Pw�jO3���>�ʣ*��;�n3g��G�:5S���5k�շ�yH?�x��v���
O�<o�X��c��@�Ң-����7_�HNruUO��+��?�A[׎�X��Zx�w��ߵ;&j�gЩP�1:�Y���{��!p�ܗ۷���0H�lb�+!������_,�q�'2�+�!{�]����a,p���{/�H��~ o{��J��PE�u��Jl�C�A&L!�b)�M�9i�S�=T�G��<�=�g��)���q���!����f�AXU��۩������mO�����yhs��yzy�i�	�ϔL���!�{(�ɖ'���٥Ȇ�h��Rh�<2����94f�|i1ں���e�&��U|O�U�Ǩ��
�3�6'�c?.����C�vu��嫻��J�^gP���6X�7��(�6{���F��]G��m�2\ҫ����s�v���R&V������	�oKs?���A�p���,��1)���.5|PB���� ���پ�6��Z�K-�������m�\�I�mA�m�����]&�,^4خL�g���<ؐ������up�ڹ�6Zvt����~1a�L��?�&�_螇����޺��v�u�mkTː��M=&��ďW#�-�K`|hh���><��&&�����P�1ˉUp�B�оb}&�0�Tk"�߶�������n�6I� ���h4<��$��U�      z   l   x�3�K�+ITHIUHNL;��Ӑˈӿ�(��2�HL�/VHTH��IL�/JL�/J-�4�2�tK-*��ɬJ�+��r�$��f&g�$�g�%A�@)3��F\1z\\\ A*#}      }      x�3���K/J-��2�tO,.������ O�      ~   �   x�M�K
�0���"'P�>�u
R� n~�Ж&�$�<� z��b��v������Y$q���6K��I���[�^�։J��xw���mň(��tl�GS"�Gǅ�"U�׽��L�ل~,hc��a}y��<�^���,~e��!N_��@�uCD�@�         Q   x�3����K�,)M�2�<�X���e��X��e�钚W�����e���[�Z�XRZ��e�P���Y�Y���yxsW� _��      �     x�U�I��0C��aR"��.��9"����%Y|�(�������k�K�)�SǸr���^��&��)��kIa�Q��Йݩ���|3��4�_�_�;�����V�PVFx)޲ xG,� 6�q@ؒ�m)���g ��%�� �Z����>�>���������A���7r0�8�rt)z >G�x(�A��<"�����36h�J���\��̹��n��L��񧃥W:��+!:H���a�/~��^+!;��/Hz��|� A^5@2L
$åp�)��.�DR ����l 
� �P��L��˼+�:��U�������=��S�M��3~ׯ�1�Ȼ_'Q�������֭^ʉ	W�ľ%=a>�0#�_F�5����!A:0Wc 2����w#�����n����ɊW8�����w���P�Lx�(y�y����(p�Q�|vd`���a�%45�Ÿ4u�Ŧ��Z���ԡD�٢��6{T�f�j���&�M��v�T��6���mRU�ۤ���Ie�:j��:�2QR����:0�\T�T.�C*�!����EuH壺�|�&z�����:SͲc�ɡ�ioqX>��P�ړ23��"X[Jn!ׇ�ɇI�zɊK�sNc�OϽ�������uR����qY��?����YƵ��*c0ʏbY�Y u���"{�2�+Z��,0tP�����4��iF�/�(���@�Sʵ��1C���yǬS�X����6����Zif�ṉ�����5�ӣ��A�+�QZ�g���]�8���2�a/3���YT��ı,IH�myH]9�c�t�cB����ec4�8�V���Sy/rt<Ǥ���+q�:�>�������E�,��i�����0�$�2�N~����<�l�&�q�{SD9���3�[�衫����nM˥3��^��rG{D�z�!'d��f�ɲ��b9~��#z��a鄞�M���IfB3]�nu�>��6��׆��/����t����FXZ�N���v:�{���A�ޑ�>S<B���y�����i      �      x��{I��Xv�:�W�" -����`�����`�� <p���L��݂В5�ej�J-� �lٲ`�jK���;��$o]?�|/3++�[�|�F>/#^��xι�|߹�8��������?������������?�����������.��?|������F��~�{�7�ͷ��ޞ��?x�����O���o�ލ~�O���~������w_�����?��?q������w��}��W����r��_.&���$�����������{ϧ7�y>�������l��(��۠$s*�܎���2_��:,(���7@r�CQ�g�7�V}Y���V7�L�<��!�$B]_�ۼߟw�Q�<4� �:g'�s�˩R�Q=�ը��_�W6>�`yW/��kð��x�é�@AR=)3�/|��+����YمS�C���?��B�V�h5\�~�@[���B�U�*���)p�c(��c�/v���PZ�I�H<���p{?c"V��ŕ�J:�H���K ��6ᙉ%`�B{��'�7{XY@{��p$9%��VPї3�O���P�C�(��{$�`R��*�F��8�R7�q�/�I� 0O�����Ua�ΥW�a��/�+pў�p�+�]M��5bb�D{�l'�Z����.�Ww<���)re�%��.?�a�+�n�K;�9��8� �;4������G)��fb�5���I�)@�vR%��Ƶ�wa���ݝ���H~����ݟ�������;����������������[���[��ٷ~�o}��o��g���Ͼ��O����O?��/}�W���O��'KJ��_���������_[u��I�ov�[~�{�r[_wS�����r%j��Ǉ�c��\�݂dWB���A�9`b瀓�MZ�y�#�=cO��2���BT��vqj+��0����n	ё�u�Y.��]~��
%����[�M飭��H0���w8
���\фΰn�B#�Y7��GD\�zFk��q�f��T�n�.��9u�H��
:����J��=�U*��+m��pj5߹�#:YDS��N��'��5�[�GCUu��
7������O�c��`泩�y3P�؊9ǴD�fa���k[I".�k7r��0h��q�L�ĕ�<ȳ��m�:�ٵ>f`%��i��BH��uV��3�7�5O[���{~*P���K���M��L�����w���ū���ڟ���/	:j�CVj��H��M�p��8t&uz'������p��37V�6�Sˤ m������i��m?t�`�������D 7�<����6lҦ�F�CH��+Hc�����^j0���\bD�9� ���Zv���5�cV7[ǎ����q���kCKwxs�"�Z$�y�8�y�X5��Q�0�P�
���Nw{u܏0|7��.U���ťy��ť@���<�K
c\�D��%}a ��A���p�����o4��)�;�g>�J����Y)?�MS�͓	���S|H� �R+fn�-b�M��?&��%��_�rp�|�)	�N?+��we�y�������K�"�O��s���Ȣ�s��|l�`���O8�p��G>�2{́�4X'����%V�����(�vn�:|H�=bLbj��V][)T�V�Θ�fw��2cb�m��6�y��M����?��0��%�H&�",a�u�ܲ13�<tA�.�%��I�@f�p��v�609
�eU\�Y|B!e#��	�
�|�PLX�a��D���:3��`06$b:�u-�Ƕ���L!TLn �q|��@�;_1�[�7���,�����Ї��(�v�[�A$L����V���=2RҘ<(m!����l���{���4R�򙧝�T���b2��{�z����H�ؒ���)�&Q��	�kԣ���	�tC��7#1�Ώ'�8�gK�RV��N}$(�څ�����x2�pz�E����)�b��}�^qV<k�G�G:u��X&��u�f��h[�A��uS�r����S���[�.b?[�y�$M���ٶ�����g? E��vXꮂ��L@���Q?�y	H��$���T�	�m����Yn��u1|&���PF�+�\��2��+�o���W��!����M
�Y(�ґހG=����n�4�\s@�`�k����m�r�K�q�@��U^/�ɳ
d��J�z�/ B���l,�k��n���l��w��Z�	��3��hL�Y�y�
���$��H�2����Q�R*��5�.ָ���bi�W�#J��|g�ܝ#`�d�w���@}���EIPͳpWt��� 1\������4"\ۖjp�!�����$/幎��������%�-�C��w/�>�,��:���Wq>ۅ�-n�S�a��ұ�\�VP׷¤C�������rT17oC���@oꡕRhP
��r.FW��,V���9�t�Ƿ&�U�u��h)o�Z���`���iYĽ��;k�I�G�?\OZ���\���b�Ί={�/S��@ ��{'�i����x�-�����p�
G��[1.L˻����Ec�Q�aK�-��8M�%�-9�Ѕ�Y���>��KSM]c�PV��{�(�j���3�k3���<�oPc�YU�}?�:XXn�Wp�~�f���x{��K���a�A�ٟ����EmQ�xIm�H;MnZ�g[{Ȗٽ�_u��|��8aә��gE��KN6.��� �+��B���]�GW�i_�_��e�H8Т;mg��6�A`ې$m��P�%=�&^�����XgH�E������؇�8>�;J��[lM�d��~8ݛ�g��SdbI0�nБ5���]�8�2��/ڸX�o�j�xH.]�?���`'hk@�|U�-Cc��0�=�1)xHER��eL��L6ܶp� E�s=p��P�<+��;'���\�$��<��.�U�0
;��m\ۆ7h���M�xP ����K��0���3 �h���9\W,s��A$����O=��)��r-�r�1���̳<!J����=��&~���[�k2�����$��<�7l��/>�ȕҸv�
Zyv{Ϯpc@!�ÝQ�u%[\t*��cwq�Z��Y.�-)�(��G�DP=2KI\]MH�����PZ����"��=�}��ƲG�-��T�C��ǫ�d�>!�3��u����e��b���	4�F��s�����4�3SF��� oC��	��|��-iD�(��"&��FV��z�Zʕ�b�isC{�P���8�RLS���8{E{�/A�?�
e���
��u�Zv ����9�'��ޚ��#��=r��� �l�0yQ�H�$v�{�����de3��Hj3E	�
ޯ'��tqt��Nloz�]�s讗�[�G�BZQ�u�1O�	r���O*�X0�wk��x�I�ĉ���f�~��&!|��H@8�,3�%��Q)]��{r��8e:Y˭[�;�f@ʵ���ϓ@���yFG�ľ;�I�ʧ[;i�� �6�t�0��A��^7����έ���N�s#$��%oNvT.ŧ�ZN�	�u_�8���d��.�k_�q��Ц|���32'j⨉*��9\�*U���v�O�t�m�xID
X�d�
E�p���W�*Ts��6�^Z�h�
��;��0yy��끜�a�z����A��w��؝w��|N(�މa�_R���8o?��������C��O(/t]<FL/es?�&�`��[wR��v��%mS�S�WBX���^d�$��d�}Go�g��Ֆ,��y"�#:%��y�P� ��L�i���%L���:#>�7� �f�2|(��#�0^��8 �:�NV����۞B/���Ʌjq�@ǬΕJ]�Xll�]�v��iN����B.�ȭ ��^�&��z��NB0��\�ӣP��L����!�Nk%�<��q��aF߄�+p�u���'V�zG�a�Σpg�|�����h�p	*p�x�ᖏ2�{����$d��K�e�I^j���O��X?���{��bh��cn�ey    F�5�z��bU�ȝR�������pC�ѣS�ܽzj���"͂ף���2s�4#��+ �?��u ]
����+ ����� !\�Q4+
���^?v�3l�ʍP.�j`'8&��Ȃ��Y�S�cdO�"�Y1��&���ђ���c�L�W3n�n���D�y}�������{���d��Y�Y`��!S����8�?��~���ő�X��6���D��\B��	��N�oP������8yA�4�̖W��n�PF�P�l5��	���(�$�Y�天��Pd�Ar�f:��&_K�7�坻_��$���\,r;��=	���������ό{������!�o=2R�ƺ�͐�[`�Hs����.�Ԯ��y%�]�q��X���uY$��7�~���7���P���wO$�i�8x8^u�\��	��vc��R������O���9�g����,>#T�Զՠc`���,M-���8���4~{���K�F�C+�.�z)3��O���d���'���Kѣ&��E���3w����bAf��)&�S~J�wT�L������{-xEeAY4�ja�I	 �f���!Ac��� <1.�2IfJ�-�u`��:�8
��D���.�;G&�! �p�Y�v�U�d�mr�b��O@x���BQ7�7��alEn��YIO~/^�r;˰_�%��).��,�ZsSk #<Y��	T�����wt{Eqo/�e_)e�≓�&H���Vzru���c���]gY�j�������?�f���*�p��{Z�>|j��|o42T#Tv�F_b��[b�ӏ�^?D�0!�����o;ˌ����W�]����)�Eŭ��cG_`8��o���w�˔�ց�]�Ե��Ew6�d��R$5U8�)��%kd �D�Y�~�{���q�w8����z�,�-D�G���4]��H��[T]�9|s�P}32��֙��0��R��̆���q�3�Zⵏ�psm�.X}��_�������|���7�����?���?�K?��O���?��/}�7���O~�����>��_���������?���^m�����;�{����;?��;����_/��۟��_����������IY�M��;{0𒥥k��0��xՙu��K�F�<Dh¦�Y��.v6h���lwL�+�j�����p�i�k��������e�,��;�vX��x U輿PU,���7"���y�`�x ��K�|��Àa+�[2�Ȭ��age��K��;�?SY_�~I�N
W��� �ɜ5�[����M>	�u�y�$�̹�L��/�=��J�������12�[s��R�|hw8W¾/I�l�Z��7S�\�����[&�=�Kz_��C詁(H�C��m$Pk���LL%(2v�=�p�f�m��D�?sd��VN���r;�x�W�ca:�X���K/�V��`� ��<-Ʒ(5u]�Zt��@*��r+n&ys��x�%���n��aP����]�b��S����<7�@(,��|�Esګg���D[gX��E1u����U)G����p0�*x`.�R���ӱ#+ ��1t��K�q٢��W���S�qDQ�|���ҵ0[�j�/����KɒX"�[L����*+N`x� �;�P���&�����)�]�^��b���N����V�WR���\�˼���>ʻ(�Y�2�נy�o��C���Ժ�:C��<+"����]:A��/�Ӈrѝ�g�����<0gG]Q� YDA�ՐC�<Th6�:�I��$<�n� �h�����UF�B����&�_�ѥ~,D^f[ܙ�Y����
{t�������,)�z�f��+ݣ�崛7zA�\�hFz`�L�A�U��j�5�9j��U����Tёnsu�?"��*�\>�r�W&���ָ��^QY�fm}6��DsI:N@%�=�N�ɽ���md�:��4�{��]&\�V���a��^���_ �� ��#�.Z�9;�@�3)�43�Y-�����V�V�/�j<�OJ~�!�7�PAT�E��K�v�<}�
������$/;k��h��M�}�e���&��@�o�Yw�0CW	l�#�<0��O�VR{���8����{]�\���З�'����;�"	���:��z�4���K\�cE����Z��G����D�.	\&�Ȍ�gA���q)8��@���(����+���|yc4�gڗ��D n /@7�y�	�M�x�R�
���/�m/�Jɻ��_t|lp6�N�@��
_o91����&���W�.w�u���{v%���}	��R��tG,��SQ�:u�\����}�ȔS��{���NӼ5���Ak���>+��bpұ�G d�'Q���ݮoNy�(��tR	�Vl���Ŭd ,V& t�0�q!�$IQ�|ѺN�#��:�׸N$�am"�a�n4{mg���&RI���D<?�G�8{�n�c;P��t�w���@��c�ģ�3���Ϲ5X�]�T&���v�e]]6�� �`�>j����W��>S�Y�����Y��4`��MF ����a}wՃJ1[ۗ��ŝ؎���>?�=��&��0��4a����,�� ���;����z��Q<ǳoR=� �Q߄�h�a.#~�F`�)B{t�J�ޭɅ�g�n����)��VJ����C%�]���[10�|�Ze�wEb����!c87}6;4'���,Y��������.�L
���{�������V�`"������Q�}��<�rR��=܆���g���=�o����_`z%s��A�l�`��6�tG��yG�����"���e������L�"��T��}���Z�����TT�4ΰ���;_]��p�<�HrM���U��b�#s��a��q䮿e�y����t��
Tv���>+Ѝj�@sO��#���B�9:�,QRN(0*��"5��T��D�w�i��t��:��.�x��S������j�J�o�/66d�SֶW�`������m�y�"���m���5p���p�ۘJwՃ	\�9�̾8�@ �����{� �X��_)M�
ʶ,b���1�_�!$x\T��}�dc�H�Ϛ�*T��1ɺ��m/����`�륤 ���&F�Z�>.pe���ߎ��Dm^��um&jT�$����]�x�C�� Sm�)�����&uT�=�"��pX��߳I��~+}a�$�/�kqfB@O��z�e�|��a�k��5�s�]�[ 1����Vਈ!����A��z�8r��.=�R?`�B)B���rԕ�I��,�������41�}J��ΰ�g�Q�u�pK��@��1_91�H�rߛ�9��qDzW�꽗6(�6x1��y�wj�Ѯ�:`�[��99�$j1�����N��Q����`�l�ӭ�m4��� �x�I���p���q���%�=[
5�� ˼}|��W�[%4۹r�� z:��n�$b�C�� �Ka�<$_�Л-�Y�>y��jG�PiĲ�i�,u�#o���BZ{+`�ubG+b�Ȅ]��s��A����a���S���EB�n�>5#��x�F�lVa#�� k���z�|�r�Z� (�t�5(�3�'X��ޞ۷ ���"�0��-*`X5��z�� �oѼj⬷�����'��HX�kηx�b<�_�T',�5oWl���w�	�ăXgZ���6�!�����q���%� �?�~!V�r�x���%��/q�"@�Z4������m�R���o�LC���2�G}rw������鄧Q��s?ʒ$e#�:gt����;�ݻ����k>��E�닰:K;)2!rw��v�J�V��F�G�wҍ��#���6ۧcbMw��|��D2�7-9�6z���R#)k&;Z�X̏�R�nͧ˸�T��u��#��B��l���x�R���̓w+G/(	��8�����S�M���>Һ爳^�'P����j�H��YK|L���Z����ž�&��n� A�����k��Y�`h2�����n�,M�s{c8�w�;�R^�n�L*�Ժ�F= �  �5ax�S*w{s�}��#���J�3��BJ��^��qڍ@ٓ~'��O�hm\]O�qLxZ��1F�qN�r�D	�'x�)���W:Iv���͕"�8t�����r߹B̮�㽿w�u���s�W��21(r}q'�����yq�Z�OC���ll�^��S@�rw�v1/�a�9���D��.���]O�0��9������,�����g繒��W�ɫa�,$���㉼Q��Sz�ʧJV�r��E����]m\�P����9��]�>�n���rH�u����>J��(�wCY�ѷmgQOA��l��������i�� M~	j�F�};�x)�T���r|�����ǐ�CV��ۼM��S�{��������̔���v��W�,��p��Ԛ��-}=��{8ժ��
��4�G���Rd�eU�~%#W��������]�~�=)���l��A�2�C��6����x�{P��|��S�sKo��)�ۭ�7>��)���X�$�3�&>O���N�Wkc�e�AJz�
>ͨq�G���X�!��v��>a��S�8��_IO�|+�u&?�d��C�eBk���8��d2�:�]Đ'��<�hmG\^ĭ��t߁�Z�����?�v�N��j�h��ϩR��Rݠ���F��e���-/ۺ{�*�q��.�w:S��W�]~�6�'z,�g]\tD��.����Q{�o�"e� (��~ ~z^�Y�u�F~�4~ɳW���3�X�|��Nto�y������ب;y�$�h���O����� ��F�^S�_g�Wv�����We�qټd���Pb�O�[wv��5G���8"S�"�?D�=A���g�r@�?'}�-F���
W��W+jƏ-�(�iA�s'�!��8#�Y-�M��gUv�%k����6fX�B��]]��ϯ��8ĳ+	K���B�Nw����M��;Խ�N�E|�r �I���׻��~��q�hͥ��wDiq'��)���>������@�����M�L}�9u��T� U`�/b'����iQ,1-zNdD)n�����ʾ���-?�m��>��u�T >�>�}���b�Zw�}�pw�OVc�df��{@a3�tr��Fh��<�t�QUU[ �Șwk#R��>�zw��Ϲ���G}� �`�     