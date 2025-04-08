-- *Создание базы данных*
CREATE DATABASE IF NOT EXISTS ConstructionCompany
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ConstructionCompany;

-- *Создание таблиц*
-- Таблица "Должности" (Positions)
CREATE TABLE Positions (
    PositionID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(50) NOT NULL, -- Название должности
    Salary DECIMAL(10, 2) NOT NULL, -- Зарплата
    AccessLevel INT NOT NULL,
    CONSTRAINT CHK_AccessLevel CHECK (AccessLevel BETWEEN 1 AND 4)
) ENGINE=InnoDB;
-- DROP TABLE Positions;

-- Таблица "Сотрудники" (Employees)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    PositionID INT NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(50),
    Login VARCHAR(30) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL COMMENT 'Хранить хэш пароля!',
    FOREIGN KEY (PositionID) REFERENCES Positions(PositionID)
) ENGINE=InnoDB;
-- DROP TABLE Employees;

-- Таблица Clients (Клиенты)
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(50),
    Address VARCHAR(200)
) ENGINE=InnoDB;
-- DROP TABLE Clients;

-- Таблица Objects (Объекты)
CREATE TABLE Objects (
    ObjectID INT PRIMARY KEY AUTO_INCREMENT,
    ClientID INT NOT NULL,
    Address VARCHAR(200) NOT NULL,
    Type VARCHAR(50) NOT NULL COMMENT 'Квартира, дом, офис и т.д.',
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
) ENGINE=InnoDB;
-- DROP TABLE Objects;

-- Таблица WorkTypes (Виды работ)
CREATE TABLE WorkTypes (
    WorkTypeID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    Cost DECIMAL(10, 2) NOT NULL
) ENGINE=InnoDB;
-- DROP TABLE WorkTypes;

-- Таблица Materials (Материалы)
CREATE TABLE Materials (
    MaterialID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    Unit VARCHAR(20) NOT NULL COMMENT 'шт., кг, м и т.д.',
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity DECIMAL(10, 2) DEFAULT 0
) ENGINE=InnoDB;
-- DROP TABLE Materials;

-- Таблица Orders (Заказы)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ClientID INT NOT NULL,
    ObjectID INT NOT NULL,
    ManagerID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Status VARCHAR(20) DEFAULT 'New',
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ObjectID) REFERENCES Objects(ObjectID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
    CONSTRAINT CHK_Status CHECK (Status IN ('New', 'InProgress', 'Completed', 'Cancelled'))
) ENGINE=InnoDB;
-- DROP TABLE Orders;

-- Таблица OrderWorks (Работы по заказу)
CREATE TABLE OrderWorks (
    OrderWorkID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    WorkTypeID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (WorkTypeID) REFERENCES WorkTypes(WorkTypeID)
) ENGINE=InnoDB;
-- DROP TABLE OrderWorks;

-- Таблица OrderMaterials (Материалы по заказу)
CREATE TABLE OrderMaterials (
    OrderMaterialID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    MaterialID INT NOT NULL,
    Quantity DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (MaterialID) REFERENCES Materials(MaterialID)
) ENGINE=InnoDB;
-- DROP TABLE OrderMaterials;

-- Таблица Logs (Журнал действий)
CREATE TABLE Logs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    Action TEXT NOT NULL,
    ActionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
) ENGINE=InnoDB;
-- DROP TABLE Logs;


-- *Заполнение таблиц*
-- Заполнение таблицы Positions (Должности)
INSERT INTO Positions (Title, Salary, AccessLevel) VALUES
('Директор', 120000, 1),
('Менеджер проектов', 70000, 2),
('Прораб', 65000, 2),
('Мастер-отделочник', 50000, 3),
('Электрик', 48000, 3),
('Сантехник', 47000, 3),
('Кладовщик', 40000, 4),
('Бухгалтер', 55000, 2),
('Главный инженер', 90000, 2),
('Дизайнер интерьеров', 75000, 2),
('Маляр', 45000, 3),
('Плиточник', 52000, 3),
('Разнорабочий', 35000, 3),
('Логист', 48000, 4);


