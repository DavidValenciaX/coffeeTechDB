BEGIN;

-- Índices para la tabla users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_status_id ON users(status_id);

-- Índices para la tabla farm
CREATE INDEX idx_farm_area_unit_id ON farm(area_unit_id);
CREATE INDEX idx_farm_status_id ON farm(status_id);

-- Índices para la tabla plot
CREATE INDEX idx_plot_coffee_variety_id ON plot(coffee_variety_id);
CREATE INDEX idx_plot_farm_id ON plot(farm_id);
CREATE INDEX idx_plot_status_id ON plot(status_id);

-- Índices para la tabla transaction
CREATE INDEX idx_transaction_plot_id ON transaction(plot_id);
CREATE INDEX idx_transaction_status_id ON transaction(status_id);
CREATE INDEX idx_transaction_transaction_type_id ON transaction(transaction_type_id);
CREATE INDEX idx_transaction_transaction_date ON transaction(transaction_date);

-- Índices para la tabla user_role_farm
CREATE INDEX idx_user_role_farm_user_id ON user_role_farm(user_id);
CREATE INDEX idx_user_role_farm_farm_id ON user_role_farm(farm_id);
CREATE INDEX idx_user_role_farm_role_id ON user_role_farm(role_id);
CREATE INDEX idx_user_role_farm_status_id ON user_role_farm(status_id);

-- Índices para la tabla invitation
CREATE INDEX idx_invitation_email ON invitation(email);
CREATE INDEX idx_invitation_farm_id ON invitation(farm_id);
CREATE INDEX idx_invitation_status_id ON invitation(status_id);
CREATE INDEX idx_invitation_user_id ON invitation(inviter_user_id);

-- Índices para la tabla notifications
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_farm_id ON notifications(farm_id);
CREATE INDEX idx_notifications_status_id ON notifications(status_id);
CREATE INDEX idx_notifications_date ON notifications(date);

COMMIT;