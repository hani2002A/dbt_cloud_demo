{% macro validate_phone(column_name) %}

CASE 
    WHEN {{ column_name }} IS NULL THEN 'NULL'
    WHEN REGEXP_LIKE({{ column_name }}, '^[0-9]{10}$') THEN ph_no
    ELSE 'Invalid'
END

{% endmacro %}

{% macro name(args) %}
    
{% endmacro %}