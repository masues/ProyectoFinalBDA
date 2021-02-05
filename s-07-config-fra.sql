-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         04 de febrero de 2021
-- @Descripcion:   Habilita la Fast Recovery Area en la BD.

-- Conectando como sys
connect sys/system as sysdba

-- Configura el tamaño máximo en disco que será empleado para almacenar el
-- contenido de la FRA
alter system set db_recovery_file_dest_size = 24106M scope = both;

-- Especifica la ubicación de la FRA
alter system set db_recovery_file_dest = 
  '/u01/app/oracle/oradata/ROSUPROY/disk_5/fast_recovery_area/' scope=both;

-- Especifica el número máximo en minutos dentro de la cual la BD podrá
-- hacer flashback hacia el pasado
-- 1440 min = 24 horas
alter system set db_flashback_retention_target = 1440 scope = both;
