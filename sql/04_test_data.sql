-- Добавляем клиентов
INSERT INTO clients (full_name, passport_data, phone, branch_id, db_user_name) VALUES
('Иванов Иван Иванович', '4510-123456', '+7-999-111-2233', 1, 'client_ivan'),
('Петров Петр Петрович', '4511-654321', '+7-999-444-5566', 2, 'client_petr'),
('Сидорова Анна Сергеевна', '4512-789012', '+7-999-777-8899', 1, NULL);

-- Добавляем оборудование
INSERT INTO equipment (name, price_per_day, branch_id) VALUES
('Перфоратор Bosch', 500.00, 1),
('Болгарка Makita', 300.00, 1),
('Дрель DeWalt', 400.00, 2);

-- Добавляем аренды
INSERT INTO rentals (client_id, equipment_id, total_price, status, branch_id) VALUES
(1, 1, 1500.00, 'active', 1),
(1, 2, 900.00, 'closed', 1),
(2, 3, 2400.00, 'active', 2),
(3, 1, 2500.00, 'active', 1),
(3, 2, 2600.00, 'active', 1);
