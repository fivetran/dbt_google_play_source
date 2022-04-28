{{ config(enabled=var('google_play__using_earnings', False)) }}

select * from {{ var('earnings') }}
