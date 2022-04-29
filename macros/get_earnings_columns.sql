{% macro get_earnings_columns() %}

{% set columns = [
    {"name": "_file", "datatype": dbt_utils.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_line", "datatype": dbt_utils.type_int()},
    {"name": "_modified", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount_buyer_currency_", "datatype": dbt_utils.type_float()},
    {"name": "amount_merchant_currency_", "datatype": dbt_utils.type_float()},
    {"name": "base_plan_id", "datatype": dbt_utils.type_string()},
    {"name": "buyer_country", "datatype": dbt_utils.type_string()},
    {"name": "buyer_currency", "datatype": dbt_utils.type_string()},
    {"name": "buyer_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "buyer_state", "datatype": dbt_utils.type_string()},
    {"name": "currency_conversion_rate", "datatype": dbt_utils.type_float()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "hardware", "datatype": dbt_utils.type_string()},
    {"name": "merchant_currency", "datatype": dbt_utils.type_string()},
    {"name": "offer_id", "datatype": dbt_utils.type_string()},
    {"name": "product_id", "datatype": dbt_utils.type_string()},
    {"name": "product_title", "datatype": dbt_utils.type_string()},
    {"name": "product_type", "datatype": dbt_utils.type_int()},
    {"name": "refund_type", "datatype": dbt_utils.type_string()},
    {"name": "sku_id", "datatype": dbt_utils.type_string()},
    {"name": "tax_type", "datatype": dbt_utils.type_string()},
    {"name": "transaction_date", "datatype": dbt_utils.type_string()},
    {"name": "transaction_time", "datatype": dbt_utils.type_string()},
    {"name": "transaction_type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
