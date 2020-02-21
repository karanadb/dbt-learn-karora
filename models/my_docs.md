{% docs fct_customer %}
This is a customer model.
Refer to the following [link](wikipedia.org) to access wikipedia.
* This bullet point is to inform that user can enter a search criteria on wiki page to perform a search.
* And this is how you **bold** text.
* And this is how you _italicize_ text.
{% enddocs %}

{% docs payment_method %}
Following payment methods are accepted currently:
| 1 | credit_card   | credit card payment method                    |
| 2 | coupon        | a coupon was used to make payment             |
| 3 | bank_transfer | ach transfer from checking or savings account |
| 4 | gift_card     | gift card was used                            |
{% enddocs %}

{% docs src_jaffle_shop %}
Jaffle Shop stores customer and order information.
There can be 0, 1, or many orders for a customer.  In other words, there may not be any records in orders table for a client in the customer table.
{% enddocs %}