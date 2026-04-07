{{ config(materialized='table') }}

{% set tables = ['HR', 'FINANCE', 'IT'] %}

{% for t in tables %}

SELECT *
FROM {{ source('company_src', t) }}

{% if not loop.last %}
UNION ALL
{% endif %}

{% endfor %}