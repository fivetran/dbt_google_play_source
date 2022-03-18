
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
    -- rename here
    from fields
)

select * from final
