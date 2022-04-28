{{ config(enabled=var('google_play__using_subscriptions', False)) }}

select * from {{ var('financial_stats_subscriptions_country') }}
