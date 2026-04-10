{% set schema_name = 'RAW_HANI_SCHEMA' %}

SELECT table_name
FROM HANI_CLOUD.information_schema.tables
WHERE table_schema = '{{ schema_name }}'

