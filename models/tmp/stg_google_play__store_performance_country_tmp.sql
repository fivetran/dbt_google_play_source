ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{
    fivetran_utils.union_data(
        table_identifier='store_performance_country', 
        database_variable='google_play_database', 
        schema_variable='google_play_schema', 
        default_database=target.database,
        default_schema='google_play',
        default_variable='store_performance_country',
        union_schema_variable='google_play_union_schemas',
        union_database_variable='google_play_union_databases'
    )
}}