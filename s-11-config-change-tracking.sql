-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         05 de febrero de 2021
-- @Descripcion:   Habilita block change tracking para permitir el uso de
--                 backups incrementales.

-- Conecta como sys
connect sys/system as sysdba

-- Activa Block Change Tracking para grabar los cambios realizados en los
-- data files
alter database enable block change tracking using file 
  '/u01/app/oracle/oradata/ROSUPROY/change_tracking.dbf';
