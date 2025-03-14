PGDMP         	                }         
   CoffeeTech    15.8    15.8 "   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    83790 
   CoffeeTech    DATABASE        CREATE DATABASE "CoffeeTech" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "CoffeeTech";
                postgres    false                        2615    83791    audit    SCHEMA        CREATE SCHEMA audit;
    DROP SCHEMA audit;
                postgres    false                        3079    83792    pg_stat_statements 	   EXTENSION     F   CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;
 #   DROP EXTENSION pg_stat_statements;
                   false            �           0    0    EXTENSION pg_stat_statements    COMMENT     u   COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';
                        false    2            �           1247    83824    operation_type    TYPE     W   CREATE TYPE audit.operation_type AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE'
);
     DROP TYPE audit.operation_type;
       audit          postgres    false    7            )           1255    83831 !   log_cultural_work_tasks_changes()    FUNCTION     o  CREATE FUNCTION public.log_cultural_work_tasks_changes() RETURNS trigger
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
 8   DROP FUNCTION public.log_cultural_work_tasks_changes();
       public          postgres    false            *           1255    83832    log_farm_changes()    FUNCTION     �  CREATE FUNCTION public.log_farm_changes() RETURNS trigger
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
 )   DROP FUNCTION public.log_farm_changes();
       public          postgres    false            +           1255    83833    log_flowering_changes()    FUNCTION     �  CREATE FUNCTION public.log_flowering_changes() RETURNS trigger
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
 .   DROP FUNCTION public.log_flowering_changes();
       public          postgres    false            ,           1255    83834    log_health_checks_changes()    FUNCTION     P  CREATE FUNCTION public.log_health_checks_changes() RETURNS trigger
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
 2   DROP FUNCTION public.log_health_checks_changes();
       public          postgres    false            -           1255    83835    log_plot_changes()    FUNCTION     �  CREATE FUNCTION public.log_plot_changes() RETURNS trigger
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
 )   DROP FUNCTION public.log_plot_changes();
       public          postgres    false            .           1255    83836    log_role_permission_changes()    FUNCTION     -  CREATE FUNCTION public.log_role_permission_changes() RETURNS trigger
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
 4   DROP FUNCTION public.log_role_permission_changes();
       public          postgres    false            /           1255    83837    log_transaction_changes()    FUNCTION     �  CREATE FUNCTION public.log_transaction_changes() RETURNS trigger
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
 0   DROP FUNCTION public.log_transaction_changes();
       public          postgres    false            0           1255    83838    log_user_changes()    FUNCTION     8  CREATE FUNCTION public.log_user_changes() RETURNS trigger
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
 )   DROP FUNCTION public.log_user_changes();
       public          postgres    false            �            1259    83839    cultural_work_tasks_audit    TABLE     �  CREATE TABLE audit.cultural_work_tasks_audit (
    audit_id integer NOT NULL,
    cultural_work_tasks_id integer,
    cultural_works_id integer,
    plot_id integer,
    reminder_owner boolean,
    reminder_collaborator boolean,
    collaborator_user_id integer,
    owner_user_id integer,
    status_id integer,
    task_date date,
    created_at timestamp without time zone,
    operation audit.operation_type NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 ,   DROP TABLE audit.cultural_work_tasks_audit;
       audit         heap    postgres    false    7    922            �            1259    83843 &   cultural_work_tasks_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.cultural_work_tasks_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE audit.cultural_work_tasks_audit_audit_id_seq;
       audit          postgres    false    7    218            �           0    0 &   cultural_work_tasks_audit_audit_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE audit.cultural_work_tasks_audit_audit_id_seq OWNED BY audit.cultural_work_tasks_audit.audit_id;
          audit          postgres    false    219            �            1259    83844 
   farm_audit    TABLE     �  CREATE TABLE audit.farm_audit (
    audit_id integer NOT NULL,
    farm_id integer,
    name character varying(255),
    area numeric(10,2),
    area_unit_id integer,
    status_id integer,
    operation audit.operation_type NOT NULL,
    old_name character varying(255),
    old_area numeric(10,2),
    old_area_unit_id integer,
    old_status_id integer,
    modified_by_user_id integer,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE audit.farm_audit;
       audit         heap    postgres    false    922    7            �            1259    83850    farm_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.farm_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE audit.farm_audit_audit_id_seq;
       audit          postgres    false    220    7            �           0    0    farm_audit_audit_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE audit.farm_audit_audit_id_seq OWNED BY audit.farm_audit.audit_id;
          audit          postgres    false    221            �            1259    83851    flowering_audit    TABLE     O  CREATE TABLE audit.flowering_audit (
    audit_id integer NOT NULL,
    flowering_id integer,
    plot_id integer,
    flowering_date date,
    harvest_date date,
    status_id integer,
    flowering_type_id integer,
    operation audit.operation_type NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE audit.flowering_audit;
       audit         heap    postgres    false    7    922            �            1259    83855    flowering_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.flowering_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE audit.flowering_audit_audit_id_seq;
       audit          postgres    false    222    7            �           0    0    flowering_audit_audit_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE audit.flowering_audit_audit_id_seq OWNED BY audit.flowering_audit.audit_id;
          audit          postgres    false    223            �            1259    83856    health_checks_audit    TABLE     r  CREATE TABLE audit.health_checks_audit (
    audit_id integer NOT NULL,
    health_checks_id integer,
    check_date date,
    recommendation_id integer,
    prediction character varying(150),
    cultural_work_tasks_id integer,
    status_id integer,
    operation audit.operation_type NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 &   DROP TABLE audit.health_checks_audit;
       audit         heap    postgres    false    922    7            �            1259    83860     health_checks_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.health_checks_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE audit.health_checks_audit_audit_id_seq;
       audit          postgres    false    7    224            �           0    0     health_checks_audit_audit_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE audit.health_checks_audit_audit_id_seq OWNED BY audit.health_checks_audit.audit_id;
          audit          postgres    false    225            �            1259    83861 
   plot_audit    TABLE     �  CREATE TABLE audit.plot_audit (
    audit_id integer NOT NULL,
    plot_id integer,
    name character varying(255),
    longitude numeric(11,8),
    latitude numeric(11,8),
    altitude numeric(10,2),
    coffee_variety_id integer,
    farm_id integer,
    status_id integer,
    operation audit.operation_type NOT NULL,
    old_name character varying(255),
    old_longitude numeric(11,8),
    old_latitude numeric(11,8),
    old_altitude numeric(10,2),
    old_coffee_variety_id integer,
    old_farm_id integer,
    old_status_id integer,
    modified_by_user_id integer,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE audit.plot_audit;
       audit         heap    postgres    false    7    922            �            1259    83867    plot_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.plot_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE audit.plot_audit_audit_id_seq;
       audit          postgres    false    226    7            �           0    0    plot_audit_audit_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE audit.plot_audit_audit_id_seq OWNED BY audit.plot_audit.audit_id;
          audit          postgres    false    227            �            1259    83868    role_permission_audit    TABLE     �   CREATE TABLE audit.role_permission_audit (
    audit_id integer NOT NULL,
    role_id integer,
    permission_id integer,
    operation audit.operation_type NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 (   DROP TABLE audit.role_permission_audit;
       audit         heap    postgres    false    7    922            �            1259    83872 "   role_permission_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.role_permission_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE audit.role_permission_audit_audit_id_seq;
       audit          postgres    false    7    228            �           0    0 "   role_permission_audit_audit_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE audit.role_permission_audit_audit_id_seq OWNED BY audit.role_permission_audit.audit_id;
          audit          postgres    false    229            �            1259    83873    transaction_audit    TABLE     �  CREATE TABLE audit.transaction_audit (
    audit_id integer NOT NULL,
    transaction_id integer,
    plot_id integer,
    description character varying(255),
    transaction_type_id integer,
    transaction_date date,
    status_id integer,
    value numeric(15,2),
    transaction_category_id integer,
    creador_id integer,
    operation audit.operation_type NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 $   DROP TABLE audit.transaction_audit;
       audit         heap    postgres    false    922    7            �            1259    83877    transaction_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.transaction_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE audit.transaction_audit_audit_id_seq;
       audit          postgres    false    230    7            �           0    0    transaction_audit_audit_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE audit.transaction_audit_audit_id_seq OWNED BY audit.transaction_audit.audit_id;
          audit          postgres    false    231            �            1259    83878    users_audit    TABLE     �  CREATE TABLE audit.users_audit (
    audit_id integer NOT NULL,
    user_id integer,
    name character varying(255),
    email character varying(150),
    password_hash character varying(255),
    verification_token character varying(255),
    session_token character varying(255),
    status_id integer,
    fcm_token character varying(255),
    operation audit.operation_type NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE audit.users_audit;
       audit         heap    postgres    false    922    7            �            1259    83884    users_audit_audit_id_seq    SEQUENCE     �   CREATE SEQUENCE audit.users_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE audit.users_audit_audit_id_seq;
       audit          postgres    false    232    7            �           0    0    users_audit_audit_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE audit.users_audit_audit_id_seq OWNED BY audit.users_audit.audit_id;
          audit          postgres    false    233            �            1259    83885    coffee_variety    TABLE     y   CREATE TABLE public.coffee_variety (
    coffee_variety_id integer NOT NULL,
    name character varying(255) NOT NULL
);
 "   DROP TABLE public.coffee_variety;
       public         heap    postgres    false            �            1259    83888 $   coffee_variety_coffee_variety_id_seq    SEQUENCE     �   ALTER TABLE public.coffee_variety ALTER COLUMN coffee_variety_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.coffee_variety_coffee_variety_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    234            �            1259    83889    cultural_work_tasks    TABLE     �  CREATE TABLE public.cultural_work_tasks (
    cultural_work_tasks_id integer NOT NULL,
    cultural_works_id integer NOT NULL,
    plot_id integer NOT NULL,
    reminder_owner boolean NOT NULL,
    reminder_collaborator boolean NOT NULL,
    collaborator_user_id integer NOT NULL,
    owner_user_id integer NOT NULL,
    status_id integer NOT NULL,
    task_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 '   DROP TABLE public.cultural_work_tasks;
       public         heap    postgres    false            �            1259    83893 .   cultural_work_tasks_cultural_work_tasks_id_seq    SEQUENCE       ALTER TABLE public.cultural_work_tasks ALTER COLUMN cultural_work_tasks_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cultural_work_tasks_cultural_work_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    236            �            1259    83894    cultural_works    TABLE     �   CREATE TABLE public.cultural_works (
    cultural_works_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text
);
 "   DROP TABLE public.cultural_works;
       public         heap    postgres    false            �            1259    83899 $   cultural_works_cultural_works_id_seq    SEQUENCE     �   ALTER TABLE public.cultural_works ALTER COLUMN cultural_works_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cultural_works_cultural_works_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    238            �            1259    83900    farm    TABLE     �   CREATE TABLE public.farm (
    farm_id integer NOT NULL,
    name character varying(255) NOT NULL,
    area numeric(10,2) NOT NULL,
    area_unit_id integer NOT NULL,
    status_id integer NOT NULL
);
    DROP TABLE public.farm;
       public         heap    postgres    false            �            1259    83903    farm_farm_id_seq    SEQUENCE     �   ALTER TABLE public.farm ALTER COLUMN farm_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.farm_farm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    240            �            1259    83904 	   farm_info    VIEW     h   CREATE VIEW public.farm_info AS
 SELECT farm.farm_id,
    farm.name,
    farm.area
   FROM public.farm;
    DROP VIEW public.farm_info;
       public          postgres    false    240    240    240            �            1259    83908    status    TABLE     �   CREATE TABLE public.status (
    status_id integer NOT NULL,
    name character varying(45) NOT NULL,
    status_type_id integer NOT NULL
);
    DROP TABLE public.status;
       public         heap    postgres    false            �            1259    83911    farm_with_status    VIEW     �   CREATE VIEW public.farm_with_status AS
 SELECT f.farm_id,
    f.name,
    s.name AS status_name
   FROM (public.farm f
     JOIN public.status s ON ((f.status_id = s.status_id)));
 #   DROP VIEW public.farm_with_status;
       public          postgres    false    240    243    243    240    240            �            1259    83915 	   flowering    TABLE     �   CREATE TABLE public.flowering (
    flowering_id integer NOT NULL,
    plot_id integer NOT NULL,
    flowering_date date NOT NULL,
    harvest_date date,
    status_id integer NOT NULL,
    flowering_type_id integer NOT NULL
);
    DROP TABLE public.flowering;
       public         heap    postgres    false            �            1259    83918    flowering_flowering_id_seq    SEQUENCE     �   ALTER TABLE public.flowering ALTER COLUMN flowering_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.flowering_flowering_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    245            �            1259    83919    flowering_type    TABLE     y   CREATE TABLE public.flowering_type (
    flowering_type_id integer NOT NULL,
    name character varying(255) NOT NULL
);
 "   DROP TABLE public.flowering_type;
       public         heap    postgres    false            �            1259    83922 $   flowering_type_flowering_type_id_seq    SEQUENCE     �   ALTER TABLE public.flowering_type ALTER COLUMN flowering_type_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.flowering_type_flowering_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    247            �            1259    83923    health_checks    TABLE       CREATE TABLE public.health_checks (
    health_checks_id integer NOT NULL,
    check_date date NOT NULL,
    recommendation_id integer NOT NULL,
    prediction character varying(150) NOT NULL,
    cultural_work_tasks_id integer NOT NULL,
    status_id integer DEFAULT 35 NOT NULL
);
 !   DROP TABLE public.health_checks;
       public         heap    postgres    false            �            1259    83927 "   health_checks_health_checks_id_seq    SEQUENCE     �   ALTER TABLE public.health_checks ALTER COLUMN health_checks_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.health_checks_health_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    249            �            1259    83928 
   invitation    TABLE     D  CREATE TABLE public.invitation (
    invitation_id integer NOT NULL,
    email character varying(150) NOT NULL,
    suggested_role character varying(255) NOT NULL,
    status_id integer DEFAULT 24 NOT NULL,
    farm_id integer NOT NULL,
    inviter_user_id integer NOT NULL,
    date timestamp without time zone NOT NULL
);
    DROP TABLE public.invitation;
       public         heap    postgres    false            �            1259    83932    invitation_invitation_id_seq    SEQUENCE     �   ALTER TABLE public.invitation ALTER COLUMN invitation_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.invitation_invitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    251            �            1259    83933    notification_type    TABLE        CREATE TABLE public.notification_type (
    notification_type_id integer NOT NULL,
    name character varying(255) NOT NULL
);
 %   DROP TABLE public.notification_type;
       public         heap    postgres    false            �            1259    83936 *   notification_type_notification_type_id_seq    SEQUENCE       ALTER TABLE public.notification_type ALTER COLUMN notification_type_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notification_type_notification_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    253            �            1259    83937    notifications    TABLE     9  CREATE TABLE public.notifications (
    notifications_id integer NOT NULL,
    message character varying(255),
    date timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    invitation_id integer,
    notification_type_id integer,
    farm_id integer NOT NULL,
    status_id integer NOT NULL
);
 !   DROP TABLE public.notifications;
       public         heap    postgres    false                        1259    83940 "   notifications_notifications_id_seq    SEQUENCE     �   ALTER TABLE public.notifications ALTER COLUMN notifications_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notifications_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    255                       1259    83941 
   permission    TABLE     �   CREATE TABLE public.permission (
    permission_id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(255)
);
    DROP TABLE public.permission;
       public         heap    postgres    false                       1259    83944    permission_permission_id_seq    SEQUENCE     �   ALTER TABLE public.permission ALTER COLUMN permission_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.permission_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    257                       1259    83945    plot    TABLE       CREATE TABLE public.plot (
    plot_id integer NOT NULL,
    name character varying(255) NOT NULL,
    longitude numeric(11,8),
    latitude numeric(11,8),
    altitude numeric(10,2),
    coffee_variety_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer NOT NULL,
    CONSTRAINT plot_latitude_check CHECK (((latitude >= ('-90'::integer)::numeric) AND (latitude <= (90)::numeric))),
    CONSTRAINT plot_longitude_check CHECK (((longitude >= ('-180'::integer)::numeric) AND (longitude <= (180)::numeric)))
);
    DROP TABLE public.plot;
       public         heap    postgres    false                       1259    83950    plot_plot_id_seq    SEQUENCE     �   ALTER TABLE public.plot ALTER COLUMN plot_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.plot_plot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    259                       1259    83951    recommendation    TABLE     �   CREATE TABLE public.recommendation (
    recommendation_id integer NOT NULL,
    recommendation character varying(255) NOT NULL,
    name character varying(45) NOT NULL
);
 "   DROP TABLE public.recommendation;
       public         heap    postgres    false                       1259    83954 $   recommendation_recommendation_id_seq    SEQUENCE     �   ALTER TABLE public.recommendation ALTER COLUMN recommendation_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.recommendation_recommendation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    261                       1259    83955    role    TABLE     e   CREATE TABLE public.role (
    role_id integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.role;
       public         heap    postgres    false                       1259    83958    role_permission    TABLE     j   CREATE TABLE public.role_permission (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);
 #   DROP TABLE public.role_permission;
       public         heap    postgres    false            	           1259    83961    role_role_id_seq    SEQUENCE     �   ALTER TABLE public.role ALTER COLUMN role_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    263            
           1259    83962    status_status_id_seq    SEQUENCE     �   ALTER TABLE public.status ALTER COLUMN status_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.status_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    243                       1259    83963    status_type    TABLE     s   CREATE TABLE public.status_type (
    status_type_id integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.status_type;
       public         heap    postgres    false                       1259    83966    status_type_status_type_id_seq    SEQUENCE     �   ALTER TABLE public.status_type ALTER COLUMN status_type_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.status_type_status_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    267                       1259    83967    transaction    TABLE     n  CREATE TABLE public.transaction (
    transaction_id integer NOT NULL,
    plot_id integer NOT NULL,
    description character varying(255),
    transaction_type_id integer NOT NULL,
    transaction_date date NOT NULL,
    status_id integer NOT NULL,
    value numeric(15,2) NOT NULL,
    transaction_category_id integer NOT NULL,
    creador_id integer NOT NULL
);
    DROP TABLE public.transaction;
       public         heap    postgres    false                       1259    83970    transaction_category    TABLE     �   CREATE TABLE public.transaction_category (
    transaction_category_id integer NOT NULL,
    name character varying(255) NOT NULL,
    transaction_type_id integer NOT NULL
);
 (   DROP TABLE public.transaction_category;
       public         heap    postgres    false                       1259    83973 0   transaction_category_transaction_category_id_seq    SEQUENCE       ALTER TABLE public.transaction_category ALTER COLUMN transaction_category_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.transaction_category_transaction_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    270                       1259    83974    transaction_transaction_id_seq    SEQUENCE     �   ALTER TABLE public.transaction ALTER COLUMN transaction_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.transaction_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    269                       1259    83975    transaction_type    TABLE     }   CREATE TABLE public.transaction_type (
    transaction_type_id integer NOT NULL,
    name character varying(255) NOT NULL
);
 $   DROP TABLE public.transaction_type;
       public         heap    postgres    false                       1259    83978 (   transaction_type_transaction_type_id_seq    SEQUENCE       ALTER TABLE public.transaction_type ALTER COLUMN transaction_type_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.transaction_type_transaction_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    273                       1259    83979    unit_of_measure    TABLE     �   CREATE TABLE public.unit_of_measure (
    unit_of_measure_id integer NOT NULL,
    name character varying(255) NOT NULL,
    abbreviation character varying(10) NOT NULL,
    unit_of_measure_type_id integer NOT NULL
);
 #   DROP TABLE public.unit_of_measure;
       public         heap    postgres    false                       1259    83982    unit_of_measure_type    TABLE     �   CREATE TABLE public.unit_of_measure_type (
    unit_of_measure_type_id integer NOT NULL,
    name character varying(255) NOT NULL
);
 (   DROP TABLE public.unit_of_measure_type;
       public         heap    postgres    false                       1259    83985 0   unit_of_measure_type_unit_of_measure_type_id_seq    SEQUENCE       ALTER TABLE public.unit_of_measure_type ALTER COLUMN unit_of_measure_type_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.unit_of_measure_type_unit_of_measure_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    276                       1259    83986 &   unit_of_measure_unit_of_measure_id_seq    SEQUENCE     �   ALTER TABLE public.unit_of_measure ALTER COLUMN unit_of_measure_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.unit_of_measure_unit_of_measure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    275                       1259    83987    user_role_farm    TABLE     �   CREATE TABLE public.user_role_farm (
    user_role_farm_id integer NOT NULL,
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer DEFAULT 22 NOT NULL
);
 "   DROP TABLE public.user_role_farm;
       public         heap    postgres    false                       1259    83991 $   user_role_farm_user_role_farm_id_seq    SEQUENCE     �   ALTER TABLE public.user_role_farm ALTER COLUMN user_role_farm_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_role_farm_user_role_farm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    279                       1259    83992    users    TABLE     c  CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash character varying(255) NOT NULL,
    verification_token character varying(255),
    session_token character varying(255),
    status_id integer NOT NULL,
    fcm_token character varying(255)
);
    DROP TABLE public.users;
       public         heap    postgres    false                       1259    83997    users_user_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    281                       2604    83998 "   cultural_work_tasks_audit audit_id    DEFAULT     �   ALTER TABLE ONLY audit.cultural_work_tasks_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.cultural_work_tasks_audit_audit_id_seq'::regclass);
 P   ALTER TABLE audit.cultural_work_tasks_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    219    218            !           2604    83999    farm_audit audit_id    DEFAULT     x   ALTER TABLE ONLY audit.farm_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.farm_audit_audit_id_seq'::regclass);
 A   ALTER TABLE audit.farm_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    221    220            #           2604    84000    flowering_audit audit_id    DEFAULT     �   ALTER TABLE ONLY audit.flowering_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.flowering_audit_audit_id_seq'::regclass);
 F   ALTER TABLE audit.flowering_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    223    222            %           2604    84001    health_checks_audit audit_id    DEFAULT     �   ALTER TABLE ONLY audit.health_checks_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.health_checks_audit_audit_id_seq'::regclass);
 J   ALTER TABLE audit.health_checks_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    225    224            '           2604    84002    plot_audit audit_id    DEFAULT     x   ALTER TABLE ONLY audit.plot_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.plot_audit_audit_id_seq'::regclass);
 A   ALTER TABLE audit.plot_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    227    226            )           2604    84003    role_permission_audit audit_id    DEFAULT     �   ALTER TABLE ONLY audit.role_permission_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.role_permission_audit_audit_id_seq'::regclass);
 L   ALTER TABLE audit.role_permission_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    229    228            +           2604    84004    transaction_audit audit_id    DEFAULT     �   ALTER TABLE ONLY audit.transaction_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.transaction_audit_audit_id_seq'::regclass);
 H   ALTER TABLE audit.transaction_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    231    230            -           2604    84005    users_audit audit_id    DEFAULT     z   ALTER TABLE ONLY audit.users_audit ALTER COLUMN audit_id SET DEFAULT nextval('audit.users_audit_audit_id_seq'::regclass);
 B   ALTER TABLE audit.users_audit ALTER COLUMN audit_id DROP DEFAULT;
       audit          postgres    false    233    232            n          0    83839    cultural_work_tasks_audit 
   TABLE DATA           �   COPY audit.cultural_work_tasks_audit (audit_id, cultural_work_tasks_id, cultural_works_id, plot_id, reminder_owner, reminder_collaborator, collaborator_user_id, owner_user_id, status_id, task_date, created_at, operation, "timestamp") FROM stdin;
    audit          postgres    false    218   �      p          0    83844 
   farm_audit 
   TABLE DATA           �   COPY audit.farm_audit (audit_id, farm_id, name, area, area_unit_id, status_id, operation, old_name, old_area, old_area_unit_id, old_status_id, modified_by_user_id, "timestamp") FROM stdin;
    audit          postgres    false    220   9�      r          0    83851    flowering_audit 
   TABLE DATA           �   COPY audit.flowering_audit (audit_id, flowering_id, plot_id, flowering_date, harvest_date, status_id, flowering_type_id, operation, "timestamp") FROM stdin;
    audit          postgres    false    222   B�      t          0    83856    health_checks_audit 
   TABLE DATA           �   COPY audit.health_checks_audit (audit_id, health_checks_id, check_date, recommendation_id, prediction, cultural_work_tasks_id, status_id, operation, "timestamp") FROM stdin;
    audit          postgres    false    224   ��      v          0    83861 
   plot_audit 
   TABLE DATA             COPY audit.plot_audit (audit_id, plot_id, name, longitude, latitude, altitude, coffee_variety_id, farm_id, status_id, operation, old_name, old_longitude, old_latitude, old_altitude, old_coffee_variety_id, old_farm_id, old_status_id, modified_by_user_id, "timestamp") FROM stdin;
    audit          postgres    false    226   ��      x          0    83868    role_permission_audit 
   TABLE DATA           h   COPY audit.role_permission_audit (audit_id, role_id, permission_id, operation, "timestamp") FROM stdin;
    audit          postgres    false    228   �      z          0    83873    transaction_audit 
   TABLE DATA           �   COPY audit.transaction_audit (audit_id, transaction_id, plot_id, description, transaction_type_id, transaction_date, status_id, value, transaction_category_id, creador_id, operation, "timestamp") FROM stdin;
    audit          postgres    false    230   0�      |          0    83878    users_audit 
   TABLE DATA           �   COPY audit.users_audit (audit_id, user_id, name, email, password_hash, verification_token, session_token, status_id, fcm_token, operation, "timestamp") FROM stdin;
    audit          postgres    false    232   G�      ~          0    83885    coffee_variety 
   TABLE DATA           A   COPY public.coffee_variety (coffee_variety_id, name) FROM stdin;
    public          postgres    false    234   ��      �          0    83889    cultural_work_tasks 
   TABLE DATA           �   COPY public.cultural_work_tasks (cultural_work_tasks_id, cultural_works_id, plot_id, reminder_owner, reminder_collaborator, collaborator_user_id, owner_user_id, status_id, task_date, created_at) FROM stdin;
    public          postgres    false    236   O�      �          0    83894    cultural_works 
   TABLE DATA           N   COPY public.cultural_works (cultural_works_id, name, description) FROM stdin;
    public          postgres    false    238   �      �          0    83900    farm 
   TABLE DATA           L   COPY public.farm (farm_id, name, area, area_unit_id, status_id) FROM stdin;
    public          postgres    false    240   �      �          0    83915 	   flowering 
   TABLE DATA           v   COPY public.flowering (flowering_id, plot_id, flowering_date, harvest_date, status_id, flowering_type_id) FROM stdin;
    public          postgres    false    245   �	      �          0    83919    flowering_type 
   TABLE DATA           A   COPY public.flowering_type (flowering_type_id, name) FROM stdin;
    public          postgres    false    247   }      �          0    83923    health_checks 
   TABLE DATA           �   COPY public.health_checks (health_checks_id, check_date, recommendation_id, prediction, cultural_work_tasks_id, status_id) FROM stdin;
    public          postgres    false    249   �      �          0    83928 
   invitation 
   TABLE DATA           u   COPY public.invitation (invitation_id, email, suggested_role, status_id, farm_id, inviter_user_id, date) FROM stdin;
    public          postgres    false    251   �      �          0    83933    notification_type 
   TABLE DATA           G   COPY public.notification_type (notification_type_id, name) FROM stdin;
    public          postgres    false    253         �          0    83937    notifications 
   TABLE DATA           �   COPY public.notifications (notifications_id, message, date, user_id, invitation_id, notification_type_id, farm_id, status_id) FROM stdin;
    public          postgres    false    255   u      �          0    83941 
   permission 
   TABLE DATA           F   COPY public.permission (permission_id, description, name) FROM stdin;
    public          postgres    false    257   1      �          0    83945    plot 
   TABLE DATA           s   COPY public.plot (plot_id, name, longitude, latitude, altitude, coffee_variety_id, farm_id, status_id) FROM stdin;
    public          postgres    false    259   s3      �          0    83951    recommendation 
   TABLE DATA           Q   COPY public.recommendation (recommendation_id, recommendation, name) FROM stdin;
    public          postgres    false    261   �9      �          0    83955    role 
   TABLE DATA           -   COPY public.role (role_id, name) FROM stdin;
    public          postgres    false    263   <      �          0    83958    role_permission 
   TABLE DATA           A   COPY public.role_permission (role_id, permission_id) FROM stdin;
    public          postgres    false    264   `<      �          0    83908    status 
   TABLE DATA           A   COPY public.status (status_id, name, status_type_id) FROM stdin;
    public          postgres    false    243   �<      �          0    83963    status_type 
   TABLE DATA           ;   COPY public.status_type (status_type_id, name) FROM stdin;
    public          postgres    false    267   >      �          0    83967    transaction 
   TABLE DATA           �   COPY public.transaction (transaction_id, plot_id, description, transaction_type_id, transaction_date, status_id, value, transaction_category_id, creador_id) FROM stdin;
    public          postgres    false    269   �>      �          0    83970    transaction_category 
   TABLE DATA           b   COPY public.transaction_category (transaction_category_id, name, transaction_type_id) FROM stdin;
    public          postgres    false    270   �B      �          0    83975    transaction_type 
   TABLE DATA           E   COPY public.transaction_type (transaction_type_id, name) FROM stdin;
    public          postgres    false    273   RC      �          0    83979    unit_of_measure 
   TABLE DATA           j   COPY public.unit_of_measure (unit_of_measure_id, name, abbreviation, unit_of_measure_type_id) FROM stdin;
    public          postgres    false    275   �C      �          0    83982    unit_of_measure_type 
   TABLE DATA           M   COPY public.unit_of_measure_type (unit_of_measure_type_id, name) FROM stdin;
    public          postgres    false    276   -D      �          0    83987    user_role_farm 
   TABLE DATA           a   COPY public.user_role_farm (user_role_farm_id, role_id, user_id, farm_id, status_id) FROM stdin;
    public          postgres    false    279   �D      �          0    83992    users 
   TABLE DATA           }   COPY public.users (user_id, name, email, password_hash, verification_token, session_token, status_id, fcm_token) FROM stdin;
    public          postgres    false    281   �H      �           0    0 &   cultural_work_tasks_audit_audit_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('audit.cultural_work_tasks_audit_audit_id_seq', 123, true);
          audit          postgres    false    219            �           0    0    farm_audit_audit_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('audit.farm_audit_audit_id_seq', 165, true);
          audit          postgres    false    221            �           0    0    flowering_audit_audit_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('audit.flowering_audit_audit_id_seq', 96, true);
          audit          postgres    false    223            �           0    0     health_checks_audit_audit_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('audit.health_checks_audit_audit_id_seq', 159, true);
          audit          postgres    false    225            �           0    0    plot_audit_audit_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('audit.plot_audit_audit_id_seq', 80, true);
          audit          postgres    false    227            �           0    0 "   role_permission_audit_audit_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('audit.role_permission_audit_audit_id_seq', 50, true);
          audit          postgres    false    229            �           0    0    transaction_audit_audit_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('audit.transaction_audit_audit_id_seq', 73, true);
          audit          postgres    false    231            �           0    0    users_audit_audit_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('audit.users_audit_audit_id_seq', 85, true);
          audit          postgres    false    233            �           0    0 $   coffee_variety_coffee_variety_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.coffee_variety_coffee_variety_id_seq', 7, false);
          public          postgres    false    235            �           0    0 .   cultural_work_tasks_cultural_work_tasks_id_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('public.cultural_work_tasks_cultural_work_tasks_id_seq', 152, true);
          public          postgres    false    237            �           0    0 $   cultural_works_cultural_works_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.cultural_works_cultural_works_id_seq', 3, false);
          public          postgres    false    239            �           0    0    farm_farm_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.farm_farm_id_seq', 169, true);
          public          postgres    false    241            �           0    0    flowering_flowering_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.flowering_flowering_id_seq', 100, false);
          public          postgres    false    246            �           0    0 $   flowering_type_flowering_type_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.flowering_type_flowering_type_id_seq', 3, false);
          public          postgres    false    248            �           0    0 "   health_checks_health_checks_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.health_checks_health_checks_id_seq', 317, false);
          public          postgres    false    250            �           0    0    invitation_invitation_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.invitation_invitation_id_seq', 67, false);
          public          postgres    false    252            �           0    0 *   notification_type_notification_type_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.notification_type_notification_type_id_seq', 8, false);
          public          postgres    false    254            �           0    0 "   notifications_notifications_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.notifications_notifications_id_seq', 442, false);
          public          postgres    false    256            �           0    0    permission_permission_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.permission_permission_id_seq', 32, false);
          public          postgres    false    258            �           0    0    plot_plot_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.plot_plot_id_seq', 85, true);
          public          postgres    false    260            �           0    0 $   recommendation_recommendation_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.recommendation_recommendation_id_seq', 13, false);
          public          postgres    false    262            �           0    0    role_role_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.role_role_id_seq', 4, false);
          public          postgres    false    265            �           0    0    status_status_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.status_status_id_seq', 39, false);
          public          postgres    false    266            �           0    0    status_type_status_type_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.status_type_status_type_id_seq', 13, false);
          public          postgres    false    268            �           0    0 0   transaction_category_transaction_category_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.transaction_category_transaction_category_id_seq', 7, false);
          public          postgres    false    271            �           0    0    transaction_transaction_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.transaction_transaction_id_seq', 74, false);
          public          postgres    false    272            �           0    0 (   transaction_type_transaction_type_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.transaction_type_transaction_type_id_seq', 3, false);
          public          postgres    false    274            �           0    0 0   unit_of_measure_type_unit_of_measure_type_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.unit_of_measure_type_unit_of_measure_type_id_seq', 7, false);
          public          postgres    false    277            �           0    0 &   unit_of_measure_unit_of_measure_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.unit_of_measure_unit_of_measure_id_seq', 11, false);
          public          postgres    false    278            �           0    0 $   user_role_farm_user_role_farm_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.user_role_farm_user_role_farm_id_seq', 234, false);
          public          postgres    false    280            �           0    0    users_user_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.users_user_id_seq', 113, false);
          public          postgres    false    282            6           2606    84007 8   cultural_work_tasks_audit cultural_work_tasks_audit_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY audit.cultural_work_tasks_audit
    ADD CONSTRAINT cultural_work_tasks_audit_pkey PRIMARY KEY (audit_id);
 a   ALTER TABLE ONLY audit.cultural_work_tasks_audit DROP CONSTRAINT cultural_work_tasks_audit_pkey;
       audit            postgres    false    218            8           2606    84009    farm_audit farm_audit_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY audit.farm_audit
    ADD CONSTRAINT farm_audit_pkey PRIMARY KEY (audit_id);
 C   ALTER TABLE ONLY audit.farm_audit DROP CONSTRAINT farm_audit_pkey;
       audit            postgres    false    220            :           2606    84011 $   flowering_audit flowering_audit_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY audit.flowering_audit
    ADD CONSTRAINT flowering_audit_pkey PRIMARY KEY (audit_id);
 M   ALTER TABLE ONLY audit.flowering_audit DROP CONSTRAINT flowering_audit_pkey;
       audit            postgres    false    222            <           2606    84013 ,   health_checks_audit health_checks_audit_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY audit.health_checks_audit
    ADD CONSTRAINT health_checks_audit_pkey PRIMARY KEY (audit_id);
 U   ALTER TABLE ONLY audit.health_checks_audit DROP CONSTRAINT health_checks_audit_pkey;
       audit            postgres    false    224            >           2606    84015    plot_audit plot_audit_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY audit.plot_audit
    ADD CONSTRAINT plot_audit_pkey PRIMARY KEY (audit_id);
 C   ALTER TABLE ONLY audit.plot_audit DROP CONSTRAINT plot_audit_pkey;
       audit            postgres    false    226            @           2606    84017 0   role_permission_audit role_permission_audit_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY audit.role_permission_audit
    ADD CONSTRAINT role_permission_audit_pkey PRIMARY KEY (audit_id);
 Y   ALTER TABLE ONLY audit.role_permission_audit DROP CONSTRAINT role_permission_audit_pkey;
       audit            postgres    false    228            B           2606    84019 (   transaction_audit transaction_audit_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY audit.transaction_audit
    ADD CONSTRAINT transaction_audit_pkey PRIMARY KEY (audit_id);
 Q   ALTER TABLE ONLY audit.transaction_audit DROP CONSTRAINT transaction_audit_pkey;
       audit            postgres    false    230            D           2606    84021    users_audit users_audit_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY audit.users_audit
    ADD CONSTRAINT users_audit_pkey PRIMARY KEY (audit_id);
 E   ALTER TABLE ONLY audit.users_audit DROP CONSTRAINT users_audit_pkey;
       audit            postgres    false    232            F           2606    84023 "   coffee_variety coffee_variety_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.coffee_variety
    ADD CONSTRAINT coffee_variety_pkey PRIMARY KEY (coffee_variety_id);
 L   ALTER TABLE ONLY public.coffee_variety DROP CONSTRAINT coffee_variety_pkey;
       public            postgres    false    234            H           2606    84025 ,   cultural_work_tasks cultural_work_tasks_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT cultural_work_tasks_pkey PRIMARY KEY (cultural_work_tasks_id);
 V   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT cultural_work_tasks_pkey;
       public            postgres    false    236            O           2606    84027 "   cultural_works cultural_works_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.cultural_works
    ADD CONSTRAINT cultural_works_pkey PRIMARY KEY (cultural_works_id);
 L   ALTER TABLE ONLY public.cultural_works DROP CONSTRAINT cultural_works_pkey;
       public            postgres    false    238            Q           2606    84029    farm farm_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.farm
    ADD CONSTRAINT farm_pkey PRIMARY KEY (farm_id);
 8   ALTER TABLE ONLY public.farm DROP CONSTRAINT farm_pkey;
       public            postgres    false    240            Y           2606    84031    flowering flowering_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT flowering_pkey PRIMARY KEY (flowering_id);
 B   ALTER TABLE ONLY public.flowering DROP CONSTRAINT flowering_pkey;
       public            postgres    false    245            ^           2606    84033 "   flowering_type flowering_type_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.flowering_type
    ADD CONSTRAINT flowering_type_pkey PRIMARY KEY (flowering_type_id);
 L   ALTER TABLE ONLY public.flowering_type DROP CONSTRAINT flowering_type_pkey;
       public            postgres    false    247            `           2606    84035     health_checks health_checks_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT health_checks_pkey PRIMARY KEY (health_checks_id);
 J   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT health_checks_pkey;
       public            postgres    false    249            g           2606    84037    invitation invitation_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT invitation_pkey PRIMARY KEY (invitation_id);
 D   ALTER TABLE ONLY public.invitation DROP CONSTRAINT invitation_pkey;
       public            postgres    false    251            i           2606    84039 (   notification_type notification_type_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.notification_type
    ADD CONSTRAINT notification_type_pkey PRIMARY KEY (notification_type_id);
 R   ALTER TABLE ONLY public.notification_type DROP CONSTRAINT notification_type_pkey;
       public            postgres    false    253            p           2606    84041     notifications notifications_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notifications_id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public            postgres    false    255            r           2606    84043    permission permission_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.permission DROP CONSTRAINT permission_name_key;
       public            postgres    false    257            t           2606    84045    permission permission_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);
 D   ALTER TABLE ONLY public.permission DROP CONSTRAINT permission_pkey;
       public            postgres    false    257            x           2606    84047    plot plot_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT plot_pkey PRIMARY KEY (plot_id);
 8   ALTER TABLE ONLY public.plot DROP CONSTRAINT plot_pkey;
       public            postgres    false    259            z           2606    84049 "   recommendation recommendation_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (recommendation_id);
 L   ALTER TABLE ONLY public.recommendation DROP CONSTRAINT recommendation_pkey;
       public            postgres    false    261            |           2606    84051    role role_name_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);
 <   ALTER TABLE ONLY public.role DROP CONSTRAINT role_name_key;
       public            postgres    false    263            �           2606    84053 $   role_permission role_permission_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (role_id, permission_id);
 N   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT role_permission_pkey;
       public            postgres    false    264    264            ~           2606    84055    role role_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            postgres    false    263            W           2606    84057    status status_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (status_id);
 <   ALTER TABLE ONLY public.status DROP CONSTRAINT status_pkey;
       public            postgres    false    243            �           2606    84059    status_type status_type_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_pkey PRIMARY KEY (status_type_id);
 F   ALTER TABLE ONLY public.status_type DROP CONSTRAINT status_type_pkey;
       public            postgres    false    267            �           2606    84061 .   transaction_category transaction_category_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT transaction_category_pkey PRIMARY KEY (transaction_category_id);
 X   ALTER TABLE ONLY public.transaction_category DROP CONSTRAINT transaction_category_pkey;
       public            postgres    false    270            �           2606    84063    transaction transaction_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);
 F   ALTER TABLE ONLY public.transaction DROP CONSTRAINT transaction_pkey;
       public            postgres    false    269            �           2606    84065 &   transaction_type transaction_type_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.transaction_type
    ADD CONSTRAINT transaction_type_pkey PRIMARY KEY (transaction_type_id);
 P   ALTER TABLE ONLY public.transaction_type DROP CONSTRAINT transaction_type_pkey;
       public            postgres    false    273            �           2606    84067 0   unit_of_measure unit_of_measure_abbreviation_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_abbreviation_key UNIQUE (abbreviation);
 Z   ALTER TABLE ONLY public.unit_of_measure DROP CONSTRAINT unit_of_measure_abbreviation_key;
       public            postgres    false    275            �           2606    84069 $   unit_of_measure unit_of_measure_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (unit_of_measure_id);
 N   ALTER TABLE ONLY public.unit_of_measure DROP CONSTRAINT unit_of_measure_pkey;
       public            postgres    false    275            �           2606    84071 .   unit_of_measure_type unit_of_measure_type_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.unit_of_measure_type
    ADD CONSTRAINT unit_of_measure_type_pkey PRIMARY KEY (unit_of_measure_type_id);
 X   ALTER TABLE ONLY public.unit_of_measure_type DROP CONSTRAINT unit_of_measure_type_pkey;
       public            postgres    false    276            �           2606    84073 "   user_role_farm user_role_farm_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT user_role_farm_pkey PRIMARY KEY (user_role_farm_id);
 L   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT user_role_farm_pkey;
       public            postgres    false    279            �           2606    84075 9   user_role_farm user_role_farm_user_id_role_id_farm_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT user_role_farm_user_id_role_id_farm_id_key UNIQUE (user_id, role_id, farm_id);
 c   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT user_role_farm_user_id_role_id_farm_id_key;
       public            postgres    false    279    279    279            �           2606    84077    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    281            �           2606    84079    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    281            I           1259    84080 )   idx_cultural_work_tasks_collaborator_user    INDEX     y   CREATE INDEX idx_cultural_work_tasks_collaborator_user ON public.cultural_work_tasks USING btree (collaborator_user_id);
 =   DROP INDEX public.idx_cultural_work_tasks_collaborator_user;
       public            postgres    false    236            J           1259    84081 )   idx_cultural_work_tasks_cultural_works_id    INDEX     v   CREATE INDEX idx_cultural_work_tasks_cultural_works_id ON public.cultural_work_tasks USING btree (cultural_works_id);
 =   DROP INDEX public.idx_cultural_work_tasks_cultural_works_id;
       public            postgres    false    236            K           1259    84082 "   idx_cultural_work_tasks_owner_user    INDEX     k   CREATE INDEX idx_cultural_work_tasks_owner_user ON public.cultural_work_tasks USING btree (owner_user_id);
 6   DROP INDEX public.idx_cultural_work_tasks_owner_user;
       public            postgres    false    236            L           1259    84083    idx_cultural_work_tasks_plot_id    INDEX     b   CREATE INDEX idx_cultural_work_tasks_plot_id ON public.cultural_work_tasks USING btree (plot_id);
 3   DROP INDEX public.idx_cultural_work_tasks_plot_id;
       public            postgres    false    236            M           1259    84084 #   idx_cultural_work_tasks_plot_status    INDEX     q   CREATE INDEX idx_cultural_work_tasks_plot_status ON public.cultural_work_tasks USING btree (plot_id, status_id);
 7   DROP INDEX public.idx_cultural_work_tasks_plot_status;
       public            postgres    false    236    236            R           1259    84085    idx_farm_area_unit_id    INDEX     N   CREATE INDEX idx_farm_area_unit_id ON public.farm USING btree (area_unit_id);
 )   DROP INDEX public.idx_farm_area_unit_id;
       public            postgres    false    240            S           1259    84086    idx_farm_status_id    INDEX     H   CREATE INDEX idx_farm_status_id ON public.farm USING btree (status_id);
 &   DROP INDEX public.idx_farm_status_id;
       public            postgres    false    240            Z           1259    84087    idx_flowering_flowering_type_id    INDEX     b   CREATE INDEX idx_flowering_flowering_type_id ON public.flowering USING btree (flowering_type_id);
 3   DROP INDEX public.idx_flowering_flowering_type_id;
       public            postgres    false    245            [           1259    84088    idx_flowering_plot    INDEX     K   CREATE INDEX idx_flowering_plot ON public.flowering USING btree (plot_id);
 &   DROP INDEX public.idx_flowering_plot;
       public            postgres    false    245            \           1259    84089    idx_flowering_status    INDEX     O   CREATE INDEX idx_flowering_status ON public.flowering USING btree (status_id);
 (   DROP INDEX public.idx_flowering_status;
       public            postgres    false    245            a           1259    84090 (   idx_health_checks_cultural_work_tasks_id    INDEX     t   CREATE INDEX idx_health_checks_cultural_work_tasks_id ON public.health_checks USING btree (cultural_work_tasks_id);
 <   DROP INDEX public.idx_health_checks_cultural_work_tasks_id;
       public            postgres    false    249            b           1259    84091 #   idx_health_checks_recommendation_id    INDEX     j   CREATE INDEX idx_health_checks_recommendation_id ON public.health_checks USING btree (recommendation_id);
 7   DROP INDEX public.idx_health_checks_recommendation_id;
       public            postgres    false    249            c           1259    84092    idx_health_checks_status_id    INDEX     Z   CREATE INDEX idx_health_checks_status_id ON public.health_checks USING btree (status_id);
 /   DROP INDEX public.idx_health_checks_status_id;
       public            postgres    false    249            d           1259    84093    idx_invitation_farm    INDEX     M   CREATE INDEX idx_invitation_farm ON public.invitation USING btree (farm_id);
 '   DROP INDEX public.idx_invitation_farm;
       public            postgres    false    251            e           1259    84094    idx_invitation_inviter_user_id    INDEX     `   CREATE INDEX idx_invitation_inviter_user_id ON public.invitation USING btree (inviter_user_id);
 2   DROP INDEX public.idx_invitation_inviter_user_id;
       public            postgres    false    251            j           1259    84095    idx_notifications_farm_id    INDEX     V   CREATE INDEX idx_notifications_farm_id ON public.notifications USING btree (farm_id);
 -   DROP INDEX public.idx_notifications_farm_id;
       public            postgres    false    255            k           1259    84096    idx_notifications_invitation_id    INDEX     b   CREATE INDEX idx_notifications_invitation_id ON public.notifications USING btree (invitation_id);
 3   DROP INDEX public.idx_notifications_invitation_id;
       public            postgres    false    255            l           1259    84097 #   idx_notifications_notification_type    INDEX     m   CREATE INDEX idx_notifications_notification_type ON public.notifications USING btree (notification_type_id);
 7   DROP INDEX public.idx_notifications_notification_type;
       public            postgres    false    255            m           1259    84098    idx_notifications_status_id    INDEX     Z   CREATE INDEX idx_notifications_status_id ON public.notifications USING btree (status_id);
 /   DROP INDEX public.idx_notifications_status_id;
       public            postgres    false    255            n           1259    84099    idx_notifications_user    INDEX     S   CREATE INDEX idx_notifications_user ON public.notifications USING btree (user_id);
 *   DROP INDEX public.idx_notifications_user;
       public            postgres    false    255            u           1259    84100    idx_plot_coffee_variety    INDEX     U   CREATE INDEX idx_plot_coffee_variety ON public.plot USING btree (coffee_variety_id);
 +   DROP INDEX public.idx_plot_coffee_variety;
       public            postgres    false    259            v           1259    84101    idx_plot_farm    INDEX     A   CREATE INDEX idx_plot_farm ON public.plot USING btree (farm_id);
 !   DROP INDEX public.idx_plot_farm;
       public            postgres    false    259                       1259    84102     idx_role_permissions_permissions    INDEX     e   CREATE INDEX idx_role_permissions_permissions ON public.role_permission USING btree (permission_id);
 4   DROP INDEX public.idx_role_permissions_permissions;
       public            postgres    false    264            �           1259    84103    idx_role_permissions_roles    INDEX     Y   CREATE INDEX idx_role_permissions_roles ON public.role_permission USING btree (role_id);
 .   DROP INDEX public.idx_role_permissions_roles;
       public            postgres    false    264            T           1259    84104    idx_status_status_id    INDEX     L   CREATE INDEX idx_status_status_id ON public.status USING btree (status_id);
 (   DROP INDEX public.idx_status_status_id;
       public            postgres    false    243            U           1259    84105    idx_status_status_type_id    INDEX     V   CREATE INDEX idx_status_status_type_id ON public.status USING btree (status_type_id);
 -   DROP INDEX public.idx_status_status_type_id;
       public            postgres    false    243            �           1259    84106    idx_status_type_status_type_id    INDEX     `   CREATE INDEX idx_status_type_status_type_id ON public.status_type USING btree (status_type_id);
 2   DROP INDEX public.idx_status_type_status_type_id;
       public            postgres    false    267            �           1259    84107    idx_transaction_category_id    INDEX     o   CREATE INDEX idx_transaction_category_id ON public.transaction_category USING btree (transaction_category_id);
 /   DROP INDEX public.idx_transaction_category_id;
       public            postgres    false    270            �           1259    84108 ,   idx_transaction_category_transaction_type_id    INDEX     |   CREATE INDEX idx_transaction_category_transaction_type_id ON public.transaction_category USING btree (transaction_type_id);
 @   DROP INDEX public.idx_transaction_category_transaction_type_id;
       public            postgres    false    270            �           1259    84109    idx_transaction_creador_id    INDEX     X   CREATE INDEX idx_transaction_creador_id ON public.transaction USING btree (creador_id);
 .   DROP INDEX public.idx_transaction_creador_id;
       public            postgres    false    269            �           1259    84110    idx_transaction_plot_date    INDEX     f   CREATE INDEX idx_transaction_plot_date ON public.transaction USING btree (plot_id, transaction_date);
 -   DROP INDEX public.idx_transaction_plot_date;
       public            postgres    false    269    269            �           1259    84111    idx_transaction_plot_id    INDEX     R   CREATE INDEX idx_transaction_plot_id ON public.transaction USING btree (plot_id);
 +   DROP INDEX public.idx_transaction_plot_id;
       public            postgres    false    269            �           1259    84112    idx_transaction_status_id    INDEX     V   CREATE INDEX idx_transaction_status_id ON public.transaction USING btree (status_id);
 -   DROP INDEX public.idx_transaction_status_id;
       public            postgres    false    269            �           1259    84113 '   idx_transaction_transaction_category_id    INDEX     r   CREATE INDEX idx_transaction_transaction_category_id ON public.transaction USING btree (transaction_category_id);
 ;   DROP INDEX public.idx_transaction_transaction_category_id;
       public            postgres    false    269            �           1259    84114 #   idx_transaction_transaction_type_id    INDEX     j   CREATE INDEX idx_transaction_transaction_type_id ON public.transaction USING btree (transaction_type_id);
 7   DROP INDEX public.idx_transaction_transaction_type_id;
       public            postgres    false    269            �           1259    84115    idx_transaction_type_id    INDEX     c   CREATE INDEX idx_transaction_type_id ON public.transaction_type USING btree (transaction_type_id);
 +   DROP INDEX public.idx_transaction_type_id;
       public            postgres    false    273            �           1259    84116 +   idx_unit_of_measure_unit_of_measure_type_id    INDEX     z   CREATE INDEX idx_unit_of_measure_unit_of_measure_type_id ON public.unit_of_measure USING btree (unit_of_measure_type_id);
 ?   DROP INDEX public.idx_unit_of_measure_unit_of_measure_type_id;
       public            postgres    false    275            �           1259    84117    idx_user_role_farm_farm    INDEX     U   CREATE INDEX idx_user_role_farm_farm ON public.user_role_farm USING btree (farm_id);
 +   DROP INDEX public.idx_user_role_farm_farm;
       public            postgres    false    279            �           1259    84118    idx_user_role_farm_roles    INDEX     V   CREATE INDEX idx_user_role_farm_roles ON public.user_role_farm USING btree (role_id);
 ,   DROP INDEX public.idx_user_role_farm_roles;
       public            postgres    false    279            �           1259    84119    idx_user_role_farm_user    INDEX     U   CREATE INDEX idx_user_role_farm_user ON public.user_role_farm USING btree (user_id);
 +   DROP INDEX public.idx_user_role_farm_user;
       public            postgres    false    279            �           1259    84120    idx_user_role_farm_user_role    INDEX     c   CREATE INDEX idx_user_role_farm_user_role ON public.user_role_farm USING btree (user_id, role_id);
 0   DROP INDEX public.idx_user_role_farm_user_role;
       public            postgres    false    279    279            �           1259    84121    idx_users_email    INDEX     B   CREATE INDEX idx_users_email ON public.users USING btree (email);
 #   DROP INDEX public.idx_users_email;
       public            postgres    false    281            �           1259    84122    idx_users_status_id    INDEX     J   CREATE INDEX idx_users_status_id ON public.users USING btree (status_id);
 '   DROP INDEX public.idx_users_status_id;
       public            postgres    false    281            �           2620    84123 5   cultural_work_tasks cultural_work_tasks_audit_trigger    TRIGGER     �   CREATE TRIGGER cultural_work_tasks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.cultural_work_tasks FOR EACH ROW EXECUTE FUNCTION public.log_cultural_work_tasks_changes();
 N   DROP TRIGGER cultural_work_tasks_audit_trigger ON public.cultural_work_tasks;
       public          postgres    false    297    236            �           2620    84124    farm farm_audit_trigger    TRIGGER     �   CREATE TRIGGER farm_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.farm FOR EACH ROW EXECUTE FUNCTION public.log_farm_changes();
 0   DROP TRIGGER farm_audit_trigger ON public.farm;
       public          postgres    false    298    240            �           2620    84125 )   health_checks health_checks_audit_trigger    TRIGGER     �   CREATE TRIGGER health_checks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.health_checks FOR EACH ROW EXECUTE FUNCTION public.log_health_checks_changes();
 B   DROP TRIGGER health_checks_audit_trigger ON public.health_checks;
       public          postgres    false    249    300            �           2620    84126    flowering log_flowering_changes    TRIGGER     �   CREATE TRIGGER log_flowering_changes AFTER INSERT OR DELETE OR UPDATE ON public.flowering FOR EACH ROW EXECUTE FUNCTION public.log_flowering_changes();
 8   DROP TRIGGER log_flowering_changes ON public.flowering;
       public          postgres    false    299    245            �           2620    84127    plot plot_audit_trigger    TRIGGER     �   CREATE TRIGGER plot_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.plot FOR EACH ROW EXECUTE FUNCTION public.log_plot_changes();
 0   DROP TRIGGER plot_audit_trigger ON public.plot;
       public          postgres    false    301    259            �           2620    84128 -   role_permission role_permission_audit_trigger    TRIGGER     �   CREATE TRIGGER role_permission_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.role_permission FOR EACH ROW EXECUTE FUNCTION public.log_role_permission_changes();
 F   DROP TRIGGER role_permission_audit_trigger ON public.role_permission;
       public          postgres    false    264    302            �           2620    84129 %   transaction transaction_audit_trigger    TRIGGER     �   CREATE TRIGGER transaction_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.transaction FOR EACH ROW EXECUTE FUNCTION public.log_transaction_changes();
 >   DROP TRIGGER transaction_audit_trigger ON public.transaction;
       public          postgres    false    303    269            �           2620    84130    users users_audit_trigger    TRIGGER     �   CREATE TRIGGER users_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.log_user_changes();
 2   DROP TRIGGER users_audit_trigger ON public.users;
       public          postgres    false    281    304            �           2606    84131 <   cultural_work_tasks fk_cultural_work_tasks_collaborator_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_collaborator_user FOREIGN KEY (collaborator_user_id) REFERENCES public.users(user_id);
 f   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_collaborator_user;
       public          postgres    false    3497    236    281            �           2606    84136 9   cultural_work_tasks fk_cultural_work_tasks_cultural_works    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_cultural_works FOREIGN KEY (cultural_works_id) REFERENCES public.cultural_works(cultural_works_id);
 c   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_cultural_works;
       public          postgres    false    3407    238    236            �           2606    84141 5   cultural_work_tasks fk_cultural_work_tasks_owner_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_owner_user FOREIGN KEY (owner_user_id) REFERENCES public.users(user_id);
 _   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_owner_user;
       public          postgres    false    3497    281    236            �           2606    84146 /   cultural_work_tasks fk_cultural_work_tasks_plot    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_plot FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id);
 Y   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_plot;
       public          postgres    false    259    3448    236            �           2606    84151 1   cultural_work_tasks fk_cultural_work_tasks_status    FK CONSTRAINT     �   ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 [   ALTER TABLE ONLY public.cultural_work_tasks DROP CONSTRAINT fk_cultural_work_tasks_status;
       public          postgres    false    243    236    3415            �           2606    84156    user_role_farm fk_farm    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_farm FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_farm;
       public          postgres    false    3409    240    279            �           2606    84161    farm fk_farm_area_unit_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.farm
    ADD CONSTRAINT fk_farm_area_unit_id FOREIGN KEY (area_unit_id) REFERENCES public.unit_of_measure(unit_of_measure_id);
 C   ALTER TABLE ONLY public.farm DROP CONSTRAINT fk_farm_area_unit_id;
       public          postgres    false    275    3481    240            �           2606    84166    flowering fk_flowering_plot_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.flowering DROP CONSTRAINT fk_flowering_plot_id;
       public          postgres    false    245    3448    259            �           2606    84171     flowering fk_flowering_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 J   ALTER TABLE ONLY public.flowering DROP CONSTRAINT fk_flowering_status_id;
       public          postgres    false    243    245    3415            �           2606    84176    flowering fk_flowering_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_type_id FOREIGN KEY (flowering_type_id) REFERENCES public.flowering_type(flowering_type_id);
 H   ALTER TABLE ONLY public.flowering DROP CONSTRAINT fk_flowering_type_id;
       public          postgres    false    245    3422    247            �           2606    84181 2   health_checks fk_health_checks_cultural_work_tasks    FK CONSTRAINT     �   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_cultural_work_tasks FOREIGN KEY (cultural_work_tasks_id) REFERENCES public.cultural_work_tasks(cultural_work_tasks_id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT fk_health_checks_cultural_work_tasks;
       public          postgres    false    3400    236    249            �           2606    84186 -   health_checks fk_health_checks_recommendation    FK CONSTRAINT     �   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_recommendation FOREIGN KEY (recommendation_id) REFERENCES public.recommendation(recommendation_id);
 W   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT fk_health_checks_recommendation;
       public          postgres    false    261    3450    249            �           2606    84191 %   health_checks fk_health_checks_status    FK CONSTRAINT     �   ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 O   ALTER TABLE ONLY public.health_checks DROP CONSTRAINT fk_health_checks_status;
       public          postgres    false    3415    249    243            �           2606    84196     invitation fk_invitation_farm_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.invitation DROP CONSTRAINT fk_invitation_farm_id;
       public          postgres    false    251    240    3409            �           2606    84201 "   invitation fk_invitation_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 L   ALTER TABLE ONLY public.invitation DROP CONSTRAINT fk_invitation_status_id;
       public          postgres    false    251    243    3415            �           2606    84206    invitation fk_invitation_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_user FOREIGN KEY (inviter_user_id) REFERENCES public.users(user_id);
 G   ALTER TABLE ONLY public.invitation DROP CONSTRAINT fk_invitation_user;
       public          postgres    false    251    3497    281            �           2606    84211 &   notifications fk_notifications_farm_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id);
 P   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_farm_id;
       public          postgres    false    3409    255    240            �           2606    84216 ,   notifications fk_notifications_invitation_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_invitation_id FOREIGN KEY (invitation_id) REFERENCES public.invitation(invitation_id);
 V   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_invitation_id;
       public          postgres    false    3431    251    255            �           2606    84221 3   notifications fk_notifications_notification_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_notification_type_id FOREIGN KEY (notification_type_id) REFERENCES public.notification_type(notification_type_id) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_notification_type_id;
       public          postgres    false    3433    253    255            �           2606    84226 (   notifications fk_notifications_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 R   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_status_id;
       public          postgres    false    3415    243    255            �           2606    84231 &   notifications fk_notifications_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.notifications DROP CONSTRAINT fk_notifications_user_id;
       public          postgres    false    255    281    3497            �           2606    84238    plot fk_plot_coffee_variety_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_coffee_variety_id FOREIGN KEY (coffee_variety_id) REFERENCES public.coffee_variety(coffee_variety_id);
 H   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_plot_coffee_variety_id;
       public          postgres    false    3398    234    259            �           2606    84243    plot fk_plot_farm_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON DELETE CASCADE;
 >   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_plot_farm_id;
       public          postgres    false    3409    259    240            �           2606    84249    plot fk_plot_status_id    FK CONSTRAINT        ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 @   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_plot_status_id;
       public          postgres    false    243    3415    259            �           2606    84254    user_role_farm fk_role    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_role;
       public          postgres    false    263    279    3454            �           2606    84259 0   role_permission fk_role_permission_permission_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_permission_id FOREIGN KEY (permission_id) REFERENCES public.permission(permission_id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT fk_role_permission_permission_id;
       public          postgres    false    264    257    3444            �           2606    84265 *   role_permission fk_role_permission_role_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.role_permission DROP CONSTRAINT fk_role_permission_role_id;
       public          postgres    false    264    263    3454            �           2606    84270    user_role_farm fk_status    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 B   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_status;
       public          postgres    false    3415    243    279            �           2606    84275    plot fk_status_id    FK CONSTRAINT     z   ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 ;   ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_status_id;
       public          postgres    false    243    259    3415            �           2606    84280    status fk_status_status_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.status
    ADD CONSTRAINT fk_status_status_type_id FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id);
 I   ALTER TABLE ONLY public.status DROP CONSTRAINT fk_status_status_type_id;
       public          postgres    false    3461    243    267            �           2606    84287 "   transaction fk_transaction_creador    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_creador FOREIGN KEY (creador_id) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_creador;
       public          postgres    false    3497    281    269            �           2606    84292 "   transaction fk_transaction_plot_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_plot_id;
       public          postgres    false    259    3448    269            �           2606    84297 $   transaction fk_transaction_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 N   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_status_id;
       public          postgres    false    243    3415    269            �           2606    84302 2   transaction fk_transaction_transaction_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_category_id FOREIGN KEY (transaction_category_id) REFERENCES public.transaction_category(transaction_category_id);
 \   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_transaction_category_id;
       public          postgres    false    270    269    3473            �           2606    84307 .   transaction fk_transaction_transaction_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_type_id FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id);
 X   ALTER TABLE ONLY public.transaction DROP CONSTRAINT fk_transaction_transaction_type_id;
       public          postgres    false    3476    273    269            �           2606    84312 (   transaction_category fk_transaction_type    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT fk_transaction_type FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.transaction_category DROP CONSTRAINT fk_transaction_type;
       public          postgres    false    3476    273    270            �           2606    84317 :   unit_of_measure fk_unit_of_measure_unit_of_measure_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT fk_unit_of_measure_unit_of_measure_type_id FOREIGN KEY (unit_of_measure_type_id) REFERENCES public.unit_of_measure_type(unit_of_measure_type_id);
 d   ALTER TABLE ONLY public.unit_of_measure DROP CONSTRAINT fk_unit_of_measure_unit_of_measure_type_id;
       public          postgres    false    276    3483    275            �           2606    84322 (   user_role_farm fk_user_role_farm_farm_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_farm_id;
       public          postgres    false    240    279    3409            �           2606    84327 (   user_role_farm fk_user_role_farm_role_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_role_id;
       public          postgres    false    3454    279    263            �           2606    84332 *   user_role_farm fk_user_role_farm_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 T   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_status_id;
       public          postgres    false    3415    243    279            �           2606    84337 (   user_role_farm fk_user_role_farm_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_role_farm DROP CONSTRAINT fk_user_role_farm_user_id;
       public          postgres    false    279    281    3497            �           2606    84342    users fk_users_status_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_users_status_id;
       public          postgres    false    281    3415    243            n   
	  x��ZK��6\��]�ď���/f��u������Z����p�[]J� �H���u�I|��?�����ą�я�ۣ|S_�/Bsc�Fӟ������0�3~�ͼXY��b�L_<����O�9O��Ҷ��ʹ0(�h�j	t���he�u�^~0o��e1_D�J���:�v���/�=�or�X��5�O������ߐ�����֮���N�gϴ��m�E|��b�@oS��:<C8�@ܝ�l�����B���yO��DQi}���<��1�����[q�|�:?�����]�������YK����2u8���6P?�-�ͦ�=����-��uD�Z���Mx�۫��QY�᤹IEe���X���^z�l�\Z����t�-��}� �,0�AU�S�	�|�7��6i*�꤁��<Џ�c��Y�@B��i��w�x>����v�ZK��W±�������}���#�qKEg�᝟�h㹠}��!�k-�<S��d��O�K��Kyp'�J��F�]}��	�_��m�Y�Z�P3����9o����QQϻ���8֏�$gxe�=e����c{9,/E��IsU%Ҧ����ȪRA��2� 1ޒ���]VQ��R��]��<��o�%����|�QmG\���9�;���"�L�e8~�!D2a�((u�:��H�;x��B��3~��+Q�s��H����z�A�����9u(������*('Ω����N�9�o�g�T���-�)���52א�)t�����'�g�kx�<B�3wδ@0]z^�	�T���Qm����{��'픹/5e}��V�y�'xRp�,^[�[����_�怇�fw)%c=L׈���:I���O)"��^3� :�H[]�j�o�۴ja�%U����%$8EEp~(ٽ̤�Z���?�Ɉ����0ݕ����'��EE�R�ɪ\��+<8ݿ����JZH|�
M�]�s=����$��|�5[ޞ5�QI��[�@�\J�9hr}m�_5>�����
����TSα�����o��;�����C�۷���}��T#`�f���Fgx�Wrȫ�̥���T��J�n �6�y�hoS�ѩF�<w���g�&(Y��2��_dXn��`�^#�B,�G��ש}��!��uD��Tw�ζ�A�=Xx?Z8:GctNn��H��'�?̦�ƟgJ��Z�Sڽ�l��US�g-S��� ekl9Q�����ƏႸ{&6�߭�Ǉک�������|�ĉ.1'���[�e�ݻ[O��������RS�8�����g��w��R��&�+�����m�P�'��q�я�γ��F���a�M|t��1���w�f�
9����~�Sђ	в���&ȵ�)��RV�/ڕYZo=Sԃ��Ƶ��|--�9�(��r�ݚ��p-��r.������]Q[m:����3�r�+��?\i����Яd�3��D|"W.�W�5�����.�b���<���q��j���K��4&y�@7��H�k��Ҧ|�S*���DfH�hY:�,@�6�(����廀|hT�8��PV����$�C���29A!߈�)p}� :;	I���$+�#���W�ГR�CGm$[O`����_�:������HmM��v��B��cL)�Յv������1�!�s7OQ^(2����q�;�& ؂����U�Sĭ\L�C�>䇻Q��U@�,��Qj|���w�6wm���j�y]`��e�zZ n Q�K�9�����b�fWf@C��Z�@UR;@��|����c��-u�b֛��ՍRBs}��5�{zKuyq�Ac���#�T)���<>��	�.�z!�ΥR<�I�I*�c�CW�/DT]����c:#|��� C%�^S14�(��o���Ǟ��A��CQ�ѻ����w�o��-򬧚��#)7W��hn�����
���R2�e(jy����5�����ƍ<����xH�h>�9N�j��֏p�ZR�_�j����]bsw���]-��z�B\��W!��f�"�/9�e��Ɗ���������Qxi�-u�3��\������Sugh_�L�M����|ȥk�KHh}%��a��v��8���N���֠�j�bx�?,��KF��Vr��G��}f�5uo���������衁�d3����!�I�LHРӚ��.$����~���K9㷵vrKIC�Ӹ�u��'\�)��q�QQyRA^#�n�P㛋���D���b}V�i�=H���5����[i�O��4���k���C4���C������\'��      p   �  x��[�r�F]_}~ ,�h�4�R�������i�� T,��,g1���V?6�I@�4���誰����:��A�Ѫ�x�f���������]x�G������R�H97�\ڙ2RJq")K�ݗ/H��8�21�H�&���^�d[A�� �b�er�t�7,�,	a	�Z��`d�iw�P2*%LN*�����ݑl�(�/l!�\f��������>9m����E<��|�u�G���2�,�X�-4e��b��ڃ�eQ�L5C�^�m�|]vd8�e普[�W_}�K3�?��_5��xDG�H�KP���O�Hҋ��EӖ]"p`�Y%Xb���Y4e�$��=k������?5/��"���Y���R�rt�o}�>H�@2�SZ#��}�H�9�JP:2�:�H6{�,#s҂�M�7mC���Q�������HP�x��󿝞�]\�npE$(�Oڍ�PQ}��ܢ�qTV��@�)�
��MjmXZ��IX˂���I،�Q.'as,(c�b:K�?Kd����e�t�ﾰ���"����ܗ˲��:�cN)W�q�F\P���b��E�2�9O�s���:��&\|� 
�1� cN�A�)�J��.�PYG����~ǧ�#R��%�������9��E]qT���F���۔ ��ˤ�^��V(+�sZݮV���d$��X��NJk�̋��h�\_׻d�l�S�`� �����٬׫�>|[�V���#Dt��(Ko�F��e����9���^f�V7F��:T������[IC��~�!��s�6��Ue�ۊ��M	�> �b[��C�O�29���� d�����o�K��5��Em��+�_�8M�naq�Æuؒq�	�r���u*ؒ�n�Pe3��l��<t�K�\=�+���+��g�54�n[>'�>~����"m�Z̓��_���X[�,%T��E}�7U��\*b7���z	�O"��?,Ef�ѓ��.�1��w��3�<c��]�� �L6�{��v�\5"��˾����{�۾�6��E�yns�fP~l�=x�KXㅅI|Ǟ�X��"��oT0��|T�P�-7��X��Q϶M�;x�F��d��ضM˩W��QY� 1�R�:2���	u��X��A�=e`�c\�`����o��>�?r�Ps��dw����srӃ�b�h<�לY��c:8h�Z"C���ؔ�)�z7=�+��^�M��7F�l�7v��^��{E͊��ӽ�f�8,
��E�4r�Nv�<S��i��36n���gq��dr��Zp��f18�I��[����k�[ydgǀ
��� �!�#�P|���E8��i�xS����Ա�6�2��c�rB	:��qeo`��D2^�^��%�6�@aR�	%����~�q��@��5�L��u]������%��}�/����!�M�e�����)ú�O��:�h������E�p�b���|��EWuГ��������.��m�r����X͉s�,dJ/﫧k�H!Q`�#C_&�r�i�c%m�����b�����ⷎA/)G���c���PG'j=b�P5����>���W�ӊ��N%(!�s��Q0�	���\U��}y��Ex���0$,�҇'!�r(���R��Ai
3
�dH
r������K��,^'�u݅W���&���?P6P($ZPշ\���І8k3�AGhK|�7U(l�@4�k>��e��*��r��ڀ��6~��q�hI�����
��Gv���m`@x�8�J	�R��$�'&�`D�$Ǵ�����[j�����e]���rd,��¨�*)����~����0:��v�lʰ�d��$߶��GU�Ą滃+6ղ�i�2� �f_.�Q(9>�9��{^�E>�s���b�����x���[��Mr�[���4셾c5}��&��<u'����ɧ�n��b��f����������%xy��7���j��<	��>�c{��ϺZ���3Ԯ0��yޤp����͕�i�p�I��|v�����+xe�ZΔr.�`�H���l�`6o;��M��9��Yn�jOy����D���)f8<x�Nc��8-{㴿���֙oH��oWV��G����O�D��4�+5���OBZ�tr����I���%���N7�T̈́�3������o�]�&򹻾/�[���B�`6�TI�
�L����@!��βL�>�������U�?�-�ۀ�6��:��EssS^������=��{F�p���C�L�4�'׳������%�      r   �  x��X;v1��S��#���i\$)}�sd��.�}���$[3�@�Ô��$H�q����-��c&������s�~����.�g�"�oB��Bl���)�;�2脕â#Q;q|~P&l��">7��B�R�$+�D�� �VM�p�����Q�NI���Q�d%AdN��0�ɀy�~G��Q���RT�b$�\m+䀇������%cԀ�Յ%<4���4�� �'�ęڻ�y����-zbJ/gO�&��m�߄m�=�ՙ�H���oW���_G�K9�U����a����U��:�ǣc�91ih�>�Y�`1��!'{�F|�A��qsdM�|����2���Im��y�T�������J��v��Xᩆ|�`ݠ! E�2WҾ.��$3��QK)ly����p�v�����R�;\�B�1BT�gFd2�*m�\0����46k�*`n�6X���M�,��R��4�ԓ#K��*/��,}��V0���N����	vrZX����v�a�.>{^`'�/YLZ�~��"c��y[����t��Y�5�B�Kv�p��;%,,y����~�]O��N�e�����r/��l��gųYC~�O�&�J9��?/�C䗵G�G��������_�"n�a[h�Z�F���ރg���*z^�cG>�Gs ������c�u�0մ-���!�&��'�_�@��}��	�ey�2��W_ȯ��{�`�"ȯ��>f����-,�+0�mz����xН��hn�������5\��-���}Z�6�o�$je���djә׹ ��1U6�lVj�)��QZ��,�0�����,�E7�z2fz\Оy��=�p_;ڊ���f���҃�'j�my��؅z�żo@,�؟?����oɒ�      t   �  x���On[7���)t ;��貋��4EW5Ql�d<ً��G���ц#R�{��e���3�gH�"Ś�љN�H�o��ۍrA�>������'ܙ6gڮ��;���;㘙NXq	H���F����d�:߭����.��v�W��2N@�*�>$��<�x�f�$(����l�/��O+>]���r?��SdX��b����w����LcOW�v������U$v�SN׫|�>c�����A��l����y���k�	9���m�_/����!!>qf>u��8�u3�����ō�����q�9�0j'�`	�pq�7b
t��|c���$FT'�bOS{Q�a?�a1���=J�S�I�tu(I����4&�����2$�m��a%z��H�H�Jr[��.�4�^�'%#q|(���/1���Ã��--\$`Ћ5��	�7�����U���NG��DF�C|�E=+��,׈��fClu���T��ZL)2�xH�y��V�JT���"��CV��W�U���(��b�9d0�зQ0���D5��D�G,�#A�A*�#���U�#�T���i�`n�������\R1��7�D���R"�Rg��DӉ��vb���ub��Ƕ&��Hhݩ�cb�E�C\�lVV�qξ�����.������9+���*)AxNa�"�JHPW�����v-�@��l!�~����ֳGG8�Qڥ4�1�u��7��<*�����@�L��uȌ��\ i��v�����G�ٶn�e�pض�|#(^ ��[wд��C�� �c�C^b��7M��2ć����CN�I].m�H�����{���2>���%�12K�%Z���,��1��K�%�92U^��7�V&�zi$�Li���ǁ-�b~M�n�+cY�Z����6͊�����gu{���@�	>���:$�dc�nmZ.����)[�v�*%�P���Q���+))E��F�2'I�(4�(|X�T� =�I9�M�J߹��G�#`�")� �4�(� v'9��cD�Ҵ�e Ċ���ĊG_���'���Ċ+5�Jx�1B�H�4�k���n��_��\��p����}��$�ݢA�CB|�9{Fm����f{q�p��6�+X�#� !�E/P�:9IPt��T��s�Ec��~tp�QPQ���BAFE�:����QP��S���r�rԅ��.$P��B��.$P��B�u�@��.t���b.u���+mW�����������mT�]4�;�'WG�:�{
=��=Ӂ=�~��C���8v��<_�*O�|�;uH�<d�*�u-!�{� ����P�P-D�:E�)T����;d��$�y�����!�����N����F�	G�AF��11ǂ301ǁ3ѣ�9�*`�]�=�N���/��l�������A�X�4�F]݁V���U�S�|Yd�zG/�^�_�K��;99��X��      v   >  x��Z�n$�<�b ����|U���z�ZIG]��Yk�Y1Cڐ�ȿ�~�Q]ՏY�X�t ��ʌ���Vp�n�=���q8�W&�������Y��X­�.� �Bp�����?������D啧W�w1��:�-I�1�D��O�����e��a7���G���g��zODޱj.�>\r��|z��H9g�<"���1�Hx��!�3��p�w�K����"�jJ�f �R�����o�gw�p���7��Q��'A��+�Q�CJ�ǿ)4��Y�4��ҨB<߇���|?.�C�;ǂ9B�	��9�
�9e�V�����i�a�83{��1�̩��*�Cg���!��O�aw�[�<ϭ�����}��<����Il�S_����N$��T$^������f
�O��}�'�Ȉ'1$+xҘɹN\�
���>�ϧ�����j�3� ��}Z�����/a�0�7��OO��GK)'hb�BJ"!T� BC����ߏ�S�f��С�',cQ��:�q,�{,ʤ���|��y�4�y��A8�yQ_���p0 RmC\+��e�[��q�>Z�h-e���.�_�C���-��f�@����c1�7��_�9�1I�0[..����u�n��i�}5kJ 3��7a�dQ��IC�4�26�'K1�q�b�C��,�NZ��itB1��m��(���bM�����$�j�Xr�+/���K9��e7Ur)�� 	�@�_PHI1G2'S*�E+\ovLU����)j�� $m3pPY<︼��Z6�od������3��Pm:��)�1[� ����n��ٜJ�R�� �˶�A�
�ϡ�L�,�*zi�;u�AO��tk�Z�/�S�0Mw�GC��@;��@�瓄�J���̜�9�_�!LM��WA����)���4�`�g{@$��!�<B�ȷw����n����������%*��q������\}^P�7]"b0�ċ��B�+z��4��L]�B�}"�Ws	쭎�Z �:skd�+��W�b��Ӹz�k(�	&cMǱ�o���y�9�!����Y�������$����y��>/wݫQ��I�O��[�T.P���;��a���e�Em�z�V�Ε@g칖��M���6�޷����R\�������]��K����*{,i�▪)[��B�b�|�@��5*u,o	���}�ģS�Z2�8��k������e�����6a�MX�Tx"u�ZD ��gN{���ؓW*#S�z�e� �e�sZ��բ��z*��U�npL��P��F�H�;���f���pY��f���Wo�Ti,���o����Ǿmpe}��ޢf��XC�|�J>�,Z��a���!�p)i1ũa"�{?��������d���#m��N����:��h�s�I�s)��8���Ҍ�R�-&9M�muo2/��y��}�� _���9]�O���$A!/��$�@/��C�mx��f�l`�d����M�~������	f���0ݜ��
A����Q��R&g�F*�����穦M��CS����K�PdgT���p�kV�H����#F����y�;I�|��&��py>����2	[���Fe��\����f�K�05���f��.�_��"4/ˉ3�����UA��uj(�>��t~"�xv���u��f~eFco5��4��8��r o��b����0�0x��y4��/��S��S��FT�X��IXyq�G�՛��2l�h��/���v��P���|^,�c�\"�V�*1i���z^[_�Tp&q������|�p�a��r*����]��_�bY��tIR�~_%a"�,�׆�Ѿ���t{ss�osS-      x     x����u�0c�
7p�����8q`;t�u�
�)�G��]��}~���7���Ǩ�5�K�3���Ք ��%હ�ln�h� ������p�&���ń�Ln5x�Nh)=( �%л-&Hr�j����љK9S÷�Dʅ	�I�;3M�3�#�t-G$I:�v4��1I@��1�"2f.E���!��ҍ�n���ӆD��6$�Wu�Dr�n���ӿ8���m�(*+�R�E"��-b�r���x���ы�"��r���r����(I>�%���s���V��      z     x����r�F���S���o �'���x�L*7Q�8o�"Eڴz��ށ���;Mh�d����eDi�"�p��=c��!���z���QA~���w?���Q�T�S�p�N�w\?�9gw������sU�d[ms�������O����5������'�x�h����0�k�&�G��p�h��ڜ�n6x���*���D���7����$�&�D���T�nH�r�pI�XnF�&)w�L6f��g����xNt�pפ��b�ٕ�1��Tl�g1o�z�����<˹GOC����d�x�r[B�$�Q���Ȝ|��שpf9�x�A���d��
(t�H<��P�X2�`)xی�7�Ta(���t
��*J�(��$@fde�PN��( � �"�ąQ8%9�r4G�l�Cd��R��n	�pY�~#nvC��ʨ�䠺�l�kND�@�Cq�=/bnF��+5 ��m}��\<�	�:ִIٖ��q��p+�GSwI}6�y��%�iO���?𣅯���?ǟ͍�'q�gg%6[���"儋��$ |I�o"A�����o$lz�jF�5H��T�}������<e1�d�۬��J�,ڞ�̝�FdK-��U��Y�����_�h9U*�D�4����^�E�c�|U�vKs`�|>]λm=��ծ��ņAB���q%2�{�+�����e�x��|ɑ�[��Wh18�����x��M;���vh�Ͷ9�m۷E��vx|,��j�P)2�b�^bab_�ʮ*_��@O`ʼ��IrEL<�Qp���\D	�������Z��t{c���:Xp�U�b��4LxN��^)�{F��֌�<��W�@�����?OU߁��Mr���a��=[��9��<�{��L�I7s@��(PCn�U S���@��sȸCA��i>	9�l��i��_=��z��Q0��o(�Ƨƹv�] l��SP�a�S�i�U�.t���ʮ�N�W��42���a���b���XX��'��/�E��9��������/[7M�eu �jXn`�*1ߊ�m����s���}K׀�B�0N�je��6Yh"�~螎�I�{S��&������o8[���>D�l��/퍽����M�Vq���霹�hM�T�QKC�۫Yq����ܿѫ۫�5!��G�\7`D]�q+�|��d�,�F/:K��(����5���o������+1�X�WB�>�����*w���w==�h�'}~����uƗ�      |      x��|Ɏ�Z�����N�'�C$G�Q)�(��yę��^����cM��:���+wܩ��ٵ�3�4�z.��v���ݡ��r8`��e���M����vn�����!jW�;�a����#���;�����o�F�e!K�4R����*I��pѕ K`�jn�U�^|p�K:��u֯m3>�*����w���|t,�Z�9]��Ce����� ��I5���A;��D��a���o�0�/0� ӺK�n���_�������|�3�Lwt\��7������Mojuq���C�F!�Z̻[`&-d���
��7���h��"ߓ0�"mB �*w���A��/�B6�AU&�t�Dޞ����$����x5F�N�0�q��"D��oo1x��SV� �h�-�I��"r��X3��e��E�D.��T.p��6��p}C'�B�������!h-u�v��W
<��j=Zљ�s��)S-�|�H�,s���\O~������@`����&o��%�A���_%n�L�YͼrV�F��6>@A�:�[ԧ���t��Y1X���'�;ka��/��J϶qF��=�q �~�5�A���2t~�[��&��y�ٸ�=�C־ �i�Y�T��g��j�Q�6�G�m��f��hb�.jB�'4���ݶ.�?�w7���MM�f��Up��}�G�||Uk��R�N��1JrB?�~�\\��fTA�/w��E$���eL�R�L�<���\PyS(�z��.�^�F��F|@���7�JS��WL����0	}�7�WL�tɟ_9�������flqȮ�0^b_"����g+a��{m�@:����v=�W���#i$��fq�MtD�*�rɳ=�qE<���7�L���O<�'�0���_e�~�ޘ��C�^CX5]�{,�����5����z�z��}��z��/Ժߓ ������=��v�Sw}�V?Z�L�p����(��s�H�p�.V.KOc�]wⱕ2��xç� ��E"V~n�c��,��.����[���qV�a�!SB��B�Oľr��������!�h�!hh�Lz��[I���%�|f%�=��]:�UQF����w�g7<�:��k^��ce��S�*/�p��Qe����4r�9���C��8:и����O	���o�� �.�-��i��FYn�`C�a�!�2H�ӃLP�f�,,#䴫��Sa�P��� ����~�3����Z�S�[�u5�}ڙ�#-Ġrv�b���d��ܣ��V��G�ѬpV�~��"A �+O7��z��WX���w�,�+�`���+q�喧��@�?f��{�+Ah<j�IH	��=Jp�1�N��c �� �n#� �o�����0oBι.��"�<������wr�]�x�PXK�Bw� �/c����)l8�i$i$*)Ɉ�{����~���M%��$+CyD��燫��_!���h��/�+kY���Q�AjO�f㦎ks$-���4إ�noD�u��w�س�G}���zV�S� 
ȉr��`>��e�ܫ�5}Ǽ@�_�G��#����x'EZc����ˤ��H0�����WPEK���&2�]�,8%��R���j�>�_������.[`u8��<�WW�.fZ��L�Y7��Ŕt�>�]��>�;�ZW��'�������y���ſ9�v2�|�y6 qz�>����2��e���)qOx���)���k�Ap�͐>��ɀ�P��!$�W�*{f\9��Z0m����E��EG�;&G|si�J��WT�am��v��z��h�C��.�O��g(�0t����5��(�h����k��P�>���@��@� 8�I���7��=���_��-�"������}�^�*��d�w��>����[L��C�l��}~J�3�l���]����q�P^]u���f6ǋ8���$p�2;=�u�����/����$�T��;�sf6/�Ӻ��j�;=��<ъ��GԂ�tI���{$���Yw.~�K��&p�y��P�-�ʿx�)�~G�T�]�~�`�k�U|i&������đR���Ӏ����;B�fX�O����i�W��c��ppԗ#ֆ�������wT ���?���w�t�I���t�ssT����x'�A��2�~�q���Ә���'z�+9<i�οY�( �I]��"�/){9��Hmphz�4Ɇ��]��*��g��8�j��������"�W#�$���ӘQQ
c�Ms�����}��15����-W�릺~:�_W}�v��}�&.i����j� r�"��3��*�ڳF �h:����Z&���p�
�29zTӋ9ٽk����Il,'20I��w����H~�����f�` X�0kn9]�mi��xmh�p�z�p�
�ɰczJi~���<���xrV�����W���@L�g�ï��7��5�Ŗ�6���L7A�*�f\�2�㦩�{������,� �6�A͙ *u�;bo0�a��0������>�s����E`�@Q|@}
�<�
P�|�<��=��R���J�<ƻ4��'ZU�g�,�;� �4]_]:�A�k*�%�մ�ę���R�q H�r����
>@o����݇1�����W�h����w=����_�䕆���LS��r�3��Q�<=+I�U�=Q�g��,j�n�%���5�m<ڷ/�>' ��='��s����\��aAx�� ��q*x眼a�s�2/6>98��ƻ�c�4�Q���<��֝�	�d	w8�~�a2���򼿊Glw��@�|����p[n�퇡,���/?�:���8h��?` p�4�:T?uAƿ�U���'�ɤc��w�l�`����S�	�kVlð۹p��7��B�œ����Y��;!F (�Հ+��/���W�ӵ���/�+zwE3o��+���̗#ǎ�a���Z
d����R*�7S	����C$0L����$q�%a�H�_s�[תO�B�ظZEK�;z����	��>x����ε��:�t�y����E��J��X㦁�+�&� Mzn�2������|�(�o��C�48 H@m�0�bD���P��o���;��`��e)z��,N�r��H���L�����[,w�Dy�ʍv`���D���q��_��e%4Ͼ�Wس�j�L�(��h����P�ߝ?�P E��!��V ��K���Ј�p��R�;�t�����O'^���gӟ<:������伴."���&X�Hi��4Et�O���y�O3</1��v�K0�5iK�?���<П}ů�b�[�Xܤ�
y��p�G����@����М�Y��[}���[U�-y1d��V����t��f9���c��Ƭ�e�BPd�B�A՝X�,��(h���J��g�ܽ7ڈ�����k�[ַ{���� ? ��D_�jD�qjÏ-M�36B ��q�M!!�AQ[K�| -�"�x��L��+&�Ð�	;*�:N��gD���_4�t\s+n��� ƠZ��$�J!R���;�u#��W��o�.��+y��ث!�%�皰@y�wdF/G�/�q&��3X�m~r$Dt'��H{��@h��&�E0 B���5���~C^���#Dmp��'&�L�>����S�x^�r�6��e�k����J���ZԚmlc&02�r��E��_�FU��M�oOF���Y����b8 a?#��uۆo���_X4�u_�U�L���k����$4��g9��Dޱٲ������W������  ���}i�ܔ�g2˱�/�e���w�XF�MC�/ZC�P֦����e�:�.^��:i |�O,�e��3/�-�ߋdr��W$��`��gZ�4Ƽd�_P�=����b�s�d�4�8A�y`(bV��'��9�¯HJ����k�r��,TbL�b�[V�T����X�%��cD&hY�{G5
���G�}�g�^���H+��y��.ﶒjW8y�� ����z�^o�m    ތ�p�	4#�ׇ���zB���j��q��P���HA UZ�MX��G1D�GA������H�Ztr�8���lS��`�������g����M��������L�����+KDV��&�����Je��ʹ3�k�_;����q�:�+n����1�]i|��
����w����ؖ�ܶ���;����?�MZw{]WY����ʱ�KR��ը��,|��C���Tꍲ�P��'KƠ8Ԇؔ=B�ra}!��YZ�:�����&u|ԺN�͑�}����@Hit����$pT�{��m	�`�p��u��-���z�V��rJ��]r�b(��4�t����51<*\3���k)����/\�ŋ?B��{/��(�! ]Du����3�A�����r��]�(��>��Ya+�Q�]���<y5�LO��X�!�'O%-zQS�E��x_��ҵ��K�6$az�mG��'C�ia9_d�D��`(�|zY�n�q���5��+�m0��sg�"ۀ��#�R^藦�/����@�:I�v��+C�%����F�Q
x�����!K���q��?�GL_o��H�oq��I�|wy���]6�\��<��0X#���S}�3� 8KϘ=�[0�E��s����oJO ���9��@�����ϐ�G� ��7���8������֢1@�K��������gtQ�Z�]y�����Q*Rg22�U� %�ȝ�(~G���}�����	�o�m��Uq]�U%�
����w\�<=?��sAE
�{��g˱|���X�0��<���Ac�ǇG�.߼� V: r��q�zx�&�y�#M�H������9��`A��2R���B��vO��R]���/m���zs^�� �~����'��)�+�FQ�b9��G���J'J�oҝnRE?֡��5�q�^Apk�s�Ew��+(�8@��Cf����E݄�V�\�-��^��GXS��#���gy��-Lٛro�[æ-d�̓ Z��5��S��!�B��c�+݄B�{v��8hU,��Bk#J#t��쐵jJ~[í�S ��qd�����oz�����g�_T4���+��D�wA�R��+pb�pM�;f���T�װ[�$3�x*ӟ�B�H2q�	!�9 ���a���y�p�'%��es(�XA���w�h$ϔ���k��iSO��!1D�Af�	���?�'��>�V�p8n�����~-�~u�!8��w��8"H�]%�F�'P����M;J�k�i��zzh��6e�ϖ�D{��le�*�p"��lq��8��-$�"�:���E��>!�0�����jӈ���v\	�+x���_�#˲����.D{���
��;�9O�jA����W��D�h�[�jb��ϭ���_�k�?��?�w�nI���	[o���8�*F��}	���>�s&�����2#��Z�ʑ�%�R�0du���!̹�3�ܛ	\��)�{�t��D�q`��ꡅ=���p�3l�7�s�$��`��?�4�4F7�VMX���:N��G%*;���F�V`���ո�h��FA`����(1?j-�=�S�_�����z0+&�̰�3�q7����Ay�0wm��+bb�
q�ؗ�I.L�y�o�h���  ��[��O�o��{=�`�<�L5E��l�D�&��2�W�pg���Kp����;�m�v�,��ծ���y�7*.��U�%�?b��l�T}�U��1��3�E+�擆���wgN�<r����oW��
�1�\�f�2ɍ�=ņ[���@"@׷i��8�#���7��x�^�5ȡ��I�3�4ѻgb��"��C�z�x{v ��6jZ
*SOs�\Y9�����r$Am$�w��ɸ6�xc;=��貇�ܫ���ލ�~C������g��O/����}6�B����x_<~c.�V�E2�̉���_��]��2�z��2@�7�@q�"#� v@)<8x^D"/ 7��p�3����Q4�Z���a�rj�.�˪H��<�%�`�r,Ԧ����mP�>��m���'$�7J�#��:�w!f`H̥����cS���i*�5R�
;<"y^��}��<��ڣ�^��<��$H5��m#�NC����B����d�t����]$�퀨�΋ܾ�E~�ᐢ(�0�zkL]n�J�5��~�I{�ّLx}���8�Ly�Kt�i�L׽|Q��et���E�3}:+��t��y�k�5�]:�%�r#���s�� 
�n%�����bh����7�����{d���kS�gk��g<M)|ݴF�#֊�l1G1OgY?�4{tC%H��c�����U�2�96��I�#AbH;�or+�g�O»���k@���,����V���{ť��Z���(0i����R)+�����Ww7�V(�3��YZ���2�jb����,Ufͯ�UDv�R��C�8w/�
�c �E?�?����Le�DC��,�Đ����Ys���v�}xe�X�}���gIib$��6�tS(٩ޤ�B����Ѹ�C�7жׁ��Uׄ"B��tdz�'�~5�	����c�u�
��4!�������nހ����!e���B}�諷�,����mdtȐ�å��{I������,�����b�Uwlܦg �����`���'Ř��J��5��Y�^,�g:�_2=���J\����v]�T{q�R�TB��92�d�>n@�&& ���U���[�zu���A��%��'�P��#2�8�W�n��+ӧt~j�6x?C��Ru3�:��Vx��.#N�����к�꾮R�-�9-�迓!ka��g2����Wc黛ᘤ�*Ɋ��;�������q�i0`ӫQ�)<�	����7,�wz)����F��qd^�Fpv&�0(�U�/y��������M�x$rT�*����M� @Q�%�
07F�	S�֮ލeI�a�KR���U��`���b9��t���*AdDC��&�P�k�G�~����/t	��*��y�M���j��w�bj�gK"�@���]�=PW���^K�+ �~E�ȭ&m�\p�N���ڕme�<��h���@iϓ�S��Q9`t���ݲϷE��g|���8t����JZ��j9}�'�퍓�������������t0|ҹ@�wLm��ɁKo���m�[���w�>���K!!U����F}�g#vǵ�JSX@f9K7�X�qУ�y���(���]W�7��[�E���?��ɰt�p\y�Y��$8a��1�=�x�X�ūԳ
�ԙ��]��� �gŇ��cx�� A�g�������lV����(��X���U@G�o�>!�ΥL�R�iy�\���2���@�$M���;��ύON@<�7�#�n*@�D�ѥ����_����w	0����AJ�j����܆+P���x1�]��ȉ����9�Ls(́�]C�h�mD|�Ba������M�uK��;�q޼�mxð�ܗ꺦��L��g�2p~��,� ��\��%Jѯa}�yG��5�K�,˹�pn��H���%�!��۟��/Rs#�7�$6L�.S�_%e2ڙ?��.�Iy2�|�M�7V�zɜ��Mh��L��f�����Μʰx�Zdeu�����Ccz0��z�70�)�n£�k��|ULJ�㛅�Umtw�ￎ�ߨ�'�� ˾�1�g�\w�;��0f�ɫ���p҆ɒ��ᐲL����B\_o�֤��X��;~A ������"I�xk��|�}�)��M΄e���L�P�	�ʒz���"�{"��|�C����PךAfYM��lF)�u��yR˫�2��+�YbZ>�Q.i>�`=R����c=|���y�F}L�5'�e͔zNd6��k�����&�Na��ASt��ė�dGe��1���5���1#�ӻ
�����X�U��",8��[i��S�5iUw.���t�5��Õ:܃S*�/���Q�x*"r=��-�� 1'�},ݽ6��n#y��}�ac�\��J	��2_�'�{!=a7������f�Yݍ�m�����+��e�ē �  ��9�L4�T¦`
���Yq�uL�'ơ��'��ZD��q��.�> �>e� v�=j�'�����X�ه@T�9
-.#ߜc�;V�h
�k�Yj~�������r�"�!-ވˤen	�P�Λ�xJn�s�#���_[]�!�������b���ysʰ�$R������(�j�mڰ
>{�oY݅�A������z�e��e���� n�]X�AyN~�Ƹjt�.$���^�-G�%��WxF]p��֘�o(Z3�R	yA�2\����Ep���nG䒾u����FR��g������A���[�{+��'��a���Q룖������'�	2�\Ø���	�(��#="f��Q�����g	2S�Wo�VS�qrÄx� J��?7_��{Y�����ui�!O&�_6��Za���� G<^WS�g3�,!ri����ثOSS
��Py��G~�B��y�m�'a����u�<���~=�� �O�&�;�j�$�t�I=e�+۹���!����:
Xc��տ��& !~/7?�!H��o�����ou����}c<(�^���p��.�5�`��d��ea�'����]27�~Ɩ��e4sVk�ŉ�,�^�K�K�u=���u�P^V4��~�v1�Tߋ�R+��`��#j�O��=���6�/S�����FY�jL�7�S��9TX~����E� O�ᖲ@�9��x�]��5�%����8iɓ�ӌ�@��ߦ5n��O;�����%Wv��k�e,�����.�Ju�Ɗ���υ��
�c�LE���f���%x�C�߀#$������ݘ?SBӳb�4��c�ĝ2�nH݋C�Syu�_�(/n<�W��W"��vb�4g����G��ރȤ&�z*8U�~���2����n���˿����Y*e      ~   E   x�3�tN,.�����2�t�/J���2���%r�p:����&e&r�r�dd&'r�q�$&er��qqq Ot�      �   e  x��YK�ۺ��88*�KPk�� ��נ��g�Y9��w ��F�	}�C��?����W�_�ߪ�G��>k����F�J��:?��'���X�n�G�a��:��p+B���T}��������2[̢����b��@f�R׏��g듵&���\c�_�|vHiyN����|̶��z�ɳ��bRzf�>�%�$������O�3�����E/Dy3֗���l����	U��N�� .�_a�����~ˊۙ��k���m��� �k�LC{/]o��jޫZu���r��2ՙYOM�.����2e@ْ��Rny��!,�������%������$�Z4���	�s؎L�Y�DB�-ӕ6���ĉÈh����[�'��2���i��Joܼ��#�?횕���{�ŒL������s}6Al��rN�5z�Di�&a7�b����@�	u��u��6��H�#R�@pH'�|����sՙhb�lq����OHJ"TG��Ex��)��Z=�4�j�bq�N �$BVBe�r)Y�#��v$$	<0i��SE��NFo��>���]f����#���3yqY�_F��7�Z��Cz��Q�A1+T���(�[�Y|P��R��>��y���" �M`���1�{H�Kg�LE��H��u�T��"��n��['�Q���BݷH> Iѣ���EmE^��@�LS�Ԋ�Y[�'����M1�ۻ{�$�.TX�Q˄�Ae��3Gs�	�g��`ڎ��3?�2aL4Զ��a8ըN
I��?)*�8#�-ps
T�HJd�3�'��#�؅����#�p�sO3t/��0���k�'��V�g(~]�� �p����n��I�7پDw�*s����cn��K:�\�f�6�.� ;*d���mT1��o�B��S�-��Y�g����~�CL�nXϴ�T��Iw�_��tH���.�c��}"}ܨu������y�j���l5�#�5O�7�Ԣ;��88�"]�{i��&O(�	��iv�N3�\Z�/�'��?4�D���C���UZ���:Z>%i뷢��c�ú����1.���w��uC?"{�앬�/ȷ+��6:{%��~y��2���ܹF��P�E�v/]X��n�D"$Ul�%���ľ�@��[��f�*�	ް����]����fL��\�`y�io%E�R=���M\�|�!�U�a�0�1g�w�M��{��T�6LqGԼ8�K�T��� �޻�������̄���k������i�i�*��k���66vHp��e���>��M?��y�Ğ�^a%�9�hA)�į��~$I�S`��|_��,�U��FR�c*�j�iק��"��簅���jG�m�x��sX6&�0�f(��ǎ��':����^Gͪm2�Uٲ�� ��ms}4e�W���kf44�!��ְ�i�t/�v$}���O%ШZódy�����d�t<�l���>v"ɸ���r���p"蒖�՛X���)��R����&'�����RWR�8�b#�sZR�=?j���Q�Tt�<��	��<I�*a?'lh�>�l���y��mK���������7q�%/:|I�����Bq�+���K,G��TH�����C�/j� T�ް,ghZ�D�����TZ=�l��q(:���L$�-t�[w>rZ�ɒ\��	k9�F
���/��|�:i�Y���{��E�Ȯ�KR�z���s�9�+r�3��l>�#t�q;xl6`[F��,ۆ����B�s��*w��Ʀ�x1���1߁--ߠRjG"�j�g�-��u��R�ȶ(������7r�n`K����I�X�HXݚ#h�����1�_I۶��0s�[m,Ѹ��I�5��k�/�?_���J)��G�      �   �   x�]P;N1�7���JpDAMKc9�����IV�HT�{1�,B�ʙ�؞���x���<��ᗧ]R8n�ȈЌ�g�'נF�]�B������<��@(�ycI��s�3�E�H�g

? ��X�lQu�6\x�A��Pa�hus���+�r�^�s�L�	hD�-�t蹫���`�v���gB�o2z���'�^�Jc��Ƴ�$5Z��R9w�*�[�L�<~u��s�+k�F      �     x���r�6�^}���x�(K���;�����t��g�w��7)S�J�V?�I��!g$j���SJî�0�IР��>t�rk(���d�ix[5�!�
	$#�[d6#_��6�B����o��+��*q�-O�(��L�p�P�3	:s�9�w�\w�)P*���̉Gb 偨�n�xp�gBeQ+R��Ҙ�3/�){�#�;���f����Sf��o�&�Ǚ���+��ѡ۶3Eە=��*/Wq$Y�-�Βܴ����x��Y��30����ӹ��sg�;��"�=P�]��q$M!�P6�&��zCP(k2�]2 >SK֎� ����/׷7wȇəO�:��} @/d�X�0et��(gIE�(4���(,�����s�n����Ų?��j�����4#�\ʼ�7h91s�Q�:L��3	qd����8�8g�'s�D�� �80.�J3���P���W|�P�?0Ք��A銦�h<ȡ.�C]"p�+���TQ� .a���a.D싑�W�BxX
'��ss"u[�(��K<����{u����g����^��s�j����\C���s�cz��'4�PS����I�����'s١�p߾`z���LW�����Ǫ��-\�%K �`f#f{*��Om�%�x-@r����i���R�],�Om����#œ�=�>d2W���׿���}Y��<����wO޼�xB.����a�r�\mv�&�w���Ual���U�>Z]��'��:D���휟|��xQ��"�K�p�XŎ�|���yg�mk0�O��K��k������|%�h۲mP�*�4ҘQ��2� ���`�C%plӣ�/ �S_|����T|NX���� ��ps0���ZD{�������9EY��}56�q0T�x�aWn���4�z��l��O�d��W���:^�������U~�x~�P��8�J&��\��j��5�hZ|�,���XE}�R_��h��8�����Q��2�ͨ uJ�	'L*YPh%�qQ�)�����4w�y�c��N{���ҕ"��ƾ�)�-P\�'�7�]������MӜ/�eؐ��@�-~^^^����vؾ��
d�L�q�/�H���]��L��z��<�����wq8G�qx><�b1�2�ky��`>^�i��P�mY� �e�Ϡ��n2ܲ|Sf�Y�@��@�dG\�x �7��ޘKU����$�� �@ĠRl���|W}��J�X�o*��w��;
W��[���A��`�1���T~��	C�wmhl�v�߁.R�?A��7W�_�.Gq����]l(R���J-�|�j��ڜ�~�a�kKW�n�$w��'��]�x�N�i���^ƞ�6���.x��o��q&]�e�hN�b�Giq}@�6��<�N�=2ݶ�K�1����J�lN�(A]��q,	DtE��2��c�����U bםR846ڷ�;��y�l4­��K��b�r[�8]��ݷ�}���gS��_���9��~J��WĎ���c�P�;��s��tV�?o����ȧ�v      �   �  x��V[�� �6{�=��������:����t��G�s@
�N�Z�'��1:��-�v��J�q:����}y�aqK(y���V�R�V)����wH��XW��O��jN��B��5w^����Jv]�gdx�U9������8� ����$��0�d��h��rF��/EHKQ�/��l�q`s�ȏ�	�B�KsT�4�5��[#�YBR��^�6��㋲�ۥ�o�gh�c@L�9�����ڨ/m$xT��>L)�L���m"�.����)9%��8	9��u��<>'�q~��I2՞����ҙp(�U	q����&doX�R�l� �����u��#��*��t�`�u���۬�+A"K �4�;װ-�I�]4W��$��dp���1��E��Ln�G�,�kFL�8;I��G@B�ܹx�w��UU֗6����RL���\���ZӣSd]�#W�8�,�����)ANm�Vh�g�39Y�3:7��Y9�b*�J�ʻ��ˏ�T�#�U��*K�@@V��V_5��i��Qe��W��`6��V���r�:,��.��G�"P`Zo�K�*�E謴
m��@� �mҜ#��^��o`SE5�-AK���8�_W�O      �   "   x�3�(��K�,H��2���,ILN����� j�#      �   �  x���Kn�0���)|���p�\�E� �*`����h�@�=W�Ћ�zS������������B^\s� ��X?>�L�z'�G��c�O����ş�}]�.��q9�]J�ES 9	��߾���r�q/������+(�A@���}<���{����K��.��_D���xa	>/�NT$�]Y�U��.|=T��h��,~�������$!)��ϲ������x�:�逘h��*+ˣ4O�p��OC�� ��@��jfG�8w����8����*���4���NA���z���u��#�0B��P��m9`��k��P#÷��@�t�����9Fn��z�	�^�~��)�&�]�k#r�(vҷ���t� �h��E"�=S�a^�C�⯵K�L `�{��GD�-���|	�FBłL���%ī�G��F�j�f�~o1����0���<l�!�[�����0������pJ�?��ehw A
��5�y{�~�Sq,F��" �m�@^�rv ���".���N��A��OzN�I�V�ҊZ����I*�K�j��H�z��Tl�L�7��v	np	np	np	��%��%��%��%��%��G�Gh	q ����5�ϩ����`ѵ�2�^=&"h�{~���C��mw.6P�ׄ�|��[������5���)��p�WeO��N\½h�qo�]A�>�{d�uu���7�a�f.n9S��xs?��} ��AM7��vI��/�z)N�����k�]Sr�\f�86�q�v||����x�a�n�"�E��*��@PŁ@J�ς�9�ʁt*!ŗ��3���3���&=s�$l�p)B�.���d�$T�H�C�T�&���$��ԘT6�r�fl�\L8<{D��d�.i4�2r�Jyj���DI��V���h�g�n!����鉅����i��d�J�^��v
�_#�(���6\����`L3���P�Y\zA�������?�9�      �   A  x����n�FE�����ztu7Wd�E��.ZRf�aH����m�#Q�h��΀���zܺE�6�n��u_�ׇ/_�m����u���r�.���b9���mEVY��*��O>?��(7>6"������
���nҸ�����:'��T������r�����b�m����w���cP�b�)��0
�dz�c�Pj8�1x��:�Wϔ)p�r�Ϸ�rq ���U���&P�C�H�>D��xs͒���q�x�R�!��G�ɥ	��Zxy(K�k��1L�H�ލ�(�䑹Q_GӬ��y��̣��h��g��&�  S��p�cN�?R���~�P#mL�H��ح	�$�z��O@�O�f�f�F����Hǁ��y�*�5^Ό0�#�'!�2�����0����&��ub�%�<9��KO�oW��G<����!b/5W��{��ޮ��y���vG���3o��	V3[�Q����H�%�G��O#�� c�oT�Hrd��`>G�!�2&��s��HU���쵤�?�q�j�F	jb��A�����[�L)k�f�K���)�,�q�J�[s�l(�M+6��[RsY��!��8>��xI���>R-���޿v�ҷC�j��y
����xs��?�c	R���t�W�t�"�j���}�����~p.)Q�bw�Pc��p)̰>�~�T\��o��P
�_n/���Bi���Ў�OȟS$L��ɉMF�wH�lz�4�RjN⇪�A���z�Ť"�T-��~�c��ݲK��1;�QCT����$���2��[��9�V�9��x��:z�c�J,�]|�1>�p�\�"��P)Xn?��$6|<���DȤ�R����)T�6���-�?Ni�}O0o�PeV/�ۀ#���j5�m�ߖ�ݾ��CTD�^�R,��0��S��px���v��B�u��NLT�ɍ�:EE���W� �8x��a�C�9y���ߖ߻M�o���Mw���^�oH*{�ܫ�� ������
r��kY{�F���¹�G�z 2����0�{5@T��7����g�;�k\����f[�?`1�c�1a� �+0@�D}v!<�$QF��&�MX�m��K�V�+�~ٮ���f?� zJ'�j�%�2�c��>�hpY�E!�u0I	�8[P�3���ĩ!����ȅ��=��e�iYBރ7�`�қ<hp	�Jo4�r�\���H��aa�ڕ�3?1�Q&Z>X���ɍ��ϐ\�`�F3�sv�6ED��wL�?y���h#X/Ŝ�{��<��8p��Q(�ǜ0�A��T-�M2��M�jVܚ�8�>r�����s��F�e      �   b   x�Mͻ@P й���l0؍i��
�\e�������иS�LW�	xY��1�'f�L�@�2	��C���_5�BX@�vЬW�%Գ>�g�G]��7D.,      �      x��]K�7�>S��{V�L�x�ؚ؉��g-��R��X�m�5d�c��������l3Q|TUdU���:�-��ߗ	 _H r��~��<>/7۟7/%}����y�ݗ����[>����/��r�T.���>��߇��r�����PB�{��+\J�vP���I��]H������r�y^��|)�6������o�������_���_���e���ȼ��=l~���E�B���Q�.�8�P�d���^�?����
��ra�B�����.��e�=��������v����)�,$8~�Pဪ������f�ٿ����.�F��<�N��fa-!%�uI+-}��޾�I��fSx㜴,-��u�F����:�+�V����,�&��L��xEH4��;�4�E�*@3~��������� ��B$��3�u���6�`��ç��˒5 c�@�$�1������
�`�u�P@МT�	+���Z����0~^�W�R9�Ki�Rb��=��e!�J���1�� �ikF��&cB��=�A>��V����^����e�{�o;��fT�P�~I�X�0�	�sM����Tn�Tg�YĠz�XЪ��������Fj�g�����,��ڄ���Bp�9+?]6�Tr�v%Ta����T�E�g��A�J��	+Y6��� ��\�M"Z��f�$��Π��jo��@j�Rg�`Z��ʹ���hi�Nra�PI�^ȥ$��@xkD��,�����ma����u.�a�v�BB+�GO�/I�g	�j�ɜ(C�t{��3:�.៫(�����9|�zƅ��+L�K�R��.IY!�����upI�!��p�1j���ׇ��*i���,/�����R��p:mjBOd�N`�~�p
l�eOs���;�+,�Q��)�
X�	FM"��c5�3��.%i�㗳H�.�w{���oʟ7�cŪ i}PbR����Y�qf��5����Ӻ@Gv����M��$���!ɠpJZ�\�6�6E��o�9�QrԏRx9���[̓�֥բP
H�!��2,�u��.���u��Yb9~i^W��5`!X{%O�b��",��
%���[����Ë!7�Rb�ԹĂ�����Qai�BYxi�g[�88����F�[Q: �Rj
ji:��$��R=.�pj��-�b�$E�(Vd��B�I�Fl��]�K�]��{����B�!��Mp�
<},��O��ԍِQ�7�PX6}���(�Aq�e�G�tg �wv&z���F{�
�� %{��>��y�I��lU�5� ��,�`d�Q�S<���������A����rZ#UU�RU���&O0\���˅�!u�	�3��mX@3�����'.�?a5����^6�>�/?ov�ҏ9�xBp�,'cʟ�G�������6��.F��\�4$��)+.��2�t!�qZ�Ӕ��/@%���/D��U�F���.��R/�c�"�Y/y��tt�$�d��bH{�Aq^'��8��&ce�Ѐ��J򐄋5���>"[�ǔ1ȇ�	:ggB�U������U4��Z�A�CHL5v8�X���pO���\~�+�.�N&EL��$�[$`�!�Tƅ5�GƮ#*A�5�Y:£`���&�O,| P�$}`��2�J�V|K�f\���Aa����[le����B�bِ�&�i8��P}���	�ç��_7���J�rd��t![���s4���΍�A��
i�ԣ9j����u89W�����P���Et��M8�S�n����?6/��2�>�7�Ajr�q��e�m������n�O��w��uM���2r��-M����VL��u���?��z,[��Qu�jc%4'���;�/t�E`-yOZ�Jb�{+t��&�綈 "�+r1�QX�@��h�;�0!��Y��z)w��ן�]?��} ��>��d�*����|z~YW�����+ٽ��(�_?mh��Ǔ���VXP��˟8��T$q����A���O[��m���|z}H������剏���5%�!-��Ԧ�`+U݋�yTM��\����e�P��?}y**�	�&�c�����W_�'Zd�/U�R�6��z߃��>=�ҏSb�ͽ^�ÊH�-I�{sZQ ����0�	#�G�з$�V(��I�[��"��h�ޒ��X�$��H�*Nv���$����I��� ���u���~,׳�0%o� Ż�<_��ɢQ72�	��F�I�X�ᜊ��f�{���i��u�ʨ��٤�W���Z�"�C��+@iBƂ�ALէ�nv�j�Q�E *l �N�W��^���	�Z�y�/yq�0�0 �����0rb���<����+e�Rh��qĆF;���!hJ�^Sa7��A�l��=�_Շ���p�?ʳ�&�=5��>���>�q�npL8����[,�>��K?Ӈ։*�4p)mp��w¹��17���xZ�%A�}���(9@�� '�&��Fj��|��v\�r�T��F��딳CQ(4�3��pF����.����3p��=���pGx2l	U��f�϶|�e��}�� הήT(�s���}�a耗���HW�a�)��2��5�u���c)/C6��v���Èu٦�
-��ʠ����l�M��M��pf%-MKC�,���#ؐ"\R����ڰ�Q�;ӲgC6"��j ����m��	�6����&W���x�1��b������O��_q��:�߬�Vf�f�P�Z���!u�S��K�BM�R��NMO��1���Cu���T��V��{��卛xUנ:�{�G�}��+܈޹U/�;,}�'Z�|��Q��b��DPa��b5%��7��}T66�����Ƃ�h��5�K\VX������:���+�%f�D�4*Y���ԡ$�(ޟ��2��[:8�
�����p��E�ϧ4x�UR�ݎ���C��e��ቛ���S��G75{�\Z�5����K���ޟ�Ջ��v,^�^hP�r������:�j(l���y6f��H������Qd��!EB���QL�X�ay7���Q�i��7Hm~ꐱ���8����B�M�mdl Lf�,!c�ۧa�@'r���N���d��$)h���Gb��Nd}rL�1N@��M3É�N�μ�EҜa��q�4׹{��n�����n�?��yUp���M��Wo#��to)�}f��ݬ7�M��q��`�Ҹ��j����MT�;Қ���;yT����{N�-����d�_-���)���K��l
��TDm��[S�v{����a|���D��=�7���7[�Q�N�%Ԫ��ӆ&A��������rχݮڳ�Ǫ����j�k��U?]e���z/�v�E@��L�x�=]��cv����*��c8 )����V�T��;0�t��k|J&��uϴCڠ�s��u�:�ޖ�!�WR�m\4�s`�{���4
<����j?�z;Z�xa��fշ75�12�*PgcoK�o�Q*��~��y-��`h@��d�����H΂�W���DQ�C�v~���XMW˴$��`�(�t4l�
/:�; ��䩉�GC/ �$�O%n��3gRx�5������>�<�ލ��U�rn^�U�;�8�R��`�̪:��Ԝ� ��x��P#�r�>�{	��d����*��p+V/a4/pyS�������y�7CR���Z�#���,Z2�^ȶL�䑙S�;�Rh'p�+!�|���
�~
��:)�m� �z����Q���{hvx>\(��wq�
6)��1�y�䫐������M]�mu5a����X��4��e\,�$��=Qz�(����03"E�Q
#]T��I��
���1���tC�+ ⹈�/�𒹌�������x�*�M�	�LZ!,�+�m-6������jTC�ꈗdV5>��&'�^�V�q�',~�|�dR�Z�v!�`�%c�k��;{�c��f����oD0'�媱Mr�I�B+��qE�A�����0��<���u�|��|�: �
  �"�0WgT��q��/�c#Q��S�~��|��i�uk��.������tSL{#�U��H�3��bPޭ�ζL����P@	?O�,W���^b��̡�
�B�aڐm@� f�9�̷��_�����^L���N�dtb���fe��N4+��RҬ������9�����3��}
�L�Q�2�#g��5K���Y׏�����S9V�_9��qΪ�I+A�2����YVAfVf7�܍H�^�mޙ�A��M|B�3֞`��4���n�\���a�\V�=!uw���T�7k�]R
��x�uMsXߗ�ܯt��QED����D_���]��
!�3*�W���H"�{m1�WRͽ����5�h����H"�yP2֗�m�v$M����43�lG�Z��	��2w3���G��ˌe��&�aI,�Z��3��N�����>'�XIL;��������껵���)65������S����q�G�� 2�� xYH��е���O۷1hu�ZRB�_��j�P>n�3�]
���롤}�?���_h��p*4���X~��y�������!q%]�}���/��n�<�h�:4��~�Ui}��t�h��M�]�A��ڪ"(��Z�RZ��W����s_�0шL}I�4�y�Y�)h�~�:,�h܈����!���@r!�9*�������A��f�~v� V�h��(�0F����y?#m8�y>G�H�`�-��Q��̶�M�u�y�BP�d����)G�G��[�7��듲�x��5�v�m�/��ఴ����q/;�_��:��F[D�������������?|����n���l��ec`���t��G�Gk�B��yy�Ը�9W��#:h4�&g����=����=�����]�y�[�:�HYD� WZ^Ԅ�L ����njp+�\b�մ��_f�=z�j���2����R��,�PuϮ�O�@򞽾�Iޭ�{�pg�n܊�$���6��*kw�XШ��V��#��I���Dʄ��Wތ2e�iV֎ɟ�g��|R�V:Qf�[�oH�V��=! M��rF�D�ӗ3�>� ���ї-�8�c� �?��X�T��=퐞J���+=�R�m�����i� �ů?����F������+aVR`9!\��z$�����꩔3|�ە���T�gpf0���&Mm^�����u�kuܪ�L���o�WG�j�(E+�`'����*Sm�O���Ӻo�#-"TtawHK�����Q��W�M��{S'��~޿<����cd~�D�g�.�o�Z��k�X.��������C�焜ץ� �a����0��gW����~G8�Ãļ��K���t㚡~�����
�JQL��waGQ�W�t�p��[���ЄB����x1o�1��J�<���7G �of��Ĝ`�Y�Q��'E�������=u��P�i޻��y3A����jj3��.�v�g�M��L��!b���b���F�cx[��m?�Ebc�9��M�>�:�-����Z'�K� ��|R^+��b�Aʞ���C��f�����K�UT����q�k���
T�QqQ���p�����̸��j ���+�<�:���"9��滥'#6��8U�x�"�BK�)�pp��$k����1*��0��6F�Υ*�7.C�V���Ek�Fi/�"Ї����O���%r�����T�"�t�PJ�+5��Uՙ4����Ǵ/粁1�7i�����˛�Q�S��c�A�1�6	b�&�@m�m7�c$]kN�t��^�!nI���&��Mҋ�D��ֶ3Ӓ2�EdZ���[��Od�]�&��2I���"����>_��rJ�l��IjN�\.N+n�J�{�uK�^�ىU=���5:�f����ύ��[�O��M�?�)���W(�<����Ȑɘ�ɸq��e8�B{��U��#Eʮ%�齭uF,"H�C�j>�/�bP8�fm=|͝�|�Y}`�dZ}�2u�鶢6�`�4Z�?������BW�B��aq��ux��,�����AM�5�"F�a_SQ�G��`t8���)�V]��i�>G�N�x<����m
s��d$_6�R�HoM<tҮ�� �i�&NhX��\��>ڈ��M4�Np�c�su���������n�bj���f�6��LT��_�3�dt8��d�߳;�ʘ���K5�u��V��'�f�:�lz���5�ٴ*��2�Gu�b�T߮ۖIS��c���\�xjQc�J n)�&�_�eF7�X*�2q��2)�ֳ���%����F:�8E��h����8@���I�s������A����h5�|$f_[�z[O�/���X.�X����u=�ĝO�)�i�T��f�Q��N Ʈ�p.W

J�� �Ԩ`�Xg��E0�������~,#4DnE�����:���c�8c��v���-hYH�XNS�8�Oz��������|jL���9�Z���.}��f�3s�4?͵}m�\��*��]��ja�� �4�^��]���r��vȞ�1�DV��&c1�h��F�+���h��>xSί���?���GT$�L�S�I���'�{������&X�P��ZH�$2���oa_Y��4��LN8�s�7�Wn����E�Ѽ0Zy�������8�2�R0BS�, L�zif�ӕiR�*0�^mV�����E��K��ݻ��:      �   I  x���[��0E��UhE=�Ww�0X�I�Ȓ!�3@��%tc�^I��.�/'uxE����;�QG�`�f����)}�xi@j{t~�A;+�7Gmءұ?���@�Gm	���N���9y7i�)n��`�z����уr>��
X���&�Mx%0NW)m�@�8�<��%�R����QN�,�|� ���N� g������m�GP=����|�W�>�V��Vzg��T#3��Rg��y����y���E���]mbprMI��	J����6*%��G	}^���GC�IV����'zmO�{a5�o(���x�G����ؤ���LQc�S��;Qo+'���z��*�@/=N��2{f1zeEt���q%�e?͆fg�p���������.≝6�����,��E��`ȬC7N��]�B��^*����W�v�2�Ჰ��m�׉�����G+���<�@]��,��oF��*�v�b�כ`��j���bl�j������
F��t�E����L��󻲍�H�1��j1Jv�蝭�./�_�l{� :�j.~/�R㓚~8�p	b�Z�c0�*�38�+��:|B���      �      x��W�n7=�_�@�1D��[�4E�E�����^7kov�]�E�G��^�c�DI3�Ho̷"9Bn���劉�0��s�K>�����zt�p���E�n|�n�O��_���x�{����g�+8z���Q�.��u?�n-:�3�hb�
vD5Zߔ-��n��`j�ɽ��Ys�����������r�w�wۻmC H+�O�����E�P���)���y��0'^�������05*)\��0��}@��.@t�������t��ʞ �S2���`�����6�QH�4
�97�ň�s1Z1їk���`�`����+�lY�<�4�G�s�p�$,���O؞�#1�)R
� ��j)*@c����j�:��~�m?�+�I)'T\"Q5"��
0v ���|���?E3dָnd��u!��2A�ׁ������aF<����Hi~�F]����@a�,]m���D�|�R�ޏޗ?��^H���Y�XBr/��O�|C��TFF�C.�օͳ�q�B���}���:��i�&I!�:R�2(nF�����㕦�0�@�x@�IY��+�W�W��`# 2R�KLR�r�2V���#�&9�8�� �Qb�<b_���Z�Ҫ�
��Gɢy����cXȽڙw"������0��C��6��K��㱵���!T�,�QBI�s�T~ݸr4JY|�޸�A����k�'M�C��->�ޞG굽 *~�0�JOT����y�%"�-|[u��zw�;6�^M�\���^5�Ka.;���t�x2���"�u2")wJ����ߊ�� ����!2Q�%/��(��R+ʆ���BY�Y�:��ע
5�����4�m��q��hK-�S��4o��~��>ts��q�!��9��|r(����Z��r�����u��Q�ʵ
�J��_C[�eă,�k�d��%�>Ӎ�~F�ú�(�ۻ?�<;��ϕ���k��X˺*����)/K�W��ꔫ�H7���F�2�c[�`ME�����,�|e�CX�K=�<֧QR���#*Em����g��<���"K�W��\I�D�c�Āەam���W��y�]�ʔ��KU�,va���)!����/��h٥�5O ��H>����o���M%�2��ktbt	z�K2{��⻱���HjzN�i�W�.o[��D�QQ�-ۓ��Q"�FѲJOf��ӥ�2��C۞��d^���Lr�L��/�wܹ��Hm.�*�cнȮ@����y;�&��JX�:s5~iv���d*cT�b��\s�.��i{�ޞzrAB�G"KZ�\�,~�N���,<�+WQj�Z�h^�YW�
�At~���Ǚ:��	�pKM��TK\ۍ�2��(�~��bQ�}R<�'W��V��8j�:����� ���oڧ]���0�`i��n¸Y���z{���0]V�6����Ib��z�,��طX� �թ.�#���������F�f����*[4:>�:ڣ�[���.���=-]0V�%2�ז����͎t¥��e�����x��oL3j�j|.��Qi���Ŀ�����[��      �   \  x�uS�n�0����B�y�A�*�a$p� �=j��A�2�4`����ܥՏeH����˙���F}��5u��瘬����hM�쵷)��p�Mq�d�S
�cMc�6���ZU�oϚSu� �#l��䀀"��]����C\�$O� �*�a�q~��U�>~1���y��昮h�"f
��>��p&��nI��HG���b��Ҽzb�~��v�%�#��Ą]d��Ll���rOI�z
(������w 26x�tXB}f�YI�5�O���B�9=�=E�f���J�;J6���pC'���n�ေ�U��b�F��7�_�����|�  �B_��͛���W�¿j�$��2;��b�Q��J�Yj��x�I�z6	=�rL��N�[��i!d�b�X���>\���l6�_b>�UM}�i�����Kαڲ�e1#�	����Z�~p�y��-����`Rv�����XV�@�L����V}������@�X$bP2qK�q�.����G ��)x;�D�w��zy����S
0�Y�!�?�
E�9Ug%6zO�mW���b!z�uAZ�\G�ʖ����� �k��n��m�4 ��       �   A   x�3�(�/�L-I,���2��/H-JL�/RHIUHN�-��2�tL����,.�K�e�%'r��qqq ���      �   r   x����0�V1���ý��:���ì���p�ь����)g���҉�Q�Oe��`t�N�@
��؍=��T�Ӫ��-�i�d�I�K�h��ӆ�7�V}GU�X�      �     x�U��n�0Eg�+��%�9m�.�������%Cr2��K�~(�!u�H�j679�[���^��h;k����N���*�X÷���(9Dl��*-|]��v�T +�@"�vJd�(D^�8]�+de6a��f�Ҭ�FO�TB����:���m����5�E.�H�<�tل��O�(\ �C^�t!�	�?���X�������q����`Ne�=J��_�ܓ�����S(�Eu(�N5�􇫼�����a�e�GX���(�����ꠤ�
m,$�R�yB�?}%��      �   �   x�%̻�0F���� R�3���ʆTY�K����x}(�g���Q�(G�p+��@�:�ט�V8	G��}/~�5.�B<[ȉ68�W�l���Vs���;�1�ECz����2�sh�Sa�3��AL���>#��c,�      �   &  x��V���6������)�w�dR�\��ʒ%k��G��ry�)Ҧ�@����h=���#�� Bi�4!�p��cO�!���|��`T$*#*'��^6=W�Ǝ���r<��z,d	��`���z������u�A$�m�,� �!����{�����V̉�����C�`Kq0-<:��˔�!1���M�#OO���g:')<'<����3�����r��6�Ĥ˔�S2�@
~���b��C\����	��.cB- ��l�����a�ll6ē���h�'�
�b���i�\�&�
��?t� %��%�E�%100��ȌP�"�G� �SC@�n�fC���k,̐]g�N�/@4@�b�.S8!Ärt��c�V���q�ߍ�R�mh��p�0�iӲ-��9��B%�����Ҿ�oik۱���^%�����g� {~.�Y�fc�t�[�?�x�1�W����Q]�GWa�<��E��_��%8�<"�;�&Rj�m��!����c�������R+�T�ކ:��븕|����<��|fVjxP���I�ۨ�l�&q����(��Q.���b���d�;@�Ԉ��x=�M�<��<����\|;m��~�������G	�"S�JP�
>*���KλsQ����WJqx�F���u�6C�A�M�Y{�5:[�.�QXҗoe-�N���_hFYn�J�;ج���?/�ЃA��M���^m�!`���Q(�f�=�|�y(���Юf�q��AG-3����. �*����u����c�H�C�4[�c�8�ͤ9�����t��N�S_We?T�LDQ�]��Z�5VA*\�<��*z�=og������o��5��h��)*�9�+���]��ש�-B4�����wU�#qp��S�rlz�l}�����ҩ���VI8oܚ̏^��t�C�V!H�]��&n�q�)B-5)���cV-^.�Gw�:�	��pd�,豢�>���ӕ(��$嬅-��#ᦇ,b v���= �O&��W�Ix�|O_`��Z+\^�W���|��$ɿ�h}�      �   l   x�3�K�+ITHIUHNL;��Ӑˈӿ�(��2�HL�/VHTH��IL�/JL�/J-�4�2�tK-*��ɬJ�+��r�$��f&g�$�g�%A�@)3��F\1z\\\ A*#}      �      x�3���K/J-��2�tO,.������ O�      �   �   x�M�K
�0���"'P�>�u
R� n~�Ж&�$�<� z��b��v������Y$q���6K��I���[�^�։J��xw���mň(��tl�GS"�Gǅ�"U�׽��L�ل~,hc��a}y��<�^���,~e��!N_��@�uCD�@�      �   Q   x�3����K�,)M�2�<�X���e��X��e�钚W�����e���[�Z�XRZ��e�P���Y�Y���yxsW� _��      �     x�E�[�!�����/{���c$	��6G�D��}�|l���k~Z�m=KG>���~��Rs���̽�0�(�ghM��T�*��,�_X��w�����Xw4*�u�C��l �Q +�'�����aG
 v�H|p�A�!��� ��!p�� ��������p`�90b`b p0p p �;9��9"rL)f ~�D�й��OԢ�C��з>���S���>���Zs���4�L@��g�ev9�e� &H��c"������VANlo>(��"y�8A�2|*A�&�t)��!��R,ԔX�V`�jM��(�����˫q��7�ٷ�|�픙6ܼ�Vo��Vbߎy~/�^gBQ{I�2��c�&��n��G%�U�؅���B��ŀ�
��ƨ,%1�S_Uߓ���Y���=�!I)1����^z)T9�*��,]e~��O`{W����U��"*�͋>d���ͫ>d�9���ҡ�1Z�h���QR��R��R��R��R��R����PT�T&�K*�%�����EuI墺�rQ]R��.�\T�T��-��՚\p�+�]�8���j���b6Y~\^
��sM�EY��1*`!���Ň�Tz+��EEr�`�/��������U*�b�spa����׃S�2�ىR��W7���z�������(�_7�G�Z2~� y<D�T�P�#��S!�m���^!��[���z셶��m]=�m������k�����Ց+�Ϝ��&v���U����7{��Zx���;��K��e�j��-�$�Q�d�(��O���z$��^gp-�;��e��E�6r�<��í`4���l�>�'i/��?+Yy�<x-fh�Z�[ߞ_��Pe�	�P�؅}�Dهv�c��Q�zh+��K��mh�uծ���6ֵ������j�,�zj�[�?�y=��k7���jC������Y�fZ]��7�����|���mk��e�|7�4�e�3OqLgb�4�%<��������G(<��?�������      �      x��{Ɏ�ږ�X�+r���+���[Q{�E���'��C<�7ԏ���|��n�GF&"�r�ݮ��!�v=ؾ�MS��PUC9Q����M�ş~]��n�����@r_���0�����[�o���<��yuf��x���!���=��E?�7M
��F/T}q�+���YS�f6����w6��`}�� n�Gǰ����ڎo � ��������@�ݺK����k�)-�Ŀ��ˡ���g���ȸF�opm�qA%������8�)��p�����w�@M��(��]"꾇��,<�����i���r����a���-xacXe�0�A�]��N{�����w.�$�F�щ���'Q� j�C���M(�w0.�F�ѢYn�4�F�ri�f����߯�A`�w_��û���uЦ����+Vpի�P/��В�Gl����Y�e��
�\C�@�r���K0f�#a{����+t'���a闶Q�����;8��y�,��|�ll �q�i��O���JJ�d0@y1�r���g��m㊌�_�`�wl@A�C�����A�;@�YW�Ε�� Z^�ǧ�g��Rx>��\C���Q>
%`cz�I��6�ͺ�	��}�wӸm]?p��e@e�9�L���x�༅�L����*׎��Nx�P���v�������Έ#��כ�����.94Ӂ�
}C�l`�v�.Z�Y���S*E�W�������M޼^1�Q%w5|��uW�7B����]=a���������5�k���F�.�zU�����H0�nq�MT�C2�b�1=��E<���7���z�'���0��勸>ʢ�}[��j}�YX�դN�X����-j5�	|*����:l_�ZP��X�{��Ӑ�By�k�n��O��K�i�?�@��5�1����b���iL|�����&}tl��|<�.��͍s��<�<)B����x9/���a5 B�4/p�/��m��wtd�>���B�7^A:g���^n.R�/^�2+y������٭�в�%W�3<��չl�Bno+� �Ԙ�Tz�G�J�G�A�#����QJ`�r��7Y���Ha8걛����`�.�� ߲�N�ͥe��������<�g�ZڞD��5}g aA�]�x_D���̟Ѝ��]5݃����7k�SV*���j�{7!��G����\�^��.�G��-_÷�Y����G�^q��7��z��[X�G����UF��-�W�P���׭+��;eبy/���$$yKf%0���D'޴1 ��Ď]
���1	���
�z�;ԛ�k�]ks[N��ɡz<8��b.[��v(���Oi��pp7���� ��&��4
�0�����y����~��
����J���!="yZ���U�����(�Y4i���B�Q�A1*9�B�	PL��qm�D��������dI8�*�l�Q뷾�u~�*%� �9>�h�	�s�XV���[���;���l�����N�B���u	�`h�=��* #�%��AhQ�L	'���;��T�<Ѧ��^� Rk���0Z�#�̃{��u1S<�U��p��S�eZ�xv�K}$#z�~3� -O������驿��m�u�|PN��A{#�(L�և��v��t��xy;'�җ�R��Ʊ�8+����A��
֙�b��,3W��7��x��h^_Tts���@t�4,���'	�}�n�O��= E��i�Gڹ���f ����f�qY�����2rR�"���v��
��_���w�:����F���?�:�G8�eS�������P�����&<�}{�ϫc�����yh\"����a�9��e7 �vc��G'�P(�=��M�~ ����a,j����������i�����粠����s^7�pX�x�e��'JQ���X��`�v�ry�	w��֝�_ؒJ���uO�����^�G��P?m�}�
'^�h��F�u^�I���` ��9q.)u^�i@�G�S�W3$���ݩ�֚�� �h;h8:��mC��^����萯Ep�����݉���\��3�����m��l:�:�
X&�]�7�q�9�����~���C�Ri�_�1��&u�˶/ �� ���$F�dC�;ϥI��F�M��*V��3�-��!^U�XW?���}�F�],�ޝǌ�R5t�]o�O��%�i ��>����n�o^��o�.t�������Y��
^��x�{Q�{Vp�L��0 DɄ�p��*�I��F9���.�w�2tV9	��Dz��/�F~O���
[J��K�Zs�jBl_ƹ����xp'}����Zxt���s\槙o�r�tƀ%W��W���GsQ��LsMHS?od�5Ŗ�������w�K36_i��+2�/X����+8�fP���t�����î�bva�뷧76��zGu�#Cؑ$A��$�z> .��c��KB\L�yY�1ާ�:�)Y"������I}u��5���VaVӢg�ݔ��Û8���"���ڍ��O4���݇1<���`*t��V~h����E9,V�JCL�y�H�K����dǝ*OA�RR}4O���(�Z�=�"D�TzC��&j|��ͺ�?[�Q��\��.|D@�?zh#$�"�C�>c]/�i�ڭ����N���a�b��!H<qa��=P���;�nb�ÙiBD��ܞ�W�m�� ��7d���E�yCY.o�_��uV`�N�|���wL�W�����Ψ����=.N&��m��eC�y[��WO�#���Y�E�k�(�oj�܋'� K;z�z?��>�
�_��hw�Z��:��B�=��p���dޤ�+���̷ˌ�K�l��Zh��Dzy)�_�4�RF�#����HF~t	��"���iF׵���"6:�V��ڞ:=��b���{��ܩ��@�k-�'�k�o�b|H����:C��40P�׸ I�NdfU��W���$��G�C �a$8�p@n�"��@����!���w������R��s[�be㽑H}��"�=��#�d�Xp�ʎv`���D1��q�8�<KҋRhҞ��*�YW�\&T�0�`���h��� �����V��KB�#���0��2�3G3���y����gN��5�-�v4��74,Hy��s�u(wU��gL�B\UW$��ߏ���!�>M��Ĕ�@�n��ք}	���@���cR��V67�����-��󱉯{Z� ��
����}h��|Ay�h[~���YY-q3D����@�j�/�6��/��'��.�$"���Ģb��F�ۇEU�=?K`��F4��LΩa�wLY�	���+7�� 0�3u�������ĺ��R�_ǔ?�0�i�[yNT.�,z��_{&xM�����0�sR���fs�8���;���܊6%z�e'ĀZ�$�J@��П��P��<HE>�:U�4��W�Ƌ7�5n⴩ΌZNh_��O;g�R}~��wg���Hy��)�����zE�^S�}�AT�	$7��Q��&W_)m�c�u�/E:{��9 �X�������fۨ�ijQ�hz��B�7��&r�	C���K�>k���~bF�E�p��m~�%6��B�鄮��b�r�����hs�GxA���,g���;5[	r�C��y�pR�;~0���⫿D�͋�Lf1�����̺֑x����f��4$��Ee�
�4=ƪc��,�����/�F�H���f�%�%�_���2��;�>��/т���kO;�T@��n����gp4oF�
ۼ�$�;�Y�
��yY�v�Ws��\hS���U=e4~:3Z�	p|��Z��~f	�_�O��ыCAc)e ��K7�����
#���l��u���p�Ƕ�����HF�^o|����	�R�א�¬�+��m���*m�*�>$�gs�[`�)T�4�ԾE&W��ypo��6��xy�`4�8�z�|�y��d~ůB�[u���Oy;KF��&��ܙS/e aʹ7p�    8���3�m����
]�c<�W!=d�I-�C_ ;�����H�� ���m���"�C��i��ڀ�����o?���$u��`[���{�xx�=L�ބ����x2DCmM��T�(��Ȟ/�T�7m? *���Z���9r�7^����K��@�p��0J�=����VA��:�\�,�^����F/4�*P��7C�����/:w�o��bQᚩ���Ts����0�wc�˸�QETW]���|V� �|�P�>$h3��b��9��
[�L1�������Q�ifZ��zmpa={2aQ����-b5��P$P�ͽ�]R�!1��n;
E=ib>^��E	��nFd'���ڕn�q~�GT��V��([�6�ܙ��6��Z����R����(\��N���X<�����˂!w����՗{;diQ�_��Z����v����Q��oqŹI�\w{���]6���I��B��A�Z��>ߙ[�]/Ϙ�b[��M���D���/��]o�j�����:�/��Wo�m5�8�	���|��p�}���^"��%/z��U�"�\�"ih��Lu TG6�H���p��6����?qb���e���ħv�֪P�������q�j{����k�� #��e����X>EZ�(\x^<ց��c���G��l���⼋ܬnܮ^�{����摎��D��0^@m�\���Ѡ��p�K���$�����s%��_�a��3���G�7�_���n#.��a�*��z�i��V:��_�T�Jک�����e�Y@��,��O������"2��"�E݄�V�]�-���T��GX���Í��gq��-������!�����A-���dc�x\�U�w@(�^t���F��-ŏJ�; ����guv�Z9%���c�0�wY����[�?16pc�},'H�GT�ʄ�)�}зd!��XgL�Ŏ^�k<��5����A�:Gf�s'��L,w���~ſ3��փտ|�e�&)F�e�0~�@�fh�z4�g�DRݕg��ɧ���� 3��\t����I�����n��}��|�}����P\�����U�^4�rπ<E�ɛ��tWl�����P�Yn�:�^-���=ي�U&vc��99�n=t?������B�z� �(J��ک��i���R5;�x���o�@b���1m%��^��R��~6o�I#4]=|iw�P��j|�I���k7������|���?���m��*N9|Bp�ƙ�Q��[�<����Ծ>E&C���*	"F�W��KR!��nwO��k��9/pusw&�D��i;�$ǁ"���H��*��Qϰ��X���a
p�A��?�4cJ5�w�T�a'���y��\�l#v�3�[�*�K09f	� �(�xu����e���oX�w��͊ι"3���t�N�@�^4���-�yZ�O�S����5ɍ�:�M	� ���D��m���S�TA\y��l<���m�L�'��j�W Pe��iK���W����6�]K�e�j�g��u��M�l��G�.+�>�(���L��4�,|ъ��� �k����A�+�9E]UJ����fk@Q�	v��):�e��@�u}�V�W�[Gn�՟�΂��lkC�g���g��D퟉���B	����8�Ȩ�KP�Z���ʈ��ˠ '7��������W����TYt;�r��'�p�F��5\�S�t݉��Nƈ�7���V�r�I��o\b'އ�٘���Is�m�B�/n�ñFhn�3����D� B��Gϋ�c��֕�����iL�����o�8�8��gU$����ϒX�|9rӒA���6�z�{�6�����?���qr���@,ƛKU���gS���Sd�k.ū*���y���H^�d��뀰rbm���� �\H�n�|�W?J��I��g+.��fV26+z�";�PH�$��(N~jQRnM�J�5��n	{�ۑHX}���8�(Dz׵K4�i����&U�mt��#f�+u�J��|��y4�5�]:�%��#�R���`'�֕��}��Um�u����w�3Xo�2q{��,޳�Ӽ�/]i�<b���f ��qta�|��F1'7���cf\Zؙ|��X������g>��M��}�![���}"�>�.�ȩ�s<����2[�S(���2vPhE��#t@��T^���Ht!��f����ӍZ"=��b(Y�i;����`�#��2T�5��Wu�L�����Y��J�ЇX�n����'�+)��:���K����j{0�.��Pe������ϒT�HD�im�.��S���`�����O�1��'4ˮ	6x���D�>Z�t�,j�!�
I9.Ⱥ�D)��1�)|.Uy�D����q��������G����Wo�Y�~�Ƿ��!BV���o�-��s�͏��Y����@c�Vwhܦ��KQ�G�	��c9G1��8/k��,QS^,0W*�^"5���^�Ly�������1�¹,��nsxl/p����K���ݏ���խԟ�������]�#�XB��z�N�gN��1@\U�O���l�~�5d.�nu\2J�.�L;@ ��Iv�(]��꾮R�-�9-?1s#x\T��?�D6�)l�����ᘄ�2wˊ��;�"�����q�) �Q�Q��ܹs���6�љ��Ѝac�D�
��/z��{�J2՗���Nk�Z�}�&U<�9�_*�%��{����i�37bMB �8�:��ahKR��Õ�=o���b9��|g���2�gXA��"�`�+�G�~(���-T	��z�j�
��&Y���T�wM� �{~�1�$ia�ג��_a;,r�I�z��,}��c b��2�H��2ڽ^�y"}�`�5JG��;�[�U_.�Vr�o��<�^I)�V-��0�qe��ATy&�6�>���l�G�'�m^~�,���W���}����A�m}�R�Oe޽�I����im����^�����g,��Qjer-\�C�O	}�sW������n���',[�[diS�g�_7�*�'�;#X�zV!�;�Z���r��p�{��]��z~Xl���e����o�I����6\	p.��>�s�Z��>� A��gh@E���+�
�.ܥ%7��y�s��Ӯ��a=~G�K���'l���w�q��L� ŋQI����nÖ�k�����QT�;2r\���Ƭ�#a���i��O� ��>��V��?��|�j���n�#oE�0�@�%��)��1�}��4�_����y3�|K�R�kH[T<%>�I�e9��^�MW!2__<��A��N�6�nn�J��RbC��6u��=o��hg��s��g�I��35�X]��9�K��&$���#D7N��>�a����)n=W� ��`:�z�7�Ю)0n�!O5�}�*&�ی�m=~�'[��\�|�/d,_�<$�J/�36͉���F��'�f۫��%���!D��S��BL[��@���;���$�Ұ���Q$��N�|�}�I��M΄f���L��	�Ғz�Ü¹{&��!WܙY4�k� ��&�� Z6��%�4��y�:WO��ٗ�.Ĕ��٣��|��z$�A�~?[1�z�"�	����kN�ۚI���d.�S
~�5 t��'��/�ERi�Wj�����Ƙۂ�����+OO�#_�ձ1�Jss'�;��[i�����kҪ�\�>3�S@�U�p�)/�`�Scmo#��\D�z���O ��
�>�ܽMoS	�#�{}��бIԠ����*��*��z/�&T���>��r����x��6G���_�蟏t̹g���2y��d6͒3��c�=Qy]�8;��R�(��f��=����ƙ#Е���<�+��BIeo<^)�(�X��|s��?0dg�xs�[1�b���/[(���H���D�$-�pK��g1�|�S�S{�MN�C�;vP[M�A8����X��RV�Ŀ�1rw���__J��b�6mX�2��3���O�Ē�0��v��z[���G<��x�kP��ٯ���B �  �O.߅��4��s˒H�����/Q�`�s��� 5�.�Լ�s�&��Zz�݌ukO,���U���+	�\������7jhA�B譈����l��F��X�b2Ƿ3m��GƋ���1iA�3����{XȜ�[��ڢ=��I.��^8Yϕ�$�����>q��U?z[Y��𙵪uk�!�&��W6��Za���'F,^WS�TD3�.�i�]��8�OS�
�U��~	 �����������̫h�	�n�B� �OD��{F��k��:�,�����Q8[��E[�W����������ׂ�����z�Ϧ.���Ϭ�!F�U}<�a��k�CT�L[��xHBw���u�~E��3�VG�QZaq�d�͎Z�[�]"
�z��E�ȡ��Hj7�h���Տs}/�[-���#GPh�r�{2���m<ߦt�%a�0"�*t�:�It�+4?��s��"Y�'TPKZ G��D|��.L}�gt�~�����͝�ח*�?}�o͇�@��̡��G�x�X�7N��!U���M�D��_#I%�G�LF���f�^�-x��?��,����黪�Oҫ��0/���o�-�����7��Ru�[$�(on<
[ȤW¸�vBO7W�#�G�j���$'�z.X��~R�C����?���?����[?��     