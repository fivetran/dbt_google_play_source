ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)


with base as (

    select *
    from {{ ref('stg_google_play__store_performance_country_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__store_performance_country_tmp')),
                staging_columns=get_stats_store_performance_country_columns()
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
        country_region,
        package_name,
        sum(store_listing_acquisitions) as store_listing_acquisitions,
        avg(store_listing_conversion_rate) as store_listing_conversion_rate,
        sum(store_listing_visitors) as store_listing_visitors
    from fields
    group by 1,2,3
)

select *
from final
