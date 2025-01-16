-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
USE [LouisHamburgers]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [GetMenu] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		b.idBurger,
		b.[name] AS BurgerName,
		b.price AS Price,
		(SELECT mL.[name]
		 FROM meatBurger mB
		 JOIN meatList mL ON mL.idMeat = mB.idMeat
		 WHERE mB.idBurger = b.idBurger) AS Meat,
		(SELECT STRING_AGG(vL.[name], ', ')
		 FROM vegetableBurger vB
		 JOIN vegetablesList vL ON vL.idVegetable = vB.idVegetable
		 WHERE vB.idBurger = b.idBurger) AS Vegetables,
		(SELECT STRING_AGG(e.[name], ', ')
		 FROM extraBurger eB
		 LEFT JOIN extra e ON e.idExtra = eB.idExtra
		 WHERE eB.idBurger = b.idBurger) AS Extras
	FROM burger b;
END