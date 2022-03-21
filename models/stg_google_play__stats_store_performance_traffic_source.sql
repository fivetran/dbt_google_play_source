
with base as (

    select * 
    from {{ ref('stg_google_play__stats_store_performance_traffic_source_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_store_performance_traffic_source_tmp')),
                staging_columns=get_stats_store_performance_traffic_source_columns()
            )
        }}
        
    from base
),

final as (
    
    select 

        date as report_date,
        package_name,
        traffic_source,
        search_term,
        store_listing_acquisitions,
        store_listing_conversion_rate,
        store_listing_visitors,
        utm_campaign,
        utm_source,
        _fivetran_synced

    from fields
)

select * from final
