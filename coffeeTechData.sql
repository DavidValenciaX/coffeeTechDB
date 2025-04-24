BEGIN;

INSERT INTO coffee_variety (coffee_variety_id, name) VALUES 
(1, 'Castillo'),
(2, 'Borbon'),
(3, 'Caturra'),
(4, 'Colombia'),
(5, 'Tipica'),
(6, 'Tabi');

INSERT INTO area_units (area_unit_id, name, abbreviation) VALUES 
(1, 'Metro cuadrado', 'm²'),
(2, 'Kilómetro cuadrado', 'km²'),
(3, 'Hectárea', 'ha');

INSERT INTO notification_type (notification_type_id, name) VALUES 
(1, 'Invitation'),
(2, 'Reminder'),
(3, 'Invitation_Accepted'),
(4, 'Invitation_Rejected');

INSERT INTO permission (permission_id, description, name) VALUES
(1, 'Permite al usuario modificar la informacion de la finca', 'edit_farm'),
(2, 'Permite al usuario eliminar finca de donde es propietario', 'delete_farm'),

(3, 'Permite al usuario agregar administrador de finca', 'add_administrator_farm'),
(4, 'Permite al usuario editar un rol de colaborador a administrador de finca', 'edit_administrator_farm'),
(5, 'Permite al usuario eliminar administrador de finca', 'delete_administrator_farm'),

(6, 'Permite al usuario agregar operador de campo', 'add_operator_farm'),
(7, 'Permite al usuario editar un rol de colaborador a operador de campo', 'edit_operator_farm'),
(8, 'Permite al usuario eliminar operador de campo', 'delete_operator_farm'),

(9, 'Permite al usuario listar los colaboradores de una finca', 'read_collaborators'),

(10, 'Permite al usuario agregar lotes', 'add_plot'),
(11, 'Permiso para editar lotes', 'edit_plot'),
(12, 'Permiso para eliminar lotes', 'delete_plot'),
(13, 'Permite al usuario listar los lotes', 'read_plots'),

(14, 'Permite al usuario ver las transaciones de la finca', 'read_transaction'),
(15, 'Permite al usuario editar las transaciones de la finca', 'edit_transaction'),
(16, 'Permite al usuario agregar las transaciones de la finca', 'add_transaction'),
(17, 'Permite al usuario eliminar las transaciones de la finca', 'delete_transaction'),

(18, 'Permite al usuario ver los reportes financieros', 'read_financial_report');

INSERT INTO role (role_id, name) VALUES 
(1, 'Propietario'),
(2, 'Administrador de finca'),
(3, 'Operador de campo');

INSERT INTO role_permission (role_id, permission_id) VALUES
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
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),


(2, 1),

(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),

(3, 9),

(3, 13),
(3, 14),

(3, 16);

INSERT INTO transaction_type (transaction_type_id, name) VALUES 
(1, 'Ingreso'),
(2, 'Gasto');

INSERT INTO transaction_category (transaction_category_id, name, transaction_type_id) VALUES 
(1, 'Venta de café', 1),
(2, 'Otros', 1),
(3, 'Pagos a colaboradores', 2),
(4, 'Fertilizantes', 2),
(5, 'Plaguicidas/herbicidas', 2),
(6, 'Otros', 2);

-- Nuevos inserts para tablas de status específicas
INSERT INTO user_status (user_status_id, name) VALUES 
(1, 'Activo'),
(2, 'Verificado'),
(3, 'No Verificado'),
(4, 'Suspendido');

INSERT INTO farm_status (farm_status_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO plot_status (plot_status_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO notification_status (notification_status_id, name) VALUES 
(1, 'Pendiente'),
(2, 'Respondida'),
(3, 'Programada'),
(4, 'Inactiva'),
(5, 'Aceptada'),
(6, 'Rechazada');

INSERT INTO user_farm_role_status (user_farm_role_status_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO transaction_status (transaction_status_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO invitation_status (invitation_status_id, name) VALUES 
(1, 'Aceptada'),
(2, 'Rechazada'),
(3, 'Pendiente');

SELECT setval(pg_get_serial_sequence('coffee_variety', 'coffee_variety_id'),
              (SELECT COALESCE(MAX(coffee_variety_id), 0) + 1 FROM coffee_variety), false);

SELECT setval(pg_get_serial_sequence('notification_type', 'notification_type_id'), 
              (SELECT COALESCE(MAX(notification_type_id), 0) + 1 FROM notification_type), false);

SELECT setval(pg_get_serial_sequence('permission', 'permission_id'), 
              (SELECT COALESCE(MAX(permission_id), 0) + 1 FROM permission), false);

SELECT setval(pg_get_serial_sequence('role', 'role_id'), 
              (SELECT COALESCE(MAX(role_id), 0) + 1 FROM role), false);

SELECT setval(pg_get_serial_sequence('transaction_category', 'transaction_category_id'), 
              (SELECT COALESCE(MAX(transaction_category_id), 0) + 1 FROM transaction_category), false);

SELECT setval(pg_get_serial_sequence('transaction_type', 'transaction_type_id'), 
              (SELECT COALESCE(MAX(transaction_type_id), 0) + 1 FROM transaction_type), false);

SELECT setval(pg_get_serial_sequence('area_units', 'area_unit_id'), 
              (SELECT COALESCE(MAX(area_unit_id), 0) + 1 FROM area_units), false);

SELECT setval(pg_get_serial_sequence('user_status', 'user_status_id'), 
              (SELECT COALESCE(MAX(user_status_id), 0) + 1 FROM user_status), false);

SELECT setval(pg_get_serial_sequence('farm_status', 'farm_status_id'), 
              (SELECT COALESCE(MAX(farm_status_id), 0) + 1 FROM farm_status), false);

SELECT setval(pg_get_serial_sequence('plot_status', 'plot_status_id'), 
              (SELECT COALESCE(MAX(plot_status_id), 0) + 1 FROM plot_status), false);

SELECT setval(pg_get_serial_sequence('notification_status', 'notification_status_id'), 
              (SELECT COALESCE(MAX(notification_status_id), 0) + 1 FROM notification_status), false);

SELECT setval(pg_get_serial_sequence('user_farm_role_status', 'user_farm_role_status_id'), 
              (SELECT COALESCE(MAX(user_farm_role_status_id), 0) + 1 FROM user_farm_role_status), false);

SELECT setval(pg_get_serial_sequence('transaction_status', 'transaction_status_id'), 
              (SELECT COALESCE(MAX(transaction_status_id), 0) + 1 FROM transaction_status), false);

SELECT setval(pg_get_serial_sequence('invitation_status', 'invitation_status_id'), 
              (SELECT COALESCE(MAX(invitation_status_id), 0) + 1 FROM invitation_status), false);

-- Confirmar la transacción si todo va bien
COMMIT;