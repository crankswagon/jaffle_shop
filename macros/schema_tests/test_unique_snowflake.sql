--note that the array function is only tested on snowflake at the moment
{% macro test_unique(model) %}
{% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}
{% set error_threshold = kwargs.get('error_threshold', 0) %}
with validation_errors as (
    select
        {{ column_name }}
        ,count(*) as occurence
    from {{ model }}
    where {{ column_name }} is not null
    group by {{ column_name }}
    having occurence > 1
)

,error_records AS
(
  SELECT 
        ARRAY_AGG(DISTINCT {{ column_name }})  WITHIN GROUP (ORDER BY {{ column_name }} DESC) AS err_array
  FROM validation_errors
)

SELECT 
err_array
FROM error_records
WHERE ARRAY_SIZE(err_array) > {{ error_threshold }}

{% endmacro %}








