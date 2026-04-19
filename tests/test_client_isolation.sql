-- Этот тест должен выполняться от имени client_ivan
-- Ожидается: только 2 аренды (Ивана)

\echo '=== Тест: клиент видит только свои аренды ==='
SELECT rental_id, equipment_id, total_price, status 
FROM rentals 
WHERE client_id = 1;

\echo '=== Попытка увидеть чужую аренду (должно быть 0 строк) ==='
SELECT * FROM rentals WHERE client_id = 2;