-- Заполнение таблицы Employees (Сотрудники)
INSERT INTO Employees (FullName, PositionID, Phone, Email, Login, Password) VALUES
('Смирнов Александр Иванович', 1, '+375171234567', 'smirnov@company.com', 'admin', SHA2('AdminPass123', 256)),
('Козлова Елена Владимировна', 2, '+375177654321', 'kozlova@company.com', 'manager', SHA2('ManagerPass456', 256)),
('Петров Игорь Дмитриевич', 3, '+375175554433', 'petrov@company.com', 'proраб', SHA2('ProRab789', 256)),
('Сидорова Ольга Николаевна', 4, '+375172223344', 'sidorova@company.com', 'master', SHA2('MasterPass111', 256)),
('Васильев Денис Сергеевич', 5, '+375173334455', 'vasilev@company.com', 'electric', SHA2('Electric222', 256)),
('Федорова Анна Павловна', 7, '+375174445566', 'fedotova@company.com', 'storekeeper', SHA2('Store333', 256)),
('Волков Дмитрий Анатольевич', 9, '+375177778899', 'volkov@company.com', 'engineer', SHA2('EngineerPass!44', 256)),
('Зайцева Анастасия Игоревна', 10, '+375178889900', 'zaytseva@company.com', 'designer', SHA2('DesignerPass%55', 256)),
('Белов Алексей Сергеевич', 11, '+375179990011', 'belov@company.com', 'painter', SHA2('PainterPass^66', 256)),
('Григорьев Павел Олегович', 12, '+375170001122', 'grigorev@company.com', 'tiler', SHA2('TilerPass&77', 256)),
('Семенова Виктория Дмитриевна', 13, '+375171112233', 'semenova@company.com', 'worker', SHA2('WorkerPass*88', 256)),
('Крылов Артем Вадимович', 14, '+375172223344', 'krylov@company.com', 'logist', SHA2('LogistPass(99', 256));

CREATE USER 'admin'@'%' IDENTIFIED BY 'AdminPass123';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'admin'@'%';
CREATE USER 'manager'@'%' IDENTIFIED BY 'ManagerPass456';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'manager'@'%';
CREATE USER 'proраб'@'%' IDENTIFIED BY 'ProRab789';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'proраб'@'%';
CREATE USER 'master'@'%' IDENTIFIED BY 'MasterPass111';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'master'@'%';
CREATE USER 'electric'@'%' IDENTIFIED BY 'Electric222';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'electric'@'%';
CREATE USER 'storekeeper'@'%' IDENTIFIED BY 'Store333';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'storekeeper'@'%';
CREATE USER 'engineer'@'%' IDENTIFIED BY 'EngineerPass!44';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'engineer'@'%';
CREATE USER 'designer'@'%' IDENTIFIED BY 'DesignerPass%55';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'designer'@'%';
CREATE USER 'painter'@'%' IDENTIFIED BY 'PainterPass^66';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'painter'@'%';
CREATE USER 'tiler'@'%' IDENTIFIED BY 'TilerPass&77';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'tiler'@'%';
CREATE USER 'worker'@'%' IDENTIFIED BY 'WorkerPass*88';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'worker'@'%';
CREATE USER 'logist'@'%' IDENTIFIED BY 'LogistPass(99';
GRANT ALL PRIVILEGES ON constructioncompany.* TO 'logist'@'%';
FLUSH PRIVILEGES;

-- TRUNCATE Employees;


-- Заполнение таблицы Clients (Клиенты)
INSERT INTO Clients (FullName, Phone, Email, Address) VALUES
('Иванов Сергей Михайлович', '+375291112233', 'ivanov@mail.ru', 'г. Минск, ул. Ленина, д. 10, кв. 5'),
('Кузнецова Мария Викторовна', '+375295556677', 'kuznetsova@gmail.com', 'г. Минск, ул. Пушкина, д. 42'),
('Соколов Андрей Игоревич', '+375298889900', 'sokolov@yandex.ru', 'г. Минск, пр. Мира, д. 15, кв. 12'),
('Морозова Екатерина Дмитриевна', '+375291234567', 'morozova@mail.ru', 'г. Минск, ул. Гагарина, д. 7, кв. 30'),
('Орлов Михаил Юрьевич', '+375291231231', 'orlov@mail.ru', 'г. Минск, ул. Тверская, д. 25, кв. 13'),
('Лебедева Татьяна Александровна', '+375292342342', 'lebedeva@gmail.com', 'г. Минск, ул. Садовая, д. 8, кв. 7'),
('Соловьев Иван Петрович', '+375293453453', 'sokolov@yandex.ru', 'г. Минск, пр. Вернадского, д. 92, кв. 64'),
('Воробьева Елена Сергеевна', '+375294564564', 'vorobeva@mail.ru', 'г. Минск, ул. Профсоюзная, д. 33, кв. 21'),
('Голубев Андрей Николаевич', '+375295675675', 'golubev@gmail.com', 'г. Минск, ул. Ленинградская, д. 15, кв. 9'),
('Филиппова Ольга Викторовна', '+375296786786', 'filippova@yandex.ru', 'г. Минск, ул. Дмитровская, д. 18, кв. 12');


