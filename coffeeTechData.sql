BEGIN;

INSERT INTO public.coffee_variety (coffee_variety_id, name) VALUES 
(1, 'Castillo'),
(2, 'Borbon'),
(3, 'Caturra'),
(4, 'Colombia'),
(5, 'Tipica'),
(6, 'Tabi');

INSERT INTO public.cultural_works (cultural_works_id, name, description) VALUES 
(1, 'Chequeo de Salud', 'Evaluación de la salud general de las plantas de café para identificar enfermedades, plagas o deficiencias y así aplicar medidas preventivas y correctivas.'),
(2, 'Chequeo de estado de maduración', 'Inspección de cultivos para determinar el nivel de maduración de los frutos y planificar la cosecha en el momento óptimo para la mejor calidad.');

INSERT INTO public.unit_of_measure_type (unit_of_measure_type_id, name) VALUES 
(1, 'Longitud'),
(2, 'Área'),
(3, 'Masa'),
(4, 'Densidad'),
(5, 'Temperatura'),
(6, 'Precipitación');

INSERT INTO public.unit_of_measure (unit_of_measure_id, name, abbreviation, unit_of_measure_type_id) VALUES 
(1, 'Metro', 'm', 1),
(2, 'Kilómetro', 'km', 1),
(4, 'Plantas por hectárea', 'pl/ha', 4),
(5, 'Kilogramos', 'kg', 3),
(6, 'Grados Celsius', '°C', 5),
(7, 'Milímetros', 'mm', 6),
(9, 'Metro cuadrado', 'm²', 2),
(10, 'Kilómetro cuadrado', 'km²', 2),
(3, 'Hectárea', 'ha', 2);

INSERT INTO public.status_type (status_type_id, name) VALUES 
(1, 'General'),
(2, 'User'),
(3, 'Farm'),
(4, 'Plot'),
(5, 'Health_Check'),
(6, 'Notification'),
(7, 'Invitation'),
(8, 'user_role_farm'),
(9, 'Flowering'),
(10, 'Task'),
(11, 'Transaction'),
(12, 'Detection');

INSERT INTO public.status (status_id, name, status_type_id) VALUES 

(1, 'Activo', 1),
(2, 'Inactivo', 1),
(3, 'Pendiente', 1),
(4, 'En Proceso', 1),

(5, 'Activo', 2),
(6, 'Verificado', 2),
(7, 'No Verificado', 2),
(8, 'Suspendido', 2),

(9, 'Activo', 3),
(10, 'Inactivo', 3),

(11, 'Activo', 4),
(12, 'Inactivo', 4),

(13, 'Completado', 5),
(14, 'Pendiente', 5),
(15, 'Revisado', 5),

(16, 'Pendiente', 6),
(17, 'Respondida', 6),
(18, 'Programada', 6),
(19, 'AsignacionTarea', 6),
(20, 'Inactivo', 6),
(21, 'ActualizacionTarea', 6),

(22, 'Aceptada', 7),
(23, 'Rechazada', 7),
(24, 'Pendiente', 7),

(25, 'Activo', 8),
(26, 'Inactivo', 8),

(27, 'Activa', 9),
(28, 'Cosechada', 9),
(29, 'Inactivo', 9),

(30, 'Por hacer', 10),
(31, 'Terminado', 10),
(32, 'Inactivo', 10),

(33, 'Activo', 11),
(34, 'Inactivo', 11),

(35, 'Pendiente', 12),
(36, 'Aceptado', 12),
(37, 'Descartado', 12),
(38, 'Desactivado', 12);

INSERT INTO public.flowering_type (flowering_type_id, name) VALUES 
(1, 'Principal'),
(2, 'Mitaca');

INSERT INTO public.recommendation (recommendation_id, recommendation, name) VALUES 
(1, 'Aplicar un fertilizante rico en nitrógeno, como el sulfato de amonio o la urea.', 'nitrogen_N'),
(2, 'Utilizar fertilizantes con alto contenido de fósforo, como superfosfato o fosfato monoamónico.', 'phosphorus_P'),
(3, 'Aplicar fertilizantes ricos en potasio, como el sulfato de potasio o cenizas de madera.', 'potassium_K'),
(4, 'Aplicar fungicidas a base de cobre o específicos para Cercospora según indicaciones de un especialista.', 'cercospora'),
(5, 'Usar fungicidas sistémicos o preventivos para combatir la roya, aplicando según el ciclo de la enfermedad y las condiciones climáticas.', 'ferrugem'),
(6, 'Aplicar fungicidas específicos para roya, especialmente aquellos aprobados para su uso en el cultivo afectado.', 'leaf_rust'),
(7, 'Está sanita, sigue así', 'hoja_sana'),
(11, 'Dejar que las frutas continúen madurando antes de la recolección.', 'Verde'),
(8, 'Recolectar las frutas sobremaduras y procesarlas adecuadamente.', 'Sobremaduro'),
(9, 'Recolectar las frutas maduras para su comercialización.', 'Maduro'),
(10, 'Mantener las frutas pintonas bajo observación y recolectar según el progreso de maduración.', 'Pintón'),
(12, 'No se han identificado granos. No se requiere acción adicional.', 'No hay granos');

