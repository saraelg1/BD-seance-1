DELIMITER $

evaluer_stock si le stock < 5 ==> "A commander" sinon "OK"

create PROCEDURE verifier_stock(in p_id INT)
BEGIN
    DECLARE v_stock int;

    set v_stock=(
        SELECT stock
        from produits
        WHERE id=p_id
    );

    if v_stock > 10 then
        select 'Produit disponible';
    else
        select 'Produit indisponible';
    end if;

END $

DELIMITER ;

call verifier_stock(3);





