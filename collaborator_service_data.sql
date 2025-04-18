BEGIN;

-- Inserción de tipos de estado
INSERT INTO status_type (status_type_id, name) VALUES 
(5, 'Invitation'),
(6, 'user_role_farm'),
(4, 'Notification');

-- Inserción de estados
INSERT INTO status (status_id, name, status_type_id) VALUES 
(9, 'Pendiente', 4),
(10, 'Respondida', 4),
(11, 'Programada', 4),
(12, 'AsignacionTarea', 4),
(13, 'Inactivo', 4),
(14, 'ActualizacionTarea', 4),
(15, 'Aceptada', 5),
(16, 'Rechazada', 5),
(17, 'Pendiente', 5),
(18, 'Activo', 6),
(19, 'Inactivo', 6);

-- Inserción de tipos de notificación
INSERT INTO notification_type (notification_type_id, name) VALUES 
(1, 'Invitation'),
(2, 'Reminder'),
(3, 'Invitation_Accepted'),
(4, 'Invitation_Rejected'),
(5, 'TaskAssignment'),
(6, 'TaskUpdate'),
(7, 'TaskDeletion');

-- Actualización de secuencias
SELECT setval(pg_get_serial_sequence('notification_type', 'notification_type_id'), 
              (SELECT COALESCE(MAX(notification_type_id), 0) + 1 FROM notification_type), false);

SELECT setval(pg_get_serial_sequence('status', 'status_id'), 
              (SELECT COALESCE(MAX(status_id), 0) + 1 FROM status), false);

SELECT setval(pg_get_serial_sequence('status_type', 'status_type_id'), 
              (SELECT COALESCE(MAX(status_type_id), 0) + 1 FROM status_type), false);

COMMIT;