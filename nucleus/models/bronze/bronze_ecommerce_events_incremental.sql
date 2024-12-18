{{
	config(
		docs={'node_color': 'tan'},
		materialized='incremental',
		unique_key='event_id',
		on_schema_change='sync_all_columns',
		partition_by={
			"field": "created_at",
			"data_type": "timestamp",
			"granularity": "day"
		}
	)
}}

WITH source AS (
	SELECT *,
	CURRENT_TIMESTAMP() as inserted_at

	FROM {{ source('thelook_ecommerce', 'events') }}
	--where created_at < '2023-01-01'
)

SELECT
	id AS event_id,
	user_id,
	sequence_number,
	session_id,
	created_at,
	ip_address,
	city,
	state,
	postal_code,
	browser,
	traffic_source,
	uri AS web_link,
	event_type,
	inserted_at


FROM source

{# Only runs this filter on an incremental run #}
{% if is_incremental() %}

{# The {{ this }} macro is essentially a {{ ref('') }} macro that allows for a circular reference #}
WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})

{% endif %}
