
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
    -- rename here
    from fields
)

select * from final
