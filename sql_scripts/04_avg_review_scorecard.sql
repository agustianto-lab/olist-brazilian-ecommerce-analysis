-- Query di bawah ini merupakan logika perhitungan scorecard avg_review yang ada pada looker.
-- perhitungan rata-rata untuk avg_review sebenarnya menggunakan tabel dataset orders_reviews langsung tanpa pembuatan view / query terlebih dahulu seperti grafik, chart atau scorecard yang lain

SELECT 
  ROUND(AVG(review_score), 2) AS average_review_score
FROM 
  `data-brazil-ecommerce.dataset_ujicoba.orders_reviews_dataset`
WHERE 
  review_score IS NOT NULL;
