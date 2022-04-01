{{ config(enabled=var('google_play__using_subscriptions', True)) }}

with base as (

    select * 
    from {{ ref('stg_google_play__financial_stats_subscriptions_country_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__financial_stats_subscriptions_country_tmp')),
                staging_columns=get_financial_stats_subscriptions_country_columns()
            )
        }}
        
    from base
),

final as (
    
    select 

        date as date_day,
        country,
        product_id,
        package_name,
        -- batch nulls together
        sum(active_subscriptions) as count_active_subscriptions,
        sum(cancelled_subscriptions) as daily_cancelled_subscriptions,
        sum(new_subscriptions) as daily_new_subscriptions

    from fields
    
    group by 1,2,3,4
)

select * from final
