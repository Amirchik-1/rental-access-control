-- Включаем RLS для таблицы аренды
ALTER TABLE rentals ENABLE ROW LEVEL SECURITY;

-- Политика 1: Клиент видит только свои аренды
DROP POLICY IF EXISTS policy_client_own_rentals ON rentals;
CREATE POLICY policy_client_own_rentals ON rentals
    FOR SELECT
    TO r_client
    USING (client_id = (
        SELECT client_id FROM clients 
        WHERE db_user_name = current_user
    ));

-- Политика 2: Менеджер видит аренды своего филиала
DROP POLICY IF EXISTS policy_manager_branch ON rentals;
CREATE POLICY policy_manager_branch ON rentals
    FOR SELECT
    TO r_manager
    USING (branch_id = (
        SELECT branch_id FROM clients 
        WHERE db_user_name = current_user
        LIMIT 1
    ));

-- Политика 3: Админ видит всё (политика не нужна, просто даём права)

-- Скрываем паспортные данные от менеджеров (на уровне столбца)
ALTER TABLE clients 
    ALTER COLUMN passport_data SET (security_label = 'restricted');
REVOKE SELECT (passport_data) ON clients FROM r_manager;
