DROP DATABASE IF EXISTS restaurantdb;

CREATE DATABASE restaurantdb;
--    PART 1  : Database & Table Creation (schema)
USE restaurantdb;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    registration_date DATE NOT NULL
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_role VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    CHECK (price >= 0)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_type VARCHAR(20) NOT NULL,
    order_status VARCHAR(20) NOT NULL DEFAULT 'Placed',

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (employee_id)
        REFERENCES Employees(employee_id),

    CHECK (
        order_type IN ('Dine-in', 'Takeaway', 'Delivery')
    ),

    CHECK (
        order_status IN (
            'Placed',
            'Preparing',
            'Completed',
            'Cancelled'
        )
    )
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (item_id)
        REFERENCES Menu_Items(item_id),

    CHECK (quantity > 0),
    CHECK (unit_price >= 0),

    UNIQUE (order_id, item_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    CHECK (amount > 0),

    CHECK (
        payment_method IN (
            'Cash',
            'UPI',
            'Card',
            'Online'
        )
    ),

    CHECK (
        payment_status IN (
            'Pending',
            'Completed',
            'Failed',
            'Refunded'
        )
    )
);

--    PART 2  : Sample Data (INSERT statements)
INSERT INTO Customers VALUES
(1, 'Aarav', 'Sharma', '9876500001',
 'aarav@example.com', '2025-01-10'),

(2, 'Diya', 'Patel', '9876500002',
 'diya@example.com', '2025-02-15'),

(3, 'Vihaan', 'Rao', '9876500003',
 'vihaan@example.com', '2025-03-20'),

(4, 'Ananya', 'Singh', '9876500004',
 'ananya@example.com', '2025-04-05'),

(5, 'Arjun', 'Kumar', '9876500005',
 'arjun@example.com', '2025-05-12'),

(6, 'Meera', 'Reddy', '9876500006',
 'meera@example.com', '2025-06-18'),

(7, 'Rahul', 'Verma', '9876500007',
 'rahul@example.com', '2025-07-22'),

(8, 'Priya', 'Nair', '9876500008',
 'priya@example.com', '2025-08-30');
 
 
 INSERT INTO Employees VALUES
(1, 'Kiran', 'Reddy', 'Manager',
 '2022-01-10', 45000.00),

(2, 'Sneha', 'Patel', 'Cashier',
 '2023-03-15', 25000.00),

(3, 'Rohit', 'Sharma', 'Waiter',
 '2023-06-20', 22000.00),

(4, 'Pooja', 'Rao', 'Waiter',
 '2024-02-01', 23000.00);
 
 
 INSERT INTO Menu_Items VALUES
(101, 'Veg Burger', 'Fast Food', 120.00, TRUE),
(102, 'Chicken Burger', 'Fast Food', 180.00, TRUE),
(103, 'Margherita Pizza', 'Pizza', 250.00, TRUE),
(104, 'Chicken Biryani', 'Main Course', 220.00, TRUE),
(105, 'Veg Biryani', 'Main Course', 160.00, TRUE),
(106, 'Masala Dosa', 'South Indian', 90.00, TRUE),
(107, 'Paneer Tikka', 'Starters', 200.00, TRUE),
(108, 'Cold Coffee', 'Beverages', 100.00, FALSE);


INSERT INTO Orders VALUES
(1001, 1, 3, '2026-10-01 12:30:00',
 'Dine-in', 'Completed'),

(1002, 2, 4, '2026-10-02 13:15:00',
 'Takeaway', 'Completed'),

(1003, 3, 3, '2026-10-03 19:00:00',
 'Delivery', 'Completed'),

(1004, 1, 2, '2026-10-04 20:10:00',
 'Dine-in', 'Completed'),

(1005, 4, 4, '2026-10-05 14:00:00',
 'Takeaway', 'Cancelled'),

(1006, 5, 3, '2026-10-06 19:30:00',
 'Delivery', 'Completed'),

