
/*01*/
create role 'read_only';
grant select on `uc4atividades`.* to 'read_only';

create user 'antonio_carlos'@'local host' identified by '111111';
grant 'read_only' to 'antonio_carlos'@'local host';

flush privileges;

/*02*/
create role 'funcionario';
grant select, insert on  `uc4atividades`.venda
to 'funcionario';
grant select, insert on  `uc4atividades`.cliente
to 'funcionario';
grant select, insert on  `uc4atividades`.produto
to 'funcionario';

create user 'lucas_amaral'@'local host' identified by '222222';
grant 'funcionario' to 'lucas_amaral'@'local host';

/*03*/
update usuario set senha = md5('12345') where id = 1;
update usuario set senha = md5('67890') where id = 2;
update usuario set senha = md5('1q2w3e') where id = 3;
update usuario set senha = md5('sil123') where id = 4;
update usuario set senha = md5('ama123') where id = 5;
update usuario set senha = md5('mar123') where id = 6;
update usuario set senha = md5('dom123') where id = 7;
update usuario set senha = md5('mar123') where id = 8;
update usuario set senha = md5('joa123') where id = 9;
update usuario set senha = md5('apa123') where id = 10;
update usuario set senha = md5('fil123') where id = 11;