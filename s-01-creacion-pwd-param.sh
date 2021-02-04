#!/bin/bash
# @Integrantes: 	Rosales Romero Ricardo
#                 Suárez Espinoza Mario Alberto
# @Fecha:         03 de febrero de 2021
# @Descripción:   Creacion del archivo de parámetros y del archivo de passwords
#                 Este script debe ejecutarse con el usuario ORACLE

#Si no se usa a oracle, el script termina
if ! [ ${USER} = "oracle" ]; then
  echo "ERROR: El script debe ejecutarse con el usuario oracle"
  exit 1
fi

echo "Establece temporalmente la variable ORACLE_SID con el valor rosuproy"
export ORACLE_SID=rosuproy

echo "Crea un archivo de passwords con los usuarios SYS y SYSBACKUP"
echo "con password = Hola1234#"
# Se envia la contraseña y se redirecciona como entrada del comando orapwd
echo Hola1234# | \
orapwd FILE=${ORACLE_HOME}/dbs/orapw${ORACLE_SID} FORCE=y \
  SYS=password \
  SYSBACKUP=password \
  password=Hola1234#

echo "Creando archivo de parámetros"
archivoParametros=${ORACLE_HOME}/dbs/init${ORACLE_SID}.ora
rm -f ${archivoParametros}
touch ${archivoParametros}
# Nombre de la base de datos
echo "db_name=${ORACLE_SID}" >> ${archivoParametros}
# Ubicación de control files
echo "control_files=(
  /u01/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl,
  /u02/app/oracle/oradata/${ORACLE_SID^^}/disk_1/control02.ctl
)" >> ${archivoParametros}
# Automatic Shared Memory Management
echo "memory_target=0" >> ${archivoParametros}
echo "sga_target=500M" >> ${archivoParametros}
echo "pga_aggregate_target=268M" >> ${archivoParametros}
# Dominio de la base de datos
echo "db_domain=gob.mx" >> ${archivoParametros}
# Tamaño del bloque de datos
echo "db_block_size=8192" >> ${archivoParametros}