(1007, 6, 2, '2026-10-07 11:45:00',
 'Dine-in', 'Completed'),

(1008, 7, 4, '2026-10-08 20:00:00',
 'Delivery', 'Preparing'),

(1009, 2, 3, '2026-10-09 12:00:00',
 'Dine-in', 'Completed'),

(1010, 3, 2, '2026-10-10 18:30:00',
 'Takeaway', 'Completed');
 
 
 INSERT INTO Order_Items VALUES
(1, 1001, 101, 2, 120.00),
(2, 1001, 106, 1, 90.00),

(3, 1002, 104, 1, 220.00),
(4, 1002, 108, 1, 100.00),

(5, 1003, 103, 1, 250.00),
(6, 1003, 107, 1, 200.00),

(7, 1004, 102, 2, 180.00),

(8, 1005, 105, 1, 160.00),

(9, 1006, 104, 2, 220.00),

(10, 1007, 106, 2, 90.00),
(11, 1007, 101, 1, 120.00),

(12, 1008, 103, 2, 250.00),

(13, 1009, 105, 2, 160.00),
(14, 1009, 101, 1, 120.00),

(15, 1010, 107, 1, 200.00);


INSERT INTO Payments VALUES
(1, 1001, '2026-10-01 12:45:00',
 330.00, 'UPI', 'Completed'),

(2, 1002, '2026-10-02 13:25:00',
 320.00, 'Cash', 'Completed'),

(3, 1003, '2026-10-03 19:30:00',
 450.00, 'Card', 'Completed'),

(4, 1004, '2026-10-04 20:30:00',
 360.00, 'UPI', 'Completed'),

(5, 1005, '2026-10-05 14:10:00',
 160.00, 'Cash', 'Refunded'),

(6, 1006, '2026-10-06 19:45:00',
 440.00, 'Online', 'Completed'),

(7, 1007, '2026-10-07 12:00:00',
 300.00, 'UPI', 'Completed'),

(8, 1008, '2026-10-08 20:15:00',
 500.00, 'Card', 'Pending'),

(9, 1009, '2026-10-09 12:20:00',
 440.00, 'UPI', 'Completed'),

(10, 1010, '2026-10-10 18:45:00',
 200.00, 'Cash', 'Completed');
 
 
 select*from Customers;
 select*from Employees;
 select*from Menu_Items;
 select*from Orders;
 select*from Order_Items;
 select*from Payments;
 
 --    PART 3  : Indexes

 CREATE INDEX idx_orders_customer
ON Orders(customer_id);

CREATE INDEX idx_orders_employee
ON Orders(employee_id);

CREATE INDEX idx_orders_date
ON Orders(order_date);

CREATE INDEX idx_orders_status
ON Orders(order_status);

CREATE INDEX idx_order_items_item
ON Order_Items(item_id);

CREATE INDEX idx_payments_order
ON Payments(order_id);

CREATE INDEX idx_payments_status
ON Payments(payment_status);

CREATE INDEX idx_menu_category
ON Menu_Items(category);

CREATE INDEX idx_menu_price
ON Menu_Items(price);


SHOW INDEX FROM Orders;

SHOW INDEX FROM Order_Items;

SHOW INDEX FROM Payments;

SHOW INDEX FROM Menu_Items;

--    PART 4  : Views

CREATE OR REPLACE VIEW view_order_details AS
SELECT
    O.order_id,
    CONCAT(C.first_name, ' ', C.last_name)
        AS customer_name,
    CONCAT(E.first_name, ' ', E.last_name)
        AS employee_name,
    O.order_date,
    O.order_type,
    O.order_status,
    COALESCE(
        SUM(OI.quantity * OI.unit_price), 0
    ) AS order_total
FROM Orders O
JOIN Customers C
    ON O.customer_id = C.customer_id
JOIN Employees E
    ON O.employee_id = E.employee_id
LEFT JOIN Order_Items OI
    ON O.order_id = OI.order_id
