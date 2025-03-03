SET client_encoding = 'UTF8';

CREATE TABLE public.coffee_variety (
    coffee_variety_id integer NOT NULL,
    name character varying(50) NOT NULL
);

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

CREATE TABLE public.cultural_works (
    cultural_works_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255)
);

CREATE TABLE public.farm (
    farm_id integer NOT NULL,
    name character varying(100) NOT NULL,
    area numeric(10,2) NOT NULL,
    area_unit_id integer NOT NULL,
    status_id integer NOT NULL
);

CREATE TABLE public.flowering (
    flowering_id integer DEFAULT nextval('public.flowering_flowering_id_seq'::regclass) NOT NULL,
    plot_id integer NOT NULL,
    flowering_date date NOT NULL,
    harvest_date date,
    status_id integer NOT NULL,
    flowering_type_id integer NOT NULL
);

CREATE TABLE public.flowering_type (
    flowering_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);

CREATE TABLE public.health_checks (
    health_checks_id integer NOT NULL,
    check_date date NOT NULL,
    recommendation_id integer NOT NULL,
    prediction character varying(150) NOT NULL,
    cultural_work_tasks_id integer NOT NULL,
    status_id integer DEFAULT 35 NOT NULL
);

CREATE TABLE public.invitation (
    invitation_id integer NOT NULL,
    email character varying(150) NOT NULL,
    suggested_role character varying(50) NOT NULL,
    status_id integer DEFAULT 24 NOT NULL,
    farm_id integer NOT NULL,
    inviter_user_id integer NOT NULL,
    date timestamp without time zone NOT NULL
);

CREATE TABLE public.notification_type (
    notification_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);

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

CREATE TABLE public.permission (
    permission_id integer NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(50)
);

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

CREATE TABLE public.recommendation (
    recommendation_id integer NOT NULL,
    recommendation character varying(255) NOT NULL,
    name character varying(45) NOT NULL
);

CREATE TABLE public.role (
    role_id integer NOT NULL,
    name character varying(50) NOT NULL
);

CREATE TABLE public.role_permission (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);

CREATE TABLE public.status (
    status_id integer NOT NULL,
    name character varying(45) NOT NULL,
    status_type_id integer NOT NULL
);

CREATE TABLE public.status_type (
    status_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);

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

CREATE TABLE public.transaction_category (
    transaction_category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    transaction_type_id integer NOT NULL
);

CREATE TABLE public.transaction_type (
    transaction_type_id integer DEFAULT nextval('public.transaction_type_transaction_type_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL
);

CREATE TABLE public.unit_of_measure (
    unit_of_measure_id integer NOT NULL,
    name character varying(50) NOT NULL,
    abbreviation character varying(10) NOT NULL,
    unit_of_measure_type_id integer NOT NULL
);

CREATE TABLE public.unit_of_measure_type (
    unit_of_measure_type_id integer NOT NULL,
    name character varying(50) NOT NULL
);

CREATE TABLE public.user_role_farm (
    user_role_farm_id integer NOT NULL,
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    farm_id integer NOT NULL,
    status_id integer DEFAULT 22
);

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

ALTER TABLE ONLY public.cultural_work_tasks ALTER COLUMN cultural_work_tasks_id SET DEFAULT nextval('public.cultural_work_tasks_cultural_work_tasks_id_seq'::regclass);

ALTER TABLE ONLY public.farm ALTER COLUMN farm_id SET DEFAULT nextval('public.farm_farm_id_seq'::regclass);

ALTER TABLE ONLY public.flowering_type ALTER COLUMN flowering_type_id SET DEFAULT nextval('public.flowering_type_flowering_type_id_seq'::regclass);

ALTER TABLE ONLY public.health_checks ALTER COLUMN health_checks_id SET DEFAULT nextval('public.health_checks_id_seq'::regclass);

ALTER TABLE ONLY public.invitation ALTER COLUMN invitation_id SET DEFAULT nextval('public.invitation_invitation_id_seq'::regclass);

ALTER TABLE ONLY public.notification_type ALTER COLUMN notification_type_id SET DEFAULT nextval('public.notification_type_notification_type_id_seq'::regclass);

ALTER TABLE ONLY public.notifications ALTER COLUMN notifications_id SET DEFAULT nextval('public.notifications_notifications_id_seq'::regclass);

ALTER TABLE ONLY public.permission ALTER COLUMN permission_id SET DEFAULT nextval('public.permission_permission_id_seq'::regclass);

ALTER TABLE ONLY public.plot ALTER COLUMN plot_id SET DEFAULT nextval('public.plot_plot_id_seq'::regclass);

ALTER TABLE ONLY public.recommendation ALTER COLUMN recommendation_id SET DEFAULT nextval('public.recommendation_id_seq'::regclass);

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);

