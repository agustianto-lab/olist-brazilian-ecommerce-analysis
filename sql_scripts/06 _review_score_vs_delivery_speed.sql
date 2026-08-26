-- script untuk visualisasi review score vs avg delivery days vs estimasi

SELECT 
  r.review_score,
  COUNT(o.order_id) AS total_reviews,
  -- Rata-rata waktu kirim nyata untuk setiap skor bintang
  ROUND(AVG(TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)), 1) AS avg_delivery_days,
  -- Rata-rata selisih hari dari estimasi (angka minus berarti lebih cepat dari estimasi)
  ROUND(AVG(TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date, DAY)), 1) AS avg_days_vs_estimate
FROM 
  `data-brazil-ecommerce.dataset_ujicoba.orders_dataset` o
JOIN 
  `data-brazil-ecommerce.dataset_ujicoba.orders_reviews_dataset` r ON o.order_id = r.order_id
WHERE 
  o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
  1
ORDER BY 
  r.review_score DESC;
