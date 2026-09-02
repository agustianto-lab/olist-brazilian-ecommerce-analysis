-- script untuk visualisasi tren penjualan dan banyaknya pesanan bulanan

SELECT 
  FORMAT_TIMESTAMP('%Y-%m', o.order_purchase_timestamp) AS order_month,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS total_revenue
FROM 
  `data-brazil-ecommerce.dataset_ujicoba.orders_dataset` o
JOIN 
  `data-brazil-ecommerce.dataset_ujicoba.orders_items_dataset` oi ON o.order_id = oi.order_id
WHERE 
  o.order_status = 'delivered'
GROUP BY 
  1
ORDER BY 
  1 ASC;
