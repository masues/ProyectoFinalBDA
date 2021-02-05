-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         04 de febrero de 2021
-- @Descripcion:   Configura el modo archivado en la base de datos

-- Conectando como sys
connect sys/system as sysdba

-- Respaldar el spfile

create pfile = 
  '/u01/app/oracle/oradata/ROSUPROY/disk_5/fast_recovery_area/rosubackup0.ora'
  from spfile;

--Empleado para configurar 5 procesos ARCn

alter system set log_archive_max_processes= 5 scope=both;

-- Ubicación de los archivos de control en el disco 1

alter system set log_archive_dest_1 = 
  'LOCATION=/u01/app/oracle/oradata/ROSUPROY/disk_1/archivelog/ MANDATORY'
  scope=both;

-- Ubicación de los archivos de control en la fra

alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DES'
  scope=both;

-- Formato para almacenar el nombre de los archive redologs

alter system set  log_archive_format='arch_rosuproy_%t_%s_%r.arc' scope=spfile;

-- Indica el número mínimo de copias que deben generarse con éxito

alter system set  log_archive_min_succeed_dest=1 scope=both;

shutdown immediate

startup mount

alter database archivelog;

alter database open;

create pfile = 
  '/u01/app/oracle/oradata/ROSUPROY/disk_5/fast_recovery_area/rosubackup1.ora'
  from spfile;
