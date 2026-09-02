-- script untuk visualisasi performa produk

SELECT 
  o.order_purchase_timestamp, 
  COALESCE(t.english_name, p.product_category_name, 'unknown') AS category_name,
  COUNT(oi.order_item_id) AS total_quantity_sold,
  ROUND(SUM(oi.price), 2) AS total_revenue
FROM 
  `data-brazil-ecommerce.dataset_ujicoba.orders_items_dataset` oi
JOIN 
  `data-brazil-ecommerce.dataset_ujicoba.products_dataset` p ON oi.product_id = p.product_id
LEFT JOIN 
  `data-brazil-ecommerce.dataset_ujicoba.product_category_name_translation` t ON p.product_category_name = t.brazil_name
JOIN
  `data-brazil-ecommerce.dataset_ujicoba.orders_dataset` o ON oi.order_id = o.order_id
WHERE
  o.order_status = 'delivered'
GROUP BY 
  1, 2 
ORDER BY 
  total_revenue DESC;
