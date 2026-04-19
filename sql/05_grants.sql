-- Права для клиентов
GRANT SELECT ON rentals TO r_client;
GRANT SELECT ON equipment TO r_client;

-- Права для менеджеров
GRANT SELECT, INSERT, UPDATE ON rentals TO r_manager;
GRANT SELECT ON equipment TO r_manager;
GRANT SELECT (full_name, phone) ON clients TO r_manager;

-- Права для администратора
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO r_admin;
