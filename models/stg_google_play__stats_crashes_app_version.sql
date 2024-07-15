ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)


with base as (

    select *
    from {{ ref('stg_google_play__stats_crashes_app_version_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_crashes_app_version_tmp')),
                staging_columns=get_stats_crashes_app_version_columns()
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
        app_version_code,
        package_name,
        sum(daily_anrs) as anrs,
        sum(daily_crashes) as crashes
    from fields
    group by 1,2,3
)

select *
from final
