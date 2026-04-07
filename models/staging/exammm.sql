{{ config(materialized='table') }}

{% set query %}
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'RAW_HANI_SCHEMA'
{% endset %}

{% set results = run_query(query) %}

{% if execute %}

    {% set tables = [] %}
    {% for row in results %}
        {% do tables.append(row[0]) %}
    {% endfor %}

    {% for t in tables %}

        SELECT
            -- handle emp_id
            {% if t == 'IT' %}
                employee_id AS emp_id
            {% elif t == 'HR' or t == 'FINANCE' %}
                emp_id
            {% else %}
                NULL AS emp_id
            {% endif %},

            -- common columns
            emp_name,
            department,
            salary,

            -- handle hire_date
            {% if t == 'HR' %}
                hire_date
            {% else %}
                NULL AS hire_date
            {% endif %}

        FROM RAW_HANI_SCHEMA.{{ t }}

        {% if not loop.last %}
            UNION ALL
        {% endif %}

    {% endfor %}

{% endif %}