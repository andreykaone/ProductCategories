
USE master;  
GO  
IF DB_ID (N'ManyToManyRelationsip') IS NOT NULL
DROP DATABASE ManyToManyRelationsip;
GO
CREATE DATABASE ManyToManyRelationsip;  
GO


USE ManyToManyRelationsip;  
GO

CREATE TABLE Products (
    ProductId INT NOT NULL, -- убрал IDENTITY(1,1), чтобы управлять Id'шками данных при INSERT'е
    Name varchar(255),

	PRIMARY KEY CLUSTERED (ProductId ASC)
);

CREATE TABLE Categories (
    CategoryId INT NOT NULL, -- убрал IDENTITY(1,1), чтобы управлять Id'шками данных при INSERT'е
    Name varchar(255),

	PRIMARY KEY CLUSTERED (CategoryId ASC)
);

CREATE TABLE ProductsCategories (
    [Id] INT IDENTITY(1,1) NOT NULL,
    ProductId INT NULL,
    CategoryId INT NULL,

    FOREIGN KEY(ProductId) REFERENCES Products(ProductId),
    FOREIGN KEY(CategoryId) REFERENCES Categories(CategoryId),

    PRIMARY KEY CLUSTERED ([Id] ASC)
);


INSERT into Products (ProductId, Name)
SELECT 1, 'Samsung UE40NU7100U' UNION
SELECT 2, 'Sony WHH900N' UNION
SELECT 3, 'MSI GT75VR 7RE TITAN' UNION
SELECT 4, 'Apple MacBook Pro 15 with Retina display Mid 2018' UNION
SELECT 5, 'LEGO DC Super Hero' UNION
SELECT 6, 'Monitor HP DreamColor Z31x'


INSERT into Categories (CategoryId, Name)
SELECT 1, 'TV-station' UNION
SELECT 2, 'Computer Accessories' UNION
SELECT 3, 'Headphones' UNION
SELECT 4, 'Laptops' UNION
SELECT 5, 'Household Appliances' UNION
SELECT 6, 'Perfume'

INSERT into ProductsCategories (ProductId, CategoryId)
SELECT 1, 1 UNION
SELECT 2, 2 UNION
SELECT 2, 3 UNION
SELECT 3, 4 UNION
SELECT 4, 4 UNION
SELECT 5, null UNION
SELECT null, 5


SELECT product.Name AS [Product Name], category.Name AS [Category Name] FROM Products product
LEFT JOIN ProductsCategories  pc
	ON pc.ProductId = product.ProductId
LEFT JOIN Categories category
	ON category.CategoryId = pc.CategoryId


SELECT category.Name AS [Category Name], product.Name AS [Product Name] FROM Categories category
LEFT JOIN ProductsCategories  pc
	ON pc.CategoryId = category.CategoryId
LEFT JOIN Products product
	ON product.ProductId = pc.ProductId

--В запросе продуктов "LEGO DC Super Hero" и "Monitor HP DreamColor Z31x" без категории, потому в таблице ProductsCategories у Lego есть запись без категории,
-- а у монитора нет даже записи. Но они всё ещё продукты, поэтому в запросе продуктов два вхождения продуктов без категорий.
--Тоже самое у категорий - "Household Appliances" имеет запись в ProductsCategories с "null" продуктом, у "Perfume" нет даже записи. Но они всё ещё категории.
