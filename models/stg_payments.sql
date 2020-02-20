select
    id as payment_id,
    "orderID" as order_id,
    amount
from raw.stripe.payment