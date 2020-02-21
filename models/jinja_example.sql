{%- set payment_methods_query -%}
select distinct payment_method from {{ ref('stg_payments') }}
{%- endset -%}

{%- set results = run_query(payment_methods_query) -%}

select order_id,
       {%- if execute -%}
            {% for row in results.rows %}
                sum(case when payment_method = '{{ row[0] }}' then amount else 0 end) as {{ row[0] }}_amount
                {%- if not loop.last -%},{%- endif -%}
            {% endfor %}
        {%- endif %}
from {{ ref('stg_payments')}}
group by 1

{#-
/*
--SQL version of it --

select order_id,
    sum(case when payment_method = 'credit_card' then amount else 0 end) as credit_card_amount,
    sum(case when payment_method = 'coupon' then amount else 0 end) as coupon_amount
    sum(case when payment_method = 'bank_transfer' then amount else 0 end) as bank_transfer_amount
    sum(case when payment_method = 'gift_card' then amount else 0 end) as gift_card_amount
from {{ ref('stg_payments')}}
group by 1


-- JINJA for loop --

select order_id
       {%- for payment_method in ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}
       , sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount
       {%- endfor %}
from {{ ref('stg_payments')}}
group by 1


-- JINJA for loop to handle commas --

{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

select order_id,
       {% for payment_method in payment_methods %}
       sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount
       {%- if not loop.last -%},{%- endif -%}
       {% endfor %}
from {{ ref('stg_payments')}}
group by 1


-- JINJA for loop using a dynamic query to get potential values --

{%- set payment_methods_query -%}
select distinct payment_method from {{ ref('stg_payments') }}
{%- endset -%}

{%- set results = run_query(payment_methods_query) -%}

select order_id,
       {%- if execute -%}
            {% for row in results.rows %}
                sum(case when payment_method = '{{ row[0] }}' then amount else 0 end) as {{ row[0] }}_amount
                {%- if not loop.last -%},{%- endif -%}
            {% endfor %}
        {%- endif %}
from {{ ref('stg_payments')}}
group by 1


-- JINJA using utility package --

{% set payment_methods = dbt_utils.get_column_values(
        table=ref('stg_payments'),
        column='payment_method'
) %}
select
    order_id,
    {%- for payment_method in  payment_methods %}
    sum(case when payment_method  = '{{ payment_method }}' then amount else 0 end) as  {{ payment_method }}_amount
    {%- if not loop.last -%},{%- endif -%}
    {% endfor %}
from {{ ref('stg_payments') }}
group by 1
*/
#}