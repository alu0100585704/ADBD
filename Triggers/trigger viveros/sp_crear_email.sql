CREATE DEFINER=`usuario`@`%` PROCEDURE `crear_email`(INOUT email VARCHAR(45),IN dominio VARCHAR(20))
BEGIN    

    set email =  (select  concat(email , dominio));    
END