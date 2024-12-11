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

version: 2

 sources:
   - name: gz_raw_data
     schema: gz_raw_data
     tables:
       - name: raw_gz_sales
         identifier: raw_gz_sales
         description: sales of Greenweez / we have on row per productid found in each orders_id
         columns:
           - name: date_date
             description: date of purchase
           - name: orders_id
             description: foreign key to ship
           - name: pdt_id
             description: foreign key to product
           - name: revenue
             description: the amount paid by the customer to purchase the product. revenue = quantity * selling_price
           - name: quanitity
             description: the quantity of products purchased for a given order
         tests:
           - unique:
               column_name: "(orders_id || '-' || pdt_id)"
           ## OR ## if dbt_utils is installed
           - dbt_utils.unique_combination_of_columns:
               combination_of_columns:
                 - orders_id
                 - pdt_id