-- Заполнение таблицы Objects (Объекты)
INSERT INTO Objects (ClientID, Address, Type) VALUES
(1, 'г. Минск, ул. Ленина, д. 10, кв. 5', 'Квартира'),
(2, 'г. Минск, ул. Пушкина, д. 42', 'Частный дом'),
(3, 'г. Минск, пр. Мира, д. 15, кв. 12', 'Квартира'),
(4, 'г. Минск, ул. Гагарина, д. 7, кв. 30', 'Квартира'),
(1, 'г. Минск, ул. Ленина, д. 10, кв. 6', 'Квартира'),
(5, 'г. Минск, ул. Тверская, д. 25, кв. 13', 'Квартира'),
(6, 'г. Минск, ул. Садовая, д. 8, кв. 7', 'Квартира'),
(7, 'г. Минск, пр. Вернадского, д. 92, кв. 64', 'Квартира'),
(8, 'г. Минск, ул. Профсоюзная, д. 33, кв. 21', 'Квартира'),
(9, 'г. Минск, ул. Ленинградская, д. 15, кв. 9', 'Квартира'),
(10, 'г. Минск, ул. Дмитровская, д. 18, кв. 12', 'Квартира'),
(5, 'г. Минск, ул. Тверская, д. 25, кв. 14', 'Квартира'),
(6, 'г. Минск, ул. Садовая, д. 8, кв. 8', 'Квартира');


-- Заполнение таблицы WorkTypes (Виды работ)
INSERT INTO WorkTypes (Title, Description, Cost) VALUES
('Штукатурка стен', 'Выравнивание стен цементной штукатуркой', 500.00),
('Поклейка обоев', 'Оклейка стен флизелиновыми обоями', 300.00),
('Укладка плитки', 'Укладка керамической плитки на пол и стены', 800.00),
('Электромонтажные работы', 'Разводка электропроводки, установка розеток', 1200.00),
('Сантехнические работы', 'Установка сантехники, прокладка труб', 1500.00),
('Установка натяжного потолка', 'Монтаж ПВХ потолка с освещением', 2000.00),
('Демонтаж перегородок', 'Удаление старых стен и перегородок', 1200.00),
('Грунтовка стен', 'Обработка стен грунтовкой глубокого проникновения', 200.00),
('Установка дверей', 'Монтаж межкомнатных и входных дверей', 2500.00),
('Укладка ламината', 'Настил ламината с подложкой', 600.00),
('Покраска потолка', 'Покраска водоэмульсионной краской', 400.00),
('Установка розеток', 'Монтаж электрических розеток и выключателей', 300.00);


-- Заполнение таблицы Materials (Материалы)
INSERT INTO Materials (Title, Unit, Price, StockQuantity) VALUES
('Цемент М500', 'мешок (50 кг)', 450.00, 100),
('Гипсокартон', 'лист', 600.00, 50),
('Керамическая плитка', 'кв.м', 1200.00, 200),
('Обои флизелиновые', 'рулон', 800.00, 30),
('Провод 2.5 мм²', 'метр', 60.00, 500),
('Труба ПВХ 50 мм', 'метр', 200.00, 100),
('Краска акриловая', 'банка (5 л)', 1500.00, 20),
('Плинтус напольный', 'метр', 250.00, 150),
('Ламинат', 'кв.м', 800.00, 150),
('Дверь межкомнатная', 'шт.', 4500.00, 20),
('Грунтовка', 'литр', 250.00, 50),
('Саморезы', 'упаковка (100 шт.)', 120.00, 200),
('Шпаклевка финишная', 'мешок (25 кг)', 700.00, 40),
('Плинтус потолочный', 'метр', 180.00, 100),
('Керамогранит', 'кв.м', 1500.00, 80),
('Монтажная пена', 'баллон', 300.00, 60);


