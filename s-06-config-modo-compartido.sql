-- @Integrantes:   Rosales Romero Ricardo
--                 Suaréz Espinoza Mario Alberto
-- @Fecha:         04 de febrero de 2021
-- @Descripcion:   Configura el modo compartido en la base de datos.
--                 Para poder registrar en el listener se necesita que esté
--                 habilitado.

-- Conectando como sys
connect sys/system as sysdba

-- Configura 2 dispatchers empleando el protocolo TCP
alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=both;

-- Configura 4 shared servers
alter system set shared_servers=4 scope=both;

-- Actualiza la configuración en el listener
alter system register;
