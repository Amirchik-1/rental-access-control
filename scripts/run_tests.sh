#!/bin/bash

# =====================================================
# run_tests.sh - Запуск всех тестов безопасности
# =====================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=========================================="
echo "ЗАПУСК ТЕСТОВ БЕЗОПАСНОСТИ"
echo "==========================================${NC}"

DB_NAME="rental_db"
TESTS_PASSED=0
TESTS_FAILED=0

# Функция запуска теста
run_test() {
    local test_name=$1
    local test_file=$2
    local expected_result=$3
    
    echo -e "${YELLOW}Тест: $test_name${NC}"
    
    if psql -U postgres -d $DB_NAME -f "$test_file" 2>&1; then
        echo -e "${GREEN}  ✅ $test_name - ПРОЙДЕН${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}  ❌ $test_name - НЕ ПРОЙДЕН${NC}"
        ((TESTS_FAILED++))
    fi
    echo ""
}

# Запуск всех тестов
run_test "Изоляция клиентов" "tests/test_client_isolation.sql"
run_test "Региональное ограничение" "tests/test_manager_branch.sql"
run_test "Защита паспортных данных" "tests/test_passport_hidden.sql"
run_test "Полный доступ администратора" "tests/test_admin_full_access.sql"

# Итоги
echo -e "${BLUE}=========================================="
echo "ИТОГИ ТЕСТИРОВАНИЯ"
echo "==========================================${NC}"
echo -e "${GREEN}Пройдено: $TESTS_PASSED${NC}"
echo -e "${RED}Не пройдено: $TESTS_FAILED${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ ВСЕ ТЕСТЫ ПРОЙДЕНЫ! Система безопасна.${NC}"
    exit 0
else
    echo -e "${RED}❌ ЕСТЬ ОШИБКИ! Проверьте настройки RLS.${NC}"
    exit 1
fi
