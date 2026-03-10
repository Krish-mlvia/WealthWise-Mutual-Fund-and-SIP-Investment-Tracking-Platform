CREATE TABLE portfolio_summary (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_invested DECIMAL(12,2),
    total_units DECIMAL(12,4),
    current_value DECIMAL(12,2),
    profit_loss DECIMAL(12,2),
    cagr DECIMAL(6,2),

    FOREIGN KEY (user_id) REFERENCES users(id)
);