-- Заполнение таблицы Orders (Заказы)
INSERT INTO Orders (ClientID, ObjectID, ManagerID, StartDate, EndDate, Status) VALUES
(1, 1, 2, '2024-05-01', '2024-05-30', 'Completed'),
(2, 2, 2, '2024-06-15', NULL, 'InProgress'),
(3, 3, 3, '2024-07-01', NULL, 'New'),
(4, 4, 2, '2024-05-20', '2024-06-20', 'Completed'),
(1, 5, 3, '2024-06-01', NULL, 'InProgress'),
(5, 6, 3, '2024-06-10', NULL, 'InProgress'),
(6, 7, 2, '2024-06-15', NULL, 'InProgress'),
(7, 8, 3, '2024-07-01', NULL, 'New'),
(8, 9, 2, '2024-05-25', '2024-06-25', 'Completed'),
(9, 10, 3, '2024-06-05', NULL, 'InProgress'),
(10, 11, 2, '2024-06-20', NULL, 'InProgress'),
(5, 12, 3, '2024-07-05', NULL, 'New'),
(6, 13, 2, '2024-05-30', '2024-06-30', 'Completed');


-- Заполнение таблицы OrderWorks (Работы по заказу)
INSERT INTO OrderWorks (OrderID, WorkTypeID, Quantity) VALUES
(1, 1, 50), -- Штукатурка стен для заказа 1
(1, 2, 30), -- Поклейка обоев для заказа 1
(2, 3, 25), -- Укладка плитки для заказа 2
(2, 4, 1),  -- Электромонтаж для заказа 2
(3, 5, 1),  -- Сантехника для заказа 3
(4, 6, 1),  -- Натяжной потолок для заказа 4
(5, 1, 40), -- Штукатурка стен для заказа 5
(6, 7, 1),   -- Демонтаж для заказа 6
(6, 8, 50),  -- Грунтовка для заказа 6
(7, 9, 3),   -- Установка дверей для заказа 7
(8, 10, 35), -- Укладка ламината для заказа 8
(9, 11, 1),  -- Покраска потолка для заказа 9
(10, 12, 10), -- Установка розеток для заказа 10
(11, 1, 30), -- Штукатурка для заказа 11
(12, 3, 20); -- Укладка плитки для заказа 12


-- Заполнение таблицы OrderMaterials (Материалы по заказу)
INSERT INTO OrderMaterials (OrderID, MaterialID, Quantity) VALUES
(1, 1, 20),  -- Цемент для заказа 1
(1, 2, 30),  -- Гипсокартон для заказа 1
(2, 3, 25),  -- Плитка для заказа 2
(2, 5, 50),  -- Провод для заказа 2
(3, 6, 10),  -- Трубы для заказа 3
(4, 7, 5),   -- Краска для заказа 4
(5, 1, 15),  -- Цемент для заказа 5
(6, 9, 10),  -- Ламинат для заказа 6
(6, 10, 2),  -- Двери для заказа 6
(7, 11, 5),  -- Грунтовка для заказа 7
(8, 12, 3),  -- Саморезы для заказа 8
(9, 13, 2),  -- Шпаклевка для заказа 9
(10, 14, 30), -- Плинтус для заказа 10
(11, 1, 15), -- Цемент для заказа 11
(12, 3, 25); -- Плитка для заказа 12


-- Заполнение таблицы Logs (Журнал действий)
INSERT INTO Logs (EmployeeID, Action) VALUES
(1, 'Создана новая должность: Бухгалтер'),
(2, 'Добавлен клиент: Морозова Екатерина Дмитриевна'),
(3, 'Зарегистрирован новый заказ №3'),
(2, 'Изменен статус заказа №1 на "Completed"'),
(4, 'Списаны материалы по заказу №2'),
(3, 'Заказ №6 передан в работу мастеру Белову А.С.'),
(2, 'Клиенту Орлову М.Ю. отправлен договор по заказу №6'),
(5, 'Списаны материалы: 10 кв.м ламината по заказу №6'),
(4, 'Завершены штукатурные работы по заказу №11'),
(6, 'На склад поступила партия керамогранита (80 кв.м)'),
(1, 'Изменен прайс-лист на малярные работы');


-- *Проверки*
-- Вывод заказов с клиентами
SELECT o.OrderID, c.FullName AS Client, o.Status
FROM Orders o
JOIN Clients c ON o.ClientID = c.ClientID;


