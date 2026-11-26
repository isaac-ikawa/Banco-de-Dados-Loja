
create database if not exists Loja;

use Loja;

create table Estado(
ID int primary key auto_increment,
Nome varchar(100) not null,
UF varchar(2) not null
);

create table Municipio (
ID int primary key auto_increment,
FK_EstadoID int not null,
Nome varchar(100) not null,
codIBGE int not null,
foreign key (FK_EstadoID) references Estado(ID)
);

create table Cliente (
ID int primary key auto_increment,
Nome varchar(80) not null,
CPF varchar(11) not null,
Celular varchar(11) not null,
Endlogradouro varchar(100) not null,
EndNumero varchar (10) not null,
EndMunicipio int not null,
EndCEP char(8) not null,
FK_Municipio_ID int not null,
foreign key (FK_Municipio_ID) references Municipio(ID)
);

create table ContaReceber(
ID int primary key auto_increment,
FK_Cliente_ID int not null,
FaturaVendaID int not null,
DataConta date not null,
DataVencimento date not null,
Valor decimal (18,2) not null,
Situacao enum ('1','2','3') not null,
foreign key (FK_Cliente_ID) references cliente(ID)
);


INSERT INTO Estado (Nome, UF) VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG');

select * from Estado;

INSERT INTO Municipio (FK_EstadoID, Nome, CodIBGE) VALUES
(1, 'São Luiz ', 3550308),
(2, 'São João' ,3304557),
(3, 'Santo Antonio', 3106200);

select * from Municipio;

INSERT INTO Cliente
(Nome, CPF, Celular, EndLogradouro, EndNumero, EndMunicipio, EndCEP, FK_Municipio_ID) VALUES
('Ana Silva', '98765432101', '9876543210', 'Rua A', '123', 1, '98765432', 1),
('José Santos', '12345678910', '1234567890', 'Rua B', '456', 2, '12345678', 2),
('Maria Oliveira', '45678912310', '4567891230', 'Rua C', '789', 3, '45678912', 3);

select * from cliente;


INSERT INTO ContaReceber
(FK_Cliente_ID, FaturaVendaID, DataConta, DataVencimento, Valor, Situacao) VALUES
(1, 105, '2024-08-06', '2025-05-15', 100.00, '1'),
(2, 106, '2024-04-07', '2025-03-15', 200.00, '2'),
(3, 107, '2024-06-25', '2025-04-20', 300.00, '3');

create view ContasNaoPagas as
select CR.ID as 'ID da conta a receber',
	C.Nome as 'Nome do Cliente',
    C.CPF as 'CPF do Cliente',
    CR.DataVencimento as 'Data de venciemnto',
    CR.Valor as 'Valor da conta'
from ContaReceber  CR
join Cliente C on CR.Fk_Cliente_ID = C.ID
where CR.Situacao = '1';    

select * from ContasNaoPagas;

select * from ContaReceber;


