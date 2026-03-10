CREATE TABLE sip_investments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    fund_id INT,
    monthly_amount DECIMAL(10,2),
    frequency VARCHAR(20),
    start_date DATE,
    status VARCHAR(20),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (fund_id) REFERENCES mutual_funds(id)
);