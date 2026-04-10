{{ config(
    materialized='table',
    schema='DBT_HANI'
) }}

{% set tables_query %}
SELECT table_name
FROM HANI_CLOUD.INFORMATION_SCHEMA.TABLES
WHERE table_schema ILIKE 'DBT_HANI'
  AND table_name ILIKE 'STG%'
{% endset %}

{% set tables_result = run_query(tables_query) %}

{% if execute %}
    {% set tables = tables_result.columns[0].values() %}
{% else %}
    {% set tables = [] %}
{% endif %}

-- DEBUG
{% for table in tables %}
    {{ log("TABLE: " ~ table, info=True) }}
{% endfor %}

{% if tables | length == 0 %}

    -- TEMP DEBUG OUTPUT
    SELECT 'NO TABLES FOUND' AS message

{% else %}

    {% set columns_query %}
    SELECT DISTINCT column_name
    FROM HANI_CLOUD.INFORMATION_SCHEMA.COLUMNS
    WHERE table_schema ILIKE 'DBT_HANI'
      AND table_name IN (
        {% for table in tables %}
            '{{ table }}'{% if not loop.last %}, {% endif %}
        {% endfor %}
      )
    {% endset %}

    {% set columns_result = run_query(columns_query) %}
    {% set all_columns = columns_result.columns[0].values() %}

    {% set union_sql = [] %}

    {% for table in tables %}

        {% set table_columns_query %}
        SELECT column_name
        FROM HANI_CLOUD.INFORMATION_SCHEMA.COLUMNS
        WHERE table_schema ILIKE 'DBT_HANI'
          AND table_name = '{{ table }}'
        {% endset %}

        {% set table_columns_result = run_query(table_columns_query) %}
        {% set table_columns = table_columns_result.columns[0].values() %}

        {% set select_cols = [] %}

        {% for col in all_columns %}
            {% if col in table_columns %}
                {% do select_cols.append(col) %}
            {% else %}
                {% do select_cols.append('NULL AS ' ~ col) %}
            {% endif %}
        {% endfor %}

        {% do union_sql.append(
            'SELECT ' ~ select_cols | join(', ') ~ 
            ' FROM DBT_HANI.' ~ table
        ) %}

    {% endfor %}

    {{ union_sql | join(' UNION ALL ') }}

{% endif %}}}