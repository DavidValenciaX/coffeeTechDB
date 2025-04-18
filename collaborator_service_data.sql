BEGIN;

-- Inserción de tipos de estado
INSERT INTO status_type (status_type_id, name) VALUES 
(1, 'Notification'),
(2, 'Invitation'),
(3, 'user_role_farm');

-- Inserción de estados
INSERT INTO status (status_id, name, status_type_id) VALUES 
(1, 'Pendiente', 1),
(2, 'Respondida', 1),
(3, 'Programada', 1),
(4, 'AsignacionTarea', 1),
(5, 'Inactivo', 1),
(6, 'ActualizacionTarea', 1),

(7, 'Aceptada', 2),
(8, 'Rechazada', 2),
(9, 'Pendiente', 2),

(10, 'Activo', 3),
(11, 'Inactivo', 3);

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