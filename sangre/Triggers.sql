Use RegistroDonantesSangre;	
INSERT INTO Donacion(DonarDeNuevo) 
SELECT DATE_ADD(fechaDonacion,INTERVAL 6 MONTH) FROM Datos_Personales WHERE id_Datos_Personales = 1;

-- trigger
show triggers;

delimiter $$
 create trigger entrada after insert On Donacion
 for each ROW
 begin
declare idc int default 0;
declare idc_2 int default 0;
set idc=NEW.idcantidad_total; -- catintidad total que tenemos registrado 
set idc_2=NEW.cantidad; -- cantidad de sangre que se va a +- 
 update Bolsa_sangre set cantidad=cantidad+idc_2 where idcantidad_total=idc;
 end$$
 delimiter ;

-- trigger 
show triggers;

delimiter $$
 create trigger Salida after insert On Exportacion
 for each ROW
 begin
declare idc int default 0;
declare idc_2 int default 0;
set idc=NEW.idcantidad;
set idc_2=NEW.cantidad;
 update Bolsa_sangre set cantidad=cantidad-idc_2 where idcantidad_total=idc;
 end$$
 delimiter ;
 
 -- Agregar al inventario
 INSERT INTO `registrodonantessangre`.`Almacen` (`nombre`, `cantidad`, `idproducto`) VALUES ('Sangre', '10', '1');
select * from Almacen ;
-- trigger
show triggers;

DROP TRIGGER entrada;

delimiter $$
 create trigger entrada after insert On Donacion
 for each ROW
 begin
declare idp int default 0;
declare idc int default 0;
set idp=NEW.idproducto; -- catintidad total que tenemos registrado 
set idc=NEW.cantidad; -- cantidad de sangre que se va a +- 
 update Almacen set cantidad=cantidad+idc where idproducto=idp;
 end$$
 delimiter ;
 
 
 -- Sacar del inventario
 INSERT INTO `registrodonantessangre`.`Exportacion` (`cantidad`, `idproducto`) VALUES ('200', '1');

select * from Exportacion;
delimiter $$
 create trigger salida after insert On Exportacion
 for each ROW
 begin
declare idp int default 0;
declare idc int default 0;
set idp=NEW.idproducto; -- catintidad total que tenemos registrado 
set idc=NEW.cantidad; -- cantidad de sangre que se va a +- 
 update Almacen set cantidad=cantidad-idc where idproducto=idp;
 end$$
 delimiter ;