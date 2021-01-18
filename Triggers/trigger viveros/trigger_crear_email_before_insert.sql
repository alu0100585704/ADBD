DROP TRIGGER IF EXISTS `viverosDB`.`CLIENTES_BEFORE_INSERT`;
DELIMITER $$
CREATE DEFINER=`usuario`@`%` TRIGGER `viverosDB`.`CLIENTES_BEFORE_INSERT` BEFORE INSERT ON `CLIENTES` FOR EACH ROW
BEGIN

IF NEW.email is NULL THEN
    
    #Selecciono los dos primeros caracters del nombre y los dos primeros del primer apellido
    
	set New.email = (select concat((select substring(New.Nombre,1,2)),(select substring(New.Apellido1,1,2))));
            
	CALL crear_email(NEW.email,'.miempresa.com');
    
end if;

END$$
DELIMITER ;