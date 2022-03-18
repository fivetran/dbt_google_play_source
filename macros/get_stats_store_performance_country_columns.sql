23:45:12  {% macro get_stats_store_performance_country_columns() %}

{% set columns = [
    {"name": "_file", "datatype": dbt_utils.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_line", "datatype": dbt_utils.type_int()},
    {"name": "_modified", "datatype": dbt_utils.type_timestamp()},
    {"name": "country_region", "datatype": dbt_utils.type_string()},
    {"name": "date", "datatype": "date"},
    {"name": "package_name", "datatype": dbt_utils.type_string()},
    {"name": "store_listing_acquisitions", "datatype": dbt_utils.type_int()},
    {"name": "store_listing_conversion_rate", "datatype": dbt_utils.type_float()},
    {"name": "store_listing_visitors", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
