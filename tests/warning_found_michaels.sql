-- alert a test warning when we see Michaels

 {{ config(severity = 'warn') }}

select 
* 
from {{ ref('stg_customers')}}
where first_name = 'Michael'