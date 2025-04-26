INSERT INTO user_states (user_state_id, name) VALUES 
(1, 'Activo'),
(2, 'Verificado'),
(3, 'No Verificado'),
(4, 'Suspendido');

INSERT INTO permissions (permission_id, description, name) VALUES
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

INSERT INTO roles (role_id, name) VALUES 
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