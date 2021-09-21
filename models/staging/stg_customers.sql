with source as (

    select * from {{ source('jaffle_shop', 'raw_customers')}}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name,
        md5(concat(first_name, last_name, 'jaffleshop')) AS customer_hash

    from source

)

select * from renamed
