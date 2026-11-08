delimiter $

CREATE PROCEDURE evaluer_stock(in pid int)
BEGIN
    DECLARE v_stock INT;
    set v_stock=(
        SELECT stock
        from produits
        where id=pid
    );

    if v_stock < 20 THEN
        SELECT 'A commander';
    ELSE
        SELECT 'OK';
    END IF;
end $

delimiter ;
