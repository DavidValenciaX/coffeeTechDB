BEGIN;

INSERT INTO public.coffee_variety (coffee_variety_id, name) VALUES 
(1, 'Castillo'),
(2, 'Borbon'),
(3, 'Caturra'),
(4, 'Colombia'),
(5, 'Tipica'),
(6, 'Tabi');

INSERT INTO public.area_units (area_unit_id, name, abbreviation) VALUES 
(1, 'Metro cuadrado', 'm²'),
(2, 'Kilómetro cuadrado', 'km²'),
(3, 'Hectárea', 'ha');

INSERT INTO public.status_type (status_type_id, name) VALUES 
(1, 'User'),
(2, 'Farm'),
(3, 'Plot'),
(4, 'Notification'),
(5, 'Invitation'),
(6, 'user_role_farm'),
(7, 'Transaction');

INSERT INTO public.status (status_id, name, status_type_id) VALUES 

(1, 'Activo', 1),
(2, 'Verificado', 1),
(3, 'No Verificado', 1),
(4, 'Suspendido', 1),

(5, 'Activo', 2),
(6, 'Inactivo', 2),

(7, 'Activo', 3),
(8, 'Inactivo', 3),

(9, 'Pendiente', 4),
(10, 'Respondida', 4),
(11, 'Programada', 4),
(12, 'Inactiva', 4),

(13, 'Aceptada', 5),
(14, 'Rechazada', 5),
(15, 'Pendiente', 5),

(16, 'Activo', 6),
(17, 'Inactivo', 6),

(18, 'Activo', 7),
(19, 'Inactivo', 7);

INSERT INTO public.notification_type (notification_type_id, name) VALUES 
(1, 'Invitation'),
(2, 'Reminder'),
(3, 'Invitation_Accepted'),
(4, 'Invitation_Rejected');

INSERT INTO public.permission (permission_id, description, name) VALUES
(1, 'Permite al usuario modificar la informacion de la finca', 'edit_farm'),
(5, 'Permite al usuario eliminar finca de donde es propietario', 'delete_farm'),

(2, 'Permite al usuario agregar administrador de finca', 'add_administrator_farm'),
(11, 'Permite al usuario editar un rol de colaborador a administrador de finca', 'edit_administrator_farm'),
(6, 'Permite al usuario eliminar administrador de finca', 'delete_administrator_farm'),

(3, 'Permite al usuario agregar operador de campo', 'add_operator_farm'),
(10, 'Permite al usuario editar un rol de colaborador a operador de campo', 'edit_operator_farm'),
(7, 'Permite al usuario eliminar operador de campo', 'delete_operator_farm'),

(9, 'Permite al usuario listar los colaboradores de una finca', 'read_collaborators'),

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

INSERT INTO public.role (role_id, name) VALUES 
(1, 'Propietario'),
(2, 'Administrador de finca'),
(3, 'Operador de campo');

INSERT INTO public.role_permission (role_id, permission_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 18),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 29),

(2, 1),
(2, 3),
(2, 4),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 12),
(2, 13),
(2, 24),
(2, 25),
(2, 26),
(2, 27);

INSERT INTO public.transaction_type (transaction_type_id, name) VALUES 
(1, 'Ingreso'),
(2, 'Gasto');

INSERT INTO public.transaction_category (transaction_category_id, name, transaction_type_id) VALUES 
(1, 'Venta de café', 1),
(2, 'Otros', 1),
(3, 'Pagos a colaboradores', 2),
(4, 'Fertilizantes', 2),
(5, 'Plaguicidas/herbicidas', 2),
(6, 'Otros', 2);

SELECT setval(pg_get_serial_sequence('coffee_variety', 'coffee_variety_id'),
              (SELECT COALESCE(MAX(coffee_variety_id), 0) + 1 FROM coffee_variety), false);

SELECT setval(pg_get_serial_sequence('notification_type', 'notification_type_id'), 
              (SELECT COALESCE(MAX(notification_type_id), 0) + 1 FROM notification_type), false);

SELECT setval(pg_get_serial_sequence('permission', 'permission_id'), 
              (SELECT COALESCE(MAX(permission_id), 0) + 1 FROM permission), false);

SELECT setval(pg_get_serial_sequence('role', 'role_id'), 
              (SELECT COALESCE(MAX(role_id), 0) + 1 FROM role), false);

SELECT setval(pg_get_serial_sequence('status', 'status_id'), 
              (SELECT COALESCE(MAX(status_id), 0) + 1 FROM status), false);

SELECT setval(pg_get_serial_sequence('status_type', 'status_type_id'), 
              (SELECT COALESCE(MAX(status_type_id), 0) + 1 FROM status_type), false);

SELECT setval(pg_get_serial_sequence('transaction_category', 'transaction_category_id'), 
              (SELECT COALESCE(MAX(transaction_category_id), 0) + 1 FROM transaction_category), false);

SELECT setval(pg_get_serial_sequence('transaction_type', 'transaction_type_id'), 
              (SELECT COALESCE(MAX(transaction_type_id), 0) + 1 FROM transaction_type), false);

SELECT setval(pg_get_serial_sequence('area_units', 'area_unit_id'), 
              (SELECT COALESCE(MAX(area_unit_id), 0) + 1 FROM area_units), false);

-- Confirmar la transacción si todo va bien
COMMIT;