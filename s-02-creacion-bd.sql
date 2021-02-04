--Integrantes: Rosales Romero Ricardo, Suaréz Espinoza Mario Alberto
--Fecha: 03 de febrero de 2020
--Creacion de base de datos en modo ARCHIVE, grupos de redo logs y tablespaces comunes a los modulos
--modificar tamaños y numero de datafiles
--para los grupos de redo se recomiendo un tamaño >4gb, por cuestiones de espacio se ponen de 50m


create database rosuproy 
	user sys identified by system2
	user system identified by system2
	logfile group 1 (
		'/u01/app/oracle/oradata/ROSUPROY/redo01a.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_2/redo01b.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_3/redo01c.log') size 50m blocksize 512,
	group 2 (
		'/u01/app/oracle/oradata/ROSUPROY/redo02a.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_2/redo02b.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_3/redo02c.log') size 50m blocksize 512,
	group 3 (
		'/u01/app/oracle/oradata/ROSUPROY/redo03a.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_2/redo03b.log',
		'/u01/app/oracle/oradata/ROSUPROY/disk_3/redo03c.log') size 50m blocksize 512
	maxloghistory 1
	maxlogfiles 4
	maxlogmembers 5
	maxdatafiles 100
	ARCHIVELOG
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
    tablespace admin_usr_ts
        datafile '/u01/app/oracle/oradata/ROSUPROY/tablasadminusers.dbf' size 400M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_2/tablasadminusers02.dbf' size 400M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_3/tablasadminusers03.dbf' size 400M
        AUTOEXTEND ON
            NEXT 1024K
            MAXSIZE 1G
        extent management local autoallocate
        segment space management auto
    tablespace admin_obj_ts
        datafile '/u01/app/oracle/oradata/ROSUPROY/tablasadminobj.dbf' size 500M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_2/tablasadminobj02.dbf' size 500M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_3/tablasadminobj03.dbf' size 500M
        AUTOEXTEND ON
            NEXT 1024K
            MAXSIZE 1G
        extent management local autoallocate
        segment space management auto
    tablespace admin_usr_index_ts
        datafile '/u01/app/oracle/oradata/ROSUPROY/indexadminusers.dbf' size 20M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_2/indexadminusers02.dbf' size 20M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_3/indexadminusers03.dbf' size 20M
        AUTOEXTEND ON
            NEXT 1024K
            MAXSIZE 100M
        extent management local autoallocate
        segment space management auto
    tablespace admin_obj_index_ts
        datafile '/u01/app/oracle/oradata/ROSUPROY/indexadminobj.dbf' size 20M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_2/indexadminobj02.dbf' size 20M,
		 '/u01/app/oracle/oradata/ROSUPROY/disk_3/indexadminobj03.dbf' size 20M
        AUTOEXTEND ON
            NEXT 1024K
            MAXSIZE 100M
        extent management local autoallocate
        segment space management auto
    bigfile tablespace admin_usr_blob_ts
        datafile '/u01/app/oracle/oradata/ROSUPROY/blobadminobj.dbf' size 1G,
        AUTOEXTEND ON
            NEXT 3M
            MAXSIZE 4G
        extent management local autoallocate
        segment space management auto
    bigfile tablespace admin_obj_blob_ts
        datafile '/u01/app/oracle/oradata/ROSUPROY/blobadminobj.dbf' size 5G,
        AUTOEXTEND ON
            NEXT 18M
            MAXSIZE 10G
        extent management local autoallocate
        segment space management auto;
        
alter user sys identified by system2;
alter user system identified by system2;
