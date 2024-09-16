-- Question 1
SELECT * FROM Orders o WHERE o.restaurantId IN (SELECT restaurantId  FROM Restaurants r WHERE r.city = "Atlanta");

-- Question 2
SELECT * FROM Orders o WHERE [menus.name] LIKE "%Burger%";

-- Question 3
SELECT * FROM Orders o ORDER BY o.dateAdded ASC;

-- Question 4
SELECT r.restaurantId, r.name, r.city, c.numberOfOrders
FROM (SELECT o.restaurantId, COUNT(o.restaurantId) AS numberOfOrders FROM Orders o GROUP BY o.restaurantId) c
LEFT JOIN Restaurants r ON c.restaurantId = r.restaurantId
ORDER BY c.numberOfOrders DESC
LIMIT 10;

-- Question 5
SELECT r.restaurantId, r.name, r.city, c.numberOfOrders
FROM (SELECT o.restaurantId, COUNT(o.restaurantId) AS numberOfOrders FROM Orders o GROUP BY o.restaurantId) c
LEFT JOIN Restaurants r ON c.restaurantId = r.restaurantId
WHERE c.numberOfOrders > 20;

-- Question 6
SELECT * FROM Orders o LEFT JOIN Restaurants r ON o.restaurantId = r.restaurantId;

-- Question 7
SELECT k.restaurantId, k.name, k.fullAddress, o.categories, [menus.amountMax], [menus.amountMin], [menus.dateSeen], [menus.description], [menus.name], averageMenuPrice
FROM Orders o 
    LEFT JOIN (SELECT restaurantId, AVG([menus.amountMax]) AS averageMenuPrice FROM Orders o GROUP BY restaurantId) a  ON r.restaurantId = a.restaurantId
) k ON o.restaurantId = k.restaurantId;

-- Question 8
SELECT * FROM Orders o WHERE o.restaurantId IN
(SELECT restaurantId FROM Restaurants r WHERE r.city IN
(SELECT city FROM Restaurants r WHERE r.name = "Wildwood Pizza"));

-- Question 9
SELECT avg((UNIXEPOCH(dateUpdated) - UNIXEPOCH(dateAdded))/86400) as averageTimeBetween FROM Orders o;

-- Question 10
SELECT k.restaurantId, k.name, k.fullAddress, k.latitude, k.longitude, o.categories, [menus.amountMax], [menus.amountMin], [menus.dateSeen], [menus.description], [menus.name], averageMenuPrice
FROM Orders o 
LEFT JOIN (
    SELECT r.name, r.restaurantId, r.latitude, r.longitude, averageMenuPrice, (r.address || ' ' || r.city || ' ' || r.country || ' ' || r.postalCode) AS fullAddress FROM Restaurants r
    LEFT JOIN (SELECT restaurantId, AVG([menus.amountMax]) AS averageMenuPrice FROM Orders o GROUP BY restaurantId) a  ON r.restaurantId = a.restaurantId
) k ON o.restaurantId = k.restaurantId
WHERE o.categories LIKE "%karaoke%"
ORDER BY [menus.dateSeen] ASC;

-- Question 11
SELECT r.name, r.province, c.numberOfOrders
FROM (SELECT o.restaurantId, COUNT(o.restaurantId) AS numberOfOrders FROM Orders o GROUP BY o.restaurantId) c 
LEFT JOIN Restaurants r ON c.restaurantId = r.restaurantId
ORDER BY c.numberOfOrders DESC;

-- Question 12
SELECT r.name, [menus.name], [menus.description]
FROM Orders o LEFT JOIN Restaurants r ON o.restaurantId = r.restaurantId
WHERE [menus.name] LIKE "%vegan%pizza%" OR [menus.name] LIKE "%vegetarian%pizza%";