-- Вывод материалов по заказу №1
SELECT m.Title, om.Quantity, m.Unit
FROM OrderMaterials om
JOIN Materials m ON om.MaterialID = m.MaterialID
WHERE om.OrderID = 1;


-- Вывод заказы с клиентами, менеджерами и объектами
    SELECT
    o.OrderID,
    c.FullName AS Client,
    e.FullName AS Manager,
    obj.Address AS Object,
    o.Status
FROM Orders o
JOIN Clients c ON o.ClientID = c.ClientID
JOIN Employees e ON o.ManagerID = e.EmployeeID
JOIN Objects obj ON o.ObjectID = obj.ObjectID
LIMIT 10;


-- *Тригеры*
-- Триггер для автоматического обновления остатков материалов
DELIMITER //
CREATE TRIGGER tr_UpdateMaterialStock
AFTER INSERT ON OrderMaterials
FOR EACH ROW
BEGIN
    UPDATE Materials
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE MaterialID = NEW.MaterialID;
END //
DELIMITER ;
-- Добавление материала в заказ
INSERT INTO OrderMaterials (OrderID, MaterialID, Quantity)
VALUES (5, 1, 10); -- 10 мешков цемента
-- Проверка остатка
SELECT StockQuantity FROM Materials WHERE MaterialID = 1;


-- Триггер проверки дат заказа
DELIMITER //
CREATE TRIGGER tr_CheckOrderDates
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    IF NEW.StartDate > NEW.EndDate AND NEW.EndDate IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Дата начала не может быть позже даты окончания';
    END IF;
END //
DELIMITER ;
-- Попытка создать заказ с некорректными датами
INSERT INTO Orders (ClientID, ObjectID, ManagerID, StartDate, EndDate)
VALUES (1, 1, 2, '2024-07-01', '2024-06-01'); -- Выводит ошибку


-- Триггер логирования изменений статуса заказа
DELIMITER //
CREATE TRIGGER tr_LogOrderStatusChange
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF OLD.Status != NEW.Status THEN
        INSERT INTO Logs (EmployeeID, Action)
        VALUES (NEW.ManagerID, CONCAT('Изменен статус заказа №', NEW.OrderID, ' с "', OLD.Status, '" на "', NEW.Status, '"'));
    END IF;
END //
DELIMITER ;
-- Изменение статуса заказа
UPDATE Orders SET Status = 'Completed'
WHERE OrderID = 2;
-- Проверка лога
SELECT Action FROM Logs
WHERE Action LIKE '%заказ №2%';


-- Триггер расчета стоимости заказа
DELIMITER //
CREATE TRIGGER tr_CalculateOrderTotal
AFTER INSERT ON OrderWorks
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(wt.Cost * ow.Quantity) INTO total
    FROM OrderWorks ow
    JOIN WorkTypes wt ON ow.WorkTypeID = wt.WorkTypeID
    WHERE ow.OrderID = NEW.OrderID;

    UPDATE Orders SET TotalCost = total WHERE OrderID = NEW.OrderID;
END //
DELIMITER ;
-- Тест 1: Добавление работы к заказу
-- Исходные данные
INSERT INTO Orders (OrderID, ClientID, ObjectID, ManagerID, StartDate)
VALUES (100, 1, 1, 2, '2024-01-01');

INSERT INTO WorkTypes (WorkTypeID, Title, Cost)
VALUES (100, 'Тестовая работа', 500.00);

-- Добавляем работу к заказу (должен сработать триггер)
INSERT INTO OrderWorks (OrderWorkID, OrderID, WorkTypeID, Quantity)
VALUES (100, 100, 100, 2);

INSERT INTO WorkTypes (WorkTypeID, Title, Cost)
VALUES (101, 'Дополнительная работа', 300.00);

INSERT INTO OrderWorks (OrderWorkID, OrderID, WorkTypeID, Quantity)
VALUES (101, 100, 101, 3);

-- Тест 2: Добавление второй работы к заказу
SELECT OrderID, TotalCost FROM Orders WHERE OrderID = 100;

-- Проверяем результат
SELECT OrderID, TotalCost FROM Orders WHERE OrderID = 100;
-- Создаем тестовую должность с некорректным уровнем доступа
INSERT INTO Positions (PositionID, Title, Salary, AccessLevel)
VALUES (100, 'Тестовая должность', 50000, 5); -- Уровень 5 недопустим
-- Попытка добавить сотрудника (должна вызвать ошибку)
INSERT INTO Employees (EmployeeID, FullName, PositionID, Login, Password)
VALUES (100, 'Тестовый Сотрудник', 100, 'test', 'test123');


