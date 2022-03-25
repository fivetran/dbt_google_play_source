
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

    date as date_day,
    package_name,
    android_os_version,
    active_device_installs,
    {# current_device_installs,
    current_user_installs, #}
    daily_device_installs,
    daily_device_uninstalls,
    daily_device_upgrades,
    daily_user_installs,
    daily_user_uninstalls,
    total_user_installs as total_unique_user_installs,
    install_events,
    uninstall_events,
    update_events,
    _fivetran_synced

    from fields

    where android_os_version is not null -- TODO !!!!!!!! figure this out/remove
)

select * from final
