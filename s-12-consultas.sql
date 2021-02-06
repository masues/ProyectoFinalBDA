-- Muestra información general de los tablespaces
select * from v$tablespace;

-- Muestra infromación de los data files
select file_name, blocks, tablespace_name
from dba_data_files;

-- Muestra los usuarios
select * from all_users;

-- Información de los virtual circuits de usuarios que se conectan via
-- dispatcher
select * from v$circuit;

-- A nivel SO se puede consultar el estado del listener
-- lsnrctl services

-- Uso de la FRA
select 
   name,
  floor(space_limit / 1024 / 1024) "Size MB",
  ceil(space_used / 1024 / 1024) "Used MB"
from v$recovery_file_dest;

-- Archivos que contiene la FRA
select * from v$flash_recovery_area_usage;

-- Lista el uso de archive log
archive log list;

-- Muestra las configuraciones aplicadas a RMAN
select * from  v$rman_configuration;

-- Muestra el estado del block change tracking
select status, filename from v$block_change_tracking;

-- Consulta para revisar los objetos y sus ofertantes
-- Debe realizarse con el ususario rrr_admin_objects
select o.nombre, o.descripcion, o.tipo, ofe.oferta_ganadora, 
  u.nombre "OFERTANTE", a.anio, c.direccion, h.extension
from objeto o
join oferta ofe
on ofe.objeto_id = o.objeto_id
join mse_admin_users.usuario u
on u.usuario_id = ofe.usuario_id
left join auto a
on a.objeto_id = o.objeto_id
left join casa c
on c.objeto_id = o.objeto_id
left join hacienda h
on h.objeto_id = o.objeto_id;