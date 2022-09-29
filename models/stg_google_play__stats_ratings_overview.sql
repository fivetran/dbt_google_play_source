
with base as (

    select * 
    from {{ ref('stg_google_play__stats_ratings_overview_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_ratings_overview_tmp')),
                staging_columns=get_stats_ratings_overview_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        date as date_day,
        package_name,
        cast( nullif(cast(daily_average_rating as {{ dbt_utils.type_string() }}), 'NA') as {{ dbt_utils.type_float() }} ) as average_rating,
        total_average_rating as rolling_total_average_rating,
        _fivetran_synced
    from fields
)

select * 
from final
