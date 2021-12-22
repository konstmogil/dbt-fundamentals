WITH payments AS (
    SELECT
        id            AS customer_id,
        orderid       AS order_id,
        paymentmethod AS payment_method,
        status        AS status,
        amount / 100  AS amount,
        created       AS created_at
    FROM
        {{ source("dbt-fundamentals-payments", "payment") }}
)

SELECT * FROM payments
