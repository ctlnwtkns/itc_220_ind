
#Individual SQL Testing

##To Turn In:
I want to see the SQL and the answer to the query. 
For the 12 and 13, run a SELECT query to show that the operations were successful.

```sql
--List all Last names, phone numbers and zip of the customers
SELECT CustomerLastName, CustomerPhoneKey, CustomerZip 
FROM Customer
ORDER BY CustomerLastName
```
| CustomerLastName | CustomerPhoneKey | CustomerZip
|---|---|---|
|Anderson	|2065553213	|98001
|Jimenez	|2065556623	|98003
|Johnston	|2065553252	|98001
|Lamont	|2065552123	|98001
|Lewis	|2065552963	|98002
|Wong	|2065552217	|98002

```sql
--List only those from Zip code 98002
SELECT CustomerLastName, CustomerPhoneKey, CustomerZip 
FROM Customer
WHERE CustomerZip = 98002
ORDER BY CustomerLastName
```

| CustomerLastName | CustomerPhoneKey | CustomerZip
|---|---|---|
|Lewis	|2065552963	|98002
|Wong	|2065552217	|98002

```sql
--List all the customers that have no first Address entered in the database
SELECT CustomerLastName, CustomerFirstName
FROM Customer
WHERE CustomerAddress1 IS NULL
ORDER BY CustomerLastName
```

| CustomerLastName | CustomerFirstName
|---|---|
|Lamont	|NULL
|Lewis	|NULL
|Wong	|NULL

```sql
--List all the products that are priced higher than ten dollars
SELECT ProductName 
FROM Product
WHERE ProductUnitPrice > 10
ORDER BY ProductUnitPrice
```

|ProductName |
|---|
|Basic Pizza Large|
|Specialty Large|

```sql
--List all the products priced between 5 and 7 dollars
SELECT ProductName 
FROM Product
WHERE ProductUnitPrice BETWEEN 5 AND 7
ORDER BY ProductUnitPrice
```

|ProductName|
|---|
|Basic Pizza Small|
|Specialty Small|

```sql
--List all the customers whose last name starts with L
SELECT CustomerLastName, CustomerFirstName
FROM Customer
WHERE CustomerLastName LIKE ‘L%’ 
ORDER BY CustomerLastName
```

| CustomerLastName | CustomerFirstName
|---|---|
|Lamont	|NULL
|Lewis	|NULL

```sql
--What is the Average price of a product
SELECT ROUND(AVG(ProductUnitPrice),2) AS AvgPrice
FROM Product
```
|AvgPrice|
|---|
|7.120000|

```sql
--What is the highest price of a product
SELECT MAX(ProductUnitPrice) AS MaxPrice
FROM Product
```
|MaxPrice|
|---|
|15.00|

```sql
--What is the total due for order 1003
SELECT SUM(OrderDetailPriceCharged) AS TotalDue
FROM OrderDetail
WHERE OrderKey = 1003
```
|TotalDue|
|---|
|11.35|

```sql
--Join the product and the OrderDetail table so that the result contains the product name, product unit size and product unit price as well the charged price. 
--Do it for order 1000

SELECT ProductName, ProductUnitSize, ProductUnitPrice, OrderDetailPriceCharged
FROM Product p
LEFT JOIN OrderDetail ord ON p.ProductKey = ord.ProductKey
WHERE OrderKey = 1000
```
|ProductName|ProductUnitSize|ProductUnitPrice|OrderDetailPriceCharged|
|---|---|---|---|
|Soda bottle	|2 Liter bottle	|3.75	|7.25
|Breadsticks	|8 per pack	|2.50	|2.50
|Specialty Medium	|12 inch	|9.25	|7.35

```sql
--List all the order and order details for each order made by the customer with the phone number 2065556623
SELECT *
FROM Order o
LEFT JOIN OrderDetail ord USING (OrderKey)
WHERE CustomerPhoneKey = 2065556623
```

|OrderKey|OrderDate|OrderTime|CustomerPhoneKey|EmployeeKey|OrderDetailQuality|OrderDetailPriceCharged
|---|---|---|---|---|---|---|
|1001	|2014-10-08	|14:25:00.0000000	|2065556623	|cmanning	|4	|1001	|specialL	|1	|15.00
|1005	|2014-10-10	|12:02:00.0000000	|2065556623	|btaylor	|10	|1005	|basicM	|2	|14.70

```sql
--Change the price of breadsticks to 3.00
UPDATE Product SET ProductUnitPrice = 3.00 WHERE ProductName = 'Breadsticks'

SELECT ProductName, ProductUnitPrice 
FROM Product
WHERE ProductName = 'Breadsticks'
```

|ProductName|ProductUnitPrice|
|---|---|
|Breadsticks|3.00|

```sql
--Process a pizza order for a new customer (this will involve 3 insert statements)
INSERT INTO Customer 
VALUES (2065550852, 'Jasper', 'Luanne', 'Apt 2', '1842 E Aloha St.', 'Seattle', 'WA', 98112 )

INSERT INTO Orders (OrderKey, OrderDate, OrderTime, CustomerPhoneKey, EmployeeKey)
VALUES (1006, GetDate(), CURRENT_TIMESTAMP, 2065550852, 'skristoph' )

INSERT INTO OrderDetail (OrderDetailKey, OrderKey, ProductKey, OrderDetailQuality, OrderDetailPriceCharged)
VALUES (11, (SELECT OrderKey FROM Orders WHERE CustomerPhoneKey = 2065550852), 'basicL', 2, (Select ProductUnitPrice*2 FROM Product WHERE ProductKey = 'basicL') )

SELECT *
FROM Orders o
LEFT JOIN OrderDetail ord ON o.OrderKey = ord.OrderKey
WHERE o.CustomerPhoneKey = 2065550852
```

|OrderKey|OrderDate|OrderTime|CustomerPhoneKey|EmployeeKey|OrderDetailKey|OrderKey|ProductKey|OrderDetailQuantity|OrderDetailPriceCharged|
|---|---|---|---|---|---|---|---|---|---|
|1006	|2016-02-22	|15:01:59.3030000	|2065550852	|skristoph	|11	|1006	|basicL	|2	|27.00
