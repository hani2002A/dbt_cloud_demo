{% macro salary_range(column_name) %}

CASE 
    WHEN {{ column_name }} > 85000 THEN 'high'
    WHEN {{ column_name }} BETWEEN 50000 AND 85000 THEN 'medium'
    ELSE 'low'
END

{% endmacro %}