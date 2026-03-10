CREATE TABLE mutual_funds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fund_name VARCHAR(150) NOT NULL,
    fund_house VARCHAR(150),
    category VARCHAR(50),
    risk_level VARCHAR(50),
    current_nav DECIMAL(10,4)
);