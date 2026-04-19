#!/bin/bash

# =====================================================
# setup_db.sh - Скрипт для развёртывания базы данных
# =====================================================

set -e  # Останавливаем скрипт при любой ошибке

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================="
echo "Установка системы разграничения доступа"
echo "==========================================${NC}"

# Параметры подключения
DB_NAME="rental_db"
DB_USER="postgres"
DB_PASSWORD="postgres"

# Проверка наличия PostgreSQL
if ! command -v psql &> /dev/null; then
    echo -e "${RED}Ошибка: PostgreSQL не установлен${NC}"
    echo "Установите PostgreSQL: https://www.postgresql.org/download/"
    exit 1
fi

echo -e "${GREEN}✓ PostgreSQL найден${NC}"

# Создание базы данных (если не существует)
echo -e "${BLUE}Создание базы данных $DB_NAME...${NC}"
createdb -U $DB_USER $DB_NAME 2>/dev/null || echo "База данных уже существует"

# Выполнение SQL-скриптов в правильном порядке
echo -e "${BLUE}Выполнение SQL-скриптов...${NC}"

for script in sql/01_schema.sql sql/02_roles.sql sql/03_rls_policies.sql sql/04_test_data.sql sql/05_grants.sql; do
    echo -e "  Запуск $script..."
    psql -U $DB_USER -d $DB_NAME -f "$script" > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "    ${GREEN}✓ Готово${NC}"
    else
        echo -e "    ${RED}✗ Ошибка в $script${NC}"
        exit 1
    fi
done

echo -e "${GREEN}=========================================="
echo "Установка завершена успешно!"
echo "==========================================${NC}"

# Вывод информации для пользователя
echo -e "${BLUE}Проверка работы:${NC}"
echo ""
echo "1. Подключитесь как клиент Иван:"
echo "   psql -U client_ivan -d $DB_NAME -c 'SELECT * FROM rentals;'"
echo "   Пароль: IvanPass123!"
echo ""
echo "2. Подключитесь как менеджер Мария:"
echo "   psql -U manager_maria -d $DB_NAME -c 'SELECT full_name, phone FROM clients;'"
echo "   Пароль: MariaPass123!"
echo ""
echo "3. Подключитесь как администратор:"
echo "   psql -U admin_alex -d $DB_NAME -c 'SELECT * FROM clients;'"
echo "   Пароль: AdminPass123!"
echo ""
echo "4. Запустить все тесты:"
echo "   ./scripts/run_tests.sh"
