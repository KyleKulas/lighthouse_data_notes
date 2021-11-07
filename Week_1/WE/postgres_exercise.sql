/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/

SELECT ProductName, QuantityPerUnit FROM Products;


/* TASK II
Q2. Write a query to get most expense and least expensive Product list (name and unit price)
*/

SELECT ProductName, UnitPrice FROM Products
    WHERE UnitPrice = (SELECT MIN(UnitPrice) FROM products)
    OR UnitPrice = (SELECT MAX(UnitPrice) FROM products);

/* TASK III
Q3. Write a query to count current and discontinued products.
*/

SELECT discontinued, COUNT(*) FROM products
    GROUP BY discontinued;

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/

SELECT ProductName, CategoryName FROM Products
    JOIN Categories ON Products.CategoryID = Categories.CategoryID;

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from USA region. (26 rows)
*/

SELECT ProductName, UnitPrice, Suppliers.Region FROM Products
    JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
    WHERE Suppliers.region NOT IN (SELECT region from suppliers where country = 'USA')

SELECT ProductName, UnitPrice, Suppliers.Region FROM Products
    JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
    where country != 'USA'

/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/

SELECT SUM(Quantity) FROM order_details;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/

SELECT orderID, SUM(Quantity) FROM order_details
    GROUP BY orderID;


/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/

SELECT COUNT(*) FROM employees
    WHERE (DATE_PART('year',CURRENT_DATE) -DATE_PART('year', hiredate)) > 5;

