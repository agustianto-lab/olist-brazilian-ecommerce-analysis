# olist-brazilian-ecommerce-analysis
SQL-based analysis, BigQuery, Looker (Google Data Studio)

# Olist E-Commerce End-to-End Business Performance Analytics

## 1. Latar Belakang
**Olist** adalah penyedia layanan pemasaran produk yang menghubungkan usaha kecil - menengah dari seluruh penjuru Brasil dengan saluran penjualan nasional. Dalam proyek analisis data ini, saya bertindak sebagai **Data Analyst** untuk mengevaluasi performa makro perusahaan berdasarkan dataset publik yang berisi **96.478 transaksi pesanan sukses (*delivered*)** sepanjang periode **September 2016 hingga September 2018**.

Proyek ini dibangun secara *end-to-end* mulai dari proses pengolahan data mentah (*Exploratory Data Analysis* & *Data Cleansing*) menggunakan **Google Cloud Platform (GCP) BigQuery (SQL)** hingga visualisasi interaktif menggunakan **Looker Studio**.

-------

## 2. Pertanyaan Bisnis & Pembatasan Masalah (*Scope Limitation*)
Untuk memastikan analisa tetap fokus dan memberikan nilai bisnis yang nyata, ruang lingkup analisis dibatasi pada 4 pertanyaan utama:
1. **Tren Penjualan Bulanan**: Bagaimana pergerakan total pendapatan (*Total Revenue*) dan volume pesanan (*Total Orders*) Olist dari waktu ke waktu? Apakah terdapat indikasi musiman (*seasonality*)?
2. **Kategori Produk**: Kategori produk apa saja yang memberikan revenue terbesar (*Top 5 Product Category* ), dan seberapa besar kontribusi porsinya secara persentase?
3. **Efisiensi Logistik (Kurir)**: Berapa tingkat ketepatan waktu pengiriman (*On-Time Delivery Rate*) kurir dalam memenuhi batas tanggal estimasi yang dijanjikan sistem kepada pelanggan?
4. **Faktor Kepuasan Pelanggan**: Apakah durasi total waktu tunggu pengiriman (*Delivery Duration*) berkorelasi langsung terhadap nilai ulasan (*Review Score*) yang diberikan konsumen?

-------

## 3. Arsitektur Data
* **Data Warehouse & Transformation**: GCP BigQuery (SQL)
* **Business Intelligence & Visualisasi**: Looker Studio (Google Data Studio)
* **Pengolahan**: Pemanfaatan *Tabel Virtual (View)* untuk memisahkan logika agregasi kompleks di database dari fungsionalitas visualisasi di aplikasi BI.

-------

## 4. Tantangan Pembersihan Data & Pemodelan (*Data Cleansing & Modeling*)
Sebagai *Data Analyst*, nilai tambah terbesar dalam proyek ini adalah menyelesaikan kendala integritas data krusial di level database:

### A. Penyelamatan 4.000 Baris Teks Ulasan yang Rusak (*Quoted Newlines*)
* **Masalah**: Kolom komentar pembeli ('review_comment_message') mengandung banyak karakter pindah baris (*Enter/Newline*). Saat impor awal ke BigQuery, sistem salah membaca karakter Enter tersebut sebagai akhir dari baris data, menyebabkan ribuan baris teks terpotong menjadi baris tiruan baru dan merusak struktur tabel.
* **Solusi**: Mengonfigurasi ulang parameter *Advanced Options* pada skema pengunggahan BigQuery dengan mengaktifkan fitur 'Allow Quoted Newlines' untuk menjaga keutuhan teks di dalam tanda kutip.

-------

## 5. Temuan Kunci Utama & Rekomendasi Bisnis (*Key Insights & Actionable Items*)

Berdasarkan hasil analisis data, berikut adalah jawaban atas empat pertanyaan bisnis utama:

### 1. Tren Pertumbuhan & Volume Penjualan
*   **Temuan Data**: Sepanjang periode operasional (2016-2018), Olist eCommerce berhasil membukukan **Total Pendapatan (Revenue) sebesar R$ 13.22M** dengan **Total Volume Transaksi mencapai 96.478 pesanan sukses**. 
*   **Pola Tren**: Grafik tren bulanan menunjukkan pertumbuhan yang sangat agresif sejak kuartal ke-4 tahun 2017. Pola musiman (*seasonality*) puncak tertinggi terjadi pada bulan **November 2017** (mencapai omset bulanan tertinggi sekitar **R$ 987k**), yang didorong oleh momentum perayaan belanja nasional *Black Friday*.

