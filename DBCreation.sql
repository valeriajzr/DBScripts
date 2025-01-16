CREATE DATABASE LouisHamburgers;

USE LouisHamburgers;

----------------tables creation ------------------
CREATE TABLE burger (
	idBurger int NOT NULL,
	[name] varchar(30) NOT NULL,
	price int NOT NULL
	PRIMARY KEY (idBurger)
);

CREATE TABLE meatList (
	idMeat int NOT NULL,
	[name] varchar (30) NOT NULL
	PRIMARY KEY (idMeat)
);


CREATE TABLE vegetablesList(
	idVegetable int NOT NULL,
	[name] varchar (30) NOT NULL,
	PRIMARY KEY (idVegetable)
);

CREATE TABLE meatBurger(
	idBurger int NOT NULL,
	idMeat int NOT NULL,
	PRIMARY KEY (idBurger, idMeat),
	FOREIGN KEY (idBurger) REFERENCES burger,
	FOREIGN KEY (idMeat) REFERENCES meatList
);

CREATE TABLE vegetableBurger(
	idBurger int NOT NULL,
	idVegetable int NOT NULL,
	PRIMARY KEY (idBurger, idVegetable),
	FOREIGN KEY (idBurger) REFERENCES burger,
	FOREIGN KEY (idVegetable) REFERENCES vegetablesList
);

CREATE TABLE extra (
	idExtra int NOT NULL,
	[name] varchar (20) NOT NULL,
	price DECIMAL (10, 2),
	PRIMARY KEY (idExtra)
);

CREATE TABLE extraBurger(
	idBurger int NOT NULL,
	idExtra int NOT NULL,
	PRIMARY KEY (idBurger, idExtra),
	FOREIGN KEY (idBurger) REFERENCES burger,
	FOREIGN KEY (idExtra) REFERENCES extra
);


CREATE TABLE [order] (
	idOrder int IDENTITY (1,1) PRIMARY KEY,
	totalPrice decimal (10, 2) NOT NULL
);

CREATE TABLE orderBurger (
	idOrder int NOT NULL,
	idBurger int NOT NULL,
	idExtra int,
	PRIMARY KEY (idOrder, idBurger),
	FOREIGN KEY (idOrder) REFERENCES [order],
	FOREIGN KEY (idBurger) REFERENCES burger,
	FOREIGN KEY (idExtra) REFERENCES extra
);

----------------values insertions ------------------


INSERT INTO burger VALUES (1, 'Classic burger', 4);
INSERT INTO burger VALUES (2, 'Cheese burger', 4);
INSERT INTO burger VALUES (3, 'Hawaian burger', 5);
INSERT INTO burger VALUES (4, 'Bacon burger', 5);
INSERT INTO burger VALUES (5, 'Chicken burger', 5);


INSERT INTO meatList VALUES (1, 'Beef');
INSERT INTO meatList VALUES (2, 'Chicken');
INSERT INTO meatList VALUES (3, 'Bacon');
INSERT INTO meatList VALUES (4, 'Ham');

INSERT INTO vegetablesList VALUES (1, 'Lettuce');
INSERT INTO vegetablesList VALUES (2, 'Tomato');
INSERT INTO vegetablesList VALUES (3, 'Onion');
INSERT INTO vegetablesList VALUES (4, 'Pineapple');

INSERT INTO extra VALUES (1, 'Bacon', 1.50);
INSERT INTO extra VALUES (2, 'Ham', 1.10);
INSERT INTO extra VALUES (3, 'Cheese', 1.10);
INSERT INTO extra VALUES (4, 'Pineapple', 0.80);

INSERT INTO meatBurger VALUES (1,1);
INSERT INTO meatBurger VALUES (2,1);
INSERT INTO meatBurger VALUES (3,1);
INSERT INTO meatBurger VALUES (4,1);
INSERT INTO meatBurger VALUES (5,2);

