CREATE DATABASE windowFunction_practice;

USE windowFunction_practice;

CREATE TABLE insurance_claims (
    claim_id INT,
    policy_id INT,
    customer_name VARCHAR(50),
    hospital VARCHAR(50),
    claim_amount INT,
    claim_date DATE,
    claim_status VARCHAR(20),
    city VARCHAR(30)
);

INSERT INTO insurance_claims VALUES
(1, 101, 'Amit',   'Apollo',   50000, '2023-01-10', 'APPROVED', 'Bangalore'),
(2, 101, 'Amit',   'Apollo',   30000, '2023-02-15', 'REJECTED', 'Bangalore'),
(3, 102, 'Riya',   'Fortis',   70000, '2023-01-12', 'APPROVED', 'Mumbai'),
(4, 102, 'Riya',   'Fortis',   20000, '2023-03-18', 'PENDING',  'Mumbai'),
(5, 103, 'Kiran',  'Manipal',  45000, '2023-02-05', 'APPROVED', 'Bangalore'),
(6, 103, 'Kiran',  'Manipal',  55000, '2023-04-22', 'APPROVED', 'Bangalore'),
(7, 104, 'Neha',   'Apollo',   60000, '2023-01-20', 'REJECTED', 'Delhi'),
(8, 104, 'Neha',   'Apollo',   65000, '2023-03-25', 'APPROVED', 'Delhi'),
(9, 105, 'Arjun',  'Fortis',   40000, '2023-02-14', 'PENDING',  'Mumbai'),
(10,105, 'Arjun',  'Fortis',   90000, '2023-04-30', 'APPROVED', 'Mumbai');

SELECT * FROM insurance_claims;

-- AGGREGATE WINDOW FUNCTIONS

-- 1️.Show each claim with total claim amount per policy_id
SELECT claim_id,policy_id,claim_amount,
SUM(claim_amount)OVER(PARTITION BY policy_id)AS clm_amt_per_pol_id
FROM insurance_claims;

-- 2. Show each claim with average claim amount per customer
SELECT claim_id,customer_name,
AVG(claim_amount)OVER(PARTITION BY customer_name) as cust_avg_claim
FROM insurance_claims;


SELECT * FROM insurance_claims;

-- 3. Show each claim with maximum claim amount per hospital
SELECT claim_id,hospital,claim_amount,
MAX(claim_amount)OVER(PARTITION BY hospital) as max_clm_amt_per_hosp
FROM insurance_claims;

-- 4. Show each claim with total APPROVED claim amount per city
SELECT claim_id,city,claim_amount,
SUM(claim_amount)OVER(PARTITION BY city) as total_approved_amr_per_cirt
FROM insurance_claims
WHERE claim_status='APPROVED';

SELECT * FROM insurance_claims;

-- 5.Show each claim with count of claims per policy
SELECT claim_id,policy_id,
COUNT(policy_id)OVER(PARTITION BY policy_id)as count_of_claims_per_policy
FROM insurance_claims;