ALTER TABLE ONLY public.status ALTER COLUMN status_id SET DEFAULT nextval('public.status_status_id_seq'::regclass);

ALTER TABLE ONLY public.status_type ALTER COLUMN status_type_id SET DEFAULT nextval('public.status_type_status_type_id_seq'::regclass);

ALTER TABLE ONLY public.transaction_category ALTER COLUMN transaction_category_id SET DEFAULT nextval('public.transaction_category_transaction_category_id_seq'::regclass);

ALTER TABLE ONLY public.unit_of_measure ALTER COLUMN unit_of_measure_id SET DEFAULT nextval('public.unit_of_measure_unit_of_measure_id_seq'::regclass);

ALTER TABLE ONLY public.unit_of_measure_type ALTER COLUMN unit_of_measure_type_id SET DEFAULT nextval('public.unit_of_measure_type_unit_of_measure_type_id_seq'::regclass);

ALTER TABLE ONLY public.user_role_farm ALTER COLUMN user_role_farm_id SET DEFAULT nextval('public.user_role_farm_user_role_farm_id_seq'::regclass);

ALTER TABLE ONLY public.coffee_variety
    ADD CONSTRAINT coffee_variety_pkey PRIMARY KEY (coffee_variety_id);

ALTER TABLE ONLY public.cultural_works
    ADD CONSTRAINT cultural_works_pkey PRIMARY KEY (cultural_works_id);

ALTER TABLE ONLY public.farm
    ADD CONSTRAINT farm_pkey PRIMARY KEY (farm_id);

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT flowering_pkey PRIMARY KEY (flowering_id);

ALTER TABLE ONLY public.flowering_type
    ADD CONSTRAINT flowering_type_pkey PRIMARY KEY (flowering_type_id);

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT health_checks_pkey PRIMARY KEY (health_checks_id);

ALTER TABLE ONLY public.notification_type
    ADD CONSTRAINT notification_type_pkey PRIMARY KEY (notification_type_id);

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notifications_id);

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_name_key UNIQUE (name);

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT plot_pkey PRIMARY KEY (plot_id);

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (recommendation_id);

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (role_id, permission_id);

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (status_id);

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_pkey PRIMARY KEY (status_type_id);

ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT transaction_category_pkey PRIMARY KEY (transaction_category_id);

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);

ALTER TABLE ONLY public.transaction_type
    ADD CONSTRAINT transaction_type_pkey PRIMARY KEY (transaction_type_id);

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unique_abbreviation UNIQUE (abbreviation);

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT unique_cultural_work_tasks_id UNIQUE (cultural_work_tasks_id);

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (unit_of_measure_id);

ALTER TABLE ONLY public.unit_of_measure_type
    ADD CONSTRAINT unit_of_measure_type_pkey PRIMARY KEY (unit_of_measure_type_id);

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT user_role_farm_pkey PRIMARY KEY (user_role_farm_id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);

CREATE INDEX fk_flowering_plot1_idx ON public.flowering USING btree (plot_id);

CREATE INDEX fk_flowering_status1_idx ON public.flowering USING btree (status_id);

CREATE INDEX fk_invitation_farm1_idx ON public.invitation USING btree (farm_id);

CREATE INDEX fk_notifications_notification_type1_idx ON public.notifications USING btree (notification_type_id);

CREATE INDEX fk_notifications_user1_idx ON public.notifications USING btree (user_id);

CREATE INDEX fk_plot_coffee_variety1_idx ON public.plot USING btree (coffee_variety_id);

CREATE INDEX fk_plot_farm1_idx ON public.plot USING btree (farm_id);

CREATE INDEX fk_role_permissions_permissions1_idx ON public.role_permission USING btree (permission_id);

CREATE INDEX fk_role_permissions_roles1_idx ON public.role_permission USING btree (role_id);

CREATE INDEX fk_transaction_plot_id_idx ON public.transaction USING btree (plot_id);

CREATE INDEX fk_transaction_status_id_idx ON public.transaction USING btree (status_id);

CREATE INDEX fk_transaction_transaction_category_id_idx ON public.transaction USING btree (transaction_category_id);

CREATE INDEX fk_transaction_transaction_type_id_idx ON public.transaction USING btree (transaction_type_id);

CREATE INDEX fk_user_role_farm_farm1_idx ON public.user_role_farm USING btree (farm_id);

CREATE INDEX fk_user_role_farm_roles1_idx ON public.user_role_farm USING btree (role_id);

