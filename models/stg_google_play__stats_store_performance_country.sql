
with base as (

    select * 
    from {{ ref('stg_google_play__stats_store_performance_country_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_store_performance_country_tmp')),
                staging_columns=get_stats_store_performance_country_columns()
            )
        }}
        
    from base
),

final as (
    
    select 

        date as date_day,
        country_region,
        package_name,
        store_listing_acquisitions,
        store_listing_conversion_rate,
        store_listing_visitors,
        _fivetran_synced

    from fields
)

select * from final
