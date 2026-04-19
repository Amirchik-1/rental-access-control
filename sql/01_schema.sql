CREATE TABLE IF NOT EXISTS clients (
    client_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    passport_data VARCHAR(20) NOT NULL,
    phone VARCHAR(20),
    branch_id INTEGER DEFAULT 1,
    db_user_name VARCHAR(63)  -- имя пользователя PostgreSQL
);

CREATE TABLE IF NOT EXISTS equipment (
    equipment_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price_per_day DECIMAL(10,2),
    branch_id INTEGER
);

CREATE TABLE IF NOT EXISTS rentals (
    rental_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES clients(client_id),
    equipment_id INTEGER REFERENCES equipment(equipment_id),
    total_price DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'active',
    branch_id INTEGER
);
