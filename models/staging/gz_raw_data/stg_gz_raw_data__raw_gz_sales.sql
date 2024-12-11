with 

source as (

    select * from {{ source('gz_raw_data', 'raw_gz_sales') }}

),

renamed as (

    select
        date_date,
        orders_id,
        pdt_id as product_id,
        revenue,
        quantity

    from source

)

select * from renamed

version: 2

 sources:
   - name: gz_raw_data
     schema: gz_raw_data
     tables:
       - name: raw_gz_sales
         identifier: raw_gz_sales
         description: sales of Greenweez / we have on row per product_id found in each orders_id
         columns:
           - name: date_date
             description: date of purchase