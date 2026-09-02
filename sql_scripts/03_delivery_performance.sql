-- script untuk visualisasi logistik dan pemetaan wilayah

SELECT 
  o.order_id,
  o.order_purchase_timestamp,
  
  CASE c.customer_state
    WHEN 'AC' THEN 'BR-Acre'
    WHEN 'AL' THEN 'BR-Alagoas'
    WHEN 'AM' THEN 'BR-Amazonas'
    WHEN 'AP' THEN 'BR-Amapá'
    WHEN 'BA' THEN 'BR-Bahia'
    WHEN 'CE' THEN 'BR-Ceará'
    WHEN 'DF' THEN 'BR-Distrito Federal'
    WHEN 'GO' THEN 'BR-Goiás'
    WHEN 'MA' THEN 'BR-Maranhão'
    WHEN 'MG' THEN 'BR-Minas Gerais'
    WHEN 'MS' THEN 'BR-Mato Grosso do Sul'
    WHEN 'MT' THEN 'BR-Mato Grosso'
    WHEN 'PA' THEN 'BR-Pará'
    WHEN 'PB' THEN 'BR-Paraíba'
    WHEN 'PE' THEN 'BR-Pernambuco'
    WHEN 'PI' THEN 'BR-Piauí'
    WHEN 'PR' THEN 'BR-Paraná'
    WHEN 'RJ' THEN 'BR-Rio de Janeiro'
    WHEN 'RN' THEN 'BR-Rio Grande do Norte'
    WHEN 'RO' THEN 'BR-Rondônia'
    WHEN 'RR' THEN 'BR-Roraima'
    WHEN 'RS' THEN 'BR-Rio Grande do Sul'
    WHEN 'SC' THEN 'BR-Santa Catarina'
    WHEN 'SE' THEN 'BR-Sergipe'
    WHEN 'SP' THEN 'BR-São Paulo'
    WHEN 'TO' THEN 'BR-Tocantins'
    ELSE CONCAT('BR-', c.customer_state)
  END AS customer_state_name,
  TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY) AS delivery_days,
  CASE 
    WHEN o.order_delivered_customer_date IS NULL THEN 'Tidak Diketahui (Data Kosong)'
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Terlambat'
    ELSE 'Tepat Waktu / Lebih Cepat'
  END AS status_pengiriman
FROM 
  `data-brazil-ecommerce.dataset_ujicoba.orders_dataset` o
JOIN 
  `data-brazil-ecommerce.dataset_ujicoba.olist_customers_dataset` c ON o.customer_id = c.customer_id
WHERE 
  o.order_status = 'delivered';