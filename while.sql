delimiter $

CREATE PROCEDURE compteur(in n int)
BEGIN

    DECLARE i int default 2;
    while i<=n DO
        if i%2=0 then
            SELECT i;
        end if;
        set i=i+1;
    end while;

END $

delimiter ;
