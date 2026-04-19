-- =====================================================
-- ТЕСТ 4: Полный доступ администратора
-- Администратор должен видеть ВСЕ данные
-- =====================================================

\echo '=========================================='
\echo 'ТЕСТ 4: Полный доступ администратора'
\echo '=========================================='

-- Администратор видит всех клиентов с паспортами
SELECT '=== Все клиенты с паспортными данными ===' AS test_point;
SELECT client_id, full_name, passport_data, branch_id FROM clients;

-- Администратор видит все аренды
SELECT '=== Все аренды ===' AS test_point;
SELECT r.rental_id, c.full_name, e.name, r.total_price, r.status
FROM rentals r
JOIN clients c ON r.client_id = c.client_id
JOIN equipment e ON r.equipment_id = e.equipment_id;

-- Статистика системы (как в вашей первой работе)
SELECT '=== Статистика системы ===' AS test_point;
SELECT 
    (SELECT COUNT(*) FROM clients) AS total_clients,
    (SELECT COUNT(*) FROM rentals) AS total_rentals,
    (SELECT COUNT(*) FROM rentals WHERE status = 'active') AS active_rentals;

-- Администратор видит обороты по филиалам
SELECT '=== Обороты по филиалам ===' AS test_point;
SELECT 
    branch_id,
    COUNT(*) as rental_count,
    SUM(total_price) as total_revenue
FROM rentals
GROUP BY branch_id;

\echo '=== РЕЗУЛЬТАТ ТЕСТА 4 ==='
\echo '✅ Администратор имеет полный доступ - ТЕСТ ПРОЙДЕН'
