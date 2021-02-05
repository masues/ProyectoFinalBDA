-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         03 de febrero de 2021
-- @Descripcion:   Script para elminar a los usuarios mse_admin_users y
--                 rrr_admin_objects en caso de error

connect sys/system as sysdba
drop user mse_admin_users cascade;
drop user rrr_admin_objects cascade;