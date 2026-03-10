CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sip_id INT,
    amount DECIMAL(10,2),
    nav DECIMAL(10,4),
    units DECIMAL(10,4),
    transaction_date DATE,

    FOREIGN KEY (sip_id) REFERENCES sip_investments(id)
);