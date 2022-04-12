
with base as (

    select * 
    from {{ ref('stg_google_play__stats_installs_device_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_installs_device_tmp')),
                staging_columns=get_stats_installs_device_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        date as date_day,
        device,
        package_name,
        sum(active_device_installs) as active_device_installs,
        sum(daily_device_installs) as daily_device_installs,
        sum(daily_device_uninstalls) as daily_device_uninstalls,
        sum(daily_device_upgrades) as daily_device_upgrades,
        sum(daily_user_installs) as daily_user_installs,
        sum(daily_user_uninstalls) as daily_user_uninstalls,
        sum(total_user_installs) as total_unique_user_installs,
        sum(install_events) as install_events,
        sum(uninstall_events) as uninstall_events,
        sum(update_events) as update_events
    from fields
    group by 1,2,3 -- for grouping NULL devices together into one pile

)

select * from final
