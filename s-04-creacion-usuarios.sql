-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         03 de febrero de 2020
-- @Descripcion:   Creacion de usuarios por modulo en la base de datos.

-------Usuario del modulo Administración de usuarios------------

sqlplus sys as sysdba

create user mse_admin_users identified by mario;
grant create session to mse_admin_users;
grant create procedure to mse_admin_users;
grant create sequence to mse_admin_users;
grant create table to mse_admin_users;
alter user mse_admin_users quota unlimited on admin_usr_blob_ts;
alter user mse_admin_users quota unlimited on admin_usr_index_ts;
alter user mse_admin_users quota unlimited on admin_usr_ts;
alter user mse_admin_users default tablespace admin_usr_ts;


-------Usuario del modulo Administración de objetos-----------

create user rrr_admin_objects identified by ricardo;
grant create session to rrr_admin_objects;
grant create procedure to rrr_admin_objects;
grant create sequence to rrr_admin_objects;
grant create table to rrr_admin_objects;
alter user rrr_admin_objects quota unlimited on admin_obj_blob_ts;
alter user rrr_admin_objects quota unlimited on admin_obj_ts;
alter user rrr_admin_objects quota unlimited on admin_obj_index_ts;
alter user rrr_admin_objects default tablespace admin_obj_ts;



