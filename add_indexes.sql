
-- Index for invitation.inviter_user_id
CREATE INDEX idx_invitation_inviter_user_id ON invitation USING btree (inviter_user_id);

-- Index for health_checks.status_id
CREATE INDEX idx_health_checks_status_id ON health_checks USING btree (status_id);

-- Index for health_checks.recommendation_id
CREATE INDEX idx_health_checks_recommendation_id ON health_checks USING btree (recommendation_id);

-- Index for health_checks.cultural_work_tasks_id
CREATE INDEX idx_health_checks_cultural_work_tasks_id ON health_checks USING btree (cultural_work_tasks_id);

-- Index for cultural_work_tasks.plot_id
CREATE INDEX idx_cultural_work_tasks_plot_id ON cultural_work_tasks USING btree (plot_id);

-- Index for cultural_work_tasks.cultural_works_id
CREATE INDEX idx_cultural_work_tasks_cultural_works_id ON cultural_work_tasks USING btree (cultural_works_id);

-- Index for notifications.invitation_id
CREATE INDEX idx_notifications_invitation_id ON notifications USING btree (invitation_id);

-- Index for notifications.farm_id
CREATE INDEX idx_notifications_farm_id ON notifications USING btree (farm_id);

-- Index for notifications.status_id
CREATE INDEX idx_notifications_status_id ON notifications USING btree (status_id);

-- Index for transaction.creador_id
CREATE INDEX idx_transaction_creador_id ON transaction USING btree (creador_id);

-- Index for flowering.flowering_type_id
CREATE INDEX idx_flowering_flowering_type_id ON flowering USING btree (flowering_type_id);

-- Index for farm.status_id
CREATE INDEX idx_farm_status_id ON farm USING btree (status_id);

-- Index for users.email for faster lookups during login
CREATE INDEX idx_users_email ON users USING btree (email);

-- Index for transaction_category.transaction_type_id
CREATE INDEX idx_transaction_category_transaction_type_id ON transaction_category USING btree (transaction_type_id);

-- Additional composite indexes for frequently joined columns
CREATE INDEX idx_cultural_work_tasks_plot_status ON cultural_work_tasks USING btree (plot_id, status_id);
CREATE INDEX idx_transaction_plot_date ON transaction USING btree (plot_id, transaction_date);
CREATE INDEX idx_user_role_farm_user_role ON user_role_farm USING btree (user_id, role_id);
