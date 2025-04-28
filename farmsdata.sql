INSERT INTO farm_states (farm_state_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO plot_states (plot_state_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO user_role_farm_states (user_role_farm_state_id, name) VALUES 
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO coffee_varieties (coffee_variety_id, name) VALUES 
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

SELECT setval(pg_get_serial_sequence('farm_states', 'farm_state_id'), 
              (SELECT COALESCE(MAX(farm_state_id), 0) + 1 FROM farm_states), false);

SELECT setval(pg_get_serial_sequence('plot_states', 'plot_state_id'), 
              (SELECT COALESCE(MAX(plot_state_id), 0) + 1 FROM plot_states), false);

SELECT setval(pg_get_serial_sequence('user_role_farm_states', 'user_role_farm_state_id'), 
              (SELECT COALESCE(MAX(user_role_farm_state_id), 0) + 1 FROM user_role_farm_states), false);

SELECT setval(pg_get_serial_sequence('coffee_varieties', 'coffee_variety_id'),
              (SELECT COALESCE(MAX(coffee_variety_id), 0) + 1 FROM coffee_varieties), false);

SELECT setval(pg_get_serial_sequence('area_units', 'area_unit_id'), 
              (SELECT COALESCE(MAX(area_unit_id), 0) + 1 FROM area_units), false);