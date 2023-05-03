# dbt_google_play_source v0.3.0
[PR #11](https://github.com/fivetran/dbt_google_play_source/pull/11) includes the following changes:

## 🚨 Breaking Changes 🚨:
- Updated the [country code](https://github.com/fivetran/dbt_google_play_source/blob/main/seeds/google_play__country_codes.csv) mapping table to align with Apple's [format and inclusion list](https://developer.apple.com/help/app-store-connect/reference/app-store-localizations/) of country names. This was change was made in parallel with the [Apple App Store](https://github.com/fivetran/dbt_apple_store/tree/main) dbt package in order to maintain parity for proper aggregating in the combo [App Reporting](https://github.com/fivetran/dbt_app_reporting) package.
  - This is a 🚨**breaking change**🚨 as you will need to re-seed (`dbt seed --full-refresh`) the `google_play__country_codes` file again.

## Under the Hood:
- Documents the `google_play__country_codes` seed file in yml.
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job.
- Updated the pull request [templates](/.github).

# dbt_google_play_source v0.2.0

## 🚨 Breaking Changes 🚨:
[PR #9](https://github.com/fivetran/dbt_google_play_source/pull/9) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- `dbt_utils.surrogate_key` has also been updated to `dbt_utils.generate_surrogate_key`. Since the method for creating surrogate keys differ, we suggest all users do a `full-refresh` for the most accurate data. For more information, please refer to dbt-utils [release notes](https://github.com/dbt-labs/dbt-utils/releases) for this update.
- `packages.yml` has been updated to reflect new default `fivetran/fivetran_utils` version, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.

# dbt_google_play_source v0.1.1
## Fixes
- Fix casting issue with daily_average_rating ([#8](https://github.com/fivetran/dbt_google_play_source/pull/8))

## Contributors
- [@johnf](https://github.com/johnf) ([#8](https://github.com/fivetran/dbt_google_play_source/pull/8))


# dbt_google_play_source v0.1.0

## Initial Release
This is the initial release of this package. 

__What does this dbt package do?__
- Cleans, tests, and prepares your Google Play data from [Fivetran's connector](https://fivetran.com/docs/applications/google-play) for analysis.
- Generates a comprehensive data dictionary of your Google Play data via the [dbt docs site](https://fivetran.github.io/dbt_google_play_source/)
- Materializes staging tables which leverage data in the format described [here](https://fivetran.com/docs/applications/google-play#schemainformation) and is intended to work simultaneously with our [Google Play modeling package](https://github.com/fivetran/dbt_google_play)
    - Refer to our [Docs site](https://fivetran.github.io/dbt_google_play_source/#!/overview/google_play_source/models/?g_v=1) for more details about these materialized models.

__References__
- [lukes/ISO-3166-Countries-with-Regional-Codes](https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes) for the foundation of our `country_codes` mapping table

For more information refer to the [README](/README.md).
