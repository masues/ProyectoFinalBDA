#!/bin/bash
# @Integrantes: 	Rosales Romero Ricardo
#                 Suárez Espinoza Mario Alberto
# @Fecha:         04 de febrero de 2021
# @Descripción:   Script para crear el directorio faltante (archivelog)
#                 EL SCRIPT DEBE EJECUTARSE CON EL USUARIO ROOT

#Si no se usa a root, el script termina
if ! [ ${USER} = "root" ]; then
  echo "ERROR: El script debe ejecutarse con el usuario root"
  exit 1
fi

mkdir -p /u01/app/oracle/oradata/ROSUPROY/disk_1/archivelog/
chown oracle.oinstall /u01/app/oracle/oradata/ROSUPROY/disk_1/archivelog/
chmod 755 /u01/app/oracle/oradata/ROSUPROY/disk_1/archivelog/