INSERT INTO public.notification_type (notification_type_id, name) VALUES 
(1, 'Invitation'),
(2, 'Reminder'),
(3, 'Invitation_Accepted'),
(4, 'Invitation_Rejected'),
(5, 'TaskAssignment'),
(6, 'TaskUpdate'),
(7, 'TaskDeletion');

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
(14, 'Permiso para agregar floraciones', 'add_flowering'),
(15, 'Permiso para editar floraciones', 'edit_flowering'),
(8, 'Permite al usuario listar los lotes', 'read_plots'),
(16, 'Permiso para listar floraciones', 'read_flowering'),
(17, 'Permiso para eliminar floraciones', 'delete_flowering'),
(18, 'Permite al usuario ver reportes de la finca', 'read_report'),
(19, 'Permite al usuario agregar una tarea de labor cultural\n', 'add_cultural_work_task'),
(21, 'Permite al usuario leer las tarea de labor cultural de un lote', 'read_cultural_work_task'),
(20, 'Permite al usuario completar una tarea de labor cultural', 'complete_cultural_work_task'),
(22, 'Permite al usuario modificar la información de la tarea de labor cultural', 'edit_cultural_work_task'),
(23, 'Permite al usuario eliminar la tarea de labor cultural', 'delete_cultural_work_task'),
(24, 'Permite al usuario ver las transaciones de la finca', 'read_transaction'),
(25, 'Permite al usuario editar las transaciones de la finca', 'edit_transaction'),
(26, 'Permite al usuario agregar las transaciones de la finca', 'add_transaction'),
(27, 'Permite al usuario eliminar las transaciones de la finca', 'delete_transaction'),
(28, 'Permiso para realizar detecciones', 'perform_detection'),
(29, 'Permite al usuario ver los reportes financieron', 'read_financial_report'),
(31, 'Permite al usuario ver los reportes de maduracion', 'read_maturation_checks'),
(30, 'Permite al usuario ver los reportes de salud', 'read_health_checks_report');

INSERT INTO public.role (role_id, name) VALUES 
(1, 'Propietario'),
(3, 'Operador de campo'),
(2, 'Administrador de finca');

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
(1, 14),
(1, 15),
(2, 14),
(2, 15),
(1, 16),
(1, 17),
(2, 4),
(2, 10),
(2, 16),
(2, 17),
(1, 18),
(2, 8),
(1, 19),
(3, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 26),
(1, 25),
(1, 27),
(1, 24),
(1, 28),
(2, 28),
(3, 28),
(1, 29),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(1, 30),
(1, 31);

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

SELECT setval(pg_get_serial_sequence('cultural_works', 'cultural_works_id'),
              (SELECT COALESCE(MAX(cultural_works_id), 0) + 1 FROM cultural_works), false);

SELECT setval(pg_get_serial_sequence('flowering_type', 'flowering_type_id'), 
              (SELECT COALESCE(MAX(flowering_type_id), 0) + 1 FROM flowering_type), false);

SELECT setval(pg_get_serial_sequence('notification_type', 'notification_type_id'), 
              (SELECT COALESCE(MAX(notification_type_id), 0) + 1 FROM notification_type), false);

SELECT setval(pg_get_serial_sequence('permission', 'permission_id'), 
              (SELECT COALESCE(MAX(permission_id), 0) + 1 FROM permission), false);

SELECT setval(pg_get_serial_sequence('recommendation', 'recommendation_id'), 
              (SELECT COALESCE(MAX(recommendation_id), 0) + 1 FROM recommendation), false);

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

SELECT setval(pg_get_serial_sequence('unit_of_measure_type', 'unit_of_measure_type_id'), 
              (SELECT COALESCE(MAX(unit_of_measure_type_id), 0) + 1 FROM unit_of_measure_type), false);

SELECT setval(pg_get_serial_sequence('unit_of_measure', 'unit_of_measure_id'), 
              (SELECT COALESCE(MAX(unit_of_measure_id), 0) + 1 FROM unit_of_measure), false);

-- Confirmar la transacción si todo va bien
COMMIT;