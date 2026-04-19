-- Роли пользователей системы
DROP ROLE IF EXISTS r_client;
DROP ROLE IF EXISTS r_manager;
DROP ROLE IF EXISTS r_admin;

CREATE ROLE r_client;
CREATE ROLE r_manager;
CREATE ROLE r_admin;

-- Создаём конкретных пользователей
DROP USER IF EXISTS client_ivan;
DROP USER IF EXISTS client_petr;
DROP USER IF EXISTS manager_maria;
DROP USER IF EXISTS manager_dmitry;

CREATE USER client_ivan WITH PASSWORD 'ivan123';
CREATE USER client_petr WITH PASSWORD 'petr123';
CREATE USER manager_maria WITH PASSWORD 'maria123';
CREATE USER manager_dmitry WITH PASSWORD 'dmitry123';

-- Назначаем роли пользователям
GRANT r_client TO client_ivan;
GRANT r_client TO client_petr;
GRANT r_manager TO manager_maria;
GRANT r_manager TO manager_dmitry;
