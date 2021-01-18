DROP TRIGGER IF EXISTS `viverosDB`.`PRODUCTO_BEFORE_UPDATE`;
DELIMITER $$
CREATE DEFINER=`usuario`@`%` TRIGGER `viverosDB`.`PRODUCTO_BEFORE_UPDATE` BEFORE UPDATE ON `PRODUCTO` FOR EACH ROW
BEGIN
	#como no tengo realmente una tabla de compras, he agregado un campo 'cantidad' que indica
    #la cantidad de elementos de ese producto en concreto que se deben agregar al stock
    #simulando una compra.
    if @disparado_desde_producto IS null then
    set New.stock = old.stock + New.cantidad;
    end if;
    
END$$
DELIMITER ;