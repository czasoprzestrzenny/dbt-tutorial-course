{% snapshot snapshot__distribution_centers %}

{{
	config(
		target_schema='dbt_snapshots',
		unique_key='id',
		strategy='timestamp',
		updated_at='updated_at'
	)
}}

SELECT
	id,
	name,
	latitude,
	longitude,
	CURRENT_TIMESTAMP() as updated_at

FROM {{ source('thelook_ecommerce', 'distribution_centers') }}
WHERE id < 3

{% endsnapshot %}


{# {% snapshot snapshot__distribution_centers %}

{{
    config(
      target_schema='dbt_snapshots',
      unique_key='id',
      strategy='check',
      check_cols=['name', 'latitude', 'longitude']
    )
}}

SELECT * FROM {{ source('thelook_ecommerce', 'distribution_centers') }}

{% endsnapshot %} #}