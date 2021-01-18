DROP TRIGGER IF EXISTS `viverosDB`.`CONSTA_AFTER_INSERT`;
DELIMITER $$
CREATE DEFINER=`usuario`@`%` TRIGGER `viverosDB`.`CONSTA_AFTER_INSERT` AFTER INSERT ON `CONSTA` FOR EACH ROW
BEGIN
	DECLARE tmp int(11);
	#recupero el valor actual de stock para el producto seleccionado y después le resto la cantidad que he indicado.
    #después actualizo el producto de la tabla producto
    
    set tmp = (select stock from PRODUCTO where CODIGO_BARRAS= New.CODIGO_BARRAS_PRODUCTO);
    set tmp = tmp - new.cantidad;
    
     #con esta variable global, impido que se ejecute el trigger PRODUCTO_BEFORE_UPDATE
     set @disparado_desde_producto = 1;
    UPdate PRODUCTO
	set stock = tmp
    where CODIGO_BARRAS = new.CODIGO_BARRAS_PRODUCTO;
    
    # Vuelvo a permitir el trigger PRODUCTO_BEFORE_UPDATE
    set @disparado_desde_producto = NULL;
    
END$$
DELIMITER ;