# dbt_google_play_source v0.1.0

## Initial Release
This is the initial release of this package. 

__What does this dbt package do?__
- Cleans, tests, and prepares your Google Play data from [Fivetran's connector](https://fivetran.com/docs/applications/google-play) for analysis.
- Generates a comprehensive data dictionary of your Google Play data via the [dbt docs site](https://fivetran.github.io/dbt_google_play_source/)
- Materializes staging tables which leverage data in the format described [here](https://fivetran.com/docs/applications/google-play#schemainformation) and is intended to work simultaneously with our [Google Play modeling package](https://github.com/fivetran/dbt_google_play)
    - Refer to our [Docs site](https://fivetran.github.io/dbt_google_play_source/#!/overview/google_play_source/models/?g_v=1) for more details about these materialized models. 

For more information refer to the [README](/README.md).