
{{
	config(materialized='ephemeral')
}}


SELECT
	user_id,
	MIN(created_at) AS first_order_created_at

FROM {{ ref('bronze_ecommerce__orders') }}
GROUP BY 1
