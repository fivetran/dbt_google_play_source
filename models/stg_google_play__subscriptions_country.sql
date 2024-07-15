{{ config(enabled=var('google_play__using_subscriptions', False)) }}

with base as (

    select *
    from {{ ref('stg_google_play__subscriptions_country_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__subscriptions_country_tmp')),
                staging_columns=get_financial_stats_subscriptions_country_columns()
            )
        }}

    
        {{ fivetran_utils.source_relation(
            union_schema_variable='google_play_union_schemas', 
            union_database_variable='google_play_union_databases') 
        }}

    from base
),

final as (

    select
        source_relation,
        cast(date as date) as date_day,
        country,
        product_id,
        package_name,
        sum(active_subscriptions) as total_active_subscriptions,
        sum(cancelled_subscriptions) as cancelled_subscriptions,
        sum(new_subscriptions) as new_subscriptions
    from fields
    {{ dbt_utils.group_by(5) }}
)

select *
from final
