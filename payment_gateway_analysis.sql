select COUNT(DISTINCT transaction_id) AS total_transactions
FROM payment_gateway_transactions;

SELECT *
FROM payment_gateway_transactions
LIMIT 10;

select column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'payment_gateway_transactions'
ORDER BY ordinal_position;

SELECT COUNT(*) AS total_transactions
FROM payment_gateway_transactions;

SELECT 
    payment_method,
    COUNT(*) AS transactions
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY transactions DESC;

SELECT 
    status,
    COUNT(*) AS transactions
FROM payment_gateway_transactions
GROUP BY status
ORDER BY transactions DESC;

SELECT
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(amount) AS total_processed_value,
    AVG(amount) AS average_transaction_value,
    SUM(gateway_revenue) AS total_gateway_revenue,
    SUM(net_revenue) AS total_net_revenue
FROM payment_gateway_transactions;

SELECT
    payment_method,
    COUNT(*) AS transactions,
    SUM(amount) AS transaction_value,
    AVG(amount) AS avg_transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY transaction_value DESC;

SELECT
    payment_method,
    status,
    COUNT(*) AS transactions,
    SUM(amount) AS transaction_value
FROM payment_gateway_transactions
GROUP BY payment_method, status
ORDER BY payment_method, transaction_value DESC;

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*),2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*),2) AS chargeback_rate
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY refund_rate DESC;

SELECT
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate
FROM payment_gateway_transactions;

SELECT
    merchant_category,
    COUNT(*) AS transactions,
    SUM(amount) AS transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY merchant_category
ORDER BY transaction_value DESC;

SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate,
    SUM(amount) AS transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY merchant_category
ORDER BY net_revenue DESC;

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate,
    SUM(amount) AS transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY net_revenue DESC;

SELECT
    DATE_TRUNC('month', date::DATE) AS month,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER ( WHERE status = 'Success') AS successful_transactions,
    SUM(amount) AS transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY DATE_TRUNC('month', date::DATE)
ORDER BY month;

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY chargeback_rate DESC;

SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate,
    SUM(amount) AS transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY merchant_category

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate,
    SUM(amount) AS transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
WHERE merchant_category = 'E-commerce'
GROUP BY payment_method
HAVING COUNT(*) >= 1000
ORDER BY net_revenue ASC;

SELECT
    DATE_TRUNC('month', date::DATE) AS month,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate,
    SUM(amount) AS transaction_value,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
WHERE merchant_category = 'E-commerce'
  AND payment_method = 'UPI'
GROUP BY DATE_TRUNC('month', date::DATE)
ORDER BY month;

SELECT
    merchant_category,
    payment_method,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refunded_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Refunded') / COUNT(*), 2) AS refund_rate,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'Charged-back') / COUNT(*), 2) AS chargeback_rate,
    SUM(amount) AS transaction_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY merchant_category, payment_method
HAVING COUNT(*) >= 1000
ORDER by net_revenue ASC;

SELECT
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(amount) AS total_processed_value,
    SUM(gateway_revenue) AS gross_gateway_revenue,
    SUM(interchange_cost) AS total_interchange_cost,
    SUM(network_cost) AS total_network_cost,
    SUM(refund_loss) AS total_refund_loss,
    SUM(chargeback_loss) AS total_chargeback_loss,
    SUM(net_revenue) AS net_revenue,
    ROUND((100.0 * SUM(gateway_revenue) / NULLIF(SUM(amount), 0))::numeric, 2) AS take_rate,
    ROUND((100.0 * SUM(net_revenue) / NULLIF(SUM(amount), 0))::numeric, 2) AS net_margin,
    ROUND((100.0 *(SUM(refund_loss) + SUM(chargeback_loss)) / NULLIF(SUM(gateway_revenue), 0))::numeric,2) AS revenue_leakage_rate
FROM payment_gateway_transactions;

-- Payment Method Unit Economics
SELECT
    payment_method,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(amount) AS processed_value,
    SUM(gateway_revenue) AS gross_gateway_revenue,
    SUM(interchange_cost) AS interchange_cost,
    SUM(network_cost) AS network_cost,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue,
    ROUND((100.0 * SUM(gateway_revenue) / NULLIF(SUM(amount), 0))::numeric, 2) AS take_rate,
    ROUND((100.0 * SUM(net_revenue) / NULLIF(SUM(amount), 0))::numeric, 2) AS net_margin,
    ROUND((100.0 *(SUM(refund_loss) + SUM(chargeback_loss)) / NULLIF(SUM(gateway_revenue), 0))::numeric, 2) AS revenue_leakage_rate
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY net_revenue DESC;

-- Processing Cost Burden by Payment Method
SELECT
    payment_method,
    SUM(amount) AS processed_value,
    SUM(gateway_revenue) AS gross_gateway_revenue,
    SUM(interchange_cost) AS interchange_cost,
    SUM(network_cost) AS network_cost,
    SUM(interchange_cost + network_cost) AS total_processing_cost,
    ROUND((100.0 * SUM(interchange_cost + network_cost) / NULLIF(SUM(amount), 0))::numeric,2) AS processing_cost_rate,
    ROUND((100.0 * SUM(gateway_revenue - interchange_cost - network_cost) / NULLIF(SUM(amount), 0))::numeric, 2) AS contribution_margin,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY processing_cost_rate DESC;

-- Net Revenue Reconciliation

SELECT
    SUM(gateway_revenue) AS total_gateway_revenue,
    SUM(interchange_cost) AS total_interchange_cost,
    SUM(network_cost) AS total_network_cost,
    SUM(refund_loss) AS total_refund_loss,
    SUM(chargeback_loss) AS total_chargeback_loss,
    SUM(gateway_revenue
        - interchange_cost
        - network_cost
        - refund_loss 
        - chargeback_loss) AS calculated_net_revenue,
    SUM(net_revenue) AS reported_net_revenue,
    ROUND((SUM(gateway_revenue
                - interchange_cost
                - network_cost
                - refund_loss
                - chargeback_loss) - SUM(net_revenue))::numeric, 2) AS reconciliation_difference
