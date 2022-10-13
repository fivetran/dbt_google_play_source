{% macro get_stats_crashes_overview_columns() %}

{% set columns = [
    {"name": "_file", "datatype": dbt.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "_line", "datatype": dbt.type_int()},
    {"name": "_modified", "datatype": dbt.type_timestamp()},
    {"name": "daily_anrs", "datatype": dbt.type_int()},
    {"name": "daily_crashes", "datatype": dbt.type_int()},
    {"name": "date", "datatype": "date"},
    {"name": "package_name", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
