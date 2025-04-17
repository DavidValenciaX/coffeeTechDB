BEGIN;

CREATE INDEX idx_cultural_work_tasks_collaborator_user ON cultural_work_tasks (collaborator_user_id);

CREATE INDEX idx_cultural_work_tasks_owner_user ON cultural_work_tasks (owner_user_id);

CREATE INDEX idx_flowering_plot ON flowering (plot_id);

CREATE INDEX idx_flowering_status ON flowering (status_id);

CREATE INDEX idx_invitation_farm ON invitation (farm_id);

CREATE INDEX idx_notifications_notification_type ON notifications (notification_type_id);

CREATE INDEX idx_notifications_user ON notifications (user_id);

CREATE INDEX idx_plot_coffee_variety ON plot (coffee_variety_id);

CREATE INDEX idx_plot_farm ON plot (farm_id);

CREATE INDEX idx_role_permissions_permissions ON role_permission (permission_id);

CREATE INDEX idx_role_permissions_roles ON role_permission (role_id);

CREATE INDEX idx_transaction_plot_id ON transaction (plot_id);

CREATE INDEX idx_transaction_status_id ON transaction (status_id);

CREATE INDEX idx_transaction_transaction_category_id ON transaction (transaction_category_id);

CREATE INDEX idx_transaction_transaction_type_id ON transaction (transaction_type_id);

CREATE INDEX idx_user_role_farm_farm ON user_role_farm (farm_id);

CREATE INDEX idx_user_role_farm_roles ON user_role_farm (role_id);

CREATE INDEX idx_user_role_farm_user ON user_role_farm (user_id);

CREATE INDEX idx_farm_area_unit_id ON farm (area_unit_id);

CREATE INDEX idx_status_status_type_id ON status (status_type_id);

CREATE INDEX idx_unit_of_measure_unit_of_measure_type_id ON unit_of_measure (unit_of_measure_type_id);

CREATE INDEX idx_users_status_id ON users (status_id);

CREATE INDEX idx_status_status_id ON status (status_id);

CREATE INDEX idx_status_type_status_type_id ON status_type (status_type_id);

CREATE INDEX idx_transaction_category_id ON transaction_category (transaction_category_id);

CREATE INDEX idx_transaction_type_id ON transaction_type (transaction_type_id);

CREATE INDEX idx_invitation_inviter_user_id ON invitation (inviter_user_id);

CREATE INDEX idx_health_checks_status_id ON health_checks (status_id);

CREATE INDEX idx_health_checks_recommendation_id ON health_checks (recommendation_id);

CREATE INDEX idx_health_checks_cultural_work_tasks_id ON health_checks (cultural_work_tasks_id);

CREATE INDEX idx_cultural_work_tasks_plot_id ON cultural_work_tasks (plot_id);

CREATE INDEX idx_cultural_work_tasks_cultural_works_id ON cultural_work_tasks (cultural_works_id);

CREATE INDEX idx_notifications_invitation_id ON notifications (invitation_id);

CREATE INDEX idx_notifications_farm_id ON notifications (farm_id);

CREATE INDEX idx_notifications_status_id ON notifications (status_id);

CREATE INDEX idx_transaction_creador_id ON transaction (creador_id);

CREATE INDEX idx_flowering_flowering_type_id ON flowering (flowering_type_id);

CREATE INDEX idx_farm_status_id ON farm (status_id);

CREATE INDEX idx_users_email ON users (email);

CREATE INDEX idx_transaction_category_transaction_type_id ON transaction_category (transaction_type_id);

CREATE INDEX idx_cultural_work_tasks_plot_status ON cultural_work_tasks (plot_id, status_id);

CREATE INDEX idx_transaction_plot_date ON transaction (plot_id, transaction_date);

CREATE INDEX idx_user_role_farm_user_role ON user_role_farm (user_id, role_id);

COMMIT;