FROM payment_gateway_transactions;

-- Q24: Net Revenue Bridge

SELECT
    SUM(gateway_revenue) AS gross_gateway_revenue,
    SUM(interchange_cost) AS interchange_cost,
    SUM(network_cost) AS network_cost,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue,
    ROUND((100.0 * SUM(interchange_cost) / NULLIF(SUM(gateway_revenue), 0))::numeric, 2) AS interchange_pct_of_gross_revenue,
    ROUND((100.0 * SUM(network_cost) / NULLIF(SUM(gateway_revenue), 0))::numeric, 2) AS network_pct_of_gross_revenue,
    ROUND((100.0 * SUM(refund_loss) / NULLIF(SUM(gateway_revenue), 0))::numeric, 2) AS refund_pct_of_gross_revenue,
    ROUND((100.0 * SUM(chargeback_loss) / NULLIF(SUM(gateway_revenue), 0))::numeric, 2) AS chargeback_pct_of_gross_revenue,
    ROUND((100.0 * SUM(net_revenue) / NULLIF(SUM(gateway_revenue), 0))::numeric, 2) AS net_revenue_retention_pct
FROM payment_gateway_transactions;

-- Q25: Identify Loss-Making Segments

SELECT
    merchant_category,
    payment_method,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(amount) AS processed_value,
    SUM(gateway_revenue) AS gateway_revenue,
    SUM(interchange_cost) AS interchange_cost,
    SUM(network_cost) AS network_cost,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue,
    ROUND((100.0 * SUM(net_revenue)  / NULLIF(SUM(amount), 0))::numeric, 2) AS net_margin_pct
FROM payment_gateway_transactions
GROUP by merchant_category, payment_method
HAVING SUM(net_revenue) < 0
ORDER BY net_revenue ASC;

-- Q26: Net Revenue per Successful Transaction

select merchant_category, payment_method,
    COUNT(DISTINCT transaction_id) AS successful_transactions,
    SUM(net_revenue) AS net_revenue,
    ROUND((SUM(net_revenue) / NULLIF(COUNT(DISTINCT transaction_id), 0))::numeric, 2) AS net_revenue_per_successful_transaction
FROM payment_gateway_transactions
WHERE status = 'Success'
GROUP BY merchant_category, payment_method
ORDER BY net_revenue_per_successful_transaction DESC;

-- Q7: Trailing 3-Month Net Revenue Growth + Run Rate

WITH monthly_revenue AS (select DATE_TRUNC('month', date::date) AS month,
        SUM(net_revenue) AS net_revenue
    FROM payment_gateway_transactions
    GROUP BY DATE_TRUNC('month', date::date)),
