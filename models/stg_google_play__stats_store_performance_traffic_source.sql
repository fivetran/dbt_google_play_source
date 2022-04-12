
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
        date as date_day,
        package_name,
        traffic_source,
        search_term,
        utm_campaign,
        utm_source,
        store_listing_acquisitions,
        store_listing_conversion_rate,
        store_listing_visitors,
        -- make a surrogate key as the PK involves quite a few columns
        {{ dbt_utils.surrogate_key(['date', 'package_name', 'traffic_source', 'search_term', 'utm_campaign', 'utm_source']) }} as traffic_source_unique_key,
        _fivetran_synced
    from fields
)

select * from final
