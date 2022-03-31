{{ config(enabled=var('google_play__using_earnings', True)) }}

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
        description as order_id, -- this is like the unique order id, choosing to rename to reflect that... one order can have 2 records though, one for the purchase and one for the associated google fee transaction_type
        hardware as buyer_hardware,
        merchant_currency,
        offer_id,
        product_id,
        product_title,
        product_type,
        refund_type,
        sku_id,
        tax_type,
        cast(transaction_date as date) as transaction_date,

        -- ok but this is actually a string...unsure how to convert while maintaining the timezone
        cast(cast(transaction_date as date)|| ' ' || lpad(transaction_time, 15, '0') as {{ dbt_utils.type_timestamp() }}) as transaction_pt_timestamp,
        right(transaction_time, 3) as transaction_timezone,

        transaction_type,
        _fivetran_synced

    from fields
)

select * from final
