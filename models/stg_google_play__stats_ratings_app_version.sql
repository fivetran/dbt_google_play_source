
with base as (

    select * 
    from {{ ref('stg_google_play__stats_ratings_app_version_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_ratings_app_version_tmp')),
                staging_columns=get_stats_ratings_app_version_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        date as date_day,
        app_version_code,
        package_name,
        case when app_version_code is null then null else cast( nullif(daily_average_rating, 'NA') as {{ dbt_utils.type_float() }} ) end as average_rating,
        case when app_version_code is null then null else total_average_rating end as rolling_total_average_rating
    from fields
    {{ dbt_utils.group_by(n=5) }}
)

select * from final
