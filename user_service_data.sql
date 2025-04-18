BEGIN;

-- Inserción de tipos de estado relevantes para el servicio de usuarios
INSERT INTO public.status_type (status_type_id, name) VALUES
(1, 'User'),
(2, 'Notification'),
(3, 'Invitation'),
(4, 'user_role_farm');

-- Inserción de estados relevantes para el servicio de usuarios
INSERT INTO public.status (status_id, name, status_type_id) VALUES
-- User statuses
(1, 'Activo', 1),
(2, 'Verificado', 1),
(3, 'No Verificado', 1),
(4, 'Suspendido', 1),

-- Notification statuses
(5, 'Pendiente', 2),
(6, 'Respondida', 2),
(7, 'Programada', 2),
(8, 'Inactiva', 2),

-- Invitation statuses
(9, 'Aceptada', 3),
(10, 'Rechazada', 3),
(11, 'Pendiente', 3),

-- user_role_farm statuses
(12, 'Activo', 4),
(13, 'Inactivo', 4);

-- Inserción de tipos de notificación
INSERT INTO public.notification_type (notification_type_id, name) VALUES
(1, 'Invitation'),
(2, 'Reminder'),
(3, 'Invitation_Accepted'),
(4, 'Invitation_Rejected');

-- Inserción de permisos
INSERT INTO public.permission (permission_id, description, name) VALUES
(1, 'Permite al usuario modificar la informacion de la finca', 'edit_farm'),
(5, 'Permite al usuario eliminar finca de  donde es propietario', 'delete_farm'),
(6, 'Permite al usuario eliminar administrador de finca', 'delete_administrador_farm'),
(7, 'Permite al usuario eliminar operador de campo', 'delete_operador_farm'),
(2, 'Permite al usuario agregar administrador de finca', 'add_administrador_farm'),
(3, 'Permite al usuario agregar operador de campo', 'add_operador_farm'),
(9, 'Permite al usuario listar los colaboradores de una finca', 'read_collaborators'),
(10, 'Permite al usuario editar un rol de colaborador a operador de campo', 'edit_operador_farm'),
(11, 'Permite al usuario editar un rol de colaborador a administrador de finca', 'edit_administrador_farm'),
(4, 'Permite al usuario agregar lotes', 'add_plot'),
(12, 'Permiso para editar lotes', 'edit_plot'),
(13, 'Permiso para eliminar lotes', 'delete_plot'),
(8, 'Permite al usuario listar los lotes', 'read_plots'),
(18, 'Permite al usuario ver reportes de la finca', 'read_report'),
(24, 'Permite al usuario ver las transaciones de la finca', 'read_transaction'),
(25, 'Permite al usuario editar las transaciones de la finca', 'edit_transaction'),
(26, 'Permite al usuario agregar las transaciones de la finca', 'add_transaction'),
(27, 'Permite al usuario eliminar las transaciones de la finca', 'delete_transaction'),
(29, 'Permite al usuario ver los reportes financieros', 'read_financial_report');

-- Inserción de roles
INSERT INTO public.role (role_id, name) VALUES
(1, 'Propietario'),
(2, 'Administrador de finca'),
(3, 'Operador de campo');

-- Inserción de permisos por rol
INSERT INTO public.role_permission (role_id, permission_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 8),
(1, 7),
(2, 1),
(2, 3),
(2, 7),
(2, 9),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(2, 12),
(2, 13),
(2, 4),
(2, 10),
(1, 18),
(2, 8),
(1, 26),
(1, 25),
(1, 27),
(1, 24),
(1, 29),
(2, 24),
(2, 25),
(2, 26),
(2, 27);

-- Actualización de secuencias para las tablas pobladas
SELECT setval(pg_get_serial_sequence('status_type', 'status_type_id'),
              (SELECT COALESCE(MAX(status_type_id), 0) + 1 FROM status_type), false);

SELECT setval(pg_get_serial_sequence('status', 'status_id'),
              (SELECT COALESCE(MAX(status_id), 0) + 1 FROM status), false);

SELECT setval(pg_get_serial_sequence('notification_type', 'notification_type_id'),
              (SELECT COALESCE(MAX(notification_type_id), 0) + 1 FROM notification_type), false);

SELECT setval(pg_get_serial_sequence('permission', 'permission_id'),
              (SELECT COALESCE(MAX(permission_id), 0) + 1 FROM permission), false);

SELECT setval(pg_get_serial_sequence('role', 'role_id'),
              (SELECT COALESCE(MAX(role_id), 0) + 1 FROM role), false);

-- Confirmar la transacción si todo va bien
COMMIT;