GROUP BY
    O.order_id,
    C.first_name,
    C.last_name,
    E.first_name,
    E.last_name,
    O.order_date,
    O.order_type,
    O.order_status;
    
USE restaurantdb;
    
CREATE OR REPLACE VIEW view_category_averages AS
SELECT
    category,
    ROUND(AVG(price), 2) AS average_price,
    COUNT(*) AS item_count
FROM Menu_Items
GROUP BY category;

CREATE OR REPLACE VIEW view_customer_totals AS
SELECT
    C.customer_id,
    CONCAT(C.first_name, ' ', C.last_name)
        AS customer_name,
    COUNT(DISTINCT O.order_id) AS total_orders,
    COALESCE(
        SUM(
            CASE
                WHEN O.order_status <> 'Cancelled'
                THEN OI.quantity * OI.unit_price
                ELSE 0
            END
        ), 0
    ) AS order_value
FROM Customers C
LEFT JOIN Orders O
    ON C.customer_id = O.customer_id
LEFT JOIN Order_Items OI
    ON O.order_id = OI.order_id
GROUP BY
    C.customer_id,
    C.first_name,
    C.last_name;
    
CREATE OR REPLACE VIEW view_payment_status AS
SELECT
    P.payment_id,
    P.order_id,
    CONCAT(C.first_name, ' ', C.last_name)
        AS customer_name,
    P.payment_method,
    P.amount,
    P.payment_status,
    P.payment_date
FROM Payments P
JOIN Orders O
    ON P.order_id = O.order_id
JOIN Customers C
    ON O.customer_id = C.customer_id;
    
CREATE OR REPLACE VIEW view_sales_summary AS
SELECT
    O.order_id,
    O.order_date,
    O.order_status,
    COALESCE(OT.order_total, 0) AS order_total,
    COALESCE(PT.amount_paid, 0) AS amount_paid
FROM Orders O
LEFT JOIN (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM Order_Items
    GROUP BY order_id
) OT
    ON O.order_id = OT.order_id
LEFT JOIN (
    SELECT
        order_id,
        SUM(
            CASE
                WHEN payment_status = 'Completed'
                THEN amount
                ELSE 0
            END
        ) AS amount_paid
    FROM Payments
    GROUP BY order_id
) PT
    ON O.order_id = PT.order_id;
    
    
--    PART 5  : Stored Procedures

DROP PROCEDURE IF EXISTS sp_get_customer_orders;
DELIMITER $$
CREATE PROCEDURE sp_get_customer_orders(IN p_customer_id INT)
BEGIN
    -- ✅ FIX: validate customer exists
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer not found';
    END IF;

    SELECT O.order_id, O.order_date, O.order_type, O.order_status,
           COALESCE(SUM(OI.quantity*OI.unit_price),0) AS order_total
    FROM Orders O
    LEFT JOIN Order_Items OI ON O.order_id = OI.order_id
    WHERE O.customer_id = p_customer_id
    GROUP BY O.order_id, O.order_date, O.order_type, O.order_status
    ORDER BY O.order_date;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_add_order_item;
