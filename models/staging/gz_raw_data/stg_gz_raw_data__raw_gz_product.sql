  -- stg_raw__product.sql

  with

  source as (

      select * from {{ source('gz_raw_data', 'raw_gz_product') }}

  ),

  renamed as (

      select
          products_id,
          CAST(purchse_price as FLOAT64) as purchase_price

      from source

  )

  select * from renamed

   - name: raw_gz_product
         identifier: raw_gz_product
         description: product of Greenweez
         columns:
           - name: products_id
             description: Primary key
           - name: purchase_price
             description: the purchase price of the product
