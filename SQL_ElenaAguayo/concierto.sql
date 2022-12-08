/* 
Elena Aguayo Jara
Máster en Bioinformática y Biología Computacional - Universidad Autónoma de Madrid
Base de datos relacional creada mediante PostgreSQL
25/11/2022
*/

-- CONCIERTOS --

CREATE TABLE Concierto
	(
	id_prox_concierto integer PRIMARY KEY, 	-- Identificador único
	fecha	timestamp,						-- Fecha y hora a la que es el concierto
	ciudad	varchar(20),					-- Ciudad donde es el concierto
	sala	varchar(20),					-- Sala donde se realiza el concierto
	publico integer,						-- Aforo de la sala
	otro_concierto varchar(20)				-- Próximos conciertos 
	);
	
CREATE TABLE Artista
	(
	id_artista	integer PRIMARY KEY,					-- Identificador único
	id_prox_concierto integer REFERENCES Concierto, 	-- Referencia a la primary key (id_concierto) de la tabla Concierto
	nombre_artista	varchar(20), 						-- Nombre del artista o banda de música
	estilo_musica	varchar(20),						-- Estilo de música del artista
	fecha_creacion integer,								-- Fecha en la que se formó la banda de música
	numero_disco integer,								-- Número de discos publicados por el artista o banda de música
	origen varchar(20),									-- Origen del artista o banda
	num_mujer integer									-- Número de mujeres integrantes de cada banda de música o artistas en solitario que son mujeres
	);
	
CREATE TABLE Concierto_Artista
	(
	id_prox_concierto integer REFERENCES Concierto, 	-- Referencia a la primary key (id_concierto) de la tabla Concierto
	id_artista	integer	REFERENCES Artista,				-- Referencia a la primary key (id_artista) de la tabla Artista
	PRIMARY KEY (id_prox_concierto, id_artista)			-- Ambas claves foráneas se convierte en claves primarias
	);


CREATE TABLE Entrada
	(
	id_entrada integer PRIMARY KEY,						-- Identificador único
	id_prox_concierto integer REFERENCES Concierto,		-- Referencia a la primary key (id_concierto) de la tabla Concierto
	precio_entrada	float(10) NOT NULL,					-- Precio general de la entrada
	user_cambio varchar(20)								-- Usuario que realiza el cambio de precio al ejecutar el trigger					
	);
 

CREATE TABLE Web
	(
	id_web integer PRIMARY KEY,   						-- Identificador único
	id_prox_concierto integer REFERENCES Concierto,		-- Referencia a la primary key (id_concierto) de la tabla Concierto
	id_artista integer REFERENCES Artista,				-- Referencia a la primary key (id_artista) de la tabla Artista
	enlace varchar(50),									-- Enlace a la página web de venta de entradas
	precio_web integer	NOT NULL 						-- Precio de la entrada en la página web	
	);

	
CREATE TABLE Taquilla
	(
	id_taquilla integer PRIMARY KEY, 					-- Identificador único
	id_prox_concierto integer REFERENCES Concierto, 	-- Referencia a la primary key (id_concierto) de la tabla Concierto
	id_artista integer REFERENCES Artista,				-- Referencia a la primary key (id_artista) de la tabla Artista
	direccion_taquilla varchar(50),						-- Dirección donde se encuentra la taquilla
	precio_taquilla integer NOT NULL					-- Precio de la entrada en taquilla
	);


CREATE Table Cliente_1
	(
	DNI_cliente_1 varchar(50) PRIMARY KEY,				-- Identificador único (DNI del comprador de entrada via web)
	id_web	integer REFERENCES Web, 					-- Refrencia a la primary key (id_web) de la tabla Web		
	id_prox_concierto integer REFERENCES Concierto, 	-- Referencia a la primary key (id_concierto) de la tabla Concierto
	id_artista integer REFERENCES Artista,				-- Referencia a la primary key (id_artista) de la tabla Artista
	nombre_cliente1 varchar(20) NOT NULL,				-- Nombre del comprador de la entrada vía web
	apellido varchar(20)	NOT NULL,					-- Apellido del comprador de la entrada vía web
	correo_electronico varchar(50) NOT NULL,			-- Correo electrónico del comprador de la entrada vía web
	cuenta_bancaria varchar(50) NOT NULL				-- Cuenta bancaria del comprador de la entrada vía web
	);

	
CREATE TABLE Cliente_2
	(
	DNI_cliente_2 varchar(50) PRIMARY KEY,	            -- Identificador único (DNI del comprador de entrada en taquilla)
	id_taquilla integer REFERENCES Taquilla,	        -- Referencia a la primary key (id_taquilla) de la tabla Taquilla
	id_prox_concierto integer REFERENCES Concierto,     -- Referencia a la primary key (id_concierto) de la tabla Concierto
	id_artista integer REFERENCES Artista,              -- Referencia a la primary key (id_artista) de la tabla Artista
	nombre_cliente2 varchar(20) NOT NULL,				-- Nombre del comprador de la entrada en taquilla
	apellido varchar(20) NOT NULL						-- Apellido del comprador de la entrada en taquilla
	);
	
