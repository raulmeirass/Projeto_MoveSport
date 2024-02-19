create database MoveSport;
use MoveSport;

-- TABELA EMPRESA = relaciona com a sua respectiva unidade
create table Empresa (
idEmpresa int primary key auto_increment,
NomeEmpresa varchar (45),
CNPJ char (8)
); 

-- TABELA UNIDADE DA EMPRESA = 1 empresa tem várias unidades(lojas) e 1 unidade só tem 1 empresa
create table Unidade (
idUnidade int primary key auto_increment,
NomeUnidade varchar (45),
CEP varchar (45),
número int,
fkEmpresa int,
foreign key (fkEmpresa) references Empresa (idEmpresa)
); 

-- TABELA CADASTRO DO FUNCIONÁRIO = independente da Unidade -> 1 unidade(loja) tem vários funcionários e 1 funcionário só trabalha em 1 loja
create table usuario (
id int primary key auto_increment,
nome varchar(45),
cpf varchar(45),
tel varchar (45),
email varchar(45),
senha varchar(45)
);

create table aquario (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(300)
);

/* altere esta tabela de acordo com o que está em INSERT de sua API do arduino */

create table medida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dht11_umidade DECIMAL,
	dht11_temperatura DECIMAL,
	luminosidade DECIMAL,
	lm35_temperatura DECIMAL,
	chave TINYINT,
	momento DATETIME default current_timestamp,
	fk_aquario INT,
	FOREIGN KEY (fk_aquario) REFERENCES aquario(id)
);


-- fkUnidade int,
	-- foreign key (fkUnidade) references Unidade (idUnidade)

-- TABELA CORREDOR = independente da Unidade -> 1 unidade(loja) tem vários corredores e 1 corredor só esta em 1 unidade
create table Corredor (
idCorredor int primary key auto_increment,
Setor varchar (45),
NumeroCorredor int, check (NumeroCorredor > 0),
fkUnidade int,
foreign key (fkUnidade) references Unidade (idUnidade)
); 

-- TABELA SENSOR = independente do corredor -> 1 corredor tem 1 ou + sensores e 1 sensor só esta em 1 unico corredor
create table Sensor (
idSensor int primary key auto_increment,
fkCorredor int,
foreign key (fkCorredor) references Corredor (idCorredor)
);

-- TABELA DADOS DO SENSOR = depende do Sensor -> 1 sensor tem vários dados e 1 dado só pertence a 1 único sensor
create table DadosSensor (
idDadosSensor int auto_increment,
sinal char (1),
check (sinal = 0 or sinal = 1),
dtHora datetime,
fkSensor int,
primary key (idDadosSensor,fkSensor),
foreign key (fkSensor) references Sensor (idSensor)
);

-- mostrando todas as tabelas ligadas, usando apelidos
select * from Empresa join Unidade as un
	on Empresa.idEmpresa = un.fkEmpresa
    join Funcionario as f on un.idUnidade = f.fkUnidade
    join Corredor as c on un.idUnidade = c.fkUnidade
    join Sensor as s on c.idCorredor = s.fkCorredor
    join DadosSensor as ds on s.idSensor = ds.fkSensor;
    
    
    -- ====================================================================================================================================
    -- ====================================================================================================================================
    -- ====================================================================================================================================
    
    select * from aquario;

    
	update aquario set descricao = "aquario 3" where id = 3;
    	
    insert into medida (id, dht11_umidade, dht11_temperatura, luminosidade, lm35_temperatura, chave, fk_aquario) values
    (null, '72', '23','22','860','1', 1);
    
    insert into medida (id, dht11_umidade, dht11_temperatura, luminosidade, lm35_temperatura, chave, fk_aquario) values
    (null, '71', '22','23','850','0', 4),
    (null, '71', '22','23','850','0', 4),
    (null, '70', '22','23','870','0', 4),
    (null, '70', '22','23','870','0', 4),
    (null, '70', '23','23','850','0', 4),
    (null, '70', '23','23','850','0', 4),
    (null, '72', '23','23','850','0', 4),
    (null, '71', '23','23','850','0', 4),
    (null, '70', '22','22','860','1', 4),
    (null, '72', '22','22','860','1', 4),
    (null, '72', '22','22','870','0', 4),
    (null, '72', '22','23','870','0', 4),
    (null, '70', '23','23','860','0', 4),
    (null, '70', '23','23','860','1', 4),
    (null, '71', '23','23','860','1', 4);
    
select * from medida order by id desc;
truncate medida;
select * from usuario;

-- pegou soma da contagem de chave (1) qtnd de minutos * sutraiu o 10 com 0 no segundos 09:03:27 - 27 
-- agrupa pelo minuto atual

select sum(chave) as chave, date_add(momento, INTERVAL second(momento) * -1 SECOND) as minuto from medida where fk_aquario = ${idAquario} 
group by date_add(momento, INTERVAL second(momento) * -1 SECOND)
order by id desc limit ${limite_linhas};

select date_add(current_timestamp(), INTERVAL second(current_timestamp()) * -1 SECOND);

insert into medida (chave, momento, fk_aquario) values (1, current_timestamp(), 1);
insert into medida (id, chave, momento, fk_aquario) values (null, 1, current_timestamp(), 2);
insert into medida (id, chave, momento, fk_aquario) values (null, 1, current_timestamp(), 3);
insert into medida (id, chave, momento, fk_aquario) values (null, 1, current_timestamp(), 4);


select count(chave) from medida where fk_aquario = 2 and momento = '2022-05-24 13:50:49';
select count(chave) from medida where fk_aquario = 3 and momento = '2022-05-24 13:51:45';
select count(chave) from medida where fk_aquario = 4 and momento = '2022-05-24 13:53:14';

    
    
    