CREATE INDEX fk_user_role_farm_user1_idx ON public.user_role_farm USING btree (user_id);

CREATE INDEX idx_farm_area_unit_id ON public.farm USING btree (area_unit_id);

CREATE INDEX idx_status_status_type_id ON public.status USING btree (status_type_id);

CREATE INDEX idx_unit_of_measure_unit_of_measure_type_id ON public.unit_of_measure USING btree (unit_of_measure_type_id);

CREATE INDEX idx_users_status_id ON public.users USING btree (status_id);

CREATE INDEX ix_status_status_id ON public.status USING btree (status_id);

CREATE INDEX ix_status_type_status_type_id ON public.status_type USING btree (status_type_id);

CREATE INDEX ix_transaction_category_id ON public.transaction_category USING btree (transaction_category_id);

CREATE INDEX ix_transaction_type_id ON public.transaction_type USING btree (transaction_type_id);

CREATE TRIGGER cultural_work_tasks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.cultural_work_tasks FOR EACH ROW EXECUTE FUNCTION public.log_cultural_work_tasks_changes();

CREATE TRIGGER farm_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.farm FOR EACH ROW EXECUTE FUNCTION public.log_farm_changes();

CREATE TRIGGER health_checks_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.health_checks FOR EACH ROW EXECUTE FUNCTION public.log_health_checks_changes();

CREATE TRIGGER log_flowering_changes AFTER INSERT OR DELETE OR UPDATE ON public.flowering FOR EACH ROW EXECUTE FUNCTION public.log_flowering_changes();

CREATE TRIGGER plot_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.plot FOR EACH ROW EXECUTE FUNCTION public.log_plot_changes();

CREATE TRIGGER role_permission_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.role_permission FOR EACH ROW EXECUTE FUNCTION public.log_role_permission_changes();

CREATE TRIGGER transaction_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.transaction FOR EACH ROW EXECUTE FUNCTION public.log_transaction_changes();

CREATE TRIGGER users_audit_trigger AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.log_user_changes();

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_cultural_works FOREIGN KEY (cultural_works_id) REFERENCES public.cultural_works(cultural_works_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_plot FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.cultural_work_tasks
    ADD CONSTRAINT fk_cultural_work_tasks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_farm FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.farm
    ADD CONSTRAINT fk_farm_area_unit_id FOREIGN KEY (area_unit_id) REFERENCES public.unit_of_measure(unit_of_measure_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.flowering
    ADD CONSTRAINT fk_flowering_type_id FOREIGN KEY (flowering_type_id) REFERENCES public.flowering_type(flowering_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_cultural_work_tasks FOREIGN KEY (cultural_work_tasks_id) REFERENCES public.cultural_work_tasks(cultural_work_tasks_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_recommendation FOREIGN KEY (recommendation_id) REFERENCES public.recommendation(recommendation_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_health_checks_status FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT fk_invitation_user FOREIGN KEY (inviter_user_id) REFERENCES public.users(user_id);

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_notification_type_id FOREIGN KEY (notification_type_id) REFERENCES public.notification_type(notification_type_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notifications_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_coffee_variety_id FOREIGN KEY (coffee_variety_id) REFERENCES public.coffee_variety(coffee_variety_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_plot_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_permission_id FOREIGN KEY (permission_id) REFERENCES public.permission(permission_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fk_role_permission_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_status FOREIGN KEY (status_id) REFERENCES public.status(status_id);

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON DELETE RESTRICT;

ALTER TABLE ONLY public.status
    ADD CONSTRAINT fk_status_status_type_id FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_plot_id FOREIGN KEY (plot_id) REFERENCES public.plot(plot_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_category_id FOREIGN KEY (transaction_category_id) REFERENCES public.transaction_category(transaction_category_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_transaction_transaction_type_id FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.transaction_category
    ADD CONSTRAINT fk_transaction_type FOREIGN KEY (transaction_type_id) REFERENCES public.transaction_type(transaction_type_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.unit_of_measure
    ADD CONSTRAINT fk_unit_of_measure_unit_of_measure_type_id FOREIGN KEY (unit_of_measure_type_id) REFERENCES public.unit_of_measure_type(unit_of_measure_type_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_farm_id FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_role_id FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.user_role_farm
    ADD CONSTRAINT fk_user_role_farm_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_status_id FOREIGN KEY (status_id) REFERENCES public.status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_farm_id_fkey FOREIGN KEY (farm_id) REFERENCES public.farm(farm_id);

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_notification_type_id_fkey FOREIGN KEY (notification_type_id) REFERENCES public.notification_type(notification_type_id);

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(status_id);