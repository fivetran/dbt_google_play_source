23:45:37  {% macro get_financial_stats_subscriptions_country_columns() %}

{% set columns = [
    {"name": "_file", "datatype": dbt_utils.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_line", "datatype": dbt_utils.type_int()},
    {"name": "_modified", "datatype": dbt_utils.type_timestamp()},
    {"name": "active_subscriptions", "datatype": dbt_utils.type_int()},
    {"name": "cancelled_subscriptions", "datatype": dbt_utils.type_int()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "date", "datatype": "date"},
    {"name": "new_subscriptions", "datatype": dbt_utils.type_int()},
    {"name": "package_name", "datatype": dbt_utils.type_string()},
    {"name": "product_id", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