DELIMITER $$
CREATE PROCEDURE sp_add_order_item(
    IN p_order_item_id INT,
    IN p_order_id INT,
    IN p_item_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_available BOOLEAN;
    DECLARE v_order_status VARCHAR(20);
    DECLARE v_order_exists INT DEFAULT 0;
    DECLARE v_item_exists  INT DEFAULT 0;

    IF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    -- ✅ FIX: explicit existence checks (no silent NULL issues)
    SELECT COUNT(*) INTO v_order_exists FROM Orders WHERE order_id = p_order_id;
    IF v_order_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order does not exist';
    END IF;

    SELECT COUNT(*) INTO v_item_exists FROM Menu_Items WHERE item_id = p_item_id;
    IF v_item_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Menu item does not exist';
    END IF;

    SELECT order_status INTO v_order_status FROM Orders WHERE order_id = p_order_id;
    IF v_order_status = 'Cancelled' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot add items to a cancelled order';
    END IF;

    SELECT price, is_available INTO v_price, v_available
    FROM Menu_Items WHERE item_id = p_item_id;

    IF v_available = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Menu item is currently unavailable';
    END IF;

    -- ✅ FIX: handle existing (order_id,item_id) pair to avoid UNIQUE failure
    IF EXISTS (SELECT 1 FROM Order_Items
               WHERE order_id = p_order_id AND item_id = p_item_id) THEN
        -- Increase quantity of existing row instead of inserting a duplicate
        UPDATE Order_Items
           SET quantity = quantity + p_quantity
         WHERE order_id = p_order_id AND item_id = p_item_id;
    ELSE
        INSERT INTO Order_Items(order_item_id, order_id, item_id, quantity, unit_price)
        VALUES (p_order_item_id, p_order_id, p_item_id, p_quantity, v_price);
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_category_average;
DELIMITER $$
CREATE PROCEDURE sp_category_average(IN p_category VARCHAR(50))
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Menu_Items WHERE category = p_category) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Category not found';
    END IF;
    SELECT category, ROUND(AVG(price),2) AS average_price
    FROM Menu_Items
    WHERE category = p_category
    GROUP BY category;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_order_report;
DELIMITER $$
CREATE PROCEDURE sp_order_report(IN p_order_id INT)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE order_id = p_order_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order not found';
    END IF;
    SELECT O.order_id,
           CONCAT(C.first_name,' ',C.last_name) AS customer_name,
           MI.item_name, OI.quantity, OI.unit_price,
           OI.quantity*OI.unit_price AS line_total,
           O.order_status
    FROM Orders O
    JOIN Customers C   ON O.customer_id = C.customer_id
    JOIN Order_Items OI ON O.order_id   = OI.order_id
    JOIN Menu_Items MI  ON OI.item_id   = MI.item_id
    WHERE O.order_id = p_order_id
    ORDER BY MI.item_name;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_customer_report;
DELIMITER $$
CREATE PROCEDURE sp_customer_report(IN p_customer_id INT)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer not found';
    END IF;
    SELECT CONCAT(C.first_name,' ',C.last_name) AS customer_name,
           COUNT(DISTINCT O.order_id) AS total_orders,
           COALESCE(SUM(CASE WHEN O.order_status <> 'Cancelled'
                             THEN OI.quantity*OI.unit_price ELSE 0 END),0) AS total_order_value
    FROM Customers C
    LEFT JOIN Orders O       ON C.customer_id = O.customer_id
    LEFT JOIN Order_Items OI ON O.order_id    = OI.order_id
    WHERE C.customer_id = p_customer_id
    GROUP BY C.customer_id, C.first_name, C.last_name;
END$$
DELIMITER ;
  
  USE restaurantdb;

-- 1) Aarav Sharma's orders  → expect 2 rows (1001, 1004)
CALL sp_get_customer_orders(1);

-- 2) Fast Food average price → expect 150.00
CALL sp_category_average('Fast Food');

-- 3) Order 1003 breakdown → expect Pizza 250 + Paneer Tikka 200
CALL sp_order_report(1003);

-- 4) Diya Patel report → expect 2 orders, ₹760
CALL sp_customer_report(2);

-- 5) Add Veg Biryani to order 1008 (Preparing, so allowed)
CALL sp_add_order_item(16, 1008, 105, 1);


-- Verify the insert + audit log
SELECT * FROM Order_Items WHERE order_id = 1008;
SELECT * FROM order_items_log ORDER BY log_id DESC LIMIT 3;

 USE restaurantdb;
 select database();
SHOW PROCEDURE STATUS WHERE Db = 'restaurantdb' AND Name = 'sp_add_order_item';
-- Should be 10
SELECT COUNT(*) FROM Orders;

-- Should be 8
SELECT COUNT(*) FROM Menu_Items;

-- Should be 15
SELECT COUNT(*) FROM Order_Items;

