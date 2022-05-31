{{ config(enabled=var('google_play__using_earnings', False)) }}

with base as (

    select * 
    from {{ ref('stg_google_play__earnings_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__earnings_tmp')),
                staging_columns=get_earnings_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        amount_buyer_currency_ as amount_buyer_currency,
        amount_merchant_currency_ as amount_merchant_currency,
        base_plan_id,
        buyer_country,
        buyer_currency,
        buyer_postal_code,
        buyer_state,
        currency_conversion_rate,
        description as order_id,
        hardware as buyer_hardware,
        merchant_currency,
        offer_id,
        product_id as package_name,
        product_title,
        product_type,
        refund_type,
        sku_id,
        tax_type,

        -- dates are stored like 'Apr 1, 2022' -> gotta convert these to YYYY-MM-DD
        -- times are like '1:23:45 AM PDT'
        {% if target.type == 'bigquery' %}
        parse_date("%b %e, %Y", transaction_date) as transaction_date,
        parse_timestamp("%F %T %p", parse_date("%b %e, %Y", transaction_date) || ' ' || left(lpad(transaction_time, 15, '0'), 11))

        {% elif target.type == 'snowflake' %}
        date(transaction_date, 'mon dd, yyyy') as transaction_date,
        to_timestamp_ntz(date(transaction_date, 'mon dd, yyyy') || ' ' || left(lpad(transaction_time, 15, '0'), 11), 'yyyy-mm-dd hh12:mi:ss am') 

        {% elif target.type == 'spark' %}
        to_date(transaction_date, 'MMM d, y') as transaction_date,
        to_timestamp(to_date(transaction_date, 'MMM d, y') || ' ' || left(lpad(transaction_time, 15, '0'), 11), 'yyyy-MM-dd h:m:s a') 

        {% else %}
        cast(transaction_date as date) as transaction_date,
        cast(cast(transaction_date as date) || ' ' || lpad(transaction_time, 15, '0') as {{ dbt_utils.type_timestamp() }})
        
        {%- endif -%} 
            as transaction_pt_timestamp, -- the data type will be timestamp in UTC/no timezone but all timestamps in google play are PDT or PST

        right(transaction_time, 3) as transaction_timezone, -- either PST or PDT
        coalesce(transaction_type, 'Other') as transaction_type,
        _fivetran_synced
    from fields
)

select * 
from final