-- Триггер проверки уровня доступа сотрудника
DELIMITER //
CREATE TRIGGER tr_CheckEmployeeAccess
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    DECLARE access_level INT;

    SELECT AccessLevel INTO access_level
    FROM Positions
    WHERE PositionID = NEW.PositionID;

    IF access_level < 1 OR access_level > 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Недопустимый уровень доступа для должности';
    END IF;
END //
DELIMITER ;
-- Тест 1: Попытка добавить сотрудника с недопустимым уровнем доступа
-- Создаем тестовую должность с некорректным уровнем доступа
INSERT INTO Positions (PositionID, Title, Salary, AccessLevel)
VALUES (100, 'Тестовая должность', 50000, 5); -- Уровень 5 недопустим

-- Попытка добавить сотрудника (должна вызвать ошибку)
INSERT INTO Employees (EmployeeID, FullName, PositionID, Login, Password)
VALUES (100, 'Тестовый Сотрудник', 100, 'test', 'test123');

-- Тест 2: Успешное добавление сотрудника
-- Корректная должность (уровень 2)
INSERT INTO Positions (PositionID, Title, Salary, AccessLevel)
VALUES (101, 'Нормальная должность', 60000, 2);

-- Успешное добавление
INSERT INTO Employees (EmployeeID, FullName, PositionID, Login, Password)
VALUES (101, 'Правильный Сотрудник', 101, 'valid', 'valid123');

-- Проверка
SELECT EmployeeID, FullName FROM Employees WHERE EmployeeID = 101;


-- *Хранимые процедуры*
-- Процедура формирования акта выполненных работ
DELIMITER //
CREATE PROCEDURE sp_GenerateWorkAct(IN order_id INT)
BEGIN
    SELECT
        o.OrderID,
        c.FullName AS Client,
        obj.Address AS Object,
        wt.Title AS WorkType,
        ow.Quantity,
        wt.Cost,
        (ow.Quantity * wt.Cost) AS Total
    FROM Orders o
    JOIN Clients c ON o.ClientID = c.ClientID
    JOIN Objects obj ON o.ObjectID = obj.ObjectID
    JOIN OrderWorks ow ON o.OrderID = ow.OrderID
    JOIN WorkTypes wt ON ow.WorkTypeID = wt.WorkTypeID
    WHERE o.OrderID = order_id;
END //
DELIMITER ;
-- Вызов для заказа №5
CALL sp_GenerateWorkAct(5);


-- Процедура расчета зарплаты сотрудника с премией
DELIMITER //
CREATE PROCEDURE sp_CalculateSalaryWithBonus(IN emp_id INT)
BEGIN
    DECLARE base_salary DECIMAL(10,2);
    DECLARE bonus DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    SELECT p.Salary INTO base_salary
    FROM Employees e
    JOIN Positions p ON e.PositionID = p.PositionID
    WHERE e.EmployeeID = emp_id;

    SELECT COUNT(*) * 1000 INTO bonus
    FROM Orders
    WHERE ManagerID = emp_id AND Status = 'Completed';

    SET total = base_salary + bonus;

    SELECT
        e.FullName,
        p.Title,
        base_salary AS BaseSalary,
        bonus AS Bonus,
        total AS TotalSalary;
END //
DELIMITER ;
-- Расчет для сотрудника с ID = 2
CALL sp_CalculateSalaryWithBonus(2);


-- Процедура поиска клиентов по диапазону сумм заказов
DELIMITER //
CREATE PROCEDURE sp_FindClientsByOrderSum(
    IN min_sum DECIMAL(10,2),
    IN max_sum DECIMAL(10,2))
BEGIN
    SELECT
        c.ClientID,
        c.FullName,
        SUM(wt.Cost * ow.Quantity) AS TotalOrderSum
    FROM Clients c
    JOIN Orders o ON c.ClientID = o.ClientID
    JOIN OrderWorks ow ON o.OrderID = ow.OrderID
    JOIN WorkTypes wt ON ow.WorkTypeID = wt.WorkTypeID
    GROUP BY c.ClientID, c.FullName
    HAVING TotalOrderSum BETWEEN min_sum AND max_sum
    ORDER BY TotalOrderSum DESC;
