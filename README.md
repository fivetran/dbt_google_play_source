<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_github_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="Fivetran-Release"
        href="https://fivetran.com/docs/getting-started/core-concepts#releasephases">
        <img src="https://img.shields.io/badge/Fivetran Release Phase-_Beta-orange.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_core-version_>=1.0.0_<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

# Google Play Source dbt Package ([Docs](https://fivetran.github.io/dbt_google_play_source/))
# 📣 What does this dbt package do?
- Cleans, tests, and prepares your Google Play data from [Fivetran's connector](https://fivetran.com/docs/applications/google-play) for analysis.
- Generates a comprehensive data dictionary of your Google Play data via the [dbt docs site](https://fivetran.github.io/dbt_google_play_source/)
- Materializes staging tables which leverage data in the format described [here](https://fivetran.com/docs/applications/google-play#schemainformation) and is intended to work simultaneously with our [Google Play modeling package](https://github.com/fivetran/dbt_google_play)
    - Refer to our [Docs site]https://fivetran.github.io/dbt_google_play_source/#!/overview/google_play_source/models/?g_v=1) for more details about these materialized models. 

# 🤔 Who is the target user of this dbt package?
- You use Fivetran's [Google Play connector](https://fivetran.com/docs/applications/google-play)
- You use dbt
- You want a staging layer that cleans, tests, and prepares your Google Play data for analysis
- (Optional) You want to make use of the [Google Play Modeling dbt Package](https://github.com/fivetran/dbt_google_play)
# 🎯 How do I use the dbt package?
To effectively install this package and leverage the pre-made models, you will follow the below steps:
## Step 1: Pre-Requisites
You will need to ensure you have the following before leveraging the dbt package.
- **Connector**: Have the Fivetran Google Play connector syncing data into your warehouse. 
- **Database support**: This package has been tested on **BigQuery**, **Snowflake**, **Redshift**, **Postgres**, and **Databricks**. Ensure you are using one of these supported databases.
- **dbt Version**: This dbt package requires you have a functional dbt project that utilizes a dbt version within the respective range `>=1.0.0, <2.0.0`.
## Step 2: Installing the Package
Include the following google_play_source package version in your `packages.yml`
> Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/google_play_source
    version: [">=0.1.0", "<0.2.0"]
```
## Step 3: Configure Your Variables
### Database, Schema, and Table Name Variables
By default, this package will run using your target database and the `google_play` schema. If this is not where your Google Play data is (perhaps your Google Play schema is `google_play_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    google_play_source:
        google_play_database: your_database_name
        google_play_schema: your_schema_name 

        # if an individual source table has a different name than expected, provide the name of the table as it appears in your warehouse
        <default_source_table_name>_identifier: your_table_name 
```

### Disabling Components
Your Google Play connector might not sync every table that this package expects. If you have financial and/or subscriptions data, namely the `earnings` and `financial_stats_subscriptions_country` tables, add the following variable(s) to your `dbt_project.yml` file:

```yml
vars:
    google_play__using_earnings: true # by default this is assumed to be FALSE
    google_play__using_subscriptions: true # by default this is assumed to be FALSE
```

## (Optional) Step 4: Additional Configurations
### Change the Build Schema
By default, this package builds the Google Play staging models within a schema titled (<target_schema> + `_stg_google_play`) in your target database. If this is not where you would like your staging Google Play data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    google_play_source:
      +schema: my_new_schema_name # leave blank (+schema: ) to just write to the target_schema (no suffix)
```

## Step 5: Finish Setup
Your dbt project is now setup to successfully run the dbt package models! You can now execute `dbt run` and `dbt test` to have the models materialize in your warehouse and execute the data integrity tests applied within the package.

## (Optional) Step 6: Orchestrate your package models with Fivetran
Fivetran offers the ability for you to orchestrate your dbt project through the [Fivetran Transformations for dbt Core](https://fivetran.com/docs/transformations/dbt) product. Refer to the linked docs for more information on how to setup your project for orchestration through Fivetran. 

# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. For more information on the below packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> **If you have any of these dependent packages in your own `packages.yml` I highly recommend you remove them to ensure there are no package version conflicts.**
```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.3.0", "<0.4.0"]

    - package: dbt-labs/dbt_utils
      version: [">=0.8.0", "<0.9.0"]
```
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package **only** maintains the latest version of the package. We highly recommend you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/google_plat_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_google_play_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Contributions
These dbt packages are developed by a small team of analytics engineers at Fivetran. However, the packages are made better by community contributions! 

We highly encourage and welcome contributions to this package. Check out [this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package!

# 🏪 Are there any resources available?
- If you encounter any questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_github_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran, or would like to request a future dbt package to be developed, then feel free to fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to just say hi? Book a time during our office hours [here](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or send us an email at solutions@fivetran.com.