
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

    from base
),

final as (

    select
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