trailing_3_month AS (select month, net_revenue,
        SUM(net_revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS trailing_3m_revenue
    FROM monthly_revenue)
select month, net_revenue, trailing_3m_revenue,
    ROUND(((trailing_3m_revenue / NULLIF(LAG(trailing_3m_revenue, 1) OVER (ORDER BY month), 0)) - 1)::numeric * 100, 2) AS trailing_3m_growth_pct,
    ROUND((trailing_3m_revenue / 3)::numeric, 2) AS average_monthly_net_revenue,
    ROUND(((trailing_3m_revenue / 3) * 12)::numeric, 2) AS implied_annual_run_rate
FROM trailing_3_month
ORDER BY month;

-- Q8: Net Revenue Concentration
-- Top Merchant Category + Top Payment Method

WITH category_revenue AS (SELECT merchant_category, SUM(net_revenue) AS net_revenue
    FROM payment_gateway_transactions
    GROUP BY merchant_category),
method_revenue AS (select payment_method, SUM(net_revenue) AS net_revenue
    FROM payment_gateway_transactions
    GROUP BY payment_method),
total_revenue AS (select SUM(net_revenue) AS total_net_revenue
    FROM payment_gateway_transactions)
select 'Merchant Category' AS concentration_type, cr.merchant_category AS segment,
    ROUND(cr.net_revenue::numeric, 2) AS net_revenue,
    ROUND((100.0 * cr.net_revenue / NULLIF(tr.total_net_revenue, 0))::numeric, 2) AS revenue_share_pct
FROM category_revenue cr
CROSS JOIN total_revenue tr
WHERE cr.net_revenue = (SELECT MAX(net_revenue) FROM category_revenue)
UNION ALL
select 'Payment Method' AS concentration_type, mr.payment_method AS segment,
    ROUND(mr.net_revenue::numeric, 2) AS net_revenue,
    ROUND((100.0 * mr.net_revenue / NULLIF(tr.total_net_revenue, 0))::numeric, 2) AS revenue_share_pct
FROM method_revenue mr
CROSS JOIN total_revenue tr
WHERE mr.net_revenue = (SELECT MAX(net_revenue) FROM method_revenue);

-- Q10: Net Revenue Margin
select SUM(amount) AS tpv,
    SUM(gateway_revenue) AS gross_gateway_revenue,
    SUM(interchange_cost) AS interchange_cost,
    SUM(network_cost) AS network_cost,
    SUM(refund_loss) AS refund_loss,
    SUM(chargeback_loss) AS chargeback_loss,
    SUM(net_revenue) AS net_revenue,
    ROUND((100.0 * SUM(net_revenue) / NULLIF(SUM(amount), 0))::numeric, 2) AS net_revenue_margin_pct
FROM payment_gateway_transactions;

-- Q11: Monthly Seasonality Analysis
WITH monthly_metrics AS (SELECT DATE_TRUNC('month', date::date) AS month,
        SUM(amount) AS tpv,
        SUM(net_revenue) AS net_revenue,
        COUNT(DISTINCT transaction_id) AS transactions
    FROM payment_gateway_transactions
    GROUP BY DATE_TRUNC('month', date::date)),
portfolio_avg AS (SELECT AVG(net_revenue) AS avg_monthly_net_revenue
    FROM monthly_metrics)
select mm.month, mm.tpv, mm.transactions, mm.net_revenue,
    ROUND((100.0 * mm.net_revenue / NULLIF(pa.avg_monthly_net_revenue, 0))::numeric, 2) AS pct_of_avg_monthly_revenue,
    ROUND((100.0 * (mm.net_revenue - LAG(mm.net_revenue) OVER (ORDER BY mm.month)) / NULLIF(LAG(mm.net_revenue) OVER (ORDER BY mm.month), 0))::numeric, 2) AS mom_growth_pct
FROM monthly_metrics mm
CROSS JOIN portfolio_avg p
ORDER BY mm.month;


-- Q27 Average Ticket Size
SELECT
    payment_method,
    COUNT(DISTINCT transaction_id) AS transactions,
    SUM(amount) AS processed_value,
    ROUND(SUM(amount)::numeric / NULLIF(COUNT(DISTINCT transaction_id), 0), 2) AS avg_ticket_size
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY avg_ticket_size DESC;

-- Q27 Average Ticket Size
-- Part 2: By Merchant Category

SELECT
    merchant_category,
    COUNT(DISTINCT transaction_id) AS transactions,
    SUM(amount) AS processed_value,
    ROUND(SUM(amount)::numeric / NULLIF(COUNT(DISTINCT transaction_id), 0), 2) AS avg_ticket_size
FROM payment_gateway_transactions
GROUP BY merchant_category
ORDER BY avg_ticket_size DESC;

-- Q27 Average Ticket Size
-- Part 3: Merchant Category × Payment Method

SELECT
    merchant_category,
    payment_method,
    COUNT(DISTINCT transaction_id) AS transactions,
    SUM(amount) AS processed_value,
    ROUND(SUM(amount)::numeric / NULLIF(COUNT(DISTINCT transaction_id), 0), 2) AS avg_ticket_size
FROM payment_gateway_transactions
GROUP BY merchant_category, payment_method
ORDER by avg_ticket_size DESC;

-- Q28 Refund vs Chargeback Behaviour
-- Part 1: Overall comparison

-- Q28 Refund vs Chargeback Behaviour
-- Part 1: Overall comparison

SELECT
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refund_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(SUM(refund_loss)::numeric, 2) AS total_refund_loss,
    ROUND(SUM(chargeback_loss)::numeric, 2) AS total_chargeback_loss,
    ROUND((SUM(refund_loss) / NULLIF(SUM(chargeback_loss), 0))::numeric, 2) AS refund_to_chargeback_loss_ratio
FROM payment_gateway_transactions;

-- Q28 Refund vs Chargeback Behaviour
-- Part 2: By Merchant Category

select merchant_category,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refund_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND(SUM(refund_loss)::numeric, 2) AS total_refund_loss,
    ROUND(SUM(chargeback_loss)::numeric, 2) AS total_chargeback_loss,
    ROUND((SUM(refund_loss) / NULLIF(SUM(chargeback_loss), 0))::numeric, 2) AS refund_to_chargeback_loss_ratio
FROM payment_gateway_transactions
GROUP BY merchant_category
ORDER BY total_refund_loss DESC;

-- Q29 Risk-Adjusted Revenue Per Transaction
-- Part 1: By Payment Method

SELECT
    payment_method,
    COUNT(DISTINCT transaction_id) AS transactions,
    ROUND(SUM(gateway_revenue)::numeric, 2) AS gateway_revenue,
    ROUND(SUM(refund_loss)::numeric, 2) AS refund_loss,
    ROUND(SUM(chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND((SUM(gateway_revenue)
            - SUM(refund_loss)
            - SUM(chargeback_loss))::numeric, 2) AS risk_adjusted_revenue,
    ROUND(((SUM(gateway_revenue)
                - SUM(refund_loss)
                - SUM(chargeback_loss)) / NULLIF(COUNT(DISTINCT transaction_id), 0))::numeric, 2) AS risk_adjusted_revenue_per_transaction
FROM payment_gateway_transactions
GROUP BY payment_method
ORDER BY risk_adjusted_revenue_per_transaction DESC;

-- Q29 Risk-Adjusted Revenue Per Transaction
-- Part 2: By Merchant Category

select merchant_category,
    COUNT(DISTINCT transaction_id) AS transactions,
    ROUND(SUM(gateway_revenue)::numeric, 2) AS gateway_revenue,
    ROUND(SUM(refund_loss)::numeric, 2) AS refund_loss,
    ROUND(SUM(chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND((SUM(gateway_revenue)
            - SUM(refund_loss)
            - SUM(chargeback_loss))::numeric, 2) AS risk_adjusted_revenue,
    ROUND(((SUM(gateway_revenue)
                - SUM(refund_loss)
                - SUM(chargeback_loss)
            ) / NULLIF(COUNT(DISTINCT transaction_id), 0))::numeric, 2) AS risk_adjusted_revenue_per_transaction
FROM payment_gateway_transactions
GROUP BY merchant_category
ORDER BY risk_adjusted_revenue_per_transaction DESC;

-- Q29 Risk-Adjusted Revenue Per Transaction
-- Part 3: Merchant Category × Payment Method

select merchant_category, payment_method,
    COUNT(DISTINCT transaction_id) AS transactions,
    ROUND(SUM(gateway_revenue)::numeric, 2) AS gateway_revenue,
    ROUND(SUM(refund_loss)::numeric, 2) AS refund_loss,
    ROUND(SUM(chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND((SUM(gateway_revenue)
            - SUM(refund_loss)
            - SUM(chargeback_loss))::numeric, 2) AS risk_adjusted_revenue,
    ROUND(((SUM(gateway_revenue)
                - SUM(refund_loss)
                - SUM(chargeback_loss)
            ) / NULLIF(COUNT(DISTINCT transaction_id), 0))::numeric, 2) AS risk_adjusted_revenue_per_transaction
FROM payment_gateway_transactions
GROUP BY merchant_category, payment_method
ORDER BY risk_adjusted_revenue_per_transaction DESC;

-- Q30 Does Risk Increase With Transaction Amount?

select CASE WHEN amount < 500 THEN '< ₹500'
        WHEN amount < 1000 THEN '₹500 - ₹999'
        WHEN amount < 2500 THEN '₹1,000 - ₹2,499'
        WHEN amount < 5000 THEN '₹2,500 - ₹4,999'
        WHEN amount < 10000 THEN '₹5,000 - ₹9,999'
        ELSE '₹10,000+'
    END AS amount_band,
    COUNT(DISTINCT transaction_id) AS transactions,
    ROUND(AVG(amount)::numeric, 2) AS avg_transaction_amount,
    COUNT(*) FILTER (WHERE status = 'Refunded') AS refund_transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND((COUNT(*) FILTER (WHERE status = 'Refunded')::numeric / NULLIF(COUNT(*), 0)) * 100, 2) AS refund_rate_pct,
    ROUND((COUNT(*) FILTER (WHERE status = 'Charged-back')::numeric / NULLIF(COUNT(*), 0)) * 100, 2) AS chargeback_rate_pct,
    ROUND(((COUNT(*) FILTER (WHERE status IN ('Refunded', 'Charged-back'))::numeric / NULLIF(COUNT(*), 0)) * 100), 2) AS combined_risk_rate_pct
FROM payment_gateway_transactions
GROUP BY amount_band
ORDER BY  MIN(amount);

-- Q31 Chargeback Rate by Amount Band

SELECT
    CASE
        WHEN amount < 500 THEN '< ₹500'
        WHEN amount < 1000 THEN '₹500 - ₹999'
        WHEN amount < 2500 THEN '₹1,000 - ₹2,499'
        WHEN amount < 5000 THEN '₹2,500 - ₹4,999'
        WHEN amount < 10000 THEN '₹5,000 - ₹9,999'
        ELSE '₹10,000+'
    END AS amount_band,
    COUNT(DISTINCT transaction_id) AS transactions,
    COUNT(*) FILTER (WHERE status = 'Charged-back') AS chargeback_transactions,
    ROUND((COUNT(*) FILTER (WHERE status = 'Charged-back')::numeric / NULLIF(COUNT(*), 0)) * 100, 2) AS chargeback_rate_pct,
    ROUND(SUM(chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND((SUM(chargeback_loss) / NULLIF(COUNT(*) FILTER (WHERE status = 'Charged-back'), 0))::numeric, 2) AS loss_per_chargeback
FROM payment_gateway_transactions
GROUP BY amount_band
ORDER BY MIN(amount);

-- Q32 Payment Method Mix Over Time

WITH monthly_method AS (select DATE_TRUNC('month', date::date) AS month, payment_method,
        COUNT(DISTINCT transaction_id) AS transactions,
        SUM(amount) AS processed_value
    FROM payment_gateway_transactions
    GROUP by DATE_TRUNC('month', date::date), payment_method)
SELECT month, payment_method, transactions,
    ROUND(((transactions::numeric / NULLIF(SUM(transactions) OVER (PARTITION BY month), 0)) * 100)::numeric, 2) AS transaction_mix_pct,
    ROUND(processed_value::numeric, 2) AS processed_value,
    ROUND(((processed_value::numeric / NULLIF(SUM(processed_value) OVER (PARTITION BY month), 0)) * 100)::numeric, 2) AS tpv_mix_pct
FROM monthly_method
ORDER by month, transaction_mix_pct DESC;

-- Q33 Take Rate: Price vs Mix

WITH monthly_method AS (SELECT DATE_TRUNC('month', date::date) AS month, payment_method,
        SUM(amount) AS processed_value,
        SUM(gateway_revenue) AS gateway_revenue
    FROM payment_gateway_transactions
    GROUP BY DATE_TRUNC('month', date::date), payment_method),
method_metrics AS (SELECT month, payment_method, processed_value, gateway_revenue,
        ROUND((gateway_revenue / NULLIF(processed_value, 0))::numeric * 100, 2) AS take_rate_pct,
        ROUND(((processed_value / NULLIF(SUM(processed_value) OVER (PARTITION BY month), 0)) * 100)::numeric, 2) AS tpv_mix_pct
    FROM monthly_method)
SELECT month, payment_method,
    ROUND(processed_value::numeric, 2) AS processed_value,
    ROUND(gateway_revenue::numeric, 2) AS gateway_revenue,
    take_rate_pct, tpv_mix_pct,
    ROUND((take_rate_pct::numeric * tpv_mix_pct::numeric) / 100, 2) AS contribution_to_blended_take_rate
FROM method_metrics
ORDER BY month, contribution_to_blended_take_rate DESC;

-- Q34 Monthly TPV + Net Revenue Growth

WITH monthly_financials AS (select DATE_TRUNC('month', date::date) AS month,
        SUM(amount) AS tpv,
        SUM(net_revenue) AS net_revenue
    FROM payment_gateway_transactions
    GROUP BY DATE_TRUNC('month', date::date)),
growth_metrics AS (SELECT month, tpv, net_revenue,
        LAG(tpv) OVER (ORDER BY month) AS previous_month_tpv, 
        LAG(net_revenue) OVER (ORDER BY month) AS previous_month_net_revenue
    FROM monthly_financials)
SELECT month, ROUND(tpv::numeric, 2) AS tpv,
    ROUND(net_revenue::numeric, 2) AS net_revenue,
    ROUND(((tpv - previous_month_tpv) / NULLIF(previous_month_tpv, 0))::numeric * 100, 2) AS tpv_growth_pct,
    ROUND(((net_revenue - previous_month_net_revenue) / NULLIF(previous_month_net_revenue, 0))::numeric * 100, 2) AS net_revenue_growth_pct
FROM growth_metrics
ORDER BY month;
-- Q35 Trailing 3-Month Net Revenue Growth + Run Rate

WITH monthly_financials AS (
    SELECT DATE_TRUNC('month', date::date) AS month, SUM(net_revenue) AS net_revenue
    FROM payment_gateway_transactions
    GROUP BY DATE_TRUNC('month', date::date)),
trailing_metrics AS (SELECT month, net_revenue,
        SUM(net_revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS trailing_3m_net_revenue
    FROM monthly_financials),
growth_metrics AS (SELECT month, net_revenue, trailing_3m_net_revenue,
        LAG(trailing_3m_net_revenue) OVER (ORDER BY month) AS previous_trailing_3m_revenue
    FROM trailing_metrics)
select month,
    ROUND(net_revenue::numeric, 2) AS monthly_net_revenue,
    ROUND(trailing_3m_net_revenue::numeric, 2) AS trailing_3m_net_revenue,
    ROUND(((trailing_3m_net_revenue - previous_trailing_3m_revenue) / NULLIF(previous_trailing_3m_revenue, 0))::numeric * 100, 2) AS trailing_3m_growth_pct,
    ROUND((trailing_3m_net_revenue * 4)::numeric, 2) AS annualized_run_rate
FROM growth_metrics
ORDER BY month;

-- Q36 Seasonality

WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC('month', date::date) AS month,
        COUNT(DISTINCT transaction_id) AS transactions,
        SUM(amount) AS tpv,
        SUM(net_revenue) AS net_revenue
    FROM payment_gateway_transactions
    GROUP BY DATE_TRUNC('month', date::date)
),

averages AS (
    SELECT
        AVG(tpv) AS avg_monthly_tpv,
        AVG(net_revenue) AS avg_monthly_net_revenue
    FROM monthly_metrics
)

SELECT
    m.month,
    m.transactions,
    ROUND(m.tpv::numeric, 2) AS tpv,
    ROUND(m.net_revenue::numeric, 2) AS net_revenue,

    ROUND(
        (m.tpv / NULLIF(a.avg_monthly_tpv, 0))::numeric * 100,
        2
    ) AS tpv_vs_avg_pct,

    ROUND(
        (m.net_revenue / NULLIF(a.avg_monthly_net_revenue, 0))::numeric * 100,
        2
    ) AS net_revenue_vs_avg_pct

FROM monthly_metrics m
CROSS JOIN averages a
ORDER BY m.month;

-- Q37 Failure Revenue Cost
-- First check whether failed transactions exist

select status,
    COUNT(DISTINCT transaction_id) AS transactions,
    SUM(amount) AS processed_value,
    SUM(net_revenue) AS net_revenue
FROM payment_gateway_transactions
GROUP BY status
ORDER BY transactions DESC;

-- Q38 Recoverable Revenue From Improving Success Rate
-- Establish the observed transaction baseline

SELECT
    COUNT(DISTINCT transaction_id) AS total_transactions,
    COUNT(DISTINCT CASE
        WHEN status = 'Success'
        THEN transaction_id
    END) AS successful_transactions,
    ROUND(
        (
            COUNT(DISTINCT CASE
                WHEN status = 'Success'
                THEN transaction_id
            END)::numeric
            / NULLIF(COUNT(DISTINCT transaction_id), 0)
        ) * 100,
        2
    ) AS successful_status_share_pct,
    SUM(
        CASE
            WHEN status = 'Success'
            THEN amount
            ELSE 0
        END
    ) AS successful_processed_value
FROM payment_gateway_transactions;

-- Q39 Volume Shift Scenario
-- Step 1: Baseline economics by payment method

WITH method_metrics AS (
    SELECT
        payment_method,

        COUNT(DISTINCT transaction_id) AS transactions,

        SUM(amount) AS processed_value,

        SUM(gateway_revenue) AS gateway_revenue,

        SUM(net_revenue) AS net_revenue

    FROM payment_gateway_transactions

    GROUP BY payment_method
)

SELECT
    payment_method,

    transactions,

    ROUND(processed_value::numeric, 2) AS processed_value,

    ROUND(gateway_revenue::numeric, 2) AS gateway_revenue,

    ROUND(net_revenue::numeric, 2) AS net_revenue,

    ROUND(
        (
            net_revenue::numeric
            / NULLIF(processed_value::numeric, 0)
        ) * 100,
        2
    ) AS net_margin_pct

FROM method_metrics

ORDER BY net_revenue DESC;

-- Q39 Volume Shift Scenario
-- Scenario: 10% of UPI transaction volume shifts to Net Banking

WITH method_metrics AS (
    SELECT
        payment_method,

        COUNT(DISTINCT transaction_id) AS transactions,

        SUM(amount) AS processed_value,

        SUM(net_revenue) AS net_revenue,

        SUM(net_revenue)::numeric
            / NULLIF(COUNT(DISTINCT transaction_id), 0)
            AS net_revenue_per_transaction

    FROM payment_gateway_transactions

    GROUP BY payment_method
),

baseline AS (
    SELECT
        MAX(
            CASE
                WHEN payment_method = 'UPI'
                THEN transactions
            END
        ) AS upi_transactions,

        MAX(
            CASE
                WHEN payment_method = 'UPI'
                THEN net_revenue_per_transaction
            END
        ) AS upi_net_revenue_per_transaction,

        MAX(
            CASE
                WHEN payment_method = 'Net Banking'
                THEN net_revenue_per_transaction
            END
        ) AS net_banking_net_revenue_per_transaction

    FROM method_metrics
),

scenario AS (
    SELECT
        upi_transactions * 0.10
            AS shifted_transactions,

        upi_transactions * 0.90
            AS remaining_upi_transactions,

        upi_transactions * 0.10
            AS additional_net_banking_transactions,

        upi_net_revenue_per_transaction,

        net_banking_net_revenue_per_transaction

    FROM baseline
),

impact AS (
    SELECT
        shifted_transactions,

        remaining_upi_transactions,

        additional_net_banking_transactions,

        ROUND(
            (
                shifted_transactions
                * upi_net_revenue_per_transaction
            )::numeric,
            2
        ) AS original_net_revenue_from_shifted_volume,

        ROUND(
            (
                shifted_transactions
                * net_banking_net_revenue_per_transaction
            )::numeric,
            2
        ) AS net_revenue_after_shift

    FROM scenario
)

SELECT
    ROUND(shifted_transactions::numeric, 0)
        AS transactions_shifted,

    ROUND(remaining_upi_transactions::numeric, 0)
        AS remaining_upi_transactions,

    ROUND(additional_net_banking_transactions::numeric, 0)
        AS additional_net_banking_transactions,

    original_net_revenue_from_shifted_volume,

    net_revenue_after_shift,

    ROUND(
        (
            net_revenue_after_shift
            - original_net_revenue_from_shifted_volume
        )::numeric,
        2
    ) AS incremental_net_revenue

FROM impact;

-- Q40 Risk-Based Pricing
-- Compare transaction risk and economics by payment method

SELECT
    payment_method,

    COUNT(DISTINCT transaction_id) AS transactions,

    ROUND(
        SUM(amount)::numeric,
        2
    ) AS processed_value,

    ROUND(
        SUM(gateway_revenue)::numeric,
        2
    ) AS gateway_revenue,

    ROUND(
        SUM(refund_loss)::numeric,
        2
    ) AS refund_loss,

    ROUND(
        SUM(chargeback_loss)::numeric,
        2
    ) AS chargeback_loss,

    ROUND(
        (
            SUM(refund_loss) + SUM(chargeback_loss)
        )::numeric,
        2
    ) AS total_risk_loss,

    ROUND(
        (
            (
                SUM(refund_loss) + SUM(chargeback_loss)
            )
            / NULLIF(SUM(amount), 0)
            * 100
        )::numeric,
        2
    ) AS risk_loss_rate_pct,

    ROUND(
        (
            SUM(gateway_revenue)
            / NULLIF(SUM(amount), 0)
            * 100
        )::numeric,
        2
    ) AS take_rate_pct,

    ROUND(
        SUM(net_revenue)::numeric,
        2
    ) AS net_revenue,

    ROUND(
        (
            SUM(net_revenue)
            / NULLIF(SUM(amount), 0)
            * 100
        )::numeric,
        2
    ) AS net_margin_pct

FROM payment_gateway_transactions

GROUP BY payment_method

ORDER BY risk_loss_rate_pct DESC;

-- Q41 Category × Method Growth

WITH monthly_category_method AS (
    SELECT
        DATE_TRUNC('month', date::date) AS month,
        merchant_category,
        payment_method,

        COUNT(DISTINCT transaction_id) AS transactions,

        SUM(amount)::numeric AS processed_value,

        SUM(net_revenue)::numeric AS net_revenue

    FROM payment_gateway_transactions

    GROUP BY
        DATE_TRUNC('month', date::date),
        merchant_category,
        payment_method
),

growth_metrics AS (
    SELECT
        month,
        merchant_category,
        payment_method,
        transactions,
        processed_value,
        net_revenue,

        LAG(transactions) OVER (
            PARTITION BY merchant_category, payment_method
            ORDER BY month
        ) AS previous_month_transactions,

        LAG(processed_value) OVER (
            PARTITION BY merchant_category, payment_method
            ORDER BY month
        ) AS previous_month_processed_value,

        LAG(net_revenue) OVER (
            PARTITION BY merchant_category, payment_method
            ORDER BY month
        ) AS previous_month_net_revenue

    FROM monthly_category_method
)

SELECT
    month,
    merchant_category,
    payment_method,

    transactions,

    ROUND(
        processed_value,
        2
    ) AS processed_value,

    ROUND(
        net_revenue,
        2
    ) AS net_revenue,

    ROUND(
        (
            (
                transactions::numeric
                - previous_month_transactions::numeric
            )
            / NULLIF(previous_month_transactions::numeric, 0)
        ) * 100,
        2
    ) AS transaction_growth_pct,

    ROUND(
        (
            (
                processed_value
                - previous_month_processed_value
            )
            / NULLIF(previous_month_processed_value, 0)
        ) * 100,
        2
    ) AS tpv_growth_pct,

    ROUND(
        (
            (
                net_revenue
                - previous_month_net_revenue
            )
            / NULLIF(previous_month_net_revenue, 0)
        ) * 100,
        2
    ) AS net_revenue_growth_pct

FROM growth_metrics

ORDER BY
    merchant_category,
    payment_method,
    month;


-- Q42 Top Category Concentration

WITH category_revenue AS (
    SELECT
        merchant_category,

        SUM(net_revenue)::numeric AS net_revenue

    FROM payment_gateway_transactions

    GROUP BY merchant_category
),

total_revenue AS (
    SELECT
        SUM(net_revenue)::numeric AS total_net_revenue
    FROM payment_gateway_transactions
)

SELECT
    c.merchant_category,

    ROUND(
        c.net_revenue,
        2
    ) AS net_revenue,

    ROUND(
        (
            c.net_revenue
            / NULLIF(t.total_net_revenue, 0)
        ) * 100,
        2
    ) AS revenue_share_pct

FROM category_revenue c
CROSS JOIN total_revenue t

ORDER BY
    c.net_revenue DESC;

-- Q43 Take Rate Sustainability

WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC('month', date::date) AS month,
        SUM(amount)::numeric AS processed_value,
        SUM(gateway_revenue)::numeric AS gateway_revenue
    FROM payment_gateway_transactions
    GROUP BY DATE_TRUNC('month', date::date)
),

take_rate_metrics AS (
    SELECT
        month,
        processed_value,
        gateway_revenue,

        (
            gateway_revenue
            / NULLIF(processed_value, 0)
        ) * 100 AS take_rate_pct

    FROM monthly_metrics
),

final_metrics AS (
    SELECT
        month,
        processed_value,
        gateway_revenue,
        take_rate_pct,

        LAG(take_rate_pct) OVER (
            ORDER BY month
        ) AS previous_take_rate_pct

    FROM take_rate_metrics
)

SELECT
    month,

    ROUND(
        processed_value,
        2
    ) AS processed_value,

    ROUND(
        gateway_revenue,
        2
    ) AS gateway_revenue,

    ROUND(
        take_rate_pct,
        2
    ) AS take_rate_pct,

    ROUND(
        (
            take_rate_pct
            - previous_take_rate_pct
        ),
        2
    ) AS take_rate_change_pp

FROM final_metrics

ORDER BY month;

-- Q44 Chargeback Risk Monitoring

SELECT
    payment_method,

    COUNT(DISTINCT transaction_id) AS total_transactions,

    COUNT(DISTINCT CASE
        WHEN status = 'Charged-back'
        THEN transaction_id
    END) AS chargeback_transactions,

    ROUND(
        (
            COUNT(DISTINCT CASE
                WHEN status = 'Charged-back'
                THEN transaction_id
            END)::numeric
            / NULLIF(COUNT(DISTINCT transaction_id), 0)
        ) * 100,
        2
    ) AS chargeback_rate_pct,

    ROUND(
        SUM(
            CASE
                WHEN status = 'Charged-back'
                THEN amount
                ELSE 0
            END
        )::numeric,
        2
    ) AS chargeback_value,

    ROUND(
        (
            SUM(
                CASE
                    WHEN status = 'Charged-back'
                    THEN amount
                    ELSE 0
                END
            )::numeric
            / NULLIF(SUM(amount)::numeric, 0)
        ) * 100,
        2
    ) AS chargeback_value_rate_pct,

    ROUND(
        SUM(chargeback_loss)::numeric,
        2
    ) AS chargeback_loss

FROM payment_gateway_transactions

GROUP BY payment_method

ORDER BY chargeback_rate_pct DESC;

-- Q45

WITH business_metrics AS (

    SELECT
        SUM(amount)::numeric AS processed_value,

        SUM(gateway_revenue)::numeric AS gateway_revenue,

        SUM(interchange_cost)::numeric AS interchange_cost,

        SUM(network_cost)::numeric AS network_cost,

        SUM(refund_loss)::numeric AS refund_loss,

        SUM(chargeback_loss)::numeric AS chargeback_loss,

        SUM(net_revenue)::numeric AS net_revenue

    FROM payment_gateway_transactions
)

SELECT
    ROUND(processed_value, 2) AS processed_value,

    ROUND(gateway_revenue, 2) AS gateway_revenue,

    ROUND(
        interchange_cost + network_cost,
        2
    ) AS processing_costs,

    ROUND(
        refund_loss + chargeback_loss,
        2
    ) AS risk_losses,

    ROUND(net_revenue, 2) AS net_revenue,

    ROUND(
        (net_revenue / NULLIF(processed_value, 0)) * 100,
        2
    ) AS net_revenue_margin_pct

FROM business_metrics;

-- Q46

SELECT
    merchant_category,
    payment_method,

    COUNT(*) AS total_transactions,

    ROUND(
        SUM(amount)::numeric,
        2
    ) AS processed_value,

    ROUND(
        SUM(gateway_revenue)::numeric,
        2
    ) AS gateway_revenue,

    ROUND(
        SUM(interchange_cost + network_cost)::numeric,
        2
    ) AS processing_costs,

    ROUND(
        SUM(refund_loss + chargeback_loss)::numeric,
        2
    ) AS risk_losses,

    ROUND(
        SUM(net_revenue)::numeric,
        2
    ) AS net_revenue,

    ROUND(
        (
            SUM(net_revenue)::numeric
            / NULLIF(SUM(amount)::numeric, 0)
        ) * 100,
        2
    ) AS net_revenue_margin_pct

FROM payment_gateway_transactions

GROUP BY
    merchant_category,
    payment_method

ORDER BY
    net_revenue DESC;



-- ============================================
-- DATABASE UPDATE: REGENERATED MERCHANT DATA
-- ============================================

TRUNCATE TABLE payment_gateway_transactions;

ALTER TABLE payment_gateway_transactions
DROP COLUMN merchant_id;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'payment_gateway_transactions'
ORDER BY ordinal_position;

CREATE TABLE merchants (
    merchant_id VARCHAR(20) PRIMARY KEY,
    merchant_name VARCHAR(100)
);

SELECT *
FROM merchants
LIMIT 10;

SELECT COUNT(*)
FROM merchants;

SELECT COUNT(DISTINCT merchant_id)
FROM merchants;

SELECT COUNT(*) AS transaction_rows
FROM payment_gateway_transactions;

SELECT COUNT(*) AS unmatched_merchants
FROM payment_gateway_transactions t
LEFT JOIN merchants m
    ON t.merchant_id = m.merchant_id
WHERE m.merchant_id IS NULL;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'payment_gateway_transactions'
ORDER BY ordinal_position;

ALTER TABLE payment_gateway_transactions
ADD CONSTRAINT fk_merchant
FOREIGN KEY (merchant_id)
REFERENCES merchants(merchant_id);

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(*) AS transactions,
    ROUND(SUM(t.amount)::numeric, 2) AS processed_volume,
    ROUND(SUM(t.gateway_revenue)::numeric, 2) AS gateway_revenue,
    ROUND(SUM(t.interchange_cost)::numeric, 2) AS interchange_cost,
    ROUND(SUM(t.network_cost)::numeric, 2) AS network_cost,
    ROUND(SUM(t.refund_loss)::numeric, 2) AS refund_loss,
    ROUND(SUM(t.chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND(SUM(t.net_revenue)::numeric, 2) AS net_revenue
FROM payment_gateway_transactions t
JOIN merchants m
    ON t.merchant_id = m.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY net_revenue DESC;

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(*) AS transactions,
    ROUND(SUM(t.amount)::numeric, 2) AS processed_volume,
    ROUND(SUM(t.net_revenue)::numeric, 2) AS net_revenue,
    ROUND(
        (
            100.0 * SUM(t.net_revenue)
            / NULLIF(SUM(t.amount), 0)
        )::numeric,
        3
    ) AS net_take_rate
FROM payment_gateway_transactions t
JOIN merchants m
    ON t.merchant_id = m.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY net_revenue ASC
LIMIT 10;

WITH merchant_economics AS (
    SELECT
        m.merchant_id,
        m.merchant_name,
        COUNT(*) AS transactions,
        SUM(t.amount) AS processed_volume,
        SUM(t.net_revenue) AS net_revenue,
        100.0 * SUM(t.net_revenue)
            / NULLIF(SUM(t.amount), 0) AS net_take_rate
    FROM payment_gateway_transactions t
    JOIN merchants m
        ON t.merchant_id = m.merchant_id
    GROUP BY
        m.merchant_id,
        m.merchant_name
),

benchmarks AS (
    SELECT
        AVG(net_take_rate) AS avg_net_take_rate
    FROM merchant_economics
),

ranked_merchants AS (
    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY processed_volume DESC
        ) AS volume_quartile
    FROM merchant_economics
)

SELECT
    merchant_id,
    merchant_name,
    transactions,
    ROUND(processed_volume::numeric, 2) AS processed_volume,
    ROUND(net_revenue::numeric, 2) AS net_revenue,
    ROUND(net_take_rate::numeric, 3) AS net_take_rate,
    ROUND(
        (net_take_rate - avg_net_take_rate)::numeric,
        3
    ) AS vs_avg_take_rate
FROM ranked_merchants
CROSS JOIN benchmarks
WHERE volume_quartile = 1
  AND net_take_rate < avg_net_take_rate
ORDER BY processed_volume DESC;

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(*) AS transactions,
    ROUND(SUM(t.amount)::numeric, 2) AS processed_volume,
    ROUND(SUM(t.gateway_revenue)::numeric, 2) AS gateway_revenue,
    ROUND(SUM(t.interchange_cost)::numeric, 2) AS interchange_cost,
    ROUND(SUM(t.network_cost)::numeric, 2) AS network_cost,
    ROUND(SUM(t.refund_loss)::numeric, 2) AS refund_loss,
    ROUND(SUM(t.chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND(SUM(t.net_revenue)::numeric, 2) AS net_revenue,
    ROUND(
        (
            100.0 * SUM(t.net_revenue)
            / NULLIF(SUM(t.amount), 0)
        )::numeric,
        3
    ) AS net_take_rate
FROM payment_gateway_transactions t
JOIN merchants m
    ON t.merchant_id = m.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
HAVING SUM(t.net_revenue) < 0
ORDER BY processed_volume DESC;

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(*) AS transactions,
    ROUND(SUM(t.amount)::numeric, 2) AS processed_volume,
    ROUND(SUM(t.gateway_revenue)::numeric, 2) AS gateway_revenue,
    ROUND(SUM(t.interchange_cost)::numeric, 2) AS interchange_cost,
    ROUND(SUM(t.network_cost)::numeric, 2) AS network_cost,
    ROUND(SUM(t.refund_loss)::numeric, 2) AS refund_loss,
    ROUND(SUM(t.chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND(SUM(t.net_revenue)::numeric, 2) AS net_revenue
FROM payment_gateway_transactions t
JOIN merchants m
    ON t.merchant_id = m.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
HAVING SUM(t.net_revenue) < 0
ORDER BY net_revenue ASC
LIMIT 10;

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(*) AS transactions,
    SUM(t.amount) AS processed_volume,
    SUM(CASE WHEN t.chargeback_loss > 0 THEN 1 ELSE 0 END) AS chargeback_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN t.chargeback_loss > 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS chargeback_rate,
    ROUND(SUM(t.chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND(
        100.0 * SUM(t.chargeback_loss)::numeric
        / NULLIF(SUM(t.amount)::numeric, 0),
        2
    ) AS chargeback_loss_rate
FROM payment_gateway_transactions t
JOIN merchants m
    ON t.merchant_id = m.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
HAVING SUM(t.chargeback_loss) > 0
ORDER BY chargeback_rate DESC;

SELECT
    m.merchant_id,
    m.merchant_name,

    COUNT(*) AS transactions,

    ROUND(SUM(t.amount)::numeric, 2) AS processed_volume,
    ROUND(SUM(t.gateway_revenue)::numeric, 2) AS gateway_revenue,
    ROUND(SUM(t.interchange_cost)::numeric, 2) AS interchange_cost,
    ROUND(SUM(t.network_cost)::numeric, 2) AS network_cost,
    ROUND(SUM(t.refund_loss)::numeric, 2) AS refund_loss,
    ROUND(SUM(t.chargeback_loss)::numeric, 2) AS chargeback_loss,
    ROUND(SUM(t.net_revenue)::numeric, 2) AS net_revenue,

    ROUND(
        (
            100.0 * SUM(t.net_revenue)
            / NULLIF(SUM(t.amount), 0)
        )::numeric,
        3
    ) AS net_take_rate

FROM payment_gateway_transactions t

JOIN merchants m
    ON t.merchant_id = m.merchant_id

GROUP BY
    m.merchant_id,
    m.merchant_name

HAVING SUM(t.amount) >= (
    SELECT PERCENTILE_CONT(0.75)
           WITHIN GROUP (ORDER BY merchant_volume)
    FROM (
        SELECT
            merchant_id,
            SUM(amount) AS merchant_volume
        FROM payment_gateway_transactions
        GROUP BY merchant_id
    ) x
)
ORDER BY net_revenue ASC;