-- Confirm the specific rows the demo needs
SELECT order_id, order_status FROM Orders WHERE order_id = 1008;
SELECT item_id, item_name, is_available FROM Menu_Items WHERE item_id = 105;
SELECT * FROM Order_Items WHERE order_id = 1008;

--    PART 6  : Triggers (+ supporting stock_log table)

CREATE TABLE order_items_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_item_id INT,
    order_id INT,
    item_id INT,
    action_type VARCHAR(10),
    old_quantity INT,
    new_quantity INT,
    old_unit_price DECIMAL(10,2),
    new_unit_price DECIMAL(10,2),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS trg_validate_order_item_insert;
DELIMITER $$
CREATE TRIGGER trg_validate_order_item_insert
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;
    IF NEW.unit_price < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unit price cannot be negative';
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_validate_order_item_update;
DELIMITER $$
CREATE TRIGGER trg_validate_order_item_update
BEFORE UPDATE ON Order_Items
FOR EACH ROW
BEGIN
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;
    IF NEW.unit_price < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unit price cannot be negative';
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_prevent_duplicate_order_item;
DELIMITER $$
CREATE TRIGGER trg_prevent_duplicate_order_item
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Order_Items
               WHERE order_id = NEW.order_id AND item_id = NEW.item_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This menu item already exists in the order';
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_log_order_item_insert;
DELIMITER $$
CREATE TRIGGER trg_log_order_item_insert
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    INSERT INTO order_items_log
      (order_item_id,order_id,item_id,action_type,
       old_quantity,new_quantity,old_unit_price,new_unit_price)
    VALUES (NEW.order_item_id,NEW.order_id,NEW.item_id,'INSERT',
            NULL,NEW.quantity,NULL,NEW.unit_price);
END$$
DELIMITER ;

-- ✅ FIX: also log changes to order_id or item_id (audit completeness)
DROP TRIGGER IF EXISTS trg_log_order_item_update;
DELIMITER $$
CREATE TRIGGER trg_log_order_item_update
AFTER UPDATE ON Order_Items
FOR EACH ROW
BEGIN
    IF OLD.quantity <> NEW.quantity
       OR OLD.unit_price <> NEW.unit_price
       OR OLD.order_id  <> NEW.order_id
       OR OLD.item_id   <> NEW.item_id THEN
        INSERT INTO order_items_log
          (order_item_id,order_id,item_id,action_type,
           old_quantity,new_quantity,old_unit_price,new_unit_price)
        VALUES (NEW.order_item_id,NEW.order_id,NEW.item_id,'UPDATE',
                OLD.quantity,NEW.quantity,OLD.unit_price,NEW.unit_price);
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_log_order_item_delete;
DELIMITER $$
CREATE TRIGGER trg_log_order_item_delete
AFTER DELETE ON Order_Items
FOR EACH ROW
BEGIN
    INSERT INTO order_items_log
      (order_item_id,order_id,item_id,action_type,
       old_quantity,new_quantity,old_unit_price,new_unit_price)
    VALUES (OLD.order_item_id,OLD.order_id,OLD.item_id,'DELETE',
            OLD.quantity,NULL,OLD.unit_price,NULL);
END$$
DELIMITER ;

SHOW TRIGGERS;

INSERT INTO Order_Items VALUES (17, 1008, 107, 0, 200.00);
UPDATE Order_Items SET quantity = -2 WHERE order_item_id = 1;
INSERT INTO Order_Items VALUES (18, 1001, 101, 1, 120.00);
INSERT INTO Order_Items VALUES (19, 1008, 106, 1, 90.00);
SELECT * FROM order_items_log ORDER BY log_id;
DELETE FROM Order_Items WHERE order_item_id = 19;


--    PART 11 : Demo calls for Views / Procedures / Triggers
-- 11.1 Views
SELECT * FROM view_order_details;
SELECT * FROM view_category_averages;
SELECT * FROM view_customer_totals ORDER BY order_value DESC;
SELECT * FROM view_payment_status;
SELECT * FROM view_sales_summary;

