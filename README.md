# LouisBurgers – SQL Server Database Scripts

This repository contains the SQL scripts used to create and populate the **LouisBurgers** relational database. It defines all required tables, relationships, and stored procedures that support the backend API.

---

## Contents

### `DBCreation.sql`
- Creates all tables and relationships:
  - `Burgers`
  - `Ingredients`
  - `Extras`
  - `Orders`
  - `OrderDetails`
  - `BurgerIngredients` (many-to-many)
- Adds constraints and identity keys

### `GetMenuSP.sql`
- Stored procedure that returns a **full menu** of burgers with their ingredients and price.

### `GetExtrasSP.sql`
- Stored procedure that returns a list of available **extras** (sides).
  
---

## 📌 Related Projects

- Backend – ASP.NET Core API (https://github.com/valeriajzr/LouisBurgers)
- Frontend – React + Next.js (https://github.com/valeriajzr/louisburgers-frontend)

---
