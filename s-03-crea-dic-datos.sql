-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         03 de febrero de 2021
-- @Descripcion:   Creacion de diccionario de datos.
--                 Es necesario que se haya exportado la varable ORACLE_SID
--                 antes de ejecutarlo.
--                 export ORACLE_SID=rosuproy

prompt Conectando como sys
connect sys/system as sysdba

@?/rdbms/admin/catalog.sql 
@?/rdbms/admin/catproc.sql 
@?/rdbms/admin/utlrp.sql

prompt Conectando como system
connect system/system

@?/sqlplus/admin/pupbld.sql