INSERT INTO vegetableBurger VALUES (1,1);
INSERT INTO vegetableBurger VALUES (1,2);
INSERT INTO vegetableBurger VALUES (1,3);
INSERT INTO vegetableBurger VALUES (2,1);
INSERT INTO vegetableBurger VALUES (2,2);
INSERT INTO vegetableBurger VALUES (2,3);
INSERT INTO vegetableBurger VALUES (3,1);
INSERT INTO vegetableBurger VALUES (4,1);
INSERT INTO vegetableBurger VALUES (4,2);
INSERT INTO vegetableBurger VALUES (4,3);
INSERT INTO vegetableBurger VALUES (5,1);
INSERT INTO vegetableBurger VALUES (5,2);
INSERT INTO vegetableBurger VALUES (5,3);

INSERT INTO extraBurger VALUES (2,3);
INSERT INTO extraBurger VALUES (3,2);
INSERT INTO extraBurger VALUES (3,3);
INSERT INTO extraBurger VALUES (3,4);
INSERT INTO extraBurger VALUES (4,1); 


/*Query para obtener los nombres de las hamburguesas y la carne que lleva cada una*/
SELECT b.idBurger,
b.[name],
mL.[name]
FROM burger b JOIN meatBurger mB
ON b.idBurger = mB.idBurger
JOIN meatList mL ON mB.idMeat = mL.idMeat;

/*Query para mostrar los nombres de las hamburguesas con los vegetales que lleva cada una, agrupado por nombre de hamburguesa y con STRING_AGG() Hacemos que el listado de vegetales se combine en un unico valor por hamburguesa*/

SELECT 
    b.idBurger,
    b.[name] AS BurgerName,
    STRING_AGG(vL.[name], ', ') AS Vegetables
FROM 
    burger b
JOIN 
    vegetableBurger vB ON b.idBurger = vB.idBurger
JOIN 
    vegetablesList vL ON vB.idVegetable = vL.idVegetable
GROUP BY 
    b.idBurger, b.[name];
	
/*Query para traer todas las hamburguesas que tienen extras*/
SELECT b.idBurger, 
b.[name] AS BurgerName,
STRING_AGG(e.[name],', ') AS Extras
FROM burger b 
JOIN 
	extraBurger eB ON b.idBurger = eB.idBurger
JOIN
	extra e on e.idExtra = eB.idExtra
GROUP BY b.idBurger, b.[name];

/*Query para traer todas las hamburguesas con sus extras (aun cuando las hamburguesas no tengan extras)*/
SELECT b.idBurger, 
b.[name] AS BurgerName,
STRING_AGG(e.[name],', ') AS Extras
FROM burger b 
LEFT JOIN 
	extraBurger eB ON b.idBurger = eB.idBurger
LEFT JOIN
	extra e on e.idExtra = eB.idExtra
GROUP BY b.idBurger, b.[name];


/*Query para traer todas las hamburguesas con su carne, vegetales y extras (aun cuando las hamburguesas no tengan extras)*/
SELECT b.idBurger, 
b.[name] AS BurgerName,
mL.[name] AS Meat,
STRING_AGG(vL.[name],', ') AS Vegetables,
STRING_AGG(e.[name],', ') AS Extras
FROM burger b 
/*Los dos siguientes joins son para obtener la carne de las hamburguesas*/
JOIN
	meatBurger mB ON b.idBurger = mB.idBurger
JOIN
	meatList mL on mL.idMeat = mB.idMeat
/*Los dos siguientes joins son para obtener los vegetales de las hamburguesas*/
JOIN 
	vegetableBurger vB ON b.idBurger = vB.idBurger
JOIN
	vegetablesList vL ON vL.idVegetable = vB.idVegetable
/*Los siguientes dos join son para traer todos los extras (aun cuando las hamburguesas no tengan extras)*/
LEFT JOIN extraBurger eB ON eB.idBurger = b.idBurger
LEFT JOIN extra e ON e.idExtra = eB.idExtra
GROUP BY b.idBurger, b.[name], mL.[name];