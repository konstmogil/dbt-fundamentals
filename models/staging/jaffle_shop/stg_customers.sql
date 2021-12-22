WITH customers AS (
    SELECT
        id AS customer_id,
        first_name,
        last_name
    FROM
        {{ source("dbt-fundamentals-customers-orders", "customers") }}
)

SELECT * FROM customers