END //
DELIMITER ;
-- Поиск клиентов с заказами от 50 000 до 200 000 руб.
CALL sp_FindClientsByOrderSum(50000, 200000);


-- Процедура создания резервной копии данных
DELIMITER //
CREATE PROCEDURE sp_CreateBackup(IN backup_path VARCHAR(255))
BEGIN
    SET @sql = CONCAT('SELECT * INTO OUTFILE ''', backup_path, '/clients_backup.csv'' FROM Clients');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Добавить аналогично для других таблиц
    SELECT 'Backup completed' AS Result;
END //
DELIMITER ;
-- Создание бэкапа в указанный каталог
    CALL sp_CreateBackup('/var/backups/mysql');


-- Процедура анализа загруженности мастеров
DELIMITER //
CREATE PROCEDURE sp_GetWorkersWorkload()
BEGIN
    SELECT
        e.EmployeeID,
        e.FullName,
        p.Title,
        COUNT(DISTINCT o.OrderID) AS ActiveOrders,
        SUM(wt.Cost * ow.Quantity) AS TotalWorkCost
    FROM Employees e
    JOIN Positions p ON e.PositionID = p.PositionID
    JOIN Orders o ON e.EmployeeID = o.ManagerID
    JOIN OrderWorks ow ON o.OrderID = ow.OrderID
    JOIN WorkTypes wt ON ow.WorkTypeID = wt.WorkTypeID
    WHERE o.Status = 'InProgress'
    GROUP BY e.EmployeeID, e.FullName, p.Title
    ORDER BY ActiveOrders DESC;
END //
DELIMITER ;
-- Загруженность мастеров
    CALL sp_GetWorkersWorkload();


