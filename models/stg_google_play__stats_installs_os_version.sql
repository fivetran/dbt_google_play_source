
with base as (

    select *
    from {{ ref('stg_google_play__stats_installs_os_version_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_installs_os_version_tmp')),
                staging_columns=get_stats_installs_os_version_columns()
            )
        }}

    from base
),

final as (

    select
        cast(date as date) as date_day,
        package_name,
        android_os_version,
        sum(active_device_installs) as active_devices_last_30_days,
        sum(daily_device_installs) as device_installs,
        sum(daily_device_uninstalls) as device_uninstalls,
        sum(daily_device_upgrades) as device_upgrades,
        sum(daily_user_installs) as user_installs,
        sum(daily_user_uninstalls) as user_uninstalls,
        sum(install_events) as install_events,
        sum(uninstall_events) as uninstall_events,
        sum(update_events) as update_events
    from fields
    group by 1,2,3
)

select *
from final
