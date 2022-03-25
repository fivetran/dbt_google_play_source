
with base as (

    select * 
    from {{ ref('stg_google_play__stats_installs_app_version_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_installs_app_version_tmp')),
                staging_columns=get_stats_installs_app_version_columns()
            )
        }}
        
    from base
),

final as (
    
    select 

        date as date_day,
        app_version_code,
        package_name,
        active_device_installs,
        -- these are always null? will remove
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
)

select * from final
