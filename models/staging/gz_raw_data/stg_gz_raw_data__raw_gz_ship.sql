  -- stg_raw__ship.sql

  with

  source as (

      select * from {{ source('gz_raw_data', 'raw_gz_ship') }}

  ),

  renamed as (

      select
          orders_id,
          shipping_fee,
          logcost,
          CAST(ship_cost AS INT64) AS ship_cost

      from source

  )

  select * from renamed

 - name: raw_gz_ship
         identifier: raw_gz_ship
         description: shipping data for Greenweez orders
         columns:
           - name: orders_id
             description: Primary key
           - name: shipping_fee
             description: the price the customer pays for shipping
           - name: log_cost
             description: the cost of preparing the parcel in the distribution centre/warehouse
           - name: ship_cost
             description: shipping cost paid by Greenweez to the carrier/logistics provider