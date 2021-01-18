DROP TRIGGER IF EXISTS `mydb`.`PERSONA_BEFORE_INSERT`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`PERSONA_BEFORE_INSERT` BEFORE INSERT ON `PERSONA` FOR EACH ROW
BEGIN
	
	if NEW.letra IS NOT NULL AND NEW.PLANTA IS NOT NULL AND NEW.NUMERO_PISO IS NOT NULL AND NEW.CALLE_PISO IS NOT NULL AND    
    NEW.NUMERO_UNIFAMILIAR IS NULL AND NEW.CALLE_UNIFAMILIAR IS NULL  THEN
	
            set New.letra = New.letra;
    
    ELSEIf  NEW.letra IS NULL AND NEW.PLANTA IS NULL AND NEW.NUMERO_PISO IS NULL AND NEW.CALLE_PISO IS null  AND
    NEW.NUMERO_UNIFAMILIAR IS NOT NULL AND NEW.CALLE_UNIFAMILIAR IS NOT NULL  THEN
    
			set New.numero_unifamiliar = New.numero_unifamiliar;
    else		
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Registro no agregado, no puede tener dirección en un piso y una casa unifamiliar a la vez, o bien, falta algún dato de la direccion de piso o de unifamiliar';
    END IF;    
    
    ## Lo que hago es comprobar que no existe esta misma persona dada de alta con otra fecha de inicio en la que 
    ##aún no haya finalizado su contrato. Para que una persona pueda vivir y mudarse a otro sitio, previamente
    #debe de ponerse su campo fecha_fin  con la fecha de cuando terminó, por eso, si hay algún registro para el dni
    #en cuestión que contenga fecha_fin a null, significa que aún vive en otro sitio
    
    set @yaviveenotrositio= (select dni from PERSONA WHERE dni=new.dni and fecha_fin is null);    
    if @yaviveenotrositio is not null then
			SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Esta persona aún vive en otro sitio';	
    end if;
    
    
END
$$
DELIMITER ;