-- 11.2 Stored procedures
CALL sp_get_customer_orders(1);
-- ✅ FIX: use order 1008 (Preparing) instead of a Completed order for realism
CALL sp_add_order_item(16, 1008, 105, 1);
CALL sp_category_average('Fast Food');
CALL sp_order_report(1003);
CALL sp_customer_report(2);

-- 11.3 Trigger demos
-- Test 1: invalid quantity → error
INSERT INTO Order_Items VALUES (17, 1008, 107, 0, 200.00);

-- Test 2: invalid update → error
UPDATE Order_Items SET quantity = -2 WHERE order_item_id = 1;

-- Test 3: duplicate order item → error
INSERT INTO Order_Items VALUES (18, 1001, 101, 1, 120.00);

-- Test 4: audit log
SELECT * FROM order_items_log ORDER BY log_id;

DELETE FROM Order_Items WHERE order_item_id IN (16, 19);
DELETE FROM order_items_log WHERE log_id > 0;
SELECT COUNT(*) FROM Order_Items; -- Must be 15
SELECT COUNT(*) FROM order_items_log; -- Must be 0


--    PART 7  : Query Bank - Level 1 (Q1-Q3)
-- Q1
SELECT first_name, last_name FROM Customers;

-- Q2
SELECT item_id, item_name, price
FROM Menu_Items WHERE price > 150;

-- Q3
SELECT order_id, order_date, order_status
FROM Orders ORDER BY order_date DESC;

--    PART 8  : Query Bank - Level 2 (Q4-Q6)
-- Q4
SELECT O.order_id,
       CONCAT(C.first_name,' ',C.last_name) AS customer_name,
       SUM(OI.quantity*OI.unit_price) AS order_total
FROM Orders O
JOIN Customers C   ON O.customer_id = C.customer_id
JOIN Order_Items OI ON O.order_id   = OI.order_id
GROUP BY O.order_id, C.first_name, C.last_name
ORDER BY O.order_id;

-- Q5
SELECT category, ROUND(AVG(price),2) AS average_price
FROM Menu_Items GROUP BY category;

-- Q6
SELECT COUNT(*) AS total_orders
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
WHERE C.first_name='Aarav' AND C.last_name='Sharma';

--    PART 9  : Query Bank - Level 3 (Q7-Q9)
-- Q7
SELECT CONCAT(C.first_name,' ',C.last_name) AS customer_name,
       O.order_id,
       SUM(OI.quantity*OI.unit_price) AS order_total
FROM Orders O
JOIN Customers C   ON O.customer_id = C.customer_id
JOIN Order_Items OI ON O.order_id   = OI.order_id
WHERE O.order_status <> 'Cancelled'
GROUP BY C.customer_id, C.first_name, C.last_name, O.order_id
ORDER BY order_total DESC
LIMIT 1;

-- Q8
SELECT O.order_id, SUM(OI.quantity*OI.unit_price) AS order_total
FROM Orders O
JOIN Order_Items OI ON O.order_id = OI.order_id
GROUP BY O.order_id
HAVING SUM(OI.quantity*OI.unit_price) > 300
ORDER BY order_total DESC;

-- Q9
SELECT OI.order_id, MI.item_name, OI.quantity, OI.unit_price,
       OI.quantity*OI.unit_price AS line_total,
       CASE
         WHEN OI.quantity*OI.unit_price >= 400 THEN 'High Value'
         WHEN OI.quantity*OI.unit_price >= 200 THEN 'Medium Value'
         ELSE 'Low Value'
       END AS value_category
FROM Order_Items OI
JOIN Menu_Items MI ON OI.item_id = MI.item_id;

--    PART 10 : Query Bank - New Queries (Q10-Q21)
-- Q10
SELECT first_name, last_name FROM Customers
WHERE registration_date >= '2025-01-01'
  AND registration_date <  '2026-01-01';

-- Q11
SELECT category, MAX(price) AS highest_price
FROM Menu_Items GROUP BY category;

