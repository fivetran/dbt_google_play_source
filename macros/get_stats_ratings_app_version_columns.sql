23:44:40  {% macro get_stats_ratings_app_version_columns() %}

{% set columns = [
    {"name": "_file", "datatype": dbt_utils.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_line", "datatype": dbt_utils.type_int()},
    {"name": "_modified", "datatype": dbt_utils.type_timestamp()},
    {"name": "app_version_code", "datatype": dbt_utils.type_int()},
    {"name": "daily_average_rating", "datatype": dbt_utils.type_string()},
    {"name": "date", "datatype": "date"},
    {"name": "package_name", "datatype": dbt_utils.type_string()},
    {"name": "total_average_rating", "datatype": dbt_utils.type_float()}
] %}

{{ return(columns) }}

{% endmacro %}
