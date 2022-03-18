23:45:17  {% macro get_stats_store_performance_traffic_source_columns() %}

{% set columns = [
    {"name": "_file", "datatype": dbt_utils.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_line", "datatype": dbt_utils.type_int()},
    {"name": "_modified", "datatype": dbt_utils.type_timestamp()},
    {"name": "date", "datatype": "date"},
    {"name": "package_name", "datatype": dbt_utils.type_string()},
    {"name": "search_term", "datatype": dbt_utils.type_string()},
    {"name": "store_listing_acquisitions", "datatype": dbt_utils.type_int()},
    {"name": "store_listing_conversion_rate", "datatype": dbt_utils.type_float()},
    {"name": "store_listing_visitors", "datatype": dbt_utils.type_int()},
    {"name": "traffic_source", "datatype": dbt_utils.type_string()},
    {"name": "utm_campaign", "datatype": dbt_utils.type_string()},
    {"name": "utm_source", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
