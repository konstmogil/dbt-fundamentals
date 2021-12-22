WITH customer_orders AS (
    SELECT
        customer_id,
        MIN(order_date)          AS first_order,
        MAX(order_date)          AS most_recent_order,
        COUNT(DISTINCT order_id) AS number_unique_orders,
        SUM(amount)              AS lifetime_value
    FROM
        {{ ref("fct_orders") }}
    GROUP BY 1
),

final AS (
    SELECT
        co.customer_id,
        c.first_name,
        c.last_name,
        co.first_order,
        co.most_recent_order,
        co.lifetime_value,
        COALESCE(co.number_unique_orders, 0) AS number_unique_orders
    FROM
        {{ ref("stg_customers") }}      AS c 
    LEFT JOIN customer_orders           AS co USING(customer_id)
)

SELECT
    *
FROM
    final
