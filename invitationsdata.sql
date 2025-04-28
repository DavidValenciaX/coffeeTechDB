INSERT INTO invitation_states (invitation_state_id, name) VALUES 
(1, 'Aceptada'),
(2, 'Rechazada'),
(3, 'Pendiente');

SELECT setval(pg_get_serial_sequence('invitation_states', 'invitation_state_id'), 
              (SELECT COALESCE(MAX(invitation_state_id), 0) + 1 FROM invitation_states), false);