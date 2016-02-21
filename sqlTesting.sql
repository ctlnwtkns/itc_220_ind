
--To Turn In:
--I want to see the SQL and the answer to the query. For the 12 and 13, run a SELECT query to show that the operations were successful.

--List all Last names, phone numbers and zip of the customers
SELECT CustomerLastName, CustomerPhoneKey, CustomerZip 
FROM Customer
ORDER BY CustomerLastName

--List only those from Zip code 98002
SELECT CustomerLastName, CustomerPhoneKey, CustomerZip 
FROM Customer
WHERE CustomerZip = 98002
ORDER BY CustomerLastName

--List all the customers that have no first Address entered in the database
SELECT CustomerLastName, CustomerFirstName
FROM Customer
WHERE CustomerAddress1 IS NULL
ORDER BY CustomerLastName

--List all the products that are priced higher than ten dollars
SELECT ProductName 
FROM Product
WHERE ProductUnitPrice > 10
ORDER BY ProductUnitPrice

--List all the products priced between 5 and 7 dollars
SELECT ProductName 
FROM Product
WHERE ProductUnitPrice BETWEEN 5 AND 7
ORDER BY ProductUnitPrice

--List all the customers whose last name starts with L
SELECT CustomerLastName, CustomerFirstName
FROM Customer
WHERE CustomerLastName ILIKE ‘L%’ 
ORDER BY CustomerLastName

--What is the Average price of a product
SELECT AVG(ProductUnitPrice) AS AvgPrice
FROM Product

--What is the highest price of a product
SELECT MAX(ProductUnitPrice) AS MaxPrice
FROM Product

--What is the total due for order 1003
SELECT SUM(OrderDetailPriceCharged) AS TotalDue
FROM OrderDetail
WHERE OrderKey = 1003

--Join the product and the OrderDetail table so that the result contains the product name, product unit size and product unit price as well the charged price. 
--Do it for order 1000

SELECT ProductName, ProductUnitSize, ProductUnitPrice, OrderDetailPriceCharged
FROM Product p
LEFT JOIN OrderDetail ord USING (ProductKey)
WHERE OrderKey = 1000

--List all the order and order details for each order made by the customer with the phone number 2065556623
SELECT *
FROM Order o
LEFT JOIN OrderDetail ord USING (OrderKey)
WHERE CustomerPhoneKey = 2065556623

--Change the price of breadsticks to 3.00
UPDATE TABLE Product SET ProductUnitPrice = 3.00 WHERE ProductName = 'Breadsticks'

SELECT ProductUnitPrice 
FROM Product
WHERE ProductName = 'Breadsticks'

--Process a pizza order for a new customer (this will involve 3 insert statements)
INSERT INTO Customer 
VALUES (2065550852, 'Jasper', NULL, NULL, '1842 E Aloha St.', 'Seattle', 'WA', 98112 )

INSERT INTO Orders (OrderDate, OrderTime, CustomerPhoneKey, EmployeeKey)
VALUES (GetDate(), CURRENT_TIMESTAMP, 2065550852, 'skristoph' )

INSERT INTO OrderDetail (OrderKey, ProductKey, OrderDetailQuantity, OrderDetailPriceCharged)
VALUES ((SELECT OrderKey FROM Orders WHERE CustomerPhoneKey = 2065550852), 'basicL', 2, (Select ProductUnitPrice*2 FROM Product WHERE ProductKey = 'basicL') )

SELECT *
FROM Orders o
LEFT JOIN OrderDetail ord USING (CustomerPhoneKey)
WHERE o.CustomerPhoneKey = 2065550852




