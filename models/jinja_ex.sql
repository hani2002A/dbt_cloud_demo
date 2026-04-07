{% if execute %}

{% set results = run_query("SELECT table_name FROM HANI_CLOUD.INFORMATION_SCHEMA.TABLES WHERE table_schema = 'RAW_HANI_SCHEMA'") %}

{% for row in results %}
    SELECT '{{ row[0] }}' AS table_name
    {% if not loop.last %} UNION ALL {% endif %}
{% endfor %}

{% endif %}