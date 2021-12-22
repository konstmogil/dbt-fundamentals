WITH customers_orders AS (
    SELECT
        order_id,
        SUM(CASE WHEN status = "success" THEN amount END) AS amount
    FROM
        {{ ref("stg_payments") }}
    GROUP BY 1
)

SELECT
    customers_orders.order_id,
    customer_id,
    first_name,
    last_name,
    amount,
    order_date
FROM
    customers_orders
LEFT JOIN {{ ref("stg_orders") }}    USING (order_id)
LEFT JOIN {{ ref("stg_customers") }} USING(customer_id)
