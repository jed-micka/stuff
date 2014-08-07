USE mysql;

-- drop existing infrastructure
SELECT "Dropping and recreating permissions." AS "Phase I";
DROP USER 'game'@'localhost';
DROP DATABASE game;

-- recreate the DB
CREATE DATABASE game;

-- add permisions
GRANT ALL PRIVILEGES
ON game.*
TO 'game'@'localhost'
IDENTIFIED BY 'game'
WITH GRANT OPTION;

-- switch to the db
USE game;

-- create lookup tables first
SELECT "Creating lookup tables." AS "Phase II";
SOURCE ./tables/l_account_pages.sql;
SOURCE ./tables/l_account_states.sql;
SOURCE ./tables/l_container_states.sql;
SOURCE ./tables/l_coins.sql;
SOURCE ./tables/l_damage_types.sql;
SOURCE ./tables/l_event_severities.sql;
SOURCE ./tables/l_exit_directions.sql;
SOURCE ./tables/l_object_types.sql;
SOURCE ./tables/l_object_qualities.sql;
SOURCE ./tables/l_weapon_types.sql;

-- then create main tables
SELECT "Creating main tables." AS "Phase III";
SOURCE ./tables/t_account.sql;
SOURCE ./tables/t_room.sql;
SOURCE ./tables/t_exit.sql;
SOURCE ./tables/t_object.sql;
SOURCE ./tables/t_weapon.sql;
SOURCE ./tables/t_character.sql;
SOURCE ./tables/t_character_inventory.sql;
SOURCE ./tables/t_container.sql;
SOURCE ./tables/t_container_inventory.sql;
SOURCE ./tables/t_room_inventory.sql;
SOURCE ./tables/t_log_event.sql;
SOURCE ./tables/t_pile_of_coins.sql;
SOURCE ./tables/t_message_buffer.sql;

-- then stored procedures
SELECT "Creating stored procedures." AS "Phase IV";
SOURCE ./procedures/sp_activate_character.sql;
SOURCE ./procedures/sp_authenticate_account.sql;
SOURCE ./procedures/sp_create_account.sql;
SOURCE ./procedures/sp_create_character.sql;
SOURCE ./procedures/sp_create_exit.sql;
SOURCE ./procedures/sp_is_active_account.sql;
SOURCE ./procedures/sp_get_account_page.sql;
SOURCE ./procedures/sp_get_active_character.sql;
SOURCE ./procedures/sp_get_character.sql;
SOURCE ./procedures/sp_get_character_list.sql;
SOURCE ./procedures/sp_get_character_messages.sql;
SOURCE ./procedures/sp_get_characters_in_room.sql;
SOURCE ./procedures/sp_get_current_room.sql;
SOURCE ./procedures/sp_get_exit.sql;
SOURCE ./procedures/sp_get_exits_in_room.sql;
SOURCE ./procedures/sp_get_room_inventory.sql;
SOURCE ./procedures/sp_log_error.sql;
SOURCE ./procedures/sp_logout.sql;
SOURCE ./procedures/sp_move_character.sql;
SOURCE ./procedures/sp_set_account_page.sql;
SOURCE ./procedures/sp_send_message_to_character.sql;
SOURCE ./procedures/sp_send_message_to_room.sql;
SOURCE ./procedures/sp_send_message_to_world.sql;

-- populate DB with basic records
SELECT "Populating data." AS "Phase V";
SOURCE populate.sql;