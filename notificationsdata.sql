INSERT INTO notification_states (notification_state_id, name) VALUES 
(1, 'Pendiente'),
(2, 'Respondida'),
(3, 'Programada'),
(4, 'Inactiva'),
(5, 'Aceptada'),
(6, 'Rechazada');

INSERT INTO notification_types (notification_type_id, name) VALUES 
(1, 'Invitation'),
(2, 'Reminder'),
(3, 'Invitation_Accepted'),
(4, 'Invitation_Rejected');

SELECT setval(pg_get_serial_sequence('notification_states', 'notification_state_id'), 
              (SELECT COALESCE(MAX(notification_state_id), 0) + 1 FROM notification_states), false);

SELECT setval(pg_get_serial_sequence('notification_types', 'notification_type_id'), 
              (SELECT COALESCE(MAX(notification_type_id), 0) + 1 FROM notification_types), false);