CREATE TABLE entrada_old  			-- Esta entidad guarda el precio de la entrada (precio_entrada) antes de que el trigger modifique el precio
	(
	id_entrada integer PRIMARY KEY,
	id_prox_concierto integer REFERENCES Concierto,
	precio_entrada float(10),
	user_cambio varchar(20)
	);
	
	
	
INSERT INTO Concierto VALUES(1,'2022-09-26 19:00','Madrid','Wizink Center',10.600,'Barcelona');
INSERT INTO Concierto VALUES(2,'2022-09-27 19:00','Madrid','Wizink Center',30.000,'Barcelona');	
INSERT INTO Concierto VALUES(3,'2022-09-29 20:00','Barcelona','Sala Apolo',1.200,'Londres');
INSERT INTO Concierto VALUES(4,'2022-10-02 20:00','Munich','Allianz Arena',40.000,'Londres');
INSERT INTO Concierto VALUES(5,'2022-10-03 20:00','Barcelona','Razzmatazz',2.300,'Madrid' );
INSERT INTO Concierto VALUES(6,'2022-10-04 21:15','Barcelona','Sant Jordi Club', 4.620,'Valencia');
INSERT INTO Concierto VALUES(7,'2022-10-05 21:00','Barcelona','Palau Sant Jordi',17.960,'Madrid');
INSERT INTO Concierto VALUES(8,'2022-11-10 22:00','Murcia','REM', 1.000,'Sevilla');
INSERT INTO Concierto VALUES(9,'2022-11-15 19:30','Madrid','Ochoymedio', 1.000,'Valencia');
INSERT INTO Concierto VALUES(10,'2022-11-15 20:00','Murcia','REM',1.000,'Girona');
INSERT INTO Concierto VALUES(11,'2022-12-08 21:30','Madrid','Wizink Center',10.600,'Barcelona');

INSERT INTO Artista VALUES(1,1,'Simple Plan','Punk',1999,8,'Canadá',0);
INSERT INTO Artista VALUES(2,2,'Sum41','Punk',1996,10,'Canadá',0);
INSERT INTO Artista VALUES(3,3,'PVRIS','Pop Rock Electrónico',2012,3,'Estados Unidos',1);
INSERT INTO Artista VALUES(4,4,'Maneskin','Rock',2016,2,'Italia',1);
INSERT INTO Artista VALUES(5,5,'Varry Brava','Indie',2009,5,'Murcia',0);
INSERT INTO Artista VALUES(6,6,'Bastille', 'Pop',2010,6,'Irlanda',0);
INSERT INTO Artista VALUES(7,7,'Arctic Monkeys', 'Rock',2002,8,'Reino Unido',0);
INSERT INTO Artista VALUES(8,8,'Claim','Indie',2015,2,'Murcia',0);
INSERT INTO Artista VALUES(9,9,'Yonaka', 'Rock',2014,2,'Reino Unido',1);
INSERT INTO Artista VALUES(10,10,'Of Monsters & Men','Pop',2010,5,'Estados Unidos',1);
INSERT INTO Artista VALUES(11,11,'My Chemical Romance','Punk',2001,6,'Estados Unidos',0);

INSERT INTO Concierto_Artista VALUES(1,1);
INSERT INTO Concierto_Artista VALUES(2,2);
INSERT INTO Concierto_Artista VALUES(3,3);
INSERT INTO Concierto_Artista VALUES(4,4);
INSERT INTO Concierto_Artista VALUES(5,5);
INSERT INTO Concierto_Artista VALUES(6,6);
INSERT INTO Concierto_Artista VALUES(7,7);
INSERT INTO Concierto_Artista VALUES(8,8);
INSERT INTO Concierto_Artista VALUES(9,9);
INSERT INTO Concierto_Artista VALUES(10,10);
INSERT INTO Concierto_Artista VALUES(11,11);

INSERT INTO Entrada VALUES(1,1,50,null);
INSERT INTO Entrada VALUES(2,2,45,null);
INSERT INTO Entrada VALUES(3,3,55,null);
INSERT INTO Entrada VALUES(4,4,60,null);
INSERT INTO Entrada VALUES(5,5,75,null);
INSERT INTO Entrada VALUES(6,6,35,null);
INSERT INTO Entrada VALUES(7,7,43,null);
INSERT INTO Entrada VALUES(8,8,44,null);
INSERT INTO Entrada VALUES(9,9,55,null);
INSERT INTO Entrada VALUES(10,10,48,null);
INSERT INTO Entrada VALUES(11,11,65,null);

