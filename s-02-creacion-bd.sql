-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         03 de febrero de 2020
-- @Descripcion:   Creacion de base de datos, grupos de redo logs y tablespaces.

connect sys/Hola1234# as sysdba
-- Crea el spfile
create spfile from pfile;
-- Inicia la BD
startup nomount

create database rosuproy 
	user sys identified by system
	user system identified by system
	logfile group 1 (
		'/u01/app/oracle/oradata/ROSUPROY/redo01A.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_2/redo01B.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_3/redo01C.log') size 50m blocksize 512,
	group 2 (
		'/u01/app/oracle/oradata/ROSUPROY/redo02A.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_2/redo02B.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_3/redo02C.log') size 50m blocksize 512,
	group 3 (
		'/u01/app/oracle/oradata/ROSUPROY/redo03A.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_2/redo03B.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_3/redo03C.log') size 50m blocksize 512
	maxloghistory 1
	maxlogfiles 4 -- Número máximo de grupos
	maxlogmembers 5 -- Número máximo de miembros en cada grupo
	maxdatafiles 100 -- Número máximo de data files
	character set AL32UTF8
	national character set AL16UTF16
	extent management local
	datafile '/u01/app/oracle/oradata/ROSUPROY/system01.dbf'
		size 800m reuse autoextend on next 1024k maxsize 1536m
	sysaux datafile '/u01/app/oracle/oradata/ROSUPROY/sysaux01.dbf'
		size 500m reuse autoextend on next 1024k maxsize 1G
	default temporary tablespace tempts1
		tempfile '/u01/app/oracle/oradata/ROSUPROY/temp01.dbf'
		size 25m reuse autoextend on next 512k maxsize 250m
	undo tablespace undotbs1
		datafile '/u01/app/oracle/oradata/ROSUPROY/undotbs01.dbf'
		size 200m reuse autoextend on next 1024k maxsize 1G
  default tablespace
    admin_usr_ts
      datafile '/u01/app/oracle/oradata/ROSUPROY/tablasadminusers.dbf' size 400M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_2/tablasadminusers02.dbf' size 400M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_3/tablasadminusers03.dbf' size 400M
    AUTOEXTEND ON
      NEXT 1024K
      MAXSIZE 1G
    extent management local autoallocate
    segment space management auto;

-- Actualización de contraseñas de usuarios
alter user sys identified by system;
alter user system identified by system;

-- Creación de tablespaces
create tablespace admin_obj_ts
datafile '/u01/app/oracle/oradata/ROSUPROY/tablasadminobj.dbf' size 500M,
'/u01/app/oracle/oradata/ROSUPROY/disk_2/tablasadminobj02.dbf' size 500M,
'/u01/app/oracle/oradata/ROSUPROY/disk_3/tablasadminobj03.dbf' size 500M
  AUTOEXTEND ON
      NEXT 1024K
      MAXSIZE 1G
  extent management local autoallocate
  segment space management auto;

create tablespace admin_usr_index_ts
datafile '/u01/app/oracle/oradata/ROSUPROY/indexadminusers.dbf' size 20M,
'/u01/app/oracle/oradata/ROSUPROY/disk_2/indexadminusers02.dbf' size 20M,
'/u01/app/oracle/oradata/ROSUPROY/disk_3/indexadminusers03.dbf' size 20M
  AUTOEXTEND ON
      NEXT 1024K
      MAXSIZE 100M
  extent management local autoallocate
  segment space management auto;

create tablespace admin_obj_index_ts
datafile '/u01/app/oracle/oradata/ROSUPROY/indexadminobj.dbf' size 20M,
'/u01/app/oracle/oradata/ROSUPROY/disk_2/indexadminobj02.dbf' size 20M,
'/u01/app/oracle/oradata/ROSUPROY/disk_3/indexadminobj03.dbf' size 20M
  AUTOEXTEND ON
      NEXT 1024K
      MAXSIZE 100M
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace admin_usr_blob_ts
datafile '/u01/app/oracle/oradata/ROSUPROY/disk_4/blobadminusers.dbf' size 1G
  AUTOEXTEND ON
      NEXT 3M
      MAXSIZE 4G
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace admin_obj_blob_ts
datafile '/u01/app/oracle/oradata/ROSUPROY/disk_4/blobadminobj.dbf' size 5G
  AUTOEXTEND ON
      NEXT 18M
      MAXSIZE 10G
  extent management local autoallocate
  segment space management auto;
