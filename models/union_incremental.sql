{{ config(
    materialized='incremental',
    unique_key='EMP_ID'
) }}

WITH source_data AS (

    SELECT * FROM HANI_CLOUD.RAW_HANI_SCHEMA.HR
    UNION ALL
    SELECT * FROM HANI_CLOUD.RAW_HANI_SCHEMA.IT
    UNION ALL
    SELECT * FROM HANI_CLOUD.RAW_HANI_SCHEMA.FINANCE

)

SELECT *
FROM source_data AS s

{% if is_incremental() %}
WHERE NOT EXISTS (
    SELECT 1 
    FROM {{ this }} AS t
    WHERE t.EMP_ID = s.EMP_ID
)
{% endif %}