{{
  config(
    materialized='table'
  )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),
payments as (
    select * from {{ ref('stg_payments') }}
),
final as (
    select
        orders.customer_id,
        orders.order_id,
        orders.order_date,
        payments.amount
    from orders
        join payments using (order_id)
)
select * from final