{{ config(tags=['silver'],
		  docs={'node_color': 'gold'}) }}

WITH

-- Aggregate measures
orders AS (
	SELECT
	*
	FROM {{ ref('silver_dim_orders') }}
)

SELECT * FROM orders