### 2. Dominasi Produk
*   **Temuan Data**: Dari banyaknya kategori produk yang tersedia, struktur finansial Olist sangat bergantung pada **Top 5 Kategori Produk Teratas** yang menguasai porsi mayoritas keuntungan. 
*   **Analisis Porsi**: Kategori **Health & Beauty** menempati posisi puncak sebagai penghasil uang terbesar perusahaan (menyumbang omset **R$ 1.23M / 9.3%**), diikuti sangat ketat oleh kategori **Watches & Gifts (R$ 1.16M / 8.8%)**, **Bed Bath Table (R$ 1.05M / 7.7%)**, **Sports Leisure (R$ 954K / 7.2%)**, dan **Computers Accessories (R$ 888K / 6.7%)**.

### 3. Efisiensi Logistik
*   **Temuan Data**: Performa ketepatan waktu kurir logistik Olist berada di angka yang sangat sehat, dengan **Tingkat Ketepatan Waktu (On-Time Delivery Rate) mengunci di angka 91.9%**. 
*   **Analisis Ekspektasi**: Kolom ekspektasi ('avg_days_vs_estimate') menunjukkan nilai negatif di seluruh tingkatan kepuasan. Ini membuktikan bahwa secara sistematis, **91.9% paket murni tiba lebih cepat (lebih awal)** dibandingkan dengan tanggal janji batas estimasi pengiriman yang ditampilkan ke layar konsumen.

### 4. Korelasi Logistik & Kepuasan Pelanggan
*   **Temuan Data**: Ditemukan korelasi linear berbanding terbalik yang sangat kuat antara kecepatan pengiriman barang dengan rating pembeli. Pelanggan yang memberikan **Bintang 1 mengalami rata-rata waktu tunggu pengiriman terlama hingga 20.8 hari**, sedangkan pelanggan **Bintang 5 menikmati rata-rata kecepatan kurir hanya 10.2 hari**.
*   **Kenyataan Bisnis**: Meskipun kurir berhasil mengirimkan paket 3 hari lebih cepat dari janji estimasi sistem, pelanggan Bintang 1 tetap memberikan penilaian buruk karena waktu tunggu yang selama 20.8 hari secara psikologis sudah melewati batas toleransi kesabaran belanja *online*.

---

### Rekomendasi Strategis untuk Manajemen (Actionable Items)
1.  **Evaluasi Vendor Kurir**: Tim operasional Olist harus segera meninjau ulang kontrak kerja sama dengan mitra ekspedisi kurir, khususnya untuk rute pengiriman ke negara bagian terpencil yang rata-rata waktu tunggunya membengkak di atas 14 hari, guna menekan ulasan Bintang 1.
2.  **Optimasi Alokasi Pemasaran Produk Premium**: Tim Marketing wajib memprioritaskan alokasi anggaran iklan dan diskon pada kategori *Health & Beauty* serta *Watches & Gifts*. Kedua kategori ini terbukti memiliki *Average Ticket Size* (harga per unit barang) yang tinggi, sehingga mendongkrak margin keuntungan jauh lebih cepat daripada produk bervolume tinggi berharga murah.
3.  **Kalibrasi Algoritma Estimasi Waktu**: Mengubah algoritma penentuan tanggal estimasi di aplikasi agar tidak terlalu lama. Menjanjikan waktu pengiriman yang lebih realistis dan kompetitif akan membantu menjaga kestabilan ekspektasi kepuasan psikologis pelanggan sejak awal transaksi.

-------

## 6. Dashboard Visualisasi & Fitur Interaktif

### A. Fitur Dashboard
* **Master Date Range Filter**: Dikunci pada periode operasional Olist (**September 2016 - September 2018**) tujuannya untuk menghindari *error* tampilan halaman kosong (*No Data*).
* **Tombol Reset Filter Pas**: Menyediakan tombol **'Reset Filter'** khusus untuk menghapus semua seleksi filter sementara dalam sekali klik agar memudahkan kembali ke kondisi awal saat sesi presentasi.

### B. Screenshot Tampilan Dashboard

#### Halaman 1: Executive Summary
![Executive Summary](screenshots/01_Executive_Summary.png)

#### Halaman 2: Sales Performance
![Sales Performance](screenshots/02_Sales_Performance.png)

#### Halaman 3: Product Performance
![Product Performance](screenshots/03_Product_Performance.png)

#### Halaman 4: Logistics & Delivery Performance
![Logistics Performance](screenshots/04_Delivery_Performance.png)

#### Halaman 5: Customer Satisfaction
![Customer Satisfaction](screenshots/05_Customer_Satisfaction.png)

-------

## 7. Link Dashboard
**Visualisasi ->** [Dashboard](https://datastudio.google.com/reporting/d57d3f10-fe90-484f-8ce7-4fa984ac6b71)

## 8. RAW Data
**Raw Data ->** [Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)


#  Author

**AGUSTIANTO**

Indonesia

# LinkedIn
 **LinkedIn:** [Agustianto](https://linkedin.com/in/agus-tianto-a305611a5)
 
# Github
 **GitHub:** [agustianto-lab](https://github.com/agustianto-lab)
