with payment as (
    select * from {{source('stripe', 'payment')}}
)

select
    id as payment_id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    amount
--from raw.stripe.payment
from payment