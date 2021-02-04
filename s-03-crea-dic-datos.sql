-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         03 de febrero de 2020
-- @Descripcion:   Creacion de diccionario de datos.

export ORACLE_SID=rosuproy

sqlplus sys as sysdba

@?/rdbms/admin/catalog.sql 
@?/rdbms/admin/catproc.sql 
@?/rdbms/admin/utlrp.sql

startup
disconnect

sqlplus system/system

@?/sqlplus/admin/pupbld.sql

disconnect

