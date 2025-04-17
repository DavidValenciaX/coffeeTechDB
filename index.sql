BEGIN;

-- Indexes for Foreign Keys and frequently queried columns

-- cultural_work_tasks
CREATE INDEX idx_cultural_work_tasks_cultural_works_id ON cultural_work_tasks(cultural_works_id);
CREATE INDEX idx_cultural_work_tasks_plot_id ON cultural_work_tasks(plot_id);
CREATE INDEX idx_cultural_work_tasks_collaborator_user_id ON cultural_work_tasks(collaborator_user_id);
CREATE INDEX idx_cultural_work_tasks_owner_user_id ON cultural_work_tasks(owner_user_id);
CREATE INDEX idx_cultural_work_tasks_status_id ON cultural_work_tasks(status_id);
CREATE INDEX idx_cultural_work_tasks_task_date ON cultural_work_tasks(task_date);

-- farm
CREATE INDEX idx_farm_area_unit_id ON farm(area_unit_id);
CREATE INDEX idx_farm_status_id ON farm(status_id);

-- flowering
CREATE INDEX idx_flowering_plot_id ON flowering(plot_id);
CREATE INDEX idx_flowering_status_id ON flowering(status_id);
CREATE INDEX idx_flowering_type_id ON flowering(flowering_type_id);
CREATE INDEX idx_flowering_flowering_date ON flowering(flowering_date);
CREATE INDEX idx_flowering_harvest_date ON flowering(harvest_date);

-- health_checks
CREATE INDEX idx_health_checks_cultural_work_tasks_id ON health_checks(cultural_work_tasks_id);
CREATE INDEX idx_health_checks_recommendation_id ON health_checks(recommendation_id);
CREATE INDEX idx_health_checks_status_id ON health_checks(status_id);
CREATE INDEX idx_health_checks_check_date ON health_checks(check_date);

-- invitation
CREATE INDEX idx_invitation_farm_id ON invitation(farm_id);
CREATE INDEX idx_invitation_status_id ON invitation(status_id);
CREATE INDEX idx_invitation_inviter_user_id ON invitation(inviter_user_id);
CREATE INDEX idx_invitation_email ON invitation(email);

-- notifications
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_invitation_id ON notifications(invitation_id);
CREATE INDEX idx_notifications_notification_type_id ON notifications(notification_type_id);
CREATE INDEX idx_notifications_farm_id ON notifications(farm_id);
CREATE INDEX idx_notifications_status_id ON notifications(status_id);
CREATE INDEX idx_notifications_date ON notifications(date);

-- plot
CREATE INDEX idx_plot_coffee_variety_id ON plot(coffee_variety_id);
CREATE INDEX idx_plot_farm_id ON plot(farm_id);
CREATE INDEX idx_plot_status_id ON plot(status_id);

-- status
CREATE INDEX idx_status_status_type_id ON status(status_type_id);
CREATE INDEX idx_status_name_type ON status(name, status_type_id);

-- transaction
CREATE INDEX idx_transaction_plot_id ON transaction(plot_id);
CREATE INDEX idx_transaction_transaction_type_id ON transaction(transaction_type_id);
CREATE INDEX idx_transaction_status_id ON transaction(status_id);
CREATE INDEX idx_transaction_transaction_category_id ON transaction(transaction_category_id);
CREATE INDEX idx_transaction_creator_id ON transaction(creator_id);
CREATE INDEX idx_transaction_transaction_date ON transaction(transaction_date);

-- transaction_category
CREATE INDEX idx_transaction_category_transaction_type_id ON transaction_category(transaction_type_id);

-- unit_of_measure
CREATE INDEX idx_unit_of_measure_unit_of_measure_type_id ON unit_of_measure(unit_of_measure_type_id);

-- user_role_farm
CREATE INDEX idx_user_role_farm_role_id ON user_role_farm(role_id);
CREATE INDEX idx_user_role_farm_user_id ON user_role_farm(user_id);
CREATE INDEX idx_user_role_farm_farm_id ON user_role_farm(farm_id);
CREATE INDEX idx_user_role_farm_status_id ON user_role_farm(status_id);

-- users
CREATE INDEX idx_users_status_id ON users(status_id);

COMMIT;