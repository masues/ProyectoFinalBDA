#!/bin/bash
#Integrantes: Rosales Romero Ricardo, Suárez Espinoza Mario Alberto
#Fecha: 03 de febrero de 2021
#Creacion de los directorios necesarios para create database

#Directorios correspondientes los Redo Log, data files, control files, archivelog
#Los discos independientes están en las carpetas dentro de $ORACLE_BASE

mkdir -p /u01/app/oracle/oradata/ROSUPROY/ 
		  /u01/app/oracle/oradata/ROSUPROY/disk_1 \
		  /u01/app/oracle/oradata/ROSUPROY/disk_2 \
          /u01/app/oracle/oradata/ROSUPROY/disk_3 \
          /u01/app/oracle/oradata/ROSUPROY/disk_4 \
          /u01/app/oracle/oradata/ROSUPROY/disk_5/fast_recovery_area 

#Para cambiar de propietario(oracle) los directorios

	cd /u01/app/oracle/oradata/
	chown oracle.oinstall ROSUPROY
	cd /u01/app/oracle/oradata/ROSUPROY/
	chown oracle.oinstall disk_1
	chown oracle.oinstall disk_2 
    chown oracle.oinstall disk_3 
    chown oracle.oinstall disk_4 
    chown oracle.oinstall disk_5 

#Para cambiar los permisos a los directorios

	chmod 755 /u01/app/oracle/oradata/ROSUPROY
	chmod 755 /u01/app/oracle/oradata/ROSUPROY/disk_1
	chmod 755 /u01/app/oracle/oradata/ROSUPROY/disk_2
    chmod 755 /u01/app/oracle/oradata/ROSUPROY/disk_3
	chmod 755 /u01/app/oracle/oradata/ROSUPROY/disk_4
    chmod 755 /u01/app/oracle/oradata/ROSUPROY/disk_5
				