{{
    fivetran_utils.union_data(
        table_identifier='stats_store_performance_country', 
        database_variable='google_play_database', 
        schema_variable='google_play_schema', 
        default_database=target.database,
        default_schema='google_play',
        default_variable='store_perfstats_store_performance_countryormance_country',
        union_schema_variable='google_play_union_schemas',
        union_database_variable='google_play_union_databases'
    )
}}