-- Q12
SELECT DISTINCT C.first_name, C.last_name
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
WHERE O.order_type = 'Delivery';

-- Q13  ✅ FIX: expected answer now includes Vihaan Rao (avg 325)
SELECT CONCAT(C.first_name,' ',C.last_name) AS customer_name,
       ROUND(AVG(OT.order_total),2) AS average_order_value
FROM Customers C
JOIN (
    SELECT O.order_id, O.customer_id,
           SUM(OI.quantity*OI.unit_price) AS order_total
    FROM Orders O
    JOIN Order_Items OI ON O.order_id = OI.order_id
    WHERE O.order_status <> 'Cancelled'
    GROUP BY O.order_id, O.customer_id
) OT ON C.customer_id = OT.customer_id
GROUP BY C.customer_id, C.first_name, C.last_name
HAVING AVG(OT.order_total) > 300
ORDER BY average_order_value DESC;
-- Expected result (corrected):
--   Aarav Sharma  345.00
--   Diya Patel    380.00
--   Vihaan Rao    325.00   <-- was missing in original
--   Arjun Kumar   440.00
--   Rahul Verma   500.00

-- Q14
SELECT order_status, COUNT(*) AS order_count
FROM Orders GROUP BY order_status;

-- Q15
SELECT category, ROUND(AVG(price),2) AS average_price
FROM Menu_Items
GROUP BY category
ORDER BY average_price DESC
LIMIT 1;

-- Q16
SELECT MI.item_name, MI.category, MI.price
FROM Menu_Items MI
WHERE MI.price > (
    SELECT AVG(M2.price) FROM Menu_Items M2 WHERE M2.category = MI.category
);

-- Q17
SELECT CONCAT(E.first_name,' ',E.last_name) AS employee_name,
       SUM(CASE WHEN O.order_status='Completed'  THEN 1 ELSE 0 END) AS completed_orders,
       SUM(CASE WHEN O.order_status<>'Completed' THEN 1 ELSE 0 END) AS other_orders
FROM Employees E
LEFT JOIN Orders O ON E.employee_id = O.employee_id
GROUP BY E.employee_id, E.first_name, E.last_name;

-- Q18
SELECT O.order_id,
       CONCAT(C.first_name,' ',C.last_name) AS customer_name,
       MI.item_name, OI.quantity, OI.unit_price,
       OI.quantity*OI.unit_price AS line_total,
       O.order_status
FROM Orders O
JOIN Customers C   ON O.customer_id = C.customer_id
JOIN Order_Items OI ON O.order_id   = OI.order_id
JOIN Menu_Items MI  ON OI.item_id   = MI.item_id
ORDER BY O.order_id, MI.item_name;

-- Q19
SELECT C.first_name, C.last_name
FROM Customers C
LEFT JOIN Orders O ON C.customer_id = O.customer_id
WHERE O.order_id IS NULL;

-- Q20  ✅ FIX: expected answer ordered by actual totals (verified)
SELECT CONCAT(C.first_name,' ',C.last_name) AS customer_name,
       COALESCE(SUM(CASE WHEN O.order_status <> 'Cancelled'
                         THEN OI.quantity*OI.unit_price ELSE 0 END),0) AS total_order_value
FROM Customers C
LEFT JOIN Orders O       ON C.customer_id = O.customer_id
LEFT JOIN Order_Items OI ON O.order_id    = OI.order_id
GROUP BY C.customer_id, C.first_name, C.last_name
ORDER BY total_order_value DESC, C.customer_id;
-- Expected result:
--   Diya Patel    760
--   Aarav Sharma  690
--   Vihaan Rao    650
--   Rahul Verma   500
--   Arjun Kumar   440
--   Meera Reddy   300
--   Ananya Singh  0
--   Priya Nair    0

-- Q21
SELECT DISTINCT price FROM Menu_Items
ORDER BY price DESC
LIMIT 1 OFFSET 1;