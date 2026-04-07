SELECT * FROM {{ ref('stg_hr') }}

UNION ALL

SELECT * FROM {{ ref('stg_finance') }}

UNION ALL

SELECT * FROM {{ ref('stg_it') }}