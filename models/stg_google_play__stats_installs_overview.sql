
with base as (

    select *
    from {{ ref('stg_google_play__stats_installs_overview_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_installs_overview_tmp')),
                staging_columns=get_stats_installs_overview_columns()
            )
        }}

    from base
),

final as (

    select
        cast(date as date) as date_day,
        package_name,
        active_device_installs as active_devices_last_30_days,
        daily_device_installs as device_installs,
        daily_device_uninstalls as device_uninstalls,
        daily_device_upgrades as device_upgrades,
        daily_user_installs as user_installs,
        daily_user_uninstalls as user_uninstalls,
        install_events,
        uninstall_events,
        update_events,
        _fivetran_synced
    from fields
)

select *
from final
