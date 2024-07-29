DELIMITER //
CREATE PROCEDURE ConsultarTodosProductos()
BEGIN
	SELECT p.ProductName,s.SupplierName,c.CategoryName FROM products p  INNER JOIN suppliers s ON p.SupplierID = s.SupplierID INNER JOIN categories c ON c.CategoryID = p.CategoryID;
END; //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ConsultarProductoC(idCategory INT)
BEGIN
	SELECT p.ProductName,s.SupplierName,c.CategoryName FROM products p  INNER JOIN suppliers s ON p.SupplierID = s.SupplierID INNER JOIN categories c ON c.CategoryID = p.CategoryID WHERE p.CategoryID = idCategory;
END;//
DELIMITER ;



DELIMITER //
CREATE PROCEDURE ConsultarProductoS(idSupplier INT)
BEGIN
    SELECT p.ProductName,s.SupplierName,c.CategoryName FROM products p INNER JOIN suppliers s ON p.SupplierID = s.SupplierID INNER JOIN categories c ON c.CategoryID = p.CategoryID WHERE p.SupplierID = idSupplier;
END;//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ConsultarOrdenes(ProductId INT, CustomerID INT, MaxAmount INT)
BEGIN
    SELECT o.OrderID,c.CustomerName,p.ProductName FROM orders o INNER JOIN customers c ON  o.CustomerID = c.CustomerID INNER JOIN orderdetails od ON od.OrderID = o.OrderID INNER JOIN products p ON p.ProductID = od.ProductID WHERE od.Quantity <= MaxAmount AND p.ProductID = ProductId AND c.CustomerID = CustomerId;
END;//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ConsultarVentasCategoria(idCategory INT)
BEGIN
    SELECT ca.CategoryName,SUM(od.Quantity) as TotalBuyings FROM orders o INNER JOIN customers cu ON  o.CustomerID = cu.CustomerID INNER JOIN orderdetails od ON od.OrderID = o.OrderID INNER JOIN products p ON p.ProductID = od.ProductID INNER JOIN categories ca ON p.CategoryID = ca.CategoryID WHERE ca.CategoryID = idCategory GROUP BY ca.CategoryID;
END;//
DELIMITER ;

CALL ConsultarTodosProductos();
CALL ConsultarProductoC(1);
CALL ConsultarProductoS(1);
CALL ConsultarOrdenes(11, 90, 20);
CALL ConsultarVentasCategoria(1);