INSERT INTO Web VALUES(1,1,1,'https://www.wizink.es',40);
INSERT INTO Web VALUES(2,2,2,'https://www.wizink.es',40);
INSERT INTO Web VALUES(3,3,3,'https://www.apolo.es',52);
INSERT INTO Web VALUES(4,4,4,'https://www.arena.es',54);
INSERT INTO Web VALUES(5,5,5,'https://www.razzmatazz.es',70);
INSERT INTO Web VALUES(6,6,6,'https://www.jordiclub.es',33);
INSERT INTO Web VALUES(7,7,7,'https://www.palausantjordi.es',45);
INSERT INTO Web VALUES(8,8,8,'https://www.rem.es',39);
INSERT INTO Web VALUES(9,9,9,'https://www.ochoymedio.es',49);
INSERT INTO Web VALUES(10,10,10,'https://www.rem.es',44);
INSERT INTO Web VALUES(11,11,11,'https://www.wizink.es',60);

INSERT INTO Taquilla VALUES(1,1,1,'Avenida Felipe II',50);
INSERT INTO Taquilla VALUES(2,2,2,'Avenida Felipe II',45);
INSERT INTO Taquilla VALUES(3,3,3,'Carrer Nou de la Rambla',55);
INSERT INTO Taquilla VALUES(4,4,4,'Werner-Heisenberg-Alle 25',60);
INSERT INTO Taquilla VALUES(5,5,5,'Calle de los Almogávares',75);
INSERT INTO Taquilla VALUES(6,6,6,'Passeig Olimpic',35);
INSERT INTO Taquilla VALUES(7,7,7,'Passeig Olimpic',43);
INSERT INTO Taquilla VALUES(8,8,8,'Calle Puerta Nueva',44);
INSERT INTO Taquilla VALUES(9,9,9,'Calle de Barceló',55);
INSERT INTO Taquilla VALUES(10,10,10,'Calle Puerta Nueva',48);
INSERT INTO Taquilla VALUES(11,11,11,'Avenida Felipe II',65);

INSERT INTO Cliente_1 VALUES('48623545G',1,1,1,'Elena','Aguayo','elena@gmail.com','ES123456789');
INSERT INTO Cliente_1 VALUES('38093345E',2,2,2,'Modesto','Redrejo','modesto@uam.es','ES356756789');
INSERT INTO Cliente_1 VALUES('49073345A',3,3,3,'Jose','Dorronsoro','dorronsoro@outlook.es','ES123456854');
INSERT INTO Cliente_1 VALUES('48647854F',4,4,4,'Estrella','Pulido','estrella@gmail.com','ES123454790');
INSERT INTO Cliente_1 VALUES('48643900Y',5,5,5,'Irene','Ortin','ortin@gmail.com','ES123456432');
INSERT INTO Cliente_1 VALUES('48648965T',6,6,6,'Laura','Sempere','laura@gmail.com','ES123457538');
INSERT INTO Cliente_1 VALUES('48643354M',7,7,7,'Victoriano','Mulero','mulero@umu.es','ES128966789');
INSERT INTO Cliente_1 VALUES('43343345N',8,8,8,'Carlos','Barba','carlos@live.com','ES124796789');
INSERT INTO Cliente_1 VALUES('48886345W',9,9,9,'María','Lanzarote','lanzarote@gmail.com','ES098556789');
INSERT INTO Cliente_1 VALUES('48649085Q',10,10,10,'Alba','Baptista','alba@gmail.com','ES463256789');
INSERT INTO Cliente_1 VALUES('48643657Z',11,11,11,'Victoria','Godoy','godoy@outlook.es','ES8876578943');


INSERT INTO Cliente_2 VALUES('48843345K',1,1,1,'Elena','Pardo');                                              
INSERT INTO Cliente_2 VALUES('48843367L',2,2,2,'Mer','Hollow');
INSERT INTO Cliente_2 VALUES('48843378P',3,3,3,'Nerea','Greta');
INSERT INTO Cliente_2 VALUES('48234345R',4,4,4,'Raquel','Tarraco');
INSERT INTO Cliente_2 VALUES('48763345E',5,5,5,'Rafael','Alberti');
INSERT INTO Cliente_2 VALUES('48843345I',6,6,6,'Gerardo','Diego');
INSERT INTO Cliente_2 VALUES('43935345H',7,7,7,'Vicente','Alexaindre');
INSERT INTO Cliente_2 VALUES('48689045S',8,8,8,'Miguel','Hernández');
INSERT INTO Cliente_2 VALUES('42125645X',9,9,9,'Brandom','Sanderson');
INSERT INTO Cliente_2 VALUES('37823345N',10,10,10,'Margarita','Salas');
INSERT INTO Cliente_2 VALUES('48643345E',11,11,11,'María','Blasco');