-- *Функции*
-- Функция расчета стоимости заказа
DELIMITER //
CREATE FUNCTION fn_CalculateOrderTotal(order_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(wt.Cost * ow.Quantity) INTO total
    FROM OrderWorks ow
    JOIN WorkTypes wt ON ow.WorkTypeID = wt.WorkTypeID
    WHERE ow.OrderID = order_id;

    RETURN total;
END //
DELIMITER ;
-- Расчет суммы заказа №3
SELECT fn_CalculateOrderTotal(3) AS TotalCost;

-- Функция проверки доступности материала
DELIMITER //
CREATE FUNCTION fn_CheckMaterialStock(
    material_id INT,
    required_qty DECIMAL(10,2))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE stock DECIMAL(10,2);
    DECLARE result VARCHAR(50);

    SELECT StockQuantity INTO stock
    FROM Materials
    WHERE MaterialID = material_id;

    IF stock >= required_qty THEN
        SET result = 'Достаточно';
    ELSE
        SET result = CONCAT('Недостаточно. Остаток: ', stock);
    END IF;

    RETURN result;
END //
DELIMITER ;
-- Проверка наличия 20 мешков цемента (MaterialID = 1)
SELECT fn_CheckMaterialStock(1, 20) AS Status;

-- Функция определения стажа сотрудника
DELIMITER //
CREATE FUNCTION fn_GetEmployeeExperience(emp_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE hire_date DATE;
    DECLARE experience INT;

    -- Предполагаем, что дата приема хранится в Logs
    SELECT MIN(ActionDate) INTO hire_date
    FROM Logs
    WHERE EmployeeID = emp_id AND Action LIKE '%принят%';

    SET experience = TIMESTAMPDIFF(YEAR, hire_date, CURDATE());

    RETURN experience;
END //
DELIMITER ;
-- Стаж сотрудника с ID = 1 (в годах)
SELECT fn_GetEmployeeExperience(1) AS ExperienceYears; -- Смотрит по Логам

-- Функция расчета средней стоимости работы по типу объекта
DELIMITER //
CREATE FUNCTION fn_GetAvgWorkCostByObjectType(object_type VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE avg_cost DECIMAL(10,2);

    SELECT AVG(wt.Cost) INTO avg_cost
    FROM OrderWorks ow
    JOIN WorkTypes wt ON ow.WorkTypeID = wt.WorkTypeID
    JOIN Orders o ON ow.OrderID = o.OrderID
    JOIN Objects obj ON o.ObjectID = obj.ObjectID
    WHERE obj.Type = object_type;

    RETURN avg_cost;
END //
DELIMITER ;
-- Средняя стоимость работ для квартир
SELECT fn_GetAvgWorkCostByObjectType('Квартира') AS AvgCost;

-- Функция проверки сложности заказа
DELIMITER //
CREATE FUNCTION fn_GetOrderComplexity(order_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE work_types INT;
    DECLARE complexity VARCHAR(20);

    SELECT COUNT(DISTINCT WorkTypeID) INTO work_types
    FROM OrderWorks
    WHERE OrderID = order_id;

    IF work_types > 5 THEN SET complexity = 'Сложный';
    ELSEIF work_types > 2 THEN SET complexity = 'Средний';
    ELSE SET complexity = 'Простой';
    END IF;

    RETURN complexity;
END //
DELIMITER ;
-- Определение сложности заказа №7
SELECT fn_GetOrderComplexity(7) AS Complexity;

-- *Представления*
-- Представление "Текущие заказы"
CREATE VIEW v_CurrentOrders AS
SELECT
    o.OrderID,
    c.FullName AS Client,
    obj.Address,
    o.StartDate,
    o.EndDate,
    o.Status,
    fn_CalculateOrderTotal(o.OrderID) AS TotalCost
FROM Orders o
JOIN Clients c ON o.ClientID = c.ClientID
JOIN Objects obj ON o.ObjectID = obj.ObjectID
WHERE o.Status IN ('New', 'InProgress');
-- Все активные заказы
SELECT * FROM v_CurrentOrders
WHERE Status = 'InProgress';

-- Представление "Финансовая аналитика"
CREATE VIEW v_FinancialAnalytics AS
SELECT
    DATE_FORMAT(o.StartDate, '%Y-%m') AS Month,
    COUNT(o.OrderID) AS OrdersCount,
    SUM(wt.Cost * ow.Quantity) AS Revenue,
    SUM(m.Price * om.Quantity) AS MaterialCosts,
    (SUM(wt.Cost * ow.Quantity) - SUM(m.Price * om.Quantity)) AS Profit
FROM Orders o
JOIN OrderWorks ow ON o.OrderID = ow.OrderID
JOIN WorkTypes wt ON ow.WorkTypeID = wt.WorkTypeID
LEFT JOIN OrderMaterials om ON o.OrderID = om.OrderID
LEFT JOIN Materials m ON om.MaterialID = m.MaterialID
GROUP BY Month
ORDER BY Month;
-- Данные за июнь 2024
SELECT * FROM v_FinancialAnalytics
WHERE Month = '2024-06';

-- Представление "Загрузка материалов"
CREATE VIEW v_MaterialUsage AS
SELECT
    m.Title,
    m.Unit,
    SUM(om.Quantity) AS TotalUsed,
    m.StockQuantity,
    (m.StockQuantity - SUM(om.Quantity)) AS Remaining
FROM Materials m
LEFT JOIN OrderMaterials om ON m.MaterialID = om.MaterialID
GROUP BY m.MaterialID, m.Title, m.Unit, m.StockQuantity;
-- Материалы с остатком менее 50 единиц
SELECT Title, Remaining FROM v_MaterialUsage
WHERE Remaining < 50;

-- Представление "Клиенты с максимальными затратами"
CREATE VIEW v_TopSpendingClients AS
SELECT
    c.ClientID,
    c.FullName,
    COUNT(o.OrderID) AS OrdersCount,
    SUM(fn_CalculateOrderTotal(o.OrderID)) AS TotalSpent
FROM Clients c
JOIN Orders o ON c.ClientID = o.ClientID
GROUP BY c.ClientID, c.FullName
ORDER BY TotalSpent DESC
LIMIT 10;
-- 5 самых активных клиентов
SELECT * FROM v_TopSpendingClients
LIMIT 5;

-- Представление "Статистика по работам"
CREATE VIEW v_WorkStatistics AS
SELECT
    wt.Title,
    COUNT(ow.OrderWorkID) AS UsageCount,
    AVG(wt.Cost) AS AvgCost,
    SUM(ow.Quantity) AS TotalQuantity,
    SUM(wt.Cost * ow.Quantity) AS TotalRevenue
FROM WorkTypes wt
LEFT JOIN OrderWorks ow ON wt.WorkTypeID = ow.WorkTypeID
GROUP BY wt.Title
ORDER BY UsageCount DESC;
-- Самые популярные виды работ
SELECT Title, UsageCount FROM v_WorkStatistics
ORDER BY UsageCount DESC
LIMIT 3;



-- RED Button
-- DROP DATABASE ConstructionCompany;
