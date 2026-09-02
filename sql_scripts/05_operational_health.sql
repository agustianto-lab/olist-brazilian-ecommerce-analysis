-- script untuk visuaisasi operasional: durasi pengiriman vs kepuasan pelanggan

SELECT 
  FORMAT_TIMESTAMP('%Y-%m', o.order_purchase_timestamp) AS order_month,
  ROUND(AVG(TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)), 1) AS avg_delivery_days,
  ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM 
  `data-brazil-ecommerce.dataset_ujicoba.orders_dataset` o
JOIN 
  `data-brazil-ecommerce.dataset_ujicoba.orders_reviews_dataset` r ON o.order_id = r.order_id
WHERE 
  o.order_status = 'delivered'
GROUP BY 
  1
ORDER BY 
  1 ASC;