-- QUERYS

1. Bandas de música procedentes de Murcia:

SELECT nombre_ARTISTA, origen AS Ciudad_de_origen
FROM artista
WHERE origen LIKE 'Murcia';

2. Números de discos ordenados de mayor a menor:

SELECT nombre_artista AS Banda_de_música, numero_disco AS Número_de_discos
FROM artista
WHERE numero_disco>0
ORDER BY Número_de_discos DESC;

3. Banda de música cuyo id=2, ciudad, sala y precio de la entrada 

SELECT nombre_artista AS banda_de_música, ciudad AS ciudad, sala as sala_de_conciertos, precio_entrada AS precio_€
FROM artista NATURAL INNER JOIN concierto NATURAL INNER JOIN entrada
WHERE id_prox_concierto=2;

4. Concierto al que acude Elena Pardo

SELECT nombre_cliente2, apellido, nombre_artista, ciudad, sala, fecha, precio_taquilla
FROM cliente_2 NATURAL JOIN artista NATURAL JOIN concierto NATURAL JOIN taquilla
WHERE cliente_2.nombre_cliente2='Elena';

5. Enlace web donde aparece 'wizink':

SELECT enlace
FROM web
WHERE enlace SIMILAR TO '%(W|w)izink%';

6. Bandas de música creadas antes del 2000:

SELECT fecha_creacion, nombre_artista
FROM artista
WHERE fecha_creacion < 2000;


7. Bandas de música con mujeres integrantes y el número

CREATE VIEW total_mujeres AS 
SELECT nombre_artista, count(num_mujer)
FROM artista
WHERE num_mujer >0
GROUP BY  nombre_artista

9. Número de conciertos en el Wizink Center

CREATE VIEW sala AS
SELECT sala, count(*) AS número_de_conciertos
FROM concierto
WHERE concierto.sala='Wizink Center'
GROUP BY concierto.sala;

10. Número de grupos que tocan música Pop

CREATE VIEW pop AS
SELECT estilo_musica, count(*) AS número_de_grupos
FROM artista
WHERE estilo_musica='Pop' 
GROUP BY artista.estilo_musica
HAVING count(*) >0
ORDER BY estilo_musica

11. Añadir columna a la tabla cliente_1 y actualizar a not tnull

ALTER TABLE cliente_1
Add Column edad varchar(10)

UPDATE cliente_1 set edad = 'más de 18'

ALTER TABLE cliente_1
ALTER Column edad set not null

12. Suma del número de muejeres en total

SELECT sum (num_mujer)
FROM artista

12. Banda de música con la entrada al precio más bajo

SELECT nombre_artista
FROM artista NATURAL JOIN entrada
WHERE precio_entrada IN (SELECT min(precio_entrada) FROM entrada)


13. Agrupar cuántos grupos tocan cada estilo de música

SELECT estilo_musica, count(nombre_artista)
FROM artista
GROUP BY estilo_musica

14. Número de conciertos en cada ciudad

SELECT ciudad, count(id_prox_concierto)
FROM concierto
WHERE id_prox_concierto > 0
GROUP BY ciudad
ORDER BY count asc


15. Grupos con 2 discos

SELECT nombre_artista, numero_disco
FROM artista
WHERE numero_disco=2
GROUP BY numero_disco, nombre_artista

16. Entradas a más de 55€

SELECT ciudad, precio_entrada
FROM entrada, concierto
WHERE ciudad='Madrid'
GROUP BY ciudad, precio_entrada
HAVING precio_entrada > 55 
ORDER BY precio_entrada ASC


-- TRIGGER: ACTUALIZAR PRECIO DE UNA ENTRADA GUARDANDO PREVIAMENTE EL PRECIO INICIAL EN LA TABLA ENTRADA_OLD

CREATE FUNCTION change_price() RETURNS TRIGGER
as
$$
BEGIN 

INSERT INTO entrada_old VALUES(old.id_entrada,old.id_prox_concierto,old.precio_entrada,old.user_cambio);

return new;

END
$$
Language plpgsql


CREATE TRIGGER tr_update BEFORE UPDATE ON entrada  -- GUARDA ANTES LA INFORMACION PREVIA A LA MODIFICACIÓN
for each row 
execute procedure change_price();


Update entrada set
id_entrada=11,
id_prox_concierto=11,
precio_entrada=80,
user_cambio='Elena'
WHERE precio_entrada=65;

-- Visualizamos cambio:
select * from entrada
select * from entrada_old

-- De esta manera en la tabla 'Entrada' se visualiza el precio actualizado y el nombre de quien realizó la modificación, en este caso Elena.