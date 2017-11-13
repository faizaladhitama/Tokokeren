--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tokokeren; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tokokeren;


ALTER SCHEMA tokokeren OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = tokokeren, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: jasa_kirim; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE jasa_kirim (
    nama character varying(100) NOT NULL,
    lama_kirim character varying(10) NOT NULL,
    tarif numeric(10,2) NOT NULL
);


ALTER TABLE jasa_kirim OWNER TO postgres;

--
-- Name: kategori_utama; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE kategori_utama (
    kode character(3) NOT NULL,
    nama character varying(100) NOT NULL
);


ALTER TABLE kategori_utama OWNER TO postgres;

--
-- Name: keranjang_belanja; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE keranjang_belanja (
    pembeli character varying(50) NOT NULL,
    kode_produk character(8) NOT NULL,
    berat integer NOT NULL,
    kuantitas integer NOT NULL,
    harga numeric(10,2) NOT NULL,
    sub_total numeric(10,2) NOT NULL
);


ALTER TABLE keranjang_belanja OWNER TO postgres;

--
-- Name: komentar_diskusi; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE komentar_diskusi (
    pengirim character varying(50) NOT NULL,
    penerima character varying(50) NOT NULL,
    waktu timestamp without time zone NOT NULL,
    komentar text NOT NULL
);


ALTER TABLE komentar_diskusi OWNER TO postgres;

--
-- Name: list_item; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE list_item (
    no_invoice character(10) NOT NULL,
    kode_produk character(8) NOT NULL,
    berat integer NOT NULL,
    kuantitas integer NOT NULL,
    harga numeric(10,2) NOT NULL,
    sub_total numeric(10,2) NOT NULL
);


ALTER TABLE list_item OWNER TO postgres;

--
-- Name: pelanggan; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE pelanggan (
    email character varying(50) NOT NULL,
    is_penjual boolean NOT NULL,
    nilai_reputasi numeric(10,1),
    poin integer
);


ALTER TABLE pelanggan OWNER TO postgres;

--
-- Name: pengguna; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE pengguna (
    email character varying(50) NOT NULL,
    password character varying(20) NOT NULL,
    nama character varying(100) NOT NULL,
    jenis_kelamin character(1) NOT NULL,
    tgl_lahir date NOT NULL,
    no_telp character varying(20) NOT NULL,
    alamat text NOT NULL,
    CONSTRAINT allowed_gender CHECK ((jenis_kelamin = ANY (ARRAY['L'::bpchar, 'P'::bpchar])))
);


ALTER TABLE pengguna OWNER TO postgres;

--
-- Name: produk; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE produk (
    kode_produk character(8) NOT NULL,
    nama character varying(100) NOT NULL,
    harga numeric(10,2) NOT NULL,
    deskripsi text
);


ALTER TABLE produk OWNER TO postgres;

--
-- Name: produk_pulsa; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE produk_pulsa (
    kode_produk character(8) NOT NULL,
    nominal integer NOT NULL
);


ALTER TABLE produk_pulsa OWNER TO postgres;

--
-- Name: promo; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE promo (
    id character(6) NOT NULL,
    deskripsi text NOT NULL,
    periode_awal date NOT NULL,
    periode_akhir date NOT NULL,
    kode character varying(20) NOT NULL
);


ALTER TABLE promo OWNER TO postgres;

--
-- Name: promo_produk; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE promo_produk (
    id_promo character(6) NOT NULL,
    kode_produk character(8) NOT NULL
);


ALTER TABLE promo_produk OWNER TO postgres;

--
-- Name: shipped_produk; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE shipped_produk (
    kode_produk character(8) NOT NULL,
    kategori character(5) NOT NULL,
    nama_toko character varying(100) NOT NULL,
    is_asuransi boolean NOT NULL,
    stok integer NOT NULL,
    is_baru boolean NOT NULL,
    min_order integer NOT NULL,
    min_grosir integer NOT NULL,
    max_grosir integer NOT NULL,
    harga_grosir numeric(10,2) NOT NULL,
    foto character varying(100) NOT NULL
);


ALTER TABLE shipped_produk OWNER TO postgres;

--
-- Name: sub_kategori; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE sub_kategori (
    kode character(5) NOT NULL,
    kode_kategori character(3) NOT NULL,
    nama character varying(100) NOT NULL
);


ALTER TABLE sub_kategori OWNER TO postgres;

--
-- Name: toko; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE toko (
    nama character varying(100) NOT NULL,
    deskripsi text,
    slogan character varying(100),
    lokasi text NOT NULL,
    email_penjual character varying(50) NOT NULL
);


ALTER TABLE toko OWNER TO postgres;

--
-- Name: toko_jasa_kirim; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE toko_jasa_kirim (
    nama_toko character varying(100) NOT NULL,
    jasa_kirim character varying(100) NOT NULL
);


ALTER TABLE toko_jasa_kirim OWNER TO postgres;

--
-- Name: transaksi_pulsa; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE transaksi_pulsa (
    no_invoice character(10) NOT NULL,
    tanggal date NOT NULL,
    waktu_bayar timestamp without time zone,
    status smallint,
    total_bayar numeric(10,2) NOT NULL,
    email_pembeli character varying(50) NOT NULL,
    nominal integer NOT NULL,
    nomor character varying(20) NOT NULL,
    kode_produk character(8) NOT NULL,
    CONSTRAINT allowed_status CHECK ((status = ANY (ARRAY[1, 2])))
);


ALTER TABLE transaksi_pulsa OWNER TO postgres;

--
-- Name: transaksi_shipped; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE transaksi_shipped (
    no_invoice character(10) NOT NULL,
    tanggal date NOT NULL,
    waktu_bayar timestamp without time zone,
    status smallint,
    total_bayar numeric(10,2) NOT NULL,
    email_pembeli character varying(50) NOT NULL,
    nama_toko character varying(100) NOT NULL,
    alamat_kirim text NOT NULL,
    biaya_kirim numeric(10,2) NOT NULL,
    no_resi character(16),
    nama_jasa_kirim character varying(16) NOT NULL,
    CONSTRAINT allowed_status CHECK ((status < 5))
);


ALTER TABLE transaksi_shipped OWNER TO postgres;

--
-- Name: ulasan; Type: TABLE; Schema: tokokeren; Owner: postgres
--

CREATE TABLE ulasan (
    email_pembeli character varying(50) NOT NULL,
    kode_produk character(8) NOT NULL,
    tanggal date NOT NULL,
    rating integer NOT NULL,
    komentar text,
    CONSTRAINT allowed_rating CHECK ((rating < 6))
);


ALTER TABLE ulasan OWNER TO postgres;

--
-- Data for Name: jasa_kirim; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO jasa_kirim VALUES ('JNE REGULER', '1-3', 8000.00);
INSERT INTO jasa_kirim VALUES ('JNE YES', '1', 15000.00);
INSERT INTO jasa_kirim VALUES ('JNE OKE', '2-4', 5000.00);
INSERT INTO jasa_kirim VALUES ('TIKI REGULER', '1-3', 9000.00);
INSERT INTO jasa_kirim VALUES ('POS PAKET BIASA', '1-3', 7000.00);
INSERT INTO jasa_kirim VALUES ('POS PAKET KILAT', '1-2', 12000.00);
INSERT INTO jasa_kirim VALUES ('WAHANA', '1-3', 8000.00);
INSERT INTO jasa_kirim VALUES ('J&T EXPRESS', '1-2', 14000.00);
INSERT INTO jasa_kirim VALUES ('PAHALA', '2-3', 7000.00);
INSERT INTO jasa_kirim VALUES ('LION PARCEL', '1-3', 10000.00);


--
-- Data for Name: kategori_utama; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO kategori_utama VALUES ('K01', 'Fashion Wanita');
INSERT INTO kategori_utama VALUES ('K02', 'Fashion Pria');
INSERT INTO kategori_utama VALUES ('K03', 'Fashion Muslim');
INSERT INTO kategori_utama VALUES ('K04', 'Fashion Anak');
INSERT INTO kategori_utama VALUES ('K05', 'Kecantikan');
INSERT INTO kategori_utama VALUES ('K06', 'Kesehatan');
INSERT INTO kategori_utama VALUES ('K07', 'Ibu & Bayi');
INSERT INTO kategori_utama VALUES ('K08', 'Rumah Tangga');
INSERT INTO kategori_utama VALUES ('K09', 'Handphone & Tablet');
INSERT INTO kategori_utama VALUES ('K10', 'Laptop & Aksesoris');
INSERT INTO kategori_utama VALUES ('K11', 'Komputer & Aksesoris');
INSERT INTO kategori_utama VALUES ('K12', 'Elektronik');
INSERT INTO kategori_utama VALUES ('K13', 'Kamera, Foto & Video');
INSERT INTO kategori_utama VALUES ('K14', 'Otomotif');
INSERT INTO kategori_utama VALUES ('K15', 'Olahraga');
INSERT INTO kategori_utama VALUES ('K16', 'Film, Musik & Game');
INSERT INTO kategori_utama VALUES ('K17', 'Dapur');
INSERT INTO kategori_utama VALUES ('K18', 'Office & Stationery');
INSERT INTO kategori_utama VALUES ('K19', 'Souvenir, Kado & Hadiah');
INSERT INTO kategori_utama VALUES ('K20', 'Mainan & Hobi');
INSERT INTO kategori_utama VALUES ('K21', 'Makanan & Minuman');
INSERT INTO kategori_utama VALUES ('K22', 'Buku');


--
-- Data for Name: keranjang_belanja; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO keranjang_belanja VALUES ('blampen4v@linkedin.com', 'KLJ00031', 54, 49, 500.00, 24500.00);
INSERT INTO keranjang_belanja VALUES ('abury56@tmall.com', 'KLJ00080', 14, 125, 1000.00, 125000.00);
INSERT INTO keranjang_belanja VALUES ('aginnaly4i@state.gov', 'KLJ00145', 91, 2, 1500.00, 3000.00);
INSERT INTO keranjang_belanja VALUES ('ilerego5p@github.io', 'KLJ00149', 94, 135, 2000.00, 270000.00);
INSERT INTO keranjang_belanja VALUES ('troyal49@deliciousdays.com', 'KLJ00226', 14, 134, 2500.00, 335000.00);
INSERT INTO keranjang_belanja VALUES ('cmalzard2f@acquirethisname.com', 'KLJ00135', 7, 76, 3000.00, 228000.00);
INSERT INTO keranjang_belanja VALUES ('yelger5o@trellian.com', 'KLJ00169', 6, 40, 3500.00, 140000.00);
INSERT INTO keranjang_belanja VALUES ('aluetkemeyers70@miibeian.gov.cn', 'KLJ00039', 29, 144, 4000.00, 576000.00);
INSERT INTO keranjang_belanja VALUES ('mhavercroft4j@redcross.org', 'KLJ00037', 95, 24, 4500.00, 108000.00);
INSERT INTO keranjang_belanja VALUES ('broskams9n@hud.gov', 'KLJ00196', 88, 193, 5000.00, 965000.00);
INSERT INTO keranjang_belanja VALUES ('ctembey2s@nhs.uk', 'KLJ00188', 12, 35, 5500.00, 192500.00);
INSERT INTO keranjang_belanja VALUES ('dterrey2x@bloglines.com', 'KLJ00054', 29, 160, 6000.00, 960000.00);
INSERT INTO keranjang_belanja VALUES ('gwhitworth30@slate.com', 'KLJ00173', 58, 56, 6500.00, 364000.00);
INSERT INTO keranjang_belanja VALUES ('adeg@facebook.com', 'KLJ00082', 29, 13, 7000.00, 91000.00);
INSERT INTO keranjang_belanja VALUES ('kmowsley2b@cyberchimps.com', 'KLJ00130', 47, 93, 7500.00, 697500.00);
INSERT INTO keranjang_belanja VALUES ('mchillingworth7a@themeforest.net', 'KLJ00088', 24, 125, 8000.00, 1000000.00);
INSERT INTO keranjang_belanja VALUES ('mcivitillob@google.ru', 'KLJ00219', 67, 183, 8500.00, 1555500.00);
INSERT INTO keranjang_belanja VALUES ('bstrafen8u@tinyurl.com', 'KLJ00003', 34, 111, 9000.00, 999000.00);
INSERT INTO keranjang_belanja VALUES ('dollivierre4l@statcounter.com', 'KLJ00170', 43, 123, 9500.00, 1168500.00);
INSERT INTO keranjang_belanja VALUES ('cdoughty3o@i2i.jp', 'KLJ00159', 28, 138, 10000.00, 1380000.00);
INSERT INTO keranjang_belanja VALUES ('mde2p@census.gov', 'KLJ00244', 12, 176, 10500.00, 1848000.00);
INSERT INTO keranjang_belanja VALUES ('vedgcumbe5h@prweb.com', 'KLJ00042', 18, 36, 11000.00, 396000.00);
INSERT INTO keranjang_belanja VALUES ('yduffett4o@va.gov', 'KLJ00114', 44, 40, 11500.00, 460000.00);
INSERT INTO keranjang_belanja VALUES ('vedgcumbe5h@prweb.com', 'KLJ00096', 68, 65, 12000.00, 780000.00);
INSERT INTO keranjang_belanja VALUES ('yduffett4o@va.gov', 'KLJ00090', 44, 90, 12500.00, 1125000.00);
INSERT INTO keranjang_belanja VALUES ('sestcot7f@nbcnews.com', 'KLJ00215', 7, 42, 13000.00, 546000.00);
INSERT INTO keranjang_belanja VALUES ('cjanaud1d@virginia.edu', 'KLJ00215', 89, 77, 13500.00, 1039500.00);
INSERT INTO keranjang_belanja VALUES ('mromeoo@weather.com', 'KLJ00198', 90, 126, 14000.00, 1764000.00);
INSERT INTO keranjang_belanja VALUES ('hcaistor91@mtv.com', 'KLJ00250', 90, 163, 14500.00, 2363500.00);
INSERT INTO keranjang_belanja VALUES ('dyankin59@quantcast.com', 'KLJ00085', 6, 3, 15000.00, 45000.00);
INSERT INTO keranjang_belanja VALUES ('ctipper8o@unblog.fr', 'KLJ00016', 24, 84, 15500.00, 1302000.00);
INSERT INTO keranjang_belanja VALUES ('yelger5o@trellian.com', 'KLJ00216', 46, 180, 16000.00, 2880000.00);
INSERT INTO keranjang_belanja VALUES ('ctipper8o@unblog.fr', 'KLJ00185', 15, 103, 16500.00, 1699500.00);
INSERT INTO keranjang_belanja VALUES ('ctipper8o@unblog.fr', 'KLJ00231', 83, 9, 17000.00, 153000.00);
INSERT INTO keranjang_belanja VALUES ('sjurczak3j@moonfruit.com', 'KLJ00156', 46, 32, 17500.00, 560000.00);
INSERT INTO keranjang_belanja VALUES ('llawlings5l@china.com.cn', 'KLJ00195', 48, 30, 18000.00, 540000.00);
INSERT INTO keranjang_belanja VALUES ('sgarric27@google.com', 'KLJ00160', 94, 86, 18500.00, 1591000.00);
INSERT INTO keranjang_belanja VALUES ('cjanaud1d@virginia.edu', 'KLJ00036', 85, 83, 19000.00, 1577000.00);
INSERT INTO keranjang_belanja VALUES ('ccallendar8m@xing.com', 'KLJ00156', 8, 190, 19500.00, 3705000.00);
INSERT INTO keranjang_belanja VALUES ('vedgcumbe5h@prweb.com', 'KLJ00249', 69, 50, 20000.00, 1000000.00);
INSERT INTO keranjang_belanja VALUES ('sklemke3t@lycos.com', 'KLJ00092', 27, 90, 20500.00, 1845000.00);
INSERT INTO keranjang_belanja VALUES ('hcaesar80@sina.com.cn', 'KLJ00093', 96, 66, 21000.00, 1386000.00);
INSERT INTO keranjang_belanja VALUES ('dollivierre4l@statcounter.com', 'KLJ00020', 64, 26, 21500.00, 559000.00);
INSERT INTO keranjang_belanja VALUES ('jdominici5c@wp.com', 'KLJ00031', 15, 140, 22000.00, 3080000.00);
INSERT INTO keranjang_belanja VALUES ('dterrey2x@bloglines.com', 'KLJ00182', 56, 34, 22500.00, 765000.00);
INSERT INTO keranjang_belanja VALUES ('cmcgarrell6s@dropbox.com', 'KLJ00102', 52, 95, 23000.00, 2185000.00);
INSERT INTO keranjang_belanja VALUES ('eboddymead39@flavors.me', 'KLJ00042', 18, 50, 23500.00, 1175000.00);
INSERT INTO keranjang_belanja VALUES ('tbrettle52@wsj.com', 'KLJ00166', 86, 31, 24000.00, 744000.00);
INSERT INTO keranjang_belanja VALUES ('tschimon5@rambler.ru', 'KLJ00014', 38, 8, 24500.00, 196000.00);
INSERT INTO keranjang_belanja VALUES ('mtitherington10@amazon.co.jp', 'KLJ00250', 62, 40, 25000.00, 1000000.00);


--
-- Data for Name: komentar_diskusi; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO komentar_diskusi VALUES ('gkidwell3k@kickstarter.com', 'apicopp4k@uol.com.br', '2016-08-28 00:45:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('doveralln@biglobe.ne.jp', 'lstiggles4b@ucoz.com', '2016-07-26 11:53:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('ebromhead50@tinypic.com', 'poats37@squidoo.com', '2016-05-10 06:37:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('opetigrew6p@devhub.com', 'scaccavari8b@mozilla.com', '2016-06-25 17:40:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('sklemke3t@lycos.com', 'qstonestreet93@hatena.ne.jp', '2016-08-22 19:32:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('fsyratt8h@cpanel.net', 'dwormanm@imgur.com', '2016-05-19 23:23:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('nleathers33@sbwire.com', 'mromanin87@sina.com.cn', '2016-09-26 03:57:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('hflewitt9o@unicef.org', 'bmccurrie89@intel.com', '2016-12-19 18:36:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('rpendergrast6z@hao123.com', 'hflewitt9o@unicef.org', '2017-03-05 21:54:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('lsparling73@fema.gov', 'atrickeyv@yale.edu', '2016-11-16 07:58:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('bde64@smugmug.com', 'sbendik83@independent.co.uk', '2016-06-21 14:23:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('dyankin59@quantcast.com', 'stait9@goo.ne.jp', '2017-01-02 23:16:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('tbrettle52@wsj.com', 'atatters31@marketwatch.com', '2016-12-30 14:31:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('cpeizer5e@vk.com', 'bandryunin7p@cyberchimps.com', '2016-05-18 12:26:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('fwadeson6r@discuz.net', 'dmcauslene4z@amazon.com', '2016-05-03 12:47:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('ctipper8o@unblog.fr', 'dnottingam2t@marketwatch.com', '2016-06-12 11:16:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('jbraikenridge1i@goo.gl', 'vianni53@csmonitor.com', '2017-02-02 09:18:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('jdominici5c@wp.com', 'eamiss9j@jimdo.com', '2016-05-03 16:17:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('mromeoo@weather.com', 'sdornanx@epa.gov', '2016-12-10 14:23:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('smilbourne9c@comcast.net', 'gmossman1m@de.vu', '2016-04-30 07:02:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('cdoughty3o@i2i.jp', 'ywestrip6h@pen.io', '2016-12-04 00:24:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('mramsdell78@paypal.com', 'mromanin87@sina.com.cn', '2016-05-20 21:50:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('sestcot7f@nbcnews.com', 'flapish4s@indiatimes.com', '2017-01-28 03:29:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('ghamberston55@foxnews.com', 'rjozaitis4g@icio.us', '2016-05-18 08:48:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('rjodrelle1c@topsy.com', 'swoolgar7j@thetimes.co.uk', '2016-09-25 08:12:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('dpartlett5f@wikia.com', 'mtitherington10@amazon.co.jp', '2016-07-21 00:31:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('mgallico88@zimbio.com', 'ghamberston55@foxnews.com', '2016-04-29 09:53:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('adeg@facebook.com', 'sbendik83@independent.co.uk', '2016-12-28 21:52:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('fsyratt8h@cpanel.net', 'hflewitt9o@unicef.org', '2016-07-07 21:21:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('fsyratt8h@cpanel.net', 'dsketcher7d@ehow.com', '2016-12-12 22:08:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('vnewlove8g@yahoo.com', 'dde74@fc2.com', '2016-09-20 20:50:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('kasprey6t@symantec.com', 'aoldam7n@google.fr', '2016-06-29 21:42:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('ralders58@tripod.com', 'sdornanx@epa.gov', '2016-11-06 15:33:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('mjindrich7o@twitter.com', 'mgallico88@zimbio.com', '2016-11-28 06:41:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('cpittford71@photobucket.com', 'ozettlerq@washingtonpost.com', '2016-07-20 09:47:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('ppidgen2w@paginegialle.it', 'tdjurkovic5r@livejournal.com', '2016-10-30 07:02:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('yduffett4o@va.gov', 'akiltie81@edublogs.org', '2016-11-16 06:30:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('lstiggles4b@ucoz.com', 'tmerill45@google.com.br', '2017-01-27 04:46:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('llawlings5l@china.com.cn', 'iolahy6a@yellowpages.com', '2016-12-18 23:44:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('ppidgen2w@paginegialle.it', 'msimione1p@sitemeter.com', '2016-05-18 06:36:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('ctembey2s@nhs.uk', 'gkidwell3k@kickstarter.com', '2016-12-09 03:24:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('mtitherington10@amazon.co.jp', 'broskams9n@hud.gov', '2016-09-19 12:14:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('tschimon5@rambler.ru', 'acumberpatch7w@about.me', '2017-02-05 23:57:00', 'Bahannya apa ?');
INSERT INTO komentar_diskusi VALUES ('mcivitillob@google.ru', 'cmalzard2f@acquirethisname.com', '2016-08-07 02:59:00', 'Yang merah bahannya apa?');
INSERT INTO komentar_diskusi VALUES ('eboddymead39@flavors.me', 'opetigrew6p@devhub.com', '2016-10-26 22:27:00', 'Masih ada ngga yang ini?');
INSERT INTO komentar_diskusi VALUES ('preddish7y@1und1.de', 'scaccavari8b@mozilla.com', '2016-09-28 05:15:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('gboschmann1w@themeforest.net', 'llawlings5l@china.com.cn', '2016-09-09 12:18:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('lgoggen4d@discovery.com', 'rdiggins29@storify.com', '2016-05-05 19:56:00', 'Yang Merah Ready?');
INSERT INTO komentar_diskusi VALUES ('jluxford3x@statcounter.com', 'pcuttles1@nydailynews.com', '2016-12-13 00:58:00', 'Masih ada stock?');
INSERT INTO komentar_diskusi VALUES ('cmcgarrell6s@dropbox.com', 'mromeoo@weather.com', '2017-04-15 17:44:00', 'Masih ada stock?');


--
-- Data for Name: list_item; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO list_item VALUES ('V000000000', 'KLJ00001', 83, 26, 1000.00, 26000.00);
INSERT INTO list_item VALUES ('V000000001', 'KLJ00002', 97, 30, 2000.00, 60000.00);
INSERT INTO list_item VALUES ('V000000002', 'KLJ00003', 59, 7, 3000.00, 21000.00);
INSERT INTO list_item VALUES ('V000000003', 'KLJ00004', 44, 98, 4000.00, 392000.00);
INSERT INTO list_item VALUES ('V000000004', 'KLJ00005', 36, 49, 5000.00, 245000.00);
INSERT INTO list_item VALUES ('V000000005', 'KLJ00006', 21, 58, 6000.00, 348000.00);
INSERT INTO list_item VALUES ('V000000006', 'KLJ00007', 28, 69, 7000.00, 483000.00);
INSERT INTO list_item VALUES ('V000000007', 'KLJ00008', 68, 80, 8000.00, 640000.00);
INSERT INTO list_item VALUES ('V000000008', 'KLJ00009', 37, 17, 9000.00, 153000.00);
INSERT INTO list_item VALUES ('V000000009', 'KLJ00010', 16, 88, 10000.00, 880000.00);
INSERT INTO list_item VALUES ('V000000010', 'KLJ00011', 89, 21, 11000.00, 231000.00);
INSERT INTO list_item VALUES ('V000000011', 'KLJ00012', 82, 78, 12000.00, 936000.00);
INSERT INTO list_item VALUES ('V000000012', 'KLJ00013', 3, 67, 13000.00, 871000.00);
INSERT INTO list_item VALUES ('V000000013', 'KLJ00014', 25, 18, 14000.00, 252000.00);
INSERT INTO list_item VALUES ('V000000014', 'KLJ00015', 5, 53, 15000.00, 795000.00);
INSERT INTO list_item VALUES ('V000000015', 'KLJ00016', 3, 86, 16000.00, 1376000.00);
INSERT INTO list_item VALUES ('V000000016', 'KLJ00017', 94, 66, 17000.00, 1122000.00);
INSERT INTO list_item VALUES ('V000000017', 'KLJ00018', 58, 57, 18000.00, 1026000.00);
INSERT INTO list_item VALUES ('V000000018', 'KLJ00019', 97, 97, 19000.00, 1843000.00);
INSERT INTO list_item VALUES ('V000000019', 'KLJ00020', 17, 62, 20000.00, 1240000.00);
INSERT INTO list_item VALUES ('V000000020', 'KLJ00021', 50, 76, 21000.00, 1596000.00);
INSERT INTO list_item VALUES ('V000000021', 'KLJ00022', 6, 63, 22000.00, 1386000.00);
INSERT INTO list_item VALUES ('V000000022', 'KLJ00023', 63, 81, 23000.00, 1863000.00);
INSERT INTO list_item VALUES ('V000000023', 'KLJ00024', 56, 10, 24000.00, 240000.00);
INSERT INTO list_item VALUES ('V000000024', 'KLJ00025', 84, 27, 25000.00, 675000.00);
INSERT INTO list_item VALUES ('V000000025', 'KLJ00026', 60, 66, 26000.00, 1716000.00);
INSERT INTO list_item VALUES ('V000000026', 'KLJ00027', 52, 27, 27000.00, 729000.00);
INSERT INTO list_item VALUES ('V000000027', 'KLJ00028', 85, 73, 28000.00, 2044000.00);
INSERT INTO list_item VALUES ('V000000028', 'KLJ00029', 85, 81, 29000.00, 2349000.00);
INSERT INTO list_item VALUES ('V000000029', 'KLJ00030', 76, 95, 30000.00, 2850000.00);
INSERT INTO list_item VALUES ('V000000030', 'KLJ00031', 92, 90, 31000.00, 2790000.00);
INSERT INTO list_item VALUES ('V000000031', 'KLJ00032', 54, 55, 32000.00, 1760000.00);
INSERT INTO list_item VALUES ('V000000032', 'KLJ00033', 100, 18, 33000.00, 594000.00);
INSERT INTO list_item VALUES ('V000000033', 'KLJ00034', 58, 93, 34000.00, 3162000.00);
INSERT INTO list_item VALUES ('V000000034', 'KLJ00035', 9, 63, 35000.00, 2205000.00);
INSERT INTO list_item VALUES ('V000000035', 'KLJ00036', 54, 7, 36000.00, 252000.00);
INSERT INTO list_item VALUES ('V000000036', 'KLJ00037', 96, 96, 37000.00, 3552000.00);
INSERT INTO list_item VALUES ('V000000037', 'KLJ00038', 61, 91, 38000.00, 3458000.00);
INSERT INTO list_item VALUES ('V000000038', 'KLJ00039', 17, 36, 39000.00, 1404000.00);
INSERT INTO list_item VALUES ('V000000039', 'KLJ00040', 73, 32, 40000.00, 1280000.00);
INSERT INTO list_item VALUES ('V000000040', 'KLJ00041', 59, 33, 41000.00, 1353000.00);
INSERT INTO list_item VALUES ('V000000041', 'KLJ00042', 75, 8, 42000.00, 336000.00);
INSERT INTO list_item VALUES ('V000000042', 'KLJ00043', 54, 65, 43000.00, 2795000.00);
INSERT INTO list_item VALUES ('V000000043', 'KLJ00044', 68, 41, 44000.00, 1804000.00);
INSERT INTO list_item VALUES ('V000000044', 'KLJ00045', 65, 78, 45000.00, 3510000.00);
INSERT INTO list_item VALUES ('V000000045', 'KLJ00046', 99, 52, 46000.00, 2392000.00);
INSERT INTO list_item VALUES ('V000000046', 'KLJ00047', 100, 10, 47000.00, 470000.00);
INSERT INTO list_item VALUES ('V000000047', 'KLJ00048', 13, 27, 48000.00, 1296000.00);
INSERT INTO list_item VALUES ('V000000048', 'KLJ00049', 17, 79, 49000.00, 3871000.00);
INSERT INTO list_item VALUES ('V000000049', 'KLJ00050', 48, 65, 50000.00, 3250000.00);
INSERT INTO list_item VALUES ('V000000050', 'KLJ00051', 53, 57, 51000.00, 2907000.00);
INSERT INTO list_item VALUES ('V000000051', 'KLJ00052', 36, 79, 52000.00, 4108000.00);
INSERT INTO list_item VALUES ('V000000052', 'KLJ00053', 58, 86, 53000.00, 4558000.00);
INSERT INTO list_item VALUES ('V000000053', 'KLJ00054', 51, 65, 54000.00, 3510000.00);
INSERT INTO list_item VALUES ('V000000054', 'KLJ00055', 62, 62, 55000.00, 3410000.00);
INSERT INTO list_item VALUES ('V000000055', 'KLJ00056', 13, 19, 56000.00, 1064000.00);
INSERT INTO list_item VALUES ('V000000056', 'KLJ00057', 49, 83, 57000.00, 4731000.00);
INSERT INTO list_item VALUES ('V000000057', 'KLJ00058', 90, 83, 58000.00, 4814000.00);
INSERT INTO list_item VALUES ('V000000058', 'KLJ00059', 95, 41, 59000.00, 2419000.00);
INSERT INTO list_item VALUES ('V000000059', 'KLJ00060', 90, 37, 60000.00, 2220000.00);
INSERT INTO list_item VALUES ('V000000060', 'KLJ00061', 64, 57, 61000.00, 3477000.00);
INSERT INTO list_item VALUES ('V000000061', 'KLJ00062', 99, 15, 62000.00, 930000.00);
INSERT INTO list_item VALUES ('V000000062', 'KLJ00063', 4, 7, 63000.00, 441000.00);
INSERT INTO list_item VALUES ('V000000063', 'KLJ00064', 98, 81, 64000.00, 5184000.00);
INSERT INTO list_item VALUES ('V000000064', 'KLJ00065', 13, 20, 65000.00, 1300000.00);
INSERT INTO list_item VALUES ('V000000065', 'KLJ00066', 51, 4, 66000.00, 264000.00);
INSERT INTO list_item VALUES ('V000000066', 'KLJ00067', 90, 93, 67000.00, 6231000.00);
INSERT INTO list_item VALUES ('V000000067', 'KLJ00068', 73, 10, 68000.00, 680000.00);
INSERT INTO list_item VALUES ('V000000068', 'KLJ00069', 54, 44, 69000.00, 3036000.00);
INSERT INTO list_item VALUES ('V000000069', 'KLJ00070', 52, 83, 70000.00, 5810000.00);
INSERT INTO list_item VALUES ('V000000070', 'KLJ00071', 33, 56, 71000.00, 3976000.00);
INSERT INTO list_item VALUES ('V000000071', 'KLJ00072', 18, 91, 72000.00, 6552000.00);
INSERT INTO list_item VALUES ('V000000072', 'KLJ00073', 56, 10, 73000.00, 730000.00);
INSERT INTO list_item VALUES ('V000000073', 'KLJ00074', 48, 54, 74000.00, 3996000.00);
INSERT INTO list_item VALUES ('V000000074', 'KLJ00075', 23, 14, 75000.00, 1050000.00);
INSERT INTO list_item VALUES ('V000000075', 'KLJ00076', 60, 37, 76000.00, 2812000.00);
INSERT INTO list_item VALUES ('V000000076', 'KLJ00077', 38, 58, 77000.00, 4466000.00);
INSERT INTO list_item VALUES ('V000000077', 'KLJ00078', 19, 70, 78000.00, 5460000.00);
INSERT INTO list_item VALUES ('V000000078', 'KLJ00079', 94, 16, 79000.00, 1264000.00);
INSERT INTO list_item VALUES ('V000000079', 'KLJ00080', 26, 94, 80000.00, 7520000.00);
INSERT INTO list_item VALUES ('V000000080', 'KLJ00081', 47, 96, 81000.00, 7776000.00);
INSERT INTO list_item VALUES ('V000000081', 'KLJ00082', 51, 10, 82000.00, 820000.00);
INSERT INTO list_item VALUES ('V000000082', 'KLJ00083', 15, 32, 83000.00, 2656000.00);
INSERT INTO list_item VALUES ('V000000083', 'KLJ00084', 23, 85, 84000.00, 7140000.00);
INSERT INTO list_item VALUES ('V000000084', 'KLJ00085', 57, 66, 85000.00, 5610000.00);
INSERT INTO list_item VALUES ('V000000085', 'KLJ00086', 3, 30, 86000.00, 2580000.00);
INSERT INTO list_item VALUES ('V000000086', 'KLJ00087', 68, 48, 87000.00, 4176000.00);
INSERT INTO list_item VALUES ('V000000087', 'KLJ00088', 68, 44, 88000.00, 3872000.00);
INSERT INTO list_item VALUES ('V000000088', 'KLJ00089', 89, 63, 89000.00, 5607000.00);
INSERT INTO list_item VALUES ('V000000089', 'KLJ00090', 72, 17, 90000.00, 1530000.00);
INSERT INTO list_item VALUES ('V000000090', 'KLJ00091', 92, 42, 91000.00, 3822000.00);
INSERT INTO list_item VALUES ('V000000091', 'KLJ00092', 56, 15, 92000.00, 1380000.00);
INSERT INTO list_item VALUES ('V000000092', 'KLJ00093', 93, 80, 93000.00, 7440000.00);
INSERT INTO list_item VALUES ('V000000093', 'KLJ00094', 33, 49, 94000.00, 4606000.00);
INSERT INTO list_item VALUES ('V000000094', 'KLJ00095', 66, 30, 95000.00, 2850000.00);
INSERT INTO list_item VALUES ('V000000095', 'KLJ00096', 38, 90, 96000.00, 8640000.00);
INSERT INTO list_item VALUES ('V000000096', 'KLJ00097', 75, 41, 97000.00, 3977000.00);
INSERT INTO list_item VALUES ('V000000097', 'KLJ00098', 74, 6, 98000.00, 588000.00);
INSERT INTO list_item VALUES ('V000000098', 'KLJ00099', 22, 87, 99000.00, 8613000.00);
INSERT INTO list_item VALUES ('V000000099', 'KLJ00100', 43, 12, 100000.00, 1200000.00);
INSERT INTO list_item VALUES ('V000000100', 'KLJ00101', 85, 47, 101000.00, 4747000.00);
INSERT INTO list_item VALUES ('V000000101', 'KLJ00102', 53, 75, 102000.00, 7650000.00);
INSERT INTO list_item VALUES ('V000000102', 'KLJ00103', 68, 35, 103000.00, 3605000.00);
INSERT INTO list_item VALUES ('V000000103', 'KLJ00104', 13, 58, 104000.00, 6032000.00);
INSERT INTO list_item VALUES ('V000000104', 'KLJ00105', 20, 43, 105000.00, 4515000.00);
INSERT INTO list_item VALUES ('V000000105', 'KLJ00106', 75, 24, 106000.00, 2544000.00);
INSERT INTO list_item VALUES ('V000000106', 'KLJ00107', 52, 87, 107000.00, 9309000.00);
INSERT INTO list_item VALUES ('V000000107', 'KLJ00108', 64, 53, 108000.00, 5724000.00);
INSERT INTO list_item VALUES ('V000000108', 'KLJ00109', 14, 13, 109000.00, 1417000.00);
INSERT INTO list_item VALUES ('V000000109', 'KLJ00110', 78, 61, 110000.00, 6710000.00);
INSERT INTO list_item VALUES ('V000000110', 'KLJ00111', 21, 52, 111000.00, 5772000.00);
INSERT INTO list_item VALUES ('V000000221', 'KLJ00222', 30, 25, 222000.00, 5550000.00);
INSERT INTO list_item VALUES ('V000000111', 'KLJ00112', 51, 13, 112000.00, 1456000.00);
INSERT INTO list_item VALUES ('V000000112', 'KLJ00113', 71, 30, 113000.00, 3390000.00);
INSERT INTO list_item VALUES ('V000000113', 'KLJ00114', 71, 59, 114000.00, 6726000.00);
INSERT INTO list_item VALUES ('V000000114', 'KLJ00115', 12, 16, 115000.00, 1840000.00);
INSERT INTO list_item VALUES ('V000000115', 'KLJ00116', 71, 11, 116000.00, 1276000.00);
INSERT INTO list_item VALUES ('V000000116', 'KLJ00117', 96, 11, 117000.00, 1287000.00);
INSERT INTO list_item VALUES ('V000000117', 'KLJ00118', 84, 1, 118000.00, 118000.00);
INSERT INTO list_item VALUES ('V000000118', 'KLJ00119', 7, 12, 119000.00, 1428000.00);
INSERT INTO list_item VALUES ('V000000119', 'KLJ00120', 58, 80, 120000.00, 9600000.00);
INSERT INTO list_item VALUES ('V000000120', 'KLJ00121', 50, 60, 121000.00, 7260000.00);
INSERT INTO list_item VALUES ('V000000121', 'KLJ00122', 55, 73, 122000.00, 8906000.00);
INSERT INTO list_item VALUES ('V000000122', 'KLJ00123', 53, 3, 123000.00, 369000.00);
INSERT INTO list_item VALUES ('V000000123', 'KLJ00124', 68, 90, 124000.00, 11160000.00);
INSERT INTO list_item VALUES ('V000000124', 'KLJ00125', 43, 6, 125000.00, 750000.00);
INSERT INTO list_item VALUES ('V000000125', 'KLJ00126', 83, 86, 126000.00, 10836000.00);
INSERT INTO list_item VALUES ('V000000126', 'KLJ00127', 49, 41, 127000.00, 5207000.00);
INSERT INTO list_item VALUES ('V000000127', 'KLJ00128', 68, 87, 128000.00, 11136000.00);
INSERT INTO list_item VALUES ('V000000128', 'KLJ00129', 36, 68, 129000.00, 8772000.00);
INSERT INTO list_item VALUES ('V000000129', 'KLJ00130', 84, 53, 130000.00, 6890000.00);
INSERT INTO list_item VALUES ('V000000130', 'KLJ00131', 26, 100, 131000.00, 13100000.00);
INSERT INTO list_item VALUES ('V000000131', 'KLJ00132', 40, 76, 132000.00, 10032000.00);
INSERT INTO list_item VALUES ('V000000132', 'KLJ00133', 100, 13, 133000.00, 1729000.00);
INSERT INTO list_item VALUES ('V000000133', 'KLJ00134', 5, 31, 134000.00, 4154000.00);
INSERT INTO list_item VALUES ('V000000134', 'KLJ00135', 38, 72, 135000.00, 9720000.00);
INSERT INTO list_item VALUES ('V000000135', 'KLJ00136', 15, 48, 136000.00, 6528000.00);
INSERT INTO list_item VALUES ('V000000136', 'KLJ00137', 99, 35, 137000.00, 4795000.00);
INSERT INTO list_item VALUES ('V000000137', 'KLJ00138', 26, 52, 138000.00, 7176000.00);
INSERT INTO list_item VALUES ('V000000138', 'KLJ00139', 99, 100, 139000.00, 13900000.00);
INSERT INTO list_item VALUES ('V000000139', 'KLJ00140', 5, 99, 140000.00, 13860000.00);
INSERT INTO list_item VALUES ('V000000140', 'KLJ00141', 68, 57, 141000.00, 8037000.00);
INSERT INTO list_item VALUES ('V000000141', 'KLJ00142', 80, 99, 142000.00, 14058000.00);
INSERT INTO list_item VALUES ('V000000142', 'KLJ00143', 31, 53, 143000.00, 7579000.00);
INSERT INTO list_item VALUES ('V000000143', 'KLJ00144', 18, 66, 144000.00, 9504000.00);
INSERT INTO list_item VALUES ('V000000144', 'KLJ00145', 15, 49, 145000.00, 7105000.00);
INSERT INTO list_item VALUES ('V000000145', 'KLJ00146', 27, 56, 146000.00, 8176000.00);
INSERT INTO list_item VALUES ('V000000146', 'KLJ00147', 66, 24, 147000.00, 3528000.00);
INSERT INTO list_item VALUES ('V000000147', 'KLJ00148', 19, 98, 148000.00, 14504000.00);
INSERT INTO list_item VALUES ('V000000148', 'KLJ00149', 48, 93, 149000.00, 13857000.00);
INSERT INTO list_item VALUES ('V000000149', 'KLJ00150', 89, 5, 150000.00, 750000.00);
INSERT INTO list_item VALUES ('V000000150', 'KLJ00151', 20, 82, 151000.00, 12382000.00);
INSERT INTO list_item VALUES ('V000000151', 'KLJ00152', 87, 13, 152000.00, 1976000.00);
INSERT INTO list_item VALUES ('V000000152', 'KLJ00153', 40, 94, 153000.00, 14382000.00);
INSERT INTO list_item VALUES ('V000000153', 'KLJ00154', 81, 55, 154000.00, 8470000.00);
INSERT INTO list_item VALUES ('V000000154', 'KLJ00155', 42, 78, 155000.00, 12090000.00);
INSERT INTO list_item VALUES ('V000000155', 'KLJ00156', 23, 38, 156000.00, 5928000.00);
INSERT INTO list_item VALUES ('V000000156', 'KLJ00157', 96, 31, 157000.00, 4867000.00);
INSERT INTO list_item VALUES ('V000000157', 'KLJ00158', 64, 43, 158000.00, 6794000.00);
INSERT INTO list_item VALUES ('V000000158', 'KLJ00159', 37, 54, 159000.00, 8586000.00);
INSERT INTO list_item VALUES ('V000000159', 'KLJ00160', 76, 20, 160000.00, 3200000.00);
INSERT INTO list_item VALUES ('V000000160', 'KLJ00161', 1, 20, 161000.00, 3220000.00);
INSERT INTO list_item VALUES ('V000000161', 'KLJ00162', 30, 4, 162000.00, 648000.00);
INSERT INTO list_item VALUES ('V000000162', 'KLJ00163', 53, 14, 163000.00, 2282000.00);
INSERT INTO list_item VALUES ('V000000163', 'KLJ00164', 81, 26, 164000.00, 4264000.00);
INSERT INTO list_item VALUES ('V000000164', 'KLJ00165', 32, 56, 165000.00, 9240000.00);
INSERT INTO list_item VALUES ('V000000165', 'KLJ00166', 92, 12, 166000.00, 1992000.00);
INSERT INTO list_item VALUES ('V000000166', 'KLJ00167', 97, 86, 167000.00, 14362000.00);
INSERT INTO list_item VALUES ('V000000167', 'KLJ00168', 26, 52, 168000.00, 8736000.00);
INSERT INTO list_item VALUES ('V000000168', 'KLJ00169', 47, 60, 169000.00, 10140000.00);
INSERT INTO list_item VALUES ('V000000169', 'KLJ00170', 12, 2, 170000.00, 340000.00);
INSERT INTO list_item VALUES ('V000000170', 'KLJ00171', 10, 95, 171000.00, 16245000.00);
INSERT INTO list_item VALUES ('V000000171', 'KLJ00172', 91, 81, 172000.00, 13932000.00);
INSERT INTO list_item VALUES ('V000000172', 'KLJ00173', 9, 65, 173000.00, 11245000.00);
INSERT INTO list_item VALUES ('V000000173', 'KLJ00174', 43, 76, 174000.00, 13224000.00);
INSERT INTO list_item VALUES ('V000000174', 'KLJ00175', 75, 53, 175000.00, 9275000.00);
INSERT INTO list_item VALUES ('V000000175', 'KLJ00176', 2, 37, 176000.00, 6512000.00);
INSERT INTO list_item VALUES ('V000000176', 'KLJ00177', 9, 82, 177000.00, 14514000.00);
INSERT INTO list_item VALUES ('V000000177', 'KLJ00178', 51, 32, 178000.00, 5696000.00);
INSERT INTO list_item VALUES ('V000000178', 'KLJ00179', 86, 49, 179000.00, 8771000.00);
INSERT INTO list_item VALUES ('V000000179', 'KLJ00180', 84, 60, 180000.00, 10800000.00);
INSERT INTO list_item VALUES ('V000000180', 'KLJ00181', 22, 27, 181000.00, 4887000.00);
INSERT INTO list_item VALUES ('V000000181', 'KLJ00182', 17, 79, 182000.00, 14378000.00);
INSERT INTO list_item VALUES ('V000000182', 'KLJ00183', 45, 80, 183000.00, 14640000.00);
INSERT INTO list_item VALUES ('V000000183', 'KLJ00184', 37, 48, 184000.00, 8832000.00);
INSERT INTO list_item VALUES ('V000000184', 'KLJ00185', 77, 70, 185000.00, 12950000.00);
INSERT INTO list_item VALUES ('V000000185', 'KLJ00186', 88, 99, 186000.00, 18414000.00);
INSERT INTO list_item VALUES ('V000000186', 'KLJ00187', 70, 60, 187000.00, 11220000.00);
INSERT INTO list_item VALUES ('V000000187', 'KLJ00188', 23, 21, 188000.00, 3948000.00);
INSERT INTO list_item VALUES ('V000000188', 'KLJ00189', 69, 4, 189000.00, 756000.00);
INSERT INTO list_item VALUES ('V000000189', 'KLJ00190', 90, 98, 190000.00, 18620000.00);
INSERT INTO list_item VALUES ('V000000190', 'KLJ00191', 64, 86, 191000.00, 16426000.00);
INSERT INTO list_item VALUES ('V000000191', 'KLJ00192', 44, 23, 192000.00, 4416000.00);
INSERT INTO list_item VALUES ('V000000192', 'KLJ00193', 71, 66, 193000.00, 12738000.00);
INSERT INTO list_item VALUES ('V000000193', 'KLJ00194', 37, 81, 194000.00, 15714000.00);
INSERT INTO list_item VALUES ('V000000194', 'KLJ00195', 70, 24, 195000.00, 4680000.00);
INSERT INTO list_item VALUES ('V000000195', 'KLJ00196', 48, 6, 196000.00, 1176000.00);
INSERT INTO list_item VALUES ('V000000196', 'KLJ00197', 77, 62, 197000.00, 12214000.00);
INSERT INTO list_item VALUES ('V000000197', 'KLJ00198', 79, 3, 198000.00, 594000.00);
INSERT INTO list_item VALUES ('V000000198', 'KLJ00199', 27, 24, 199000.00, 4776000.00);
INSERT INTO list_item VALUES ('V000000199', 'KLJ00200', 15, 13, 200000.00, 2600000.00);
INSERT INTO list_item VALUES ('V000000200', 'KLJ00201', 97, 64, 201000.00, 12864000.00);
INSERT INTO list_item VALUES ('V000000201', 'KLJ00202', 98, 27, 202000.00, 5454000.00);
INSERT INTO list_item VALUES ('V000000202', 'KLJ00203', 63, 79, 203000.00, 16037000.00);
INSERT INTO list_item VALUES ('V000000203', 'KLJ00204', 74, 96, 204000.00, 19584000.00);
INSERT INTO list_item VALUES ('V000000204', 'KLJ00205', 48, 18, 205000.00, 3690000.00);
INSERT INTO list_item VALUES ('V000000205', 'KLJ00206', 27, 45, 206000.00, 9270000.00);
INSERT INTO list_item VALUES ('V000000206', 'KLJ00207', 20, 47, 207000.00, 9729000.00);
INSERT INTO list_item VALUES ('V000000207', 'KLJ00208', 15, 30, 208000.00, 6240000.00);
INSERT INTO list_item VALUES ('V000000208', 'KLJ00209', 98, 84, 209000.00, 17556000.00);
INSERT INTO list_item VALUES ('V000000209', 'KLJ00210', 77, 30, 210000.00, 6300000.00);
INSERT INTO list_item VALUES ('V000000210', 'KLJ00211', 36, 93, 211000.00, 19623000.00);
INSERT INTO list_item VALUES ('V000000211', 'KLJ00212', 70, 49, 212000.00, 10388000.00);
INSERT INTO list_item VALUES ('V000000212', 'KLJ00213', 74, 52, 213000.00, 11076000.00);
INSERT INTO list_item VALUES ('V000000213', 'KLJ00214', 78, 23, 214000.00, 4922000.00);
INSERT INTO list_item VALUES ('V000000214', 'KLJ00215', 71, 27, 215000.00, 5805000.00);
INSERT INTO list_item VALUES ('V000000215', 'KLJ00216', 51, 50, 216000.00, 10800000.00);
INSERT INTO list_item VALUES ('V000000216', 'KLJ00217', 66, 39, 217000.00, 8463000.00);
INSERT INTO list_item VALUES ('V000000217', 'KLJ00218', 40, 57, 218000.00, 12426000.00);
INSERT INTO list_item VALUES ('V000000218', 'KLJ00219', 52, 61, 219000.00, 13359000.00);
INSERT INTO list_item VALUES ('V000000219', 'KLJ00220', 90, 5, 220000.00, 1100000.00);
INSERT INTO list_item VALUES ('V000000220', 'KLJ00221', 12, 32, 221000.00, 7072000.00);
INSERT INTO list_item VALUES ('V000000222', 'KLJ00223', 42, 31, 223000.00, 6913000.00);
INSERT INTO list_item VALUES ('V000000223', 'KLJ00224', 95, 35, 224000.00, 7840000.00);
INSERT INTO list_item VALUES ('V000000224', 'KLJ00225', 25, 2, 225000.00, 450000.00);
INSERT INTO list_item VALUES ('V000000225', 'KLJ00226', 39, 9, 226000.00, 2034000.00);
INSERT INTO list_item VALUES ('V000000226', 'KLJ00227', 56, 75, 227000.00, 17025000.00);
INSERT INTO list_item VALUES ('V000000227', 'KLJ00228', 68, 16, 228000.00, 3648000.00);
INSERT INTO list_item VALUES ('V000000228', 'KLJ00229', 54, 29, 229000.00, 6641000.00);
INSERT INTO list_item VALUES ('V000000229', 'KLJ00230', 65, 19, 230000.00, 4370000.00);
INSERT INTO list_item VALUES ('V000000230', 'KLJ00231', 82, 91, 231000.00, 21021000.00);
INSERT INTO list_item VALUES ('V000000231', 'KLJ00232', 65, 83, 232000.00, 19256000.00);
INSERT INTO list_item VALUES ('V000000232', 'KLJ00233', 50, 80, 233000.00, 18640000.00);
INSERT INTO list_item VALUES ('V000000233', 'KLJ00234', 72, 6, 234000.00, 1404000.00);
INSERT INTO list_item VALUES ('V000000234', 'KLJ00235', 8, 77, 235000.00, 18095000.00);
INSERT INTO list_item VALUES ('V000000235', 'KLJ00236', 83, 69, 236000.00, 16284000.00);
INSERT INTO list_item VALUES ('V000000236', 'KLJ00237', 2, 16, 237000.00, 3792000.00);
INSERT INTO list_item VALUES ('V000000237', 'KLJ00238', 66, 15, 238000.00, 3570000.00);
INSERT INTO list_item VALUES ('V000000238', 'KLJ00239', 92, 31, 239000.00, 7409000.00);
INSERT INTO list_item VALUES ('V000000239', 'KLJ00240', 59, 11, 240000.00, 2640000.00);
INSERT INTO list_item VALUES ('V000000240', 'KLJ00241', 30, 100, 241000.00, 24100000.00);
INSERT INTO list_item VALUES ('V000000241', 'KLJ00242', 58, 54, 242000.00, 13068000.00);
INSERT INTO list_item VALUES ('V000000242', 'KLJ00243', 10, 29, 243000.00, 7047000.00);
INSERT INTO list_item VALUES ('V000000243', 'KLJ00244', 20, 37, 244000.00, 9028000.00);
INSERT INTO list_item VALUES ('V000000244', 'KLJ00245', 43, 65, 245000.00, 15925000.00);
INSERT INTO list_item VALUES ('V000000245', 'KLJ00246', 76, 72, 246000.00, 17712000.00);
INSERT INTO list_item VALUES ('V000000246', 'KLJ00247', 18, 20, 247000.00, 4940000.00);
INSERT INTO list_item VALUES ('V000000247', 'KLJ00248', 15, 75, 248000.00, 18600000.00);
INSERT INTO list_item VALUES ('V000000248', 'KLJ00249', 12, 26, 249000.00, 6474000.00);
INSERT INTO list_item VALUES ('V000000249', 'KLJ00250', 74, 61, 250000.00, 15250000.00);
INSERT INTO list_item VALUES ('V000000250', 'KLJ00001', 46, 73, 251000.00, 18323000.00);
INSERT INTO list_item VALUES ('V000000251', 'KLJ00002', 59, 61, 252000.00, 15372000.00);
INSERT INTO list_item VALUES ('V000000252', 'KLJ00003', 8, 65, 253000.00, 16445000.00);
INSERT INTO list_item VALUES ('V000000253', 'KLJ00004', 8, 18, 254000.00, 4572000.00);
INSERT INTO list_item VALUES ('V000000254', 'KLJ00005', 38, 93, 255000.00, 23715000.00);
INSERT INTO list_item VALUES ('V000000255', 'KLJ00006', 49, 76, 256000.00, 19456000.00);
INSERT INTO list_item VALUES ('V000000256', 'KLJ00007', 16, 40, 257000.00, 10280000.00);
INSERT INTO list_item VALUES ('V000000257', 'KLJ00008', 34, 56, 258000.00, 14448000.00);
INSERT INTO list_item VALUES ('V000000258', 'KLJ00009', 2, 56, 259000.00, 14504000.00);
INSERT INTO list_item VALUES ('V000000259', 'KLJ00010', 87, 52, 260000.00, 13520000.00);
INSERT INTO list_item VALUES ('V000000260', 'KLJ00011', 92, 33, 261000.00, 8613000.00);
INSERT INTO list_item VALUES ('V000000261', 'KLJ00012', 92, 32, 262000.00, 8384000.00);
INSERT INTO list_item VALUES ('V000000262', 'KLJ00013', 52, 80, 263000.00, 21040000.00);
INSERT INTO list_item VALUES ('V000000263', 'KLJ00014', 14, 49, 264000.00, 12936000.00);
INSERT INTO list_item VALUES ('V000000264', 'KLJ00015', 41, 44, 265000.00, 11660000.00);
INSERT INTO list_item VALUES ('V000000265', 'KLJ00016', 92, 85, 266000.00, 22610000.00);
INSERT INTO list_item VALUES ('V000000266', 'KLJ00017', 72, 88, 267000.00, 23496000.00);
INSERT INTO list_item VALUES ('V000000267', 'KLJ00018', 70, 67, 268000.00, 17956000.00);
INSERT INTO list_item VALUES ('V000000268', 'KLJ00019', 78, 66, 269000.00, 17754000.00);
INSERT INTO list_item VALUES ('V000000269', 'KLJ00020', 42, 41, 270000.00, 11070000.00);
INSERT INTO list_item VALUES ('V000000270', 'KLJ00021', 11, 63, 271000.00, 17073000.00);
INSERT INTO list_item VALUES ('V000000271', 'KLJ00022', 84, 52, 272000.00, 14144000.00);
INSERT INTO list_item VALUES ('V000000272', 'KLJ00023', 57, 23, 273000.00, 6279000.00);
INSERT INTO list_item VALUES ('V000000273', 'KLJ00024', 59, 3, 274000.00, 822000.00);
INSERT INTO list_item VALUES ('V000000274', 'KLJ00025', 1, 24, 275000.00, 6600000.00);
INSERT INTO list_item VALUES ('V000000275', 'KLJ00026', 58, 46, 276000.00, 12696000.00);
INSERT INTO list_item VALUES ('V000000276', 'KLJ00027', 51, 52, 277000.00, 14404000.00);
INSERT INTO list_item VALUES ('V000000277', 'KLJ00028', 65, 68, 278000.00, 18904000.00);
INSERT INTO list_item VALUES ('V000000278', 'KLJ00029', 79, 19, 279000.00, 5301000.00);
INSERT INTO list_item VALUES ('V000000279', 'KLJ00030', 1, 74, 280000.00, 20720000.00);
INSERT INTO list_item VALUES ('V000000280', 'KLJ00031', 38, 25, 281000.00, 7025000.00);
INSERT INTO list_item VALUES ('V000000281', 'KLJ00032', 40, 72, 282000.00, 20304000.00);
INSERT INTO list_item VALUES ('V000000282', 'KLJ00033', 60, 52, 283000.00, 14716000.00);
INSERT INTO list_item VALUES ('V000000283', 'KLJ00034', 45, 83, 284000.00, 23572000.00);
INSERT INTO list_item VALUES ('V000000284', 'KLJ00035', 38, 89, 285000.00, 25365000.00);
INSERT INTO list_item VALUES ('V000000285', 'KLJ00036', 56, 96, 286000.00, 27456000.00);
INSERT INTO list_item VALUES ('V000000286', 'KLJ00037', 2, 28, 287000.00, 8036000.00);
INSERT INTO list_item VALUES ('V000000287', 'KLJ00038', 28, 41, 288000.00, 11808000.00);
INSERT INTO list_item VALUES ('V000000288', 'KLJ00039', 44, 48, 289000.00, 13872000.00);
INSERT INTO list_item VALUES ('V000000289', 'KLJ00040', 11, 65, 290000.00, 18850000.00);
INSERT INTO list_item VALUES ('V000000290', 'KLJ00041', 96, 29, 291000.00, 8439000.00);
INSERT INTO list_item VALUES ('V000000291', 'KLJ00042', 54, 8, 292000.00, 2336000.00);
INSERT INTO list_item VALUES ('V000000292', 'KLJ00043', 99, 2, 293000.00, 586000.00);
INSERT INTO list_item VALUES ('V000000293', 'KLJ00044', 37, 50, 294000.00, 14700000.00);
INSERT INTO list_item VALUES ('V000000294', 'KLJ00045', 92, 50, 295000.00, 14750000.00);
INSERT INTO list_item VALUES ('V000000295', 'KLJ00046', 71, 92, 296000.00, 27232000.00);
INSERT INTO list_item VALUES ('V000000296', 'KLJ00047', 79, 76, 297000.00, 22572000.00);
INSERT INTO list_item VALUES ('V000000297', 'KLJ00048', 50, 11, 298000.00, 3278000.00);
INSERT INTO list_item VALUES ('V000000298', 'KLJ00049', 1, 39, 299000.00, 11661000.00);
INSERT INTO list_item VALUES ('V000000299', 'KLJ00050', 19, 47, 300000.00, 14100000.00);
INSERT INTO list_item VALUES ('V000000300', 'KLJ00051', 66, 55, 301000.00, 16555000.00);
INSERT INTO list_item VALUES ('V000000301', 'KLJ00052', 49, 35, 302000.00, 10570000.00);
INSERT INTO list_item VALUES ('V000000302', 'KLJ00053', 3, 96, 303000.00, 29088000.00);
INSERT INTO list_item VALUES ('V000000303', 'KLJ00054', 54, 50, 304000.00, 15200000.00);
INSERT INTO list_item VALUES ('V000000304', 'KLJ00055', 77, 43, 305000.00, 13115000.00);
INSERT INTO list_item VALUES ('V000000305', 'KLJ00056', 43, 23, 306000.00, 7038000.00);
INSERT INTO list_item VALUES ('V000000306', 'KLJ00057', 38, 93, 307000.00, 28551000.00);
INSERT INTO list_item VALUES ('V000000307', 'KLJ00058', 45, 76, 308000.00, 23408000.00);
INSERT INTO list_item VALUES ('V000000308', 'KLJ00059', 45, 95, 309000.00, 29355000.00);
INSERT INTO list_item VALUES ('V000000309', 'KLJ00060', 68, 38, 310000.00, 11780000.00);
INSERT INTO list_item VALUES ('V000000310', 'KLJ00061', 71, 61, 311000.00, 18971000.00);
INSERT INTO list_item VALUES ('V000000311', 'KLJ00062', 13, 68, 312000.00, 21216000.00);
INSERT INTO list_item VALUES ('V000000312', 'KLJ00063', 22, 83, 313000.00, 25979000.00);
INSERT INTO list_item VALUES ('V000000313', 'KLJ00064', 26, 85, 314000.00, 26690000.00);
INSERT INTO list_item VALUES ('V000000314', 'KLJ00065', 5, 53, 315000.00, 16695000.00);
INSERT INTO list_item VALUES ('V000000315', 'KLJ00066', 2, 47, 316000.00, 14852000.00);
INSERT INTO list_item VALUES ('V000000316', 'KLJ00067', 52, 85, 317000.00, 26945000.00);
INSERT INTO list_item VALUES ('V000000317', 'KLJ00068', 32, 20, 318000.00, 6360000.00);
INSERT INTO list_item VALUES ('V000000318', 'KLJ00069', 7, 8, 319000.00, 2552000.00);
INSERT INTO list_item VALUES ('V000000319', 'KLJ00070', 3, 60, 320000.00, 19200000.00);
INSERT INTO list_item VALUES ('V000000320', 'KLJ00071', 51, 63, 321000.00, 20223000.00);
INSERT INTO list_item VALUES ('V000000321', 'KLJ00072', 47, 97, 322000.00, 31234000.00);
INSERT INTO list_item VALUES ('V000000322', 'KLJ00073', 54, 14, 323000.00, 4522000.00);
INSERT INTO list_item VALUES ('V000000323', 'KLJ00074', 74, 59, 324000.00, 19116000.00);
INSERT INTO list_item VALUES ('V000000324', 'KLJ00075', 48, 16, 325000.00, 5200000.00);
INSERT INTO list_item VALUES ('V000000325', 'KLJ00076', 53, 78, 326000.00, 25428000.00);
INSERT INTO list_item VALUES ('V000000326', 'KLJ00077', 12, 55, 327000.00, 17985000.00);
INSERT INTO list_item VALUES ('V000000327', 'KLJ00078', 45, 48, 328000.00, 15744000.00);
INSERT INTO list_item VALUES ('V000000328', 'KLJ00079', 31, 32, 329000.00, 10528000.00);
INSERT INTO list_item VALUES ('V000000329', 'KLJ00080', 50, 94, 330000.00, 31020000.00);
INSERT INTO list_item VALUES ('V000000330', 'KLJ00081', 31, 35, 331000.00, 11585000.00);
INSERT INTO list_item VALUES ('V000000331', 'KLJ00082', 34, 71, 332000.00, 23572000.00);
INSERT INTO list_item VALUES ('V000000332', 'KLJ00083', 3, 73, 333000.00, 24309000.00);
INSERT INTO list_item VALUES ('V000000333', 'KLJ00084', 67, 6, 334000.00, 2004000.00);
INSERT INTO list_item VALUES ('V000000334', 'KLJ00085', 7, 31, 335000.00, 10385000.00);
INSERT INTO list_item VALUES ('V000000335', 'KLJ00086', 69, 69, 336000.00, 23184000.00);
INSERT INTO list_item VALUES ('V000000336', 'KLJ00087', 83, 47, 337000.00, 15839000.00);
INSERT INTO list_item VALUES ('V000000337', 'KLJ00088', 36, 57, 338000.00, 19266000.00);
INSERT INTO list_item VALUES ('V000000338', 'KLJ00089', 10, 58, 339000.00, 19662000.00);
INSERT INTO list_item VALUES ('V000000339', 'KLJ00090', 98, 66, 340000.00, 22440000.00);
INSERT INTO list_item VALUES ('V000000340', 'KLJ00091', 64, 80, 341000.00, 27280000.00);
INSERT INTO list_item VALUES ('V000000341', 'KLJ00092', 98, 2, 342000.00, 684000.00);
INSERT INTO list_item VALUES ('V000000342', 'KLJ00093', 19, 84, 343000.00, 28812000.00);
INSERT INTO list_item VALUES ('V000000343', 'KLJ00094', 94, 86, 344000.00, 29584000.00);
INSERT INTO list_item VALUES ('V000000344', 'KLJ00095', 33, 73, 345000.00, 25185000.00);
INSERT INTO list_item VALUES ('V000000345', 'KLJ00096', 45, 81, 346000.00, 28026000.00);
INSERT INTO list_item VALUES ('V000000346', 'KLJ00097', 60, 51, 347000.00, 17697000.00);
INSERT INTO list_item VALUES ('V000000347', 'KLJ00098', 95, 88, 348000.00, 30624000.00);
INSERT INTO list_item VALUES ('V000000348', 'KLJ00099', 37, 36, 349000.00, 12564000.00);
INSERT INTO list_item VALUES ('V000000349', 'KLJ00100', 29, 47, 350000.00, 16450000.00);
INSERT INTO list_item VALUES ('V000000350', 'KLJ00101', 8, 83, 351000.00, 29133000.00);
INSERT INTO list_item VALUES ('V000000351', 'KLJ00102', 48, 43, 352000.00, 15136000.00);
INSERT INTO list_item VALUES ('V000000352', 'KLJ00103', 51, 96, 353000.00, 33888000.00);
INSERT INTO list_item VALUES ('V000000353', 'KLJ00104', 13, 96, 354000.00, 33984000.00);
INSERT INTO list_item VALUES ('V000000354', 'KLJ00105', 24, 30, 355000.00, 10650000.00);
INSERT INTO list_item VALUES ('V000000355', 'KLJ00106', 45, 11, 356000.00, 3916000.00);
INSERT INTO list_item VALUES ('V000000356', 'KLJ00107', 16, 23, 357000.00, 8211000.00);
INSERT INTO list_item VALUES ('V000000357', 'KLJ00108', 7, 96, 358000.00, 34368000.00);
INSERT INTO list_item VALUES ('V000000358', 'KLJ00109', 48, 11, 359000.00, 3949000.00);
INSERT INTO list_item VALUES ('V000000359', 'KLJ00110', 100, 8, 360000.00, 2880000.00);
INSERT INTO list_item VALUES ('V000000360', 'KLJ00111', 33, 35, 361000.00, 12635000.00);
INSERT INTO list_item VALUES ('V000000361', 'KLJ00112', 8, 48, 362000.00, 17376000.00);
INSERT INTO list_item VALUES ('V000000362', 'KLJ00113', 46, 72, 363000.00, 26136000.00);
INSERT INTO list_item VALUES ('V000000363', 'KLJ00114', 57, 20, 364000.00, 7280000.00);
INSERT INTO list_item VALUES ('V000000364', 'KLJ00115', 86, 92, 365000.00, 33580000.00);
INSERT INTO list_item VALUES ('V000000365', 'KLJ00116', 17, 98, 366000.00, 35868000.00);
INSERT INTO list_item VALUES ('V000000366', 'KLJ00117', 87, 11, 367000.00, 4037000.00);
INSERT INTO list_item VALUES ('V000000367', 'KLJ00118', 60, 87, 368000.00, 32016000.00);
INSERT INTO list_item VALUES ('V000000368', 'KLJ00119', 12, 30, 369000.00, 11070000.00);
INSERT INTO list_item VALUES ('V000000369', 'KLJ00120', 31, 20, 370000.00, 7400000.00);
INSERT INTO list_item VALUES ('V000000370', 'KLJ00121', 72, 83, 371000.00, 30793000.00);
INSERT INTO list_item VALUES ('V000000371', 'KLJ00122', 21, 46, 372000.00, 17112000.00);
INSERT INTO list_item VALUES ('V000000372', 'KLJ00123', 25, 34, 373000.00, 12682000.00);
INSERT INTO list_item VALUES ('V000000373', 'KLJ00124', 85, 33, 374000.00, 12342000.00);
INSERT INTO list_item VALUES ('V000000374', 'KLJ00125', 9, 9, 375000.00, 3375000.00);
INSERT INTO list_item VALUES ('V000000375', 'KLJ00126', 55, 56, 376000.00, 21056000.00);
INSERT INTO list_item VALUES ('V000000376', 'KLJ00127', 92, 31, 377000.00, 11687000.00);
INSERT INTO list_item VALUES ('V000000377', 'KLJ00128', 60, 48, 378000.00, 18144000.00);
INSERT INTO list_item VALUES ('V000000378', 'KLJ00129', 97, 9, 379000.00, 3411000.00);
INSERT INTO list_item VALUES ('V000000379', 'KLJ00130', 65, 43, 380000.00, 16340000.00);
INSERT INTO list_item VALUES ('V000000380', 'KLJ00131', 100, 67, 381000.00, 25527000.00);
INSERT INTO list_item VALUES ('V000000381', 'KLJ00132', 20, 35, 382000.00, 13370000.00);
INSERT INTO list_item VALUES ('V000000382', 'KLJ00133', 25, 16, 383000.00, 6128000.00);
INSERT INTO list_item VALUES ('V000000383', 'KLJ00134', 68, 15, 384000.00, 5760000.00);
INSERT INTO list_item VALUES ('V000000384', 'KLJ00135', 64, 27, 385000.00, 10395000.00);
INSERT INTO list_item VALUES ('V000000385', 'KLJ00136', 21, 63, 386000.00, 24318000.00);
INSERT INTO list_item VALUES ('V000000386', 'KLJ00137', 11, 73, 387000.00, 28251000.00);
INSERT INTO list_item VALUES ('V000000387', 'KLJ00138', 43, 77, 388000.00, 29876000.00);
INSERT INTO list_item VALUES ('V000000388', 'KLJ00139', 68, 55, 389000.00, 21395000.00);
INSERT INTO list_item VALUES ('V000000389', 'KLJ00140', 41, 78, 390000.00, 30420000.00);
INSERT INTO list_item VALUES ('V000000390', 'KLJ00141', 3, 97, 391000.00, 37927000.00);
INSERT INTO list_item VALUES ('V000000391', 'KLJ00142', 89, 62, 392000.00, 24304000.00);
INSERT INTO list_item VALUES ('V000000392', 'KLJ00143', 29, 60, 393000.00, 23580000.00);
INSERT INTO list_item VALUES ('V000000393', 'KLJ00144', 33, 91, 394000.00, 35854000.00);
INSERT INTO list_item VALUES ('V000000394', 'KLJ00145', 83, 18, 395000.00, 7110000.00);
INSERT INTO list_item VALUES ('V000000395', 'KLJ00146', 72, 97, 396000.00, 38412000.00);
INSERT INTO list_item VALUES ('V000000396', 'KLJ00147', 84, 55, 397000.00, 21835000.00);
INSERT INTO list_item VALUES ('V000000397', 'KLJ00148', 31, 75, 398000.00, 29850000.00);
INSERT INTO list_item VALUES ('V000000398', 'KLJ00149', 18, 16, 399000.00, 6384000.00);
INSERT INTO list_item VALUES ('V000000399', 'KLJ00150', 13, 90, 400000.00, 36000000.00);
INSERT INTO list_item VALUES ('V000000400', 'KLJ00151', 44, 3, 401000.00, 1203000.00);
INSERT INTO list_item VALUES ('V000000401', 'KLJ00152', 43, 53, 402000.00, 21306000.00);
INSERT INTO list_item VALUES ('V000000402', 'KLJ00153', 81, 53, 403000.00, 21359000.00);
INSERT INTO list_item VALUES ('V000000403', 'KLJ00154', 76, 11, 404000.00, 4444000.00);
INSERT INTO list_item VALUES ('V000000404', 'KLJ00155', 14, 65, 405000.00, 26325000.00);
INSERT INTO list_item VALUES ('V000000405', 'KLJ00156', 10, 83, 406000.00, 33698000.00);
INSERT INTO list_item VALUES ('V000000406', 'KLJ00157', 29, 87, 407000.00, 35409000.00);
INSERT INTO list_item VALUES ('V000000407', 'KLJ00158', 82, 26, 408000.00, 10608000.00);
INSERT INTO list_item VALUES ('V000000408', 'KLJ00159', 27, 77, 409000.00, 31493000.00);
INSERT INTO list_item VALUES ('V000000409', 'KLJ00160', 62, 58, 410000.00, 23780000.00);
INSERT INTO list_item VALUES ('V000000410', 'KLJ00161', 24, 16, 411000.00, 6576000.00);
INSERT INTO list_item VALUES ('V000000411', 'KLJ00162', 59, 16, 412000.00, 6592000.00);
INSERT INTO list_item VALUES ('V000000412', 'KLJ00163', 8, 51, 413000.00, 21063000.00);
INSERT INTO list_item VALUES ('V000000413', 'KLJ00164', 68, 91, 414000.00, 37674000.00);
INSERT INTO list_item VALUES ('V000000414', 'KLJ00165', 62, 38, 415000.00, 15770000.00);
INSERT INTO list_item VALUES ('V000000415', 'KLJ00166', 83, 71, 416000.00, 29536000.00);
INSERT INTO list_item VALUES ('V000000416', 'KLJ00167', 88, 48, 417000.00, 20016000.00);
INSERT INTO list_item VALUES ('V000000417', 'KLJ00168', 71, 65, 418000.00, 27170000.00);
INSERT INTO list_item VALUES ('V000000418', 'KLJ00169', 68, 80, 419000.00, 33520000.00);
INSERT INTO list_item VALUES ('V000000419', 'KLJ00170', 45, 48, 420000.00, 20160000.00);
INSERT INTO list_item VALUES ('V000000420', 'KLJ00171', 69, 61, 421000.00, 25681000.00);
INSERT INTO list_item VALUES ('V000000421', 'KLJ00172', 98, 32, 422000.00, 13504000.00);
INSERT INTO list_item VALUES ('V000000422', 'KLJ00173', 73, 76, 423000.00, 32148000.00);
INSERT INTO list_item VALUES ('V000000423', 'KLJ00174', 24, 79, 424000.00, 33496000.00);
INSERT INTO list_item VALUES ('V000000424', 'KLJ00175', 30, 91, 425000.00, 38675000.00);
INSERT INTO list_item VALUES ('V000000425', 'KLJ00176', 86, 36, 426000.00, 15336000.00);
INSERT INTO list_item VALUES ('V000000426', 'KLJ00177', 17, 40, 427000.00, 17080000.00);
INSERT INTO list_item VALUES ('V000000427', 'KLJ00178', 91, 43, 428000.00, 18404000.00);
INSERT INTO list_item VALUES ('V000000428', 'KLJ00179', 68, 81, 429000.00, 34749000.00);
INSERT INTO list_item VALUES ('V000000429', 'KLJ00180', 46, 8, 430000.00, 3440000.00);
INSERT INTO list_item VALUES ('V000000430', 'KLJ00181', 47, 28, 431000.00, 12068000.00);
INSERT INTO list_item VALUES ('V000000431', 'KLJ00182', 85, 7, 432000.00, 3024000.00);
INSERT INTO list_item VALUES ('V000000432', 'KLJ00183', 17, 57, 433000.00, 24681000.00);
INSERT INTO list_item VALUES ('V000000433', 'KLJ00184', 17, 23, 434000.00, 9982000.00);
INSERT INTO list_item VALUES ('V000000434', 'KLJ00185', 27, 95, 435000.00, 41325000.00);
INSERT INTO list_item VALUES ('V000000435', 'KLJ00186', 75, 19, 436000.00, 8284000.00);
INSERT INTO list_item VALUES ('V000000436', 'KLJ00187', 91, 86, 437000.00, 37582000.00);
INSERT INTO list_item VALUES ('V000000437', 'KLJ00188', 41, 66, 438000.00, 28908000.00);
INSERT INTO list_item VALUES ('V000000438', 'KLJ00189', 13, 89, 439000.00, 39071000.00);
INSERT INTO list_item VALUES ('V000000439', 'KLJ00190', 82, 17, 440000.00, 7480000.00);
INSERT INTO list_item VALUES ('V000000440', 'KLJ00191', 60, 27, 441000.00, 11907000.00);
INSERT INTO list_item VALUES ('V000000441', 'KLJ00192', 83, 68, 442000.00, 30056000.00);
INSERT INTO list_item VALUES ('V000000442', 'KLJ00193', 29, 38, 443000.00, 16834000.00);
INSERT INTO list_item VALUES ('V000000443', 'KLJ00194', 100, 63, 444000.00, 27972000.00);
INSERT INTO list_item VALUES ('V000000444', 'KLJ00195', 25, 86, 445000.00, 38270000.00);
INSERT INTO list_item VALUES ('V000000445', 'KLJ00196', 35, 93, 446000.00, 41478000.00);
INSERT INTO list_item VALUES ('V000000446', 'KLJ00197', 62, 92, 447000.00, 41124000.00);
INSERT INTO list_item VALUES ('V000000447', 'KLJ00198', 13, 16, 448000.00, 7168000.00);
INSERT INTO list_item VALUES ('V000000448', 'KLJ00199', 3, 42, 449000.00, 18858000.00);
INSERT INTO list_item VALUES ('V000000449', 'KLJ00200', 35, 6, 450000.00, 2700000.00);
INSERT INTO list_item VALUES ('V000000450', 'KLJ00201', 5, 65, 451000.00, 29315000.00);
INSERT INTO list_item VALUES ('V000000451', 'KLJ00202', 68, 80, 452000.00, 36160000.00);
INSERT INTO list_item VALUES ('V000000452', 'KLJ00203', 40, 76, 453000.00, 34428000.00);
INSERT INTO list_item VALUES ('V000000453', 'KLJ00204', 22, 15, 454000.00, 6810000.00);
INSERT INTO list_item VALUES ('V000000454', 'KLJ00205', 43, 97, 455000.00, 44135000.00);
INSERT INTO list_item VALUES ('V000000455', 'KLJ00206', 17, 52, 456000.00, 23712000.00);
INSERT INTO list_item VALUES ('V000000456', 'KLJ00207', 82, 37, 457000.00, 16909000.00);
INSERT INTO list_item VALUES ('V000000457', 'KLJ00208', 99, 67, 458000.00, 30686000.00);
INSERT INTO list_item VALUES ('V000000458', 'KLJ00209', 74, 50, 459000.00, 22950000.00);
INSERT INTO list_item VALUES ('V000000459', 'KLJ00210', 89, 68, 460000.00, 31280000.00);
INSERT INTO list_item VALUES ('V000000460', 'KLJ00211', 9, 72, 461000.00, 33192000.00);
INSERT INTO list_item VALUES ('V000000461', 'KLJ00212', 59, 47, 462000.00, 21714000.00);
INSERT INTO list_item VALUES ('V000000462', 'KLJ00213', 46, 49, 463000.00, 22687000.00);
INSERT INTO list_item VALUES ('V000000463', 'KLJ00214', 7, 84, 464000.00, 38976000.00);
INSERT INTO list_item VALUES ('V000000464', 'KLJ00215', 15, 54, 465000.00, 25110000.00);
INSERT INTO list_item VALUES ('V000000465', 'KLJ00216', 51, 27, 466000.00, 12582000.00);
INSERT INTO list_item VALUES ('V000000466', 'KLJ00217', 79, 12, 467000.00, 5604000.00);
INSERT INTO list_item VALUES ('V000000467', 'KLJ00218', 20, 100, 468000.00, 46800000.00);
INSERT INTO list_item VALUES ('V000000468', 'KLJ00219', 44, 58, 469000.00, 27202000.00);
INSERT INTO list_item VALUES ('V000000469', 'KLJ00220', 31, 18, 470000.00, 8460000.00);
INSERT INTO list_item VALUES ('V000000470', 'KLJ00221', 28, 3, 471000.00, 1413000.00);
INSERT INTO list_item VALUES ('V000000471', 'KLJ00222', 91, 94, 472000.00, 44368000.00);
INSERT INTO list_item VALUES ('V000000472', 'KLJ00223', 91, 38, 473000.00, 17974000.00);
INSERT INTO list_item VALUES ('V000000473', 'KLJ00224', 93, 18, 474000.00, 8532000.00);
INSERT INTO list_item VALUES ('V000000474', 'KLJ00225', 42, 32, 475000.00, 15200000.00);
INSERT INTO list_item VALUES ('V000000475', 'KLJ00226', 57, 7, 476000.00, 3332000.00);
INSERT INTO list_item VALUES ('V000000476', 'KLJ00227', 28, 3, 477000.00, 1431000.00);
INSERT INTO list_item VALUES ('V000000477', 'KLJ00228', 50, 85, 478000.00, 40630000.00);
INSERT INTO list_item VALUES ('V000000478', 'KLJ00229', 17, 72, 479000.00, 34488000.00);
INSERT INTO list_item VALUES ('V000000479', 'KLJ00230', 36, 65, 480000.00, 31200000.00);
INSERT INTO list_item VALUES ('V000000480', 'KLJ00231', 73, 79, 481000.00, 37999000.00);
INSERT INTO list_item VALUES ('V000000481', 'KLJ00232', 74, 98, 482000.00, 47236000.00);
INSERT INTO list_item VALUES ('V000000482', 'KLJ00233', 19, 48, 483000.00, 23184000.00);
INSERT INTO list_item VALUES ('V000000483', 'KLJ00234', 81, 11, 484000.00, 5324000.00);
INSERT INTO list_item VALUES ('V000000484', 'KLJ00235', 64, 65, 485000.00, 31525000.00);
INSERT INTO list_item VALUES ('V000000485', 'KLJ00236', 56, 21, 486000.00, 10206000.00);
INSERT INTO list_item VALUES ('V000000486', 'KLJ00237', 2, 34, 487000.00, 16558000.00);
INSERT INTO list_item VALUES ('V000000487', 'KLJ00238', 23, 66, 488000.00, 32208000.00);
INSERT INTO list_item VALUES ('V000000488', 'KLJ00239', 21, 97, 489000.00, 47433000.00);
INSERT INTO list_item VALUES ('V000000489', 'KLJ00240', 15, 32, 490000.00, 15680000.00);
INSERT INTO list_item VALUES ('V000000490', 'KLJ00241', 10, 19, 491000.00, 9329000.00);
INSERT INTO list_item VALUES ('V000000491', 'KLJ00242', 95, 11, 492000.00, 5412000.00);
INSERT INTO list_item VALUES ('V000000492', 'KLJ00243', 11, 73, 493000.00, 35989000.00);
INSERT INTO list_item VALUES ('V000000493', 'KLJ00244', 19, 27, 494000.00, 13338000.00);
INSERT INTO list_item VALUES ('V000000494', 'KLJ00245', 35, 57, 495000.00, 28215000.00);
INSERT INTO list_item VALUES ('V000000495', 'KLJ00246', 30, 39, 496000.00, 19344000.00);
INSERT INTO list_item VALUES ('V000000496', 'KLJ00247', 14, 23, 497000.00, 11431000.00);
INSERT INTO list_item VALUES ('V000000497', 'KLJ00248', 36, 57, 498000.00, 28386000.00);
INSERT INTO list_item VALUES ('V000000498', 'KLJ00249', 59, 31, 499000.00, 15469000.00);
INSERT INTO list_item VALUES ('V000000499', 'KLJ00250', 51, 49, 500000.00, 24500000.00);
INSERT INTO list_item VALUES ('V000000000', 'KLJ00249', 39, 15, 501000.00, 7515000.00);
INSERT INTO list_item VALUES ('V000000001', 'KLJ00250', 21, 100, 502000.00, 50200000.00);
INSERT INTO list_item VALUES ('V000000002', 'KLJ00002', 31, 72, 503000.00, 36216000.00);
INSERT INTO list_item VALUES ('V000000003', 'KLJ00003', 63, 46, 504000.00, 23184000.00);
INSERT INTO list_item VALUES ('V000000004', 'KLJ00004', 8, 43, 505000.00, 21715000.00);
INSERT INTO list_item VALUES ('V000000005', 'KLJ00005', 21, 94, 506000.00, 47564000.00);
INSERT INTO list_item VALUES ('V000000006', 'KLJ00006', 37, 40, 507000.00, 20280000.00);
INSERT INTO list_item VALUES ('V000000007', 'KLJ00007', 27, 35, 508000.00, 17780000.00);
INSERT INTO list_item VALUES ('V000000008', 'KLJ00008', 75, 29, 509000.00, 14761000.00);
INSERT INTO list_item VALUES ('V000000009', 'KLJ00009', 92, 87, 510000.00, 44370000.00);
INSERT INTO list_item VALUES ('V000000010', 'KLJ00010', 18, 31, 511000.00, 15841000.00);
INSERT INTO list_item VALUES ('V000000011', 'KLJ00011', 62, 37, 512000.00, 18944000.00);
INSERT INTO list_item VALUES ('V000000012', 'KLJ00012', 76, 15, 513000.00, 7695000.00);
INSERT INTO list_item VALUES ('V000000013', 'KLJ00013', 76, 50, 514000.00, 25700000.00);
INSERT INTO list_item VALUES ('V000000014', 'KLJ00014', 89, 39, 515000.00, 20085000.00);
INSERT INTO list_item VALUES ('V000000015', 'KLJ00015', 27, 22, 516000.00, 11352000.00);
INSERT INTO list_item VALUES ('V000000016', 'KLJ00016', 12, 53, 517000.00, 27401000.00);
INSERT INTO list_item VALUES ('V000000017', 'KLJ00017', 53, 13, 518000.00, 6734000.00);
INSERT INTO list_item VALUES ('V000000018', 'KLJ00018', 61, 25, 519000.00, 12975000.00);
INSERT INTO list_item VALUES ('V000000019', 'KLJ00019', 95, 82, 520000.00, 42640000.00);
INSERT INTO list_item VALUES ('V000000020', 'KLJ00020', 1, 52, 521000.00, 27092000.00);
INSERT INTO list_item VALUES ('V000000021', 'KLJ00021', 81, 27, 522000.00, 14094000.00);
INSERT INTO list_item VALUES ('V000000022', 'KLJ00022', 16, 69, 523000.00, 36087000.00);
INSERT INTO list_item VALUES ('V000000023', 'KLJ00023', 83, 85, 524000.00, 44540000.00);
INSERT INTO list_item VALUES ('V000000024', 'KLJ00024', 19, 72, 525000.00, 37800000.00);
INSERT INTO list_item VALUES ('V000000025', 'KLJ00025', 12, 6, 526000.00, 3156000.00);
INSERT INTO list_item VALUES ('V000000026', 'KLJ00026', 74, 30, 527000.00, 15810000.00);
INSERT INTO list_item VALUES ('V000000027', 'KLJ00027', 19, 93, 528000.00, 49104000.00);
INSERT INTO list_item VALUES ('V000000028', 'KLJ00028', 51, 1, 529000.00, 529000.00);
INSERT INTO list_item VALUES ('V000000029', 'KLJ00029', 87, 48, 530000.00, 25440000.00);
INSERT INTO list_item VALUES ('V000000030', 'KLJ00030', 80, 73, 531000.00, 38763000.00);
INSERT INTO list_item VALUES ('V000000031', 'KLJ00031', 29, 5, 532000.00, 2660000.00);
INSERT INTO list_item VALUES ('V000000032', 'KLJ00032', 47, 40, 533000.00, 21320000.00);
INSERT INTO list_item VALUES ('V000000033', 'KLJ00033', 55, 52, 534000.00, 27768000.00);
INSERT INTO list_item VALUES ('V000000034', 'KLJ00034', 81, 99, 535000.00, 52965000.00);
INSERT INTO list_item VALUES ('V000000035', 'KLJ00035', 64, 31, 536000.00, 16616000.00);
INSERT INTO list_item VALUES ('V000000036', 'KLJ00036', 95, 86, 537000.00, 46182000.00);
INSERT INTO list_item VALUES ('V000000037', 'KLJ00037', 17, 4, 538000.00, 2152000.00);
INSERT INTO list_item VALUES ('V000000038', 'KLJ00038', 14, 98, 539000.00, 52822000.00);
INSERT INTO list_item VALUES ('V000000039', 'KLJ00039', 19, 20, 540000.00, 10800000.00);
INSERT INTO list_item VALUES ('V000000040', 'KLJ00040', 96, 23, 541000.00, 12443000.00);
INSERT INTO list_item VALUES ('V000000041', 'KLJ00041', 19, 94, 542000.00, 50948000.00);
INSERT INTO list_item VALUES ('V000000042', 'KLJ00042', 95, 5, 543000.00, 2715000.00);
INSERT INTO list_item VALUES ('V000000043', 'KLJ00043', 51, 16, 544000.00, 8704000.00);
INSERT INTO list_item VALUES ('V000000044', 'KLJ00044', 61, 99, 545000.00, 53955000.00);
INSERT INTO list_item VALUES ('V000000045', 'KLJ00045', 71, 73, 546000.00, 39858000.00);
INSERT INTO list_item VALUES ('V000000046', 'KLJ00046', 88, 6, 547000.00, 3282000.00);
INSERT INTO list_item VALUES ('V000000047', 'KLJ00047', 52, 2, 548000.00, 1096000.00);
INSERT INTO list_item VALUES ('V000000048', 'KLJ00048', 41, 71, 549000.00, 38979000.00);
INSERT INTO list_item VALUES ('V000000049', 'KLJ00049', 49, 26, 550000.00, 14300000.00);
INSERT INTO list_item VALUES ('V000000050', 'KLJ00050', 53, 64, 551000.00, 35264000.00);
INSERT INTO list_item VALUES ('V000000051', 'KLJ00051', 62, 93, 552000.00, 51336000.00);
INSERT INTO list_item VALUES ('V000000052', 'KLJ00052', 18, 24, 553000.00, 13272000.00);
INSERT INTO list_item VALUES ('V000000053', 'KLJ00053', 51, 38, 554000.00, 21052000.00);
INSERT INTO list_item VALUES ('V000000054', 'KLJ00054', 25, 62, 555000.00, 34410000.00);
INSERT INTO list_item VALUES ('V000000055', 'KLJ00055', 46, 32, 556000.00, 17792000.00);
INSERT INTO list_item VALUES ('V000000056', 'KLJ00056', 6, 84, 557000.00, 46788000.00);
INSERT INTO list_item VALUES ('V000000057', 'KLJ00057', 56, 19, 558000.00, 10602000.00);
INSERT INTO list_item VALUES ('V000000058', 'KLJ00058', 1, 71, 559000.00, 39689000.00);
INSERT INTO list_item VALUES ('V000000059', 'KLJ00059', 86, 32, 560000.00, 17920000.00);
INSERT INTO list_item VALUES ('V000000060', 'KLJ00060', 5, 96, 561000.00, 53856000.00);
INSERT INTO list_item VALUES ('V000000061', 'KLJ00061', 10, 2, 562000.00, 1124000.00);
INSERT INTO list_item VALUES ('V000000062', 'KLJ00062', 58, 57, 563000.00, 32091000.00);
INSERT INTO list_item VALUES ('V000000063', 'KLJ00063', 61, 90, 564000.00, 50760000.00);
INSERT INTO list_item VALUES ('V000000064', 'KLJ00064', 7, 9, 565000.00, 5085000.00);
INSERT INTO list_item VALUES ('V000000065', 'KLJ00065', 82, 14, 566000.00, 7924000.00);
INSERT INTO list_item VALUES ('V000000066', 'KLJ00066', 83, 74, 567000.00, 41958000.00);
INSERT INTO list_item VALUES ('V000000067', 'KLJ00067', 11, 68, 568000.00, 38624000.00);
INSERT INTO list_item VALUES ('V000000068', 'KLJ00068', 31, 17, 569000.00, 9673000.00);
INSERT INTO list_item VALUES ('V000000069', 'KLJ00069', 80, 10, 570000.00, 5700000.00);
INSERT INTO list_item VALUES ('V000000070', 'KLJ00070', 39, 47, 571000.00, 26837000.00);
INSERT INTO list_item VALUES ('V000000071', 'KLJ00071', 6, 28, 572000.00, 16016000.00);
INSERT INTO list_item VALUES ('V000000072', 'KLJ00072', 75, 95, 573000.00, 54435000.00);
INSERT INTO list_item VALUES ('V000000073', 'KLJ00073', 61, 59, 574000.00, 33866000.00);
INSERT INTO list_item VALUES ('V000000074', 'KLJ00074', 62, 69, 575000.00, 39675000.00);
INSERT INTO list_item VALUES ('V000000075', 'KLJ00075', 92, 93, 576000.00, 53568000.00);
INSERT INTO list_item VALUES ('V000000076', 'KLJ00076', 15, 54, 577000.00, 31158000.00);
INSERT INTO list_item VALUES ('V000000077', 'KLJ00077', 66, 7, 578000.00, 4046000.00);
INSERT INTO list_item VALUES ('V000000078', 'KLJ00078', 70, 42, 579000.00, 24318000.00);
INSERT INTO list_item VALUES ('V000000079', 'KLJ00079', 10, 67, 580000.00, 38860000.00);
INSERT INTO list_item VALUES ('V000000080', 'KLJ00080', 41, 76, 581000.00, 44156000.00);
INSERT INTO list_item VALUES ('V000000081', 'KLJ00081', 47, 32, 582000.00, 18624000.00);
INSERT INTO list_item VALUES ('V000000082', 'KLJ00082', 22, 100, 583000.00, 58300000.00);
INSERT INTO list_item VALUES ('V000000083', 'KLJ00083', 44, 88, 584000.00, 51392000.00);
INSERT INTO list_item VALUES ('V000000084', 'KLJ00084', 50, 52, 585000.00, 30420000.00);
INSERT INTO list_item VALUES ('V000000085', 'KLJ00085', 30, 31, 586000.00, 18166000.00);
INSERT INTO list_item VALUES ('V000000086', 'KLJ00086', 83, 75, 587000.00, 44025000.00);
INSERT INTO list_item VALUES ('V000000087', 'KLJ00087', 67, 4, 588000.00, 2352000.00);
INSERT INTO list_item VALUES ('V000000088', 'KLJ00088', 100, 72, 589000.00, 42408000.00);
INSERT INTO list_item VALUES ('V000000089', 'KLJ00089', 85, 45, 590000.00, 26550000.00);
INSERT INTO list_item VALUES ('V000000090', 'KLJ00090', 86, 22, 591000.00, 13002000.00);
INSERT INTO list_item VALUES ('V000000091', 'KLJ00091', 95, 67, 592000.00, 39664000.00);
INSERT INTO list_item VALUES ('V000000092', 'KLJ00092', 96, 73, 593000.00, 43289000.00);
INSERT INTO list_item VALUES ('V000000093', 'KLJ00093', 90, 37, 594000.00, 21978000.00);
INSERT INTO list_item VALUES ('V000000094', 'KLJ00094', 87, 57, 595000.00, 33915000.00);
INSERT INTO list_item VALUES ('V000000095', 'KLJ00095', 61, 74, 596000.00, 44104000.00);
INSERT INTO list_item VALUES ('V000000096', 'KLJ00096', 92, 83, 597000.00, 49551000.00);
INSERT INTO list_item VALUES ('V000000097', 'KLJ00097', 35, 77, 598000.00, 46046000.00);
INSERT INTO list_item VALUES ('V000000098', 'KLJ00098', 26, 26, 599000.00, 15574000.00);
INSERT INTO list_item VALUES ('V000000099', 'KLJ00099', 96, 16, 600000.00, 9600000.00);
INSERT INTO list_item VALUES ('V000000100', 'KLJ00100', 14, 69, 601000.00, 41469000.00);
INSERT INTO list_item VALUES ('V000000101', 'KLJ00101', 27, 64, 602000.00, 38528000.00);
INSERT INTO list_item VALUES ('V000000102', 'KLJ00102', 16, 30, 603000.00, 18090000.00);
INSERT INTO list_item VALUES ('V000000103', 'KLJ00103', 18, 60, 604000.00, 36240000.00);
INSERT INTO list_item VALUES ('V000000104', 'KLJ00104', 58, 31, 605000.00, 18755000.00);
INSERT INTO list_item VALUES ('V000000105', 'KLJ00105', 79, 12, 606000.00, 7272000.00);
INSERT INTO list_item VALUES ('V000000106', 'KLJ00106', 57, 6, 607000.00, 3642000.00);
INSERT INTO list_item VALUES ('V000000107', 'KLJ00107', 62, 24, 608000.00, 14592000.00);
INSERT INTO list_item VALUES ('V000000108', 'KLJ00108', 13, 83, 609000.00, 50547000.00);
INSERT INTO list_item VALUES ('V000000109', 'KLJ00109', 47, 16, 610000.00, 9760000.00);
INSERT INTO list_item VALUES ('V000000110', 'KLJ00110', 23, 61, 611000.00, 37271000.00);
INSERT INTO list_item VALUES ('V000000111', 'KLJ00111', 63, 86, 612000.00, 52632000.00);
INSERT INTO list_item VALUES ('V000000112', 'KLJ00112', 71, 2, 613000.00, 1226000.00);
INSERT INTO list_item VALUES ('V000000113', 'KLJ00113', 30, 70, 614000.00, 42980000.00);
INSERT INTO list_item VALUES ('V000000114', 'KLJ00114', 24, 76, 615000.00, 46740000.00);
INSERT INTO list_item VALUES ('V000000115', 'KLJ00115', 47, 40, 616000.00, 24640000.00);
INSERT INTO list_item VALUES ('V000000116', 'KLJ00116', 78, 47, 617000.00, 28999000.00);
INSERT INTO list_item VALUES ('V000000117', 'KLJ00117', 41, 1, 618000.00, 618000.00);
INSERT INTO list_item VALUES ('V000000118', 'KLJ00118', 94, 99, 619000.00, 61281000.00);
INSERT INTO list_item VALUES ('V000000119', 'KLJ00119', 63, 24, 620000.00, 14880000.00);
INSERT INTO list_item VALUES ('V000000120', 'KLJ00120', 14, 98, 621000.00, 60858000.00);
INSERT INTO list_item VALUES ('V000000121', 'KLJ00121', 98, 66, 622000.00, 41052000.00);
INSERT INTO list_item VALUES ('V000000122', 'KLJ00122', 26, 74, 623000.00, 46102000.00);
INSERT INTO list_item VALUES ('V000000123', 'KLJ00123', 97, 69, 624000.00, 43056000.00);
INSERT INTO list_item VALUES ('V000000124', 'KLJ00124', 4, 2, 625000.00, 1250000.00);
INSERT INTO list_item VALUES ('V000000125', 'KLJ00125', 65, 35, 626000.00, 21910000.00);
INSERT INTO list_item VALUES ('V000000126', 'KLJ00126', 63, 7, 627000.00, 4389000.00);
INSERT INTO list_item VALUES ('V000000127', 'KLJ00127', 29, 4, 628000.00, 2512000.00);
INSERT INTO list_item VALUES ('V000000128', 'KLJ00128', 28, 36, 629000.00, 22644000.00);
INSERT INTO list_item VALUES ('V000000129', 'KLJ00129', 69, 56, 630000.00, 35280000.00);
INSERT INTO list_item VALUES ('V000000130', 'KLJ00130', 24, 25, 631000.00, 15775000.00);
INSERT INTO list_item VALUES ('V000000131', 'KLJ00131', 83, 13, 632000.00, 8216000.00);
INSERT INTO list_item VALUES ('V000000132', 'KLJ00132', 86, 14, 633000.00, 8862000.00);
INSERT INTO list_item VALUES ('V000000133', 'KLJ00133', 47, 33, 634000.00, 20922000.00);
INSERT INTO list_item VALUES ('V000000134', 'KLJ00134', 22, 89, 635000.00, 56515000.00);
INSERT INTO list_item VALUES ('V000000135', 'KLJ00135', 31, 28, 636000.00, 17808000.00);
INSERT INTO list_item VALUES ('V000000136', 'KLJ00136', 72, 24, 637000.00, 15288000.00);
INSERT INTO list_item VALUES ('V000000137', 'KLJ00137', 99, 2, 638000.00, 1276000.00);
INSERT INTO list_item VALUES ('V000000138', 'KLJ00138', 15, 92, 639000.00, 58788000.00);
INSERT INTO list_item VALUES ('V000000139', 'KLJ00139', 97, 53, 640000.00, 33920000.00);
INSERT INTO list_item VALUES ('V000000140', 'KLJ00140', 48, 32, 641000.00, 20512000.00);
INSERT INTO list_item VALUES ('V000000141', 'KLJ00141', 3, 15, 642000.00, 9630000.00);
INSERT INTO list_item VALUES ('V000000142', 'KLJ00142', 78, 31, 643000.00, 19933000.00);
INSERT INTO list_item VALUES ('V000000143', 'KLJ00143', 14, 2, 644000.00, 1288000.00);
INSERT INTO list_item VALUES ('V000000144', 'KLJ00144', 76, 92, 645000.00, 59340000.00);
INSERT INTO list_item VALUES ('V000000145', 'KLJ00145', 86, 28, 646000.00, 18088000.00);
INSERT INTO list_item VALUES ('V000000146', 'KLJ00146', 15, 67, 647000.00, 43349000.00);
INSERT INTO list_item VALUES ('V000000147', 'KLJ00147', 91, 76, 648000.00, 49248000.00);
INSERT INTO list_item VALUES ('V000000148', 'KLJ00148', 22, 14, 649000.00, 9086000.00);
INSERT INTO list_item VALUES ('V000000149', 'KLJ00149', 34, 37, 650000.00, 24050000.00);
INSERT INTO list_item VALUES ('V000000150', 'KLJ00150', 94, 16, 651000.00, 10416000.00);
INSERT INTO list_item VALUES ('V000000151', 'KLJ00151', 60, 68, 652000.00, 44336000.00);
INSERT INTO list_item VALUES ('V000000152', 'KLJ00152', 96, 38, 653000.00, 24814000.00);
INSERT INTO list_item VALUES ('V000000153', 'KLJ00153', 72, 96, 654000.00, 62784000.00);
INSERT INTO list_item VALUES ('V000000154', 'KLJ00154', 27, 17, 655000.00, 11135000.00);
INSERT INTO list_item VALUES ('V000000155', 'KLJ00155', 91, 52, 656000.00, 34112000.00);
INSERT INTO list_item VALUES ('V000000156', 'KLJ00156', 77, 34, 657000.00, 22338000.00);
INSERT INTO list_item VALUES ('V000000157', 'KLJ00157', 79, 74, 658000.00, 48692000.00);
INSERT INTO list_item VALUES ('V000000158', 'KLJ00158', 71, 8, 659000.00, 5272000.00);
INSERT INTO list_item VALUES ('V000000159', 'KLJ00159', 87, 8, 660000.00, 5280000.00);
INSERT INTO list_item VALUES ('V000000160', 'KLJ00160', 36, 16, 661000.00, 10576000.00);
INSERT INTO list_item VALUES ('V000000161', 'KLJ00161', 31, 76, 662000.00, 50312000.00);
INSERT INTO list_item VALUES ('V000000162', 'KLJ00162', 83, 42, 663000.00, 27846000.00);
INSERT INTO list_item VALUES ('V000000163', 'KLJ00163', 20, 18, 664000.00, 11952000.00);
INSERT INTO list_item VALUES ('V000000164', 'KLJ00164', 87, 2, 665000.00, 1330000.00);
INSERT INTO list_item VALUES ('V000000165', 'KLJ00165', 86, 15, 666000.00, 9990000.00);
INSERT INTO list_item VALUES ('V000000166', 'KLJ00166', 68, 80, 667000.00, 53360000.00);
INSERT INTO list_item VALUES ('V000000167', 'KLJ00167', 88, 100, 668000.00, 66800000.00);
INSERT INTO list_item VALUES ('V000000168', 'KLJ00168', 87, 84, 669000.00, 56196000.00);
INSERT INTO list_item VALUES ('V000000169', 'KLJ00169', 73, 6, 670000.00, 4020000.00);
INSERT INTO list_item VALUES ('V000000170', 'KLJ00170', 16, 13, 671000.00, 8723000.00);
INSERT INTO list_item VALUES ('V000000171', 'KLJ00171', 82, 68, 672000.00, 45696000.00);
INSERT INTO list_item VALUES ('V000000172', 'KLJ00172', 37, 73, 673000.00, 49129000.00);
INSERT INTO list_item VALUES ('V000000173', 'KLJ00173', 14, 34, 674000.00, 22916000.00);
INSERT INTO list_item VALUES ('V000000174', 'KLJ00174', 72, 29, 675000.00, 19575000.00);
INSERT INTO list_item VALUES ('V000000175', 'KLJ00175', 64, 15, 676000.00, 10140000.00);
INSERT INTO list_item VALUES ('V000000176', 'KLJ00176', 33, 61, 677000.00, 41297000.00);
INSERT INTO list_item VALUES ('V000000177', 'KLJ00177', 3, 19, 678000.00, 12882000.00);
INSERT INTO list_item VALUES ('V000000178', 'KLJ00178', 4, 93, 679000.00, 63147000.00);
INSERT INTO list_item VALUES ('V000000179', 'KLJ00179', 1, 42, 680000.00, 28560000.00);
INSERT INTO list_item VALUES ('V000000180', 'KLJ00180', 1, 80, 681000.00, 54480000.00);
INSERT INTO list_item VALUES ('V000000181', 'KLJ00181', 7, 72, 682000.00, 49104000.00);
INSERT INTO list_item VALUES ('V000000182', 'KLJ00182', 43, 79, 683000.00, 53957000.00);
INSERT INTO list_item VALUES ('V000000183', 'KLJ00183', 91, 52, 684000.00, 35568000.00);
INSERT INTO list_item VALUES ('V000000184', 'KLJ00184', 91, 74, 685000.00, 50690000.00);
INSERT INTO list_item VALUES ('V000000185', 'KLJ00185', 49, 49, 686000.00, 33614000.00);
INSERT INTO list_item VALUES ('V000000186', 'KLJ00186', 5, 57, 687000.00, 39159000.00);
INSERT INTO list_item VALUES ('V000000187', 'KLJ00187', 68, 10, 688000.00, 6880000.00);
INSERT INTO list_item VALUES ('V000000188', 'KLJ00188', 91, 42, 689000.00, 28938000.00);
INSERT INTO list_item VALUES ('V000000189', 'KLJ00189', 2, 82, 690000.00, 56580000.00);
INSERT INTO list_item VALUES ('V000000190', 'KLJ00190', 100, 72, 691000.00, 49752000.00);
INSERT INTO list_item VALUES ('V000000191', 'KLJ00191', 93, 97, 692000.00, 67124000.00);
INSERT INTO list_item VALUES ('V000000192', 'KLJ00192', 70, 79, 693000.00, 54747000.00);
INSERT INTO list_item VALUES ('V000000193', 'KLJ00193', 90, 88, 694000.00, 61072000.00);
INSERT INTO list_item VALUES ('V000000194', 'KLJ00194', 30, 82, 695000.00, 56990000.00);
INSERT INTO list_item VALUES ('V000000195', 'KLJ00195', 96, 60, 696000.00, 41760000.00);
INSERT INTO list_item VALUES ('V000000196', 'KLJ00196', 11, 23, 697000.00, 16031000.00);
INSERT INTO list_item VALUES ('V000000197', 'KLJ00197', 63, 15, 698000.00, 10470000.00);
INSERT INTO list_item VALUES ('V000000198', 'KLJ00198', 16, 72, 699000.00, 50328000.00);
INSERT INTO list_item VALUES ('V000000199', 'KLJ00199', 96, 10, 700000.00, 7000000.00);
INSERT INTO list_item VALUES ('V000000200', 'KLJ00200', 100, 91, 701000.00, 63791000.00);
INSERT INTO list_item VALUES ('V000000201', 'KLJ00201', 89, 90, 702000.00, 63180000.00);
INSERT INTO list_item VALUES ('V000000202', 'KLJ00202', 2, 55, 703000.00, 38665000.00);
INSERT INTO list_item VALUES ('V000000203', 'KLJ00203', 5, 91, 704000.00, 64064000.00);
INSERT INTO list_item VALUES ('V000000204', 'KLJ00204', 62, 50, 705000.00, 35250000.00);
INSERT INTO list_item VALUES ('V000000205', 'KLJ00205', 1, 51, 706000.00, 36006000.00);
INSERT INTO list_item VALUES ('V000000206', 'KLJ00206', 17, 11, 707000.00, 7777000.00);
INSERT INTO list_item VALUES ('V000000207', 'KLJ00207', 68, 44, 708000.00, 31152000.00);
INSERT INTO list_item VALUES ('V000000208', 'KLJ00208', 7, 25, 709000.00, 17725000.00);
INSERT INTO list_item VALUES ('V000000209', 'KLJ00209', 83, 68, 710000.00, 48280000.00);
INSERT INTO list_item VALUES ('V000000210', 'KLJ00210', 49, 41, 711000.00, 29151000.00);
INSERT INTO list_item VALUES ('V000000211', 'KLJ00211', 53, 41, 712000.00, 29192000.00);
INSERT INTO list_item VALUES ('V000000212', 'KLJ00212', 32, 31, 713000.00, 22103000.00);
INSERT INTO list_item VALUES ('V000000213', 'KLJ00213', 77, 78, 714000.00, 55692000.00);
INSERT INTO list_item VALUES ('V000000214', 'KLJ00214', 98, 93, 715000.00, 66495000.00);
INSERT INTO list_item VALUES ('V000000215', 'KLJ00215', 89, 64, 716000.00, 45824000.00);
INSERT INTO list_item VALUES ('V000000216', 'KLJ00216', 64, 27, 717000.00, 19359000.00);
INSERT INTO list_item VALUES ('V000000217', 'KLJ00217', 3, 32, 718000.00, 22976000.00);
INSERT INTO list_item VALUES ('V000000218', 'KLJ00218', 89, 45, 719000.00, 32355000.00);
INSERT INTO list_item VALUES ('V000000219', 'KLJ00219', 64, 29, 720000.00, 20880000.00);
INSERT INTO list_item VALUES ('V000000220', 'KLJ00220', 60, 28, 721000.00, 20188000.00);
INSERT INTO list_item VALUES ('V000000221', 'KLJ00221', 55, 99, 722000.00, 71478000.00);
INSERT INTO list_item VALUES ('V000000222', 'KLJ00222', 31, 46, 723000.00, 33258000.00);
INSERT INTO list_item VALUES ('V000000223', 'KLJ00223', 8, 57, 724000.00, 41268000.00);
INSERT INTO list_item VALUES ('V000000224', 'KLJ00224', 22, 26, 725000.00, 18850000.00);
INSERT INTO list_item VALUES ('V000000225', 'KLJ00225', 50, 74, 726000.00, 53724000.00);
INSERT INTO list_item VALUES ('V000000226', 'KLJ00226', 79, 70, 727000.00, 50890000.00);
INSERT INTO list_item VALUES ('V000000227', 'KLJ00227', 52, 46, 728000.00, 33488000.00);
INSERT INTO list_item VALUES ('V000000228', 'KLJ00228', 27, 97, 729000.00, 70713000.00);
INSERT INTO list_item VALUES ('V000000229', 'KLJ00229', 36, 94, 730000.00, 68620000.00);
INSERT INTO list_item VALUES ('V000000230', 'KLJ00230', 53, 47, 731000.00, 34357000.00);
INSERT INTO list_item VALUES ('V000000231', 'KLJ00231', 82, 12, 732000.00, 8784000.00);
INSERT INTO list_item VALUES ('V000000232', 'KLJ00232', 37, 11, 733000.00, 8063000.00);
INSERT INTO list_item VALUES ('V000000233', 'KLJ00233', 34, 59, 734000.00, 43306000.00);
INSERT INTO list_item VALUES ('V000000234', 'KLJ00234', 37, 64, 735000.00, 47040000.00);
INSERT INTO list_item VALUES ('V000000235', 'KLJ00235', 69, 43, 736000.00, 31648000.00);
INSERT INTO list_item VALUES ('V000000236', 'KLJ00236', 79, 51, 737000.00, 37587000.00);
INSERT INTO list_item VALUES ('V000000237', 'KLJ00237', 91, 36, 738000.00, 26568000.00);
INSERT INTO list_item VALUES ('V000000238', 'KLJ00238', 84, 87, 739000.00, 64293000.00);
INSERT INTO list_item VALUES ('V000000239', 'KLJ00239', 56, 67, 740000.00, 49580000.00);
INSERT INTO list_item VALUES ('V000000240', 'KLJ00240', 89, 7, 741000.00, 5187000.00);
INSERT INTO list_item VALUES ('V000000241', 'KLJ00241', 3, 69, 742000.00, 51198000.00);
INSERT INTO list_item VALUES ('V000000242', 'KLJ00242', 63, 26, 743000.00, 19318000.00);
INSERT INTO list_item VALUES ('V000000243', 'KLJ00243', 77, 52, 744000.00, 38688000.00);
INSERT INTO list_item VALUES ('V000000244', 'KLJ00244', 77, 29, 745000.00, 21605000.00);
INSERT INTO list_item VALUES ('V000000245', 'KLJ00245', 6, 42, 746000.00, 31332000.00);
INSERT INTO list_item VALUES ('V000000246', 'KLJ00246', 94, 100, 747000.00, 74700000.00);
INSERT INTO list_item VALUES ('V000000247', 'KLJ00247', 100, 18, 748000.00, 13464000.00);
INSERT INTO list_item VALUES ('V000000248', 'KLJ00248', 4, 80, 749000.00, 59920000.00);
INSERT INTO list_item VALUES ('V000000249', 'KLJ00249', 40, 38, 750000.00, 28500000.00);
INSERT INTO list_item VALUES ('V000000250', 'KLJ00250', 57, 32, 751000.00, 24032000.00);
INSERT INTO list_item VALUES ('V000000251', 'KLJ00001', 79, 6, 752000.00, 4512000.00);
INSERT INTO list_item VALUES ('V000000252', 'KLJ00002', 54, 90, 753000.00, 67770000.00);
INSERT INTO list_item VALUES ('V000000253', 'KLJ00003', 39, 30, 754000.00, 22620000.00);
INSERT INTO list_item VALUES ('V000000254', 'KLJ00004', 7, 20, 755000.00, 15100000.00);
INSERT INTO list_item VALUES ('V000000255', 'KLJ00005', 78, 43, 756000.00, 32508000.00);
INSERT INTO list_item VALUES ('V000000256', 'KLJ00006', 42, 34, 757000.00, 25738000.00);
INSERT INTO list_item VALUES ('V000000257', 'KLJ00007', 8, 10, 758000.00, 7580000.00);
INSERT INTO list_item VALUES ('V000000258', 'KLJ00008', 43, 96, 759000.00, 72864000.00);
INSERT INTO list_item VALUES ('V000000259', 'KLJ00009', 72, 52, 760000.00, 39520000.00);
INSERT INTO list_item VALUES ('V000000260', 'KLJ00010', 43, 34, 761000.00, 25874000.00);
INSERT INTO list_item VALUES ('V000000261', 'KLJ00011', 73, 10, 762000.00, 7620000.00);
INSERT INTO list_item VALUES ('V000000262', 'KLJ00012', 32, 80, 763000.00, 61040000.00);
INSERT INTO list_item VALUES ('V000000263', 'KLJ00013', 92, 88, 764000.00, 67232000.00);
INSERT INTO list_item VALUES ('V000000264', 'KLJ00014', 35, 36, 765000.00, 27540000.00);
INSERT INTO list_item VALUES ('V000000265', 'KLJ00015', 15, 23, 766000.00, 17618000.00);
INSERT INTO list_item VALUES ('V000000266', 'KLJ00016', 79, 7, 767000.00, 5369000.00);
INSERT INTO list_item VALUES ('V000000267', 'KLJ00017', 71, 1, 768000.00, 768000.00);
INSERT INTO list_item VALUES ('V000000268', 'KLJ00018', 87, 44, 769000.00, 33836000.00);
INSERT INTO list_item VALUES ('V000000269', 'KLJ00019', 22, 86, 770000.00, 66220000.00);
INSERT INTO list_item VALUES ('V000000270', 'KLJ00020', 84, 50, 771000.00, 38550000.00);
INSERT INTO list_item VALUES ('V000000271', 'KLJ00021', 60, 50, 772000.00, 38600000.00);
INSERT INTO list_item VALUES ('V000000272', 'KLJ00022', 44, 19, 773000.00, 14687000.00);
INSERT INTO list_item VALUES ('V000000273', 'KLJ00023', 12, 15, 774000.00, 11610000.00);
INSERT INTO list_item VALUES ('V000000274', 'KLJ00024', 41, 18, 775000.00, 13950000.00);
INSERT INTO list_item VALUES ('V000000275', 'KLJ00025', 8, 91, 776000.00, 70616000.00);
INSERT INTO list_item VALUES ('V000000276', 'KLJ00026', 97, 92, 777000.00, 71484000.00);
INSERT INTO list_item VALUES ('V000000277', 'KLJ00027', 8, 73, 778000.00, 56794000.00);
INSERT INTO list_item VALUES ('V000000278', 'KLJ00028', 18, 74, 779000.00, 57646000.00);
INSERT INTO list_item VALUES ('V000000279', 'KLJ00029', 25, 90, 780000.00, 70200000.00);
INSERT INTO list_item VALUES ('V000000280', 'KLJ00030', 78, 30, 781000.00, 23430000.00);
INSERT INTO list_item VALUES ('V000000281', 'KLJ00031', 48, 3, 782000.00, 2346000.00);
INSERT INTO list_item VALUES ('V000000282', 'KLJ00032', 21, 85, 783000.00, 66555000.00);
INSERT INTO list_item VALUES ('V000000283', 'KLJ00033', 5, 50, 784000.00, 39200000.00);
INSERT INTO list_item VALUES ('V000000284', 'KLJ00034', 1, 91, 785000.00, 71435000.00);
INSERT INTO list_item VALUES ('V000000285', 'KLJ00035', 29, 85, 786000.00, 66810000.00);
INSERT INTO list_item VALUES ('V000000286', 'KLJ00036', 45, 26, 787000.00, 20462000.00);
INSERT INTO list_item VALUES ('V000000287', 'KLJ00037', 30, 11, 788000.00, 8668000.00);
INSERT INTO list_item VALUES ('V000000288', 'KLJ00038', 55, 47, 789000.00, 37083000.00);
INSERT INTO list_item VALUES ('V000000289', 'KLJ00039', 4, 41, 790000.00, 32390000.00);
INSERT INTO list_item VALUES ('V000000290', 'KLJ00040', 20, 53, 791000.00, 41923000.00);
INSERT INTO list_item VALUES ('V000000291', 'KLJ00041', 87, 7, 792000.00, 5544000.00);
INSERT INTO list_item VALUES ('V000000292', 'KLJ00042', 68, 82, 793000.00, 65026000.00);
INSERT INTO list_item VALUES ('V000000293', 'KLJ00043', 38, 29, 794000.00, 23026000.00);
INSERT INTO list_item VALUES ('V000000294', 'KLJ00044', 42, 23, 795000.00, 18285000.00);
INSERT INTO list_item VALUES ('V000000295', 'KLJ00045', 98, 49, 796000.00, 39004000.00);
INSERT INTO list_item VALUES ('V000000296', 'KLJ00046', 95, 77, 797000.00, 61369000.00);
INSERT INTO list_item VALUES ('V000000297', 'KLJ00047', 24, 54, 798000.00, 43092000.00);
INSERT INTO list_item VALUES ('V000000298', 'KLJ00048', 18, 19, 799000.00, 15181000.00);
INSERT INTO list_item VALUES ('V000000299', 'KLJ00049', 84, 9, 800000.00, 7200000.00);
INSERT INTO list_item VALUES ('V000000300', 'KLJ00050', 9, 19, 801000.00, 15219000.00);
INSERT INTO list_item VALUES ('V000000301', 'KLJ00051', 43, 89, 802000.00, 71378000.00);
INSERT INTO list_item VALUES ('V000000302', 'KLJ00052', 23, 20, 803000.00, 16060000.00);
INSERT INTO list_item VALUES ('V000000303', 'KLJ00053', 88, 38, 804000.00, 30552000.00);
INSERT INTO list_item VALUES ('V000000304', 'KLJ00054', 87, 55, 805000.00, 44275000.00);
INSERT INTO list_item VALUES ('V000000305', 'KLJ00055', 100, 70, 806000.00, 56420000.00);
INSERT INTO list_item VALUES ('V000000306', 'KLJ00056', 85, 85, 807000.00, 68595000.00);
INSERT INTO list_item VALUES ('V000000307', 'KLJ00057', 61, 23, 808000.00, 18584000.00);
INSERT INTO list_item VALUES ('V000000308', 'KLJ00058', 95, 37, 809000.00, 29933000.00);
INSERT INTO list_item VALUES ('V000000309', 'KLJ00059', 20, 33, 810000.00, 26730000.00);
INSERT INTO list_item VALUES ('V000000310', 'KLJ00060', 80, 21, 811000.00, 17031000.00);
INSERT INTO list_item VALUES ('V000000311', 'KLJ00061', 88, 97, 812000.00, 78764000.00);
INSERT INTO list_item VALUES ('V000000312', 'KLJ00062', 36, 86, 813000.00, 69918000.00);
INSERT INTO list_item VALUES ('V000000313', 'KLJ00063', 93, 33, 814000.00, 26862000.00);
INSERT INTO list_item VALUES ('V000000314', 'KLJ00064', 75, 15, 815000.00, 12225000.00);
INSERT INTO list_item VALUES ('V000000315', 'KLJ00065', 87, 63, 816000.00, 51408000.00);
INSERT INTO list_item VALUES ('V000000316', 'KLJ00066', 44, 28, 817000.00, 22876000.00);
INSERT INTO list_item VALUES ('V000000317', 'KLJ00067', 28, 59, 818000.00, 48262000.00);
INSERT INTO list_item VALUES ('V000000318', 'KLJ00068', 13, 61, 819000.00, 49959000.00);
INSERT INTO list_item VALUES ('V000000319', 'KLJ00069', 3, 38, 820000.00, 31160000.00);
INSERT INTO list_item VALUES ('V000000320', 'KLJ00070', 33, 42, 821000.00, 34482000.00);
INSERT INTO list_item VALUES ('V000000321', 'KLJ00071', 80, 79, 822000.00, 64938000.00);
INSERT INTO list_item VALUES ('V000000322', 'KLJ00072', 54, 58, 823000.00, 47734000.00);
INSERT INTO list_item VALUES ('V000000323', 'KLJ00073', 57, 62, 824000.00, 51088000.00);
INSERT INTO list_item VALUES ('V000000324', 'KLJ00074', 45, 64, 825000.00, 52800000.00);
INSERT INTO list_item VALUES ('V000000325', 'KLJ00075', 47, 51, 826000.00, 42126000.00);
INSERT INTO list_item VALUES ('V000000326', 'KLJ00076', 49, 58, 827000.00, 47966000.00);
INSERT INTO list_item VALUES ('V000000327', 'KLJ00077', 49, 85, 828000.00, 70380000.00);
INSERT INTO list_item VALUES ('V000000328', 'KLJ00078', 80, 67, 829000.00, 55543000.00);
INSERT INTO list_item VALUES ('V000000329', 'KLJ00079', 23, 51, 830000.00, 42330000.00);
INSERT INTO list_item VALUES ('V000000330', 'KLJ00080', 18, 63, 831000.00, 52353000.00);
INSERT INTO list_item VALUES ('V000000331', 'KLJ00081', 62, 23, 832000.00, 19136000.00);
INSERT INTO list_item VALUES ('V000000332', 'KLJ00082', 20, 80, 833000.00, 66640000.00);
INSERT INTO list_item VALUES ('V000000333', 'KLJ00083', 93, 81, 834000.00, 67554000.00);
INSERT INTO list_item VALUES ('V000000334', 'KLJ00084', 69, 51, 835000.00, 42585000.00);
INSERT INTO list_item VALUES ('V000000335', 'KLJ00085', 21, 31, 836000.00, 25916000.00);
INSERT INTO list_item VALUES ('V000000336', 'KLJ00086', 23, 18, 837000.00, 15066000.00);
INSERT INTO list_item VALUES ('V000000337', 'KLJ00087', 63, 90, 838000.00, 75420000.00);
INSERT INTO list_item VALUES ('V000000338', 'KLJ00088', 74, 58, 839000.00, 48662000.00);
INSERT INTO list_item VALUES ('V000000339', 'KLJ00089', 96, 45, 840000.00, 37800000.00);
INSERT INTO list_item VALUES ('V000000340', 'KLJ00090', 96, 40, 841000.00, 33640000.00);
INSERT INTO list_item VALUES ('V000000341', 'KLJ00091', 2, 16, 842000.00, 13472000.00);
INSERT INTO list_item VALUES ('V000000342', 'KLJ00092', 100, 58, 843000.00, 48894000.00);
INSERT INTO list_item VALUES ('V000000343', 'KLJ00093', 68, 62, 844000.00, 52328000.00);
INSERT INTO list_item VALUES ('V000000344', 'KLJ00094', 91, 29, 845000.00, 24505000.00);
INSERT INTO list_item VALUES ('V000000345', 'KLJ00095', 70, 21, 846000.00, 17766000.00);
INSERT INTO list_item VALUES ('V000000346', 'KLJ00096', 66, 28, 847000.00, 23716000.00);
INSERT INTO list_item VALUES ('V000000347', 'KLJ00097', 18, 77, 848000.00, 65296000.00);
INSERT INTO list_item VALUES ('V000000348', 'KLJ00098', 25, 35, 849000.00, 29715000.00);
INSERT INTO list_item VALUES ('V000000349', 'KLJ00099', 95, 91, 850000.00, 77350000.00);
INSERT INTO list_item VALUES ('V000000350', 'KLJ00100', 13, 11, 851000.00, 9361000.00);
INSERT INTO list_item VALUES ('V000000351', 'KLJ00101', 26, 35, 852000.00, 29820000.00);
INSERT INTO list_item VALUES ('V000000352', 'KLJ00102', 58, 27, 853000.00, 23031000.00);
INSERT INTO list_item VALUES ('V000000353', 'KLJ00103', 40, 9, 854000.00, 7686000.00);
INSERT INTO list_item VALUES ('V000000354', 'KLJ00104', 20, 86, 855000.00, 73530000.00);
INSERT INTO list_item VALUES ('V000000355', 'KLJ00105', 87, 29, 856000.00, 24824000.00);
INSERT INTO list_item VALUES ('V000000356', 'KLJ00106', 21, 44, 857000.00, 37708000.00);
INSERT INTO list_item VALUES ('V000000357', 'KLJ00107', 50, 83, 858000.00, 71214000.00);
INSERT INTO list_item VALUES ('V000000358', 'KLJ00108', 12, 95, 859000.00, 81605000.00);
INSERT INTO list_item VALUES ('V000000359', 'KLJ00109', 66, 33, 860000.00, 28380000.00);
INSERT INTO list_item VALUES ('V000000360', 'KLJ00110', 43, 70, 861000.00, 60270000.00);
INSERT INTO list_item VALUES ('V000000361', 'KLJ00111', 1, 41, 862000.00, 35342000.00);
INSERT INTO list_item VALUES ('V000000362', 'KLJ00112', 62, 77, 863000.00, 66451000.00);
INSERT INTO list_item VALUES ('V000000363', 'KLJ00113', 98, 91, 864000.00, 78624000.00);
INSERT INTO list_item VALUES ('V000000364', 'KLJ00114', 1, 75, 865000.00, 64875000.00);
INSERT INTO list_item VALUES ('V000000365', 'KLJ00115', 98, 19, 866000.00, 16454000.00);
INSERT INTO list_item VALUES ('V000000366', 'KLJ00116', 77, 69, 867000.00, 59823000.00);
INSERT INTO list_item VALUES ('V000000367', 'KLJ00117', 81, 69, 868000.00, 59892000.00);
INSERT INTO list_item VALUES ('V000000368', 'KLJ00118', 94, 45, 869000.00, 39105000.00);
INSERT INTO list_item VALUES ('V000000369', 'KLJ00119', 5, 92, 870000.00, 80040000.00);
INSERT INTO list_item VALUES ('V000000370', 'KLJ00120', 69, 41, 871000.00, 35711000.00);
INSERT INTO list_item VALUES ('V000000371', 'KLJ00121', 87, 20, 872000.00, 17440000.00);
INSERT INTO list_item VALUES ('V000000372', 'KLJ00122', 70, 44, 873000.00, 38412000.00);
INSERT INTO list_item VALUES ('V000000373', 'KLJ00123', 35, 83, 874000.00, 72542000.00);
INSERT INTO list_item VALUES ('V000000374', 'KLJ00124', 4, 29, 875000.00, 25375000.00);
INSERT INTO list_item VALUES ('V000000375', 'KLJ00125', 5, 59, 876000.00, 51684000.00);
INSERT INTO list_item VALUES ('V000000376', 'KLJ00126', 82, 37, 877000.00, 32449000.00);
INSERT INTO list_item VALUES ('V000000377', 'KLJ00127', 46, 98, 878000.00, 86044000.00);
INSERT INTO list_item VALUES ('V000000378', 'KLJ00128', 79, 70, 879000.00, 61530000.00);
INSERT INTO list_item VALUES ('V000000379', 'KLJ00129', 38, 71, 880000.00, 62480000.00);
INSERT INTO list_item VALUES ('V000000380', 'KLJ00130', 24, 83, 881000.00, 73123000.00);
INSERT INTO list_item VALUES ('V000000381', 'KLJ00131', 65, 86, 882000.00, 75852000.00);
INSERT INTO list_item VALUES ('V000000382', 'KLJ00132', 91, 63, 883000.00, 55629000.00);
INSERT INTO list_item VALUES ('V000000383', 'KLJ00133', 15, 24, 884000.00, 21216000.00);
INSERT INTO list_item VALUES ('V000000384', 'KLJ00134', 96, 98, 885000.00, 86730000.00);
INSERT INTO list_item VALUES ('V000000385', 'KLJ00135', 94, 57, 886000.00, 50502000.00);
INSERT INTO list_item VALUES ('V000000386', 'KLJ00136', 70, 25, 887000.00, 22175000.00);
INSERT INTO list_item VALUES ('V000000387', 'KLJ00137', 52, 14, 888000.00, 12432000.00);
INSERT INTO list_item VALUES ('V000000388', 'KLJ00138', 45, 45, 889000.00, 40005000.00);
INSERT INTO list_item VALUES ('V000000389', 'KLJ00139', 61, 30, 890000.00, 26700000.00);
INSERT INTO list_item VALUES ('V000000390', 'KLJ00140', 27, 71, 891000.00, 63261000.00);
INSERT INTO list_item VALUES ('V000000391', 'KLJ00141', 15, 100, 892000.00, 89200000.00);
INSERT INTO list_item VALUES ('V000000392', 'KLJ00142', 7, 33, 893000.00, 29469000.00);
INSERT INTO list_item VALUES ('V000000393', 'KLJ00143', 63, 48, 894000.00, 42912000.00);
INSERT INTO list_item VALUES ('V000000394', 'KLJ00144', 26, 95, 895000.00, 85025000.00);
INSERT INTO list_item VALUES ('V000000395', 'KLJ00145', 86, 67, 896000.00, 60032000.00);
INSERT INTO list_item VALUES ('V000000396', 'KLJ00146', 16, 85, 897000.00, 76245000.00);
INSERT INTO list_item VALUES ('V000000397', 'KLJ00147', 26, 64, 898000.00, 57472000.00);
INSERT INTO list_item VALUES ('V000000398', 'KLJ00148', 49, 46, 899000.00, 41354000.00);
INSERT INTO list_item VALUES ('V000000399', 'KLJ00149', 90, 91, 900000.00, 81900000.00);
INSERT INTO list_item VALUES ('V000000400', 'KLJ00150', 50, 85, 901000.00, 76585000.00);
INSERT INTO list_item VALUES ('V000000401', 'KLJ00151', 83, 94, 902000.00, 84788000.00);
INSERT INTO list_item VALUES ('V000000402', 'KLJ00152', 37, 51, 903000.00, 46053000.00);
INSERT INTO list_item VALUES ('V000000403', 'KLJ00153', 31, 81, 904000.00, 73224000.00);
INSERT INTO list_item VALUES ('V000000404', 'KLJ00154', 70, 15, 905000.00, 13575000.00);
INSERT INTO list_item VALUES ('V000000405', 'KLJ00155', 72, 28, 906000.00, 25368000.00);
INSERT INTO list_item VALUES ('V000000406', 'KLJ00156', 40, 91, 907000.00, 82537000.00);
INSERT INTO list_item VALUES ('V000000407', 'KLJ00157', 69, 8, 908000.00, 7264000.00);
INSERT INTO list_item VALUES ('V000000408', 'KLJ00158', 10, 80, 909000.00, 72720000.00);
INSERT INTO list_item VALUES ('V000000409', 'KLJ00159', 76, 54, 910000.00, 49140000.00);
INSERT INTO list_item VALUES ('V000000410', 'KLJ00160', 73, 3, 911000.00, 2733000.00);
INSERT INTO list_item VALUES ('V000000411', 'KLJ00161', 97, 87, 912000.00, 79344000.00);
INSERT INTO list_item VALUES ('V000000412', 'KLJ00162', 46, 31, 913000.00, 28303000.00);
INSERT INTO list_item VALUES ('V000000413', 'KLJ00163', 53, 18, 914000.00, 16452000.00);
INSERT INTO list_item VALUES ('V000000414', 'KLJ00164', 25, 50, 915000.00, 45750000.00);
INSERT INTO list_item VALUES ('V000000415', 'KLJ00165', 18, 52, 916000.00, 47632000.00);
INSERT INTO list_item VALUES ('V000000416', 'KLJ00166', 35, 43, 917000.00, 39431000.00);
INSERT INTO list_item VALUES ('V000000417', 'KLJ00167', 56, 58, 918000.00, 53244000.00);
INSERT INTO list_item VALUES ('V000000418', 'KLJ00168', 49, 6, 919000.00, 5514000.00);
INSERT INTO list_item VALUES ('V000000419', 'KLJ00169', 48, 40, 920000.00, 36800000.00);
INSERT INTO list_item VALUES ('V000000420', 'KLJ00170', 42, 83, 921000.00, 76443000.00);
INSERT INTO list_item VALUES ('V000000421', 'KLJ00171', 74, 17, 922000.00, 15674000.00);
INSERT INTO list_item VALUES ('V000000422', 'KLJ00172', 25, 7, 923000.00, 6461000.00);
INSERT INTO list_item VALUES ('V000000423', 'KLJ00173', 94, 64, 924000.00, 59136000.00);
INSERT INTO list_item VALUES ('V000000424', 'KLJ00174', 78, 60, 925000.00, 55500000.00);
INSERT INTO list_item VALUES ('V000000425', 'KLJ00175', 1, 39, 926000.00, 36114000.00);
INSERT INTO list_item VALUES ('V000000426', 'KLJ00176', 35, 36, 927000.00, 33372000.00);
INSERT INTO list_item VALUES ('V000000427', 'KLJ00177', 45, 60, 928000.00, 55680000.00);
INSERT INTO list_item VALUES ('V000000428', 'KLJ00178', 76, 32, 929000.00, 29728000.00);
INSERT INTO list_item VALUES ('V000000429', 'KLJ00179', 11, 17, 930000.00, 15810000.00);
INSERT INTO list_item VALUES ('V000000430', 'KLJ00180', 66, 32, 931000.00, 29792000.00);
INSERT INTO list_item VALUES ('V000000431', 'KLJ00181', 51, 88, 932000.00, 82016000.00);
INSERT INTO list_item VALUES ('V000000432', 'KLJ00182', 79, 18, 933000.00, 16794000.00);
INSERT INTO list_item VALUES ('V000000433', 'KLJ00183', 48, 65, 934000.00, 60710000.00);
INSERT INTO list_item VALUES ('V000000434', 'KLJ00184', 53, 32, 935000.00, 29920000.00);
INSERT INTO list_item VALUES ('V000000435', 'KLJ00185', 100, 41, 936000.00, 38376000.00);
INSERT INTO list_item VALUES ('V000000436', 'KLJ00186', 28, 67, 937000.00, 62779000.00);
INSERT INTO list_item VALUES ('V000000437', 'KLJ00187', 26, 80, 938000.00, 75040000.00);
INSERT INTO list_item VALUES ('V000000438', 'KLJ00188', 53, 69, 939000.00, 64791000.00);
INSERT INTO list_item VALUES ('V000000439', 'KLJ00189', 35, 18, 940000.00, 16920000.00);
INSERT INTO list_item VALUES ('V000000440', 'KLJ00190', 62, 50, 941000.00, 47050000.00);
INSERT INTO list_item VALUES ('V000000441', 'KLJ00191', 70, 86, 942000.00, 81012000.00);
INSERT INTO list_item VALUES ('V000000442', 'KLJ00192', 8, 56, 943000.00, 52808000.00);
INSERT INTO list_item VALUES ('V000000443', 'KLJ00193', 62, 84, 944000.00, 79296000.00);
INSERT INTO list_item VALUES ('V000000444', 'KLJ00194', 38, 66, 945000.00, 62370000.00);
INSERT INTO list_item VALUES ('V000000445', 'KLJ00195', 82, 71, 946000.00, 67166000.00);
INSERT INTO list_item VALUES ('V000000446', 'KLJ00196', 62, 74, 947000.00, 70078000.00);
INSERT INTO list_item VALUES ('V000000447', 'KLJ00197', 36, 89, 948000.00, 84372000.00);
INSERT INTO list_item VALUES ('V000000448', 'KLJ00198', 57, 34, 949000.00, 32266000.00);
INSERT INTO list_item VALUES ('V000000449', 'KLJ00199', 84, 96, 950000.00, 91200000.00);
INSERT INTO list_item VALUES ('V000000450', 'KLJ00200', 43, 70, 951000.00, 66570000.00);
INSERT INTO list_item VALUES ('V000000451', 'KLJ00201', 27, 35, 952000.00, 33320000.00);
INSERT INTO list_item VALUES ('V000000452', 'KLJ00202', 92, 14, 953000.00, 13342000.00);
INSERT INTO list_item VALUES ('V000000453', 'KLJ00203', 75, 67, 954000.00, 63918000.00);
INSERT INTO list_item VALUES ('V000000454', 'KLJ00204', 95, 30, 955000.00, 28650000.00);
INSERT INTO list_item VALUES ('V000000455', 'KLJ00205', 69, 5, 956000.00, 4780000.00);
INSERT INTO list_item VALUES ('V000000456', 'KLJ00206', 38, 41, 957000.00, 39237000.00);
INSERT INTO list_item VALUES ('V000000457', 'KLJ00207', 16, 43, 958000.00, 41194000.00);
INSERT INTO list_item VALUES ('V000000458', 'KLJ00208', 40, 8, 959000.00, 7672000.00);
INSERT INTO list_item VALUES ('V000000459', 'KLJ00209', 28, 61, 960000.00, 58560000.00);
INSERT INTO list_item VALUES ('V000000460', 'KLJ00210', 92, 67, 961000.00, 64387000.00);
INSERT INTO list_item VALUES ('V000000461', 'KLJ00211', 6, 45, 962000.00, 43290000.00);
INSERT INTO list_item VALUES ('V000000462', 'KLJ00212', 80, 85, 963000.00, 81855000.00);
INSERT INTO list_item VALUES ('V000000463', 'KLJ00213', 95, 25, 964000.00, 24100000.00);
INSERT INTO list_item VALUES ('V000000464', 'KLJ00214', 60, 65, 965000.00, 62725000.00);
INSERT INTO list_item VALUES ('V000000465', 'KLJ00215', 8, 81, 966000.00, 78246000.00);
INSERT INTO list_item VALUES ('V000000466', 'KLJ00216', 43, 68, 967000.00, 65756000.00);
INSERT INTO list_item VALUES ('V000000467', 'KLJ00217', 24, 25, 968000.00, 24200000.00);
INSERT INTO list_item VALUES ('V000000468', 'KLJ00218', 61, 76, 969000.00, 73644000.00);
INSERT INTO list_item VALUES ('V000000469', 'KLJ00219', 88, 62, 970000.00, 60140000.00);
INSERT INTO list_item VALUES ('V000000470', 'KLJ00220', 89, 1, 971000.00, 971000.00);
INSERT INTO list_item VALUES ('V000000471', 'KLJ00221', 63, 23, 972000.00, 22356000.00);
INSERT INTO list_item VALUES ('V000000472', 'KLJ00222', 30, 93, 973000.00, 90489000.00);
INSERT INTO list_item VALUES ('V000000473', 'KLJ00223', 39, 52, 974000.00, 50648000.00);
INSERT INTO list_item VALUES ('V000000474', 'KLJ00224', 91, 29, 975000.00, 28275000.00);
INSERT INTO list_item VALUES ('V000000475', 'KLJ00225', 12, 44, 976000.00, 42944000.00);
INSERT INTO list_item VALUES ('V000000476', 'KLJ00226', 62, 51, 977000.00, 49827000.00);
INSERT INTO list_item VALUES ('V000000477', 'KLJ00227', 10, 18, 978000.00, 17604000.00);
INSERT INTO list_item VALUES ('V000000478', 'KLJ00228', 56, 37, 979000.00, 36223000.00);
INSERT INTO list_item VALUES ('V000000479', 'KLJ00229', 27, 62, 980000.00, 60760000.00);
INSERT INTO list_item VALUES ('V000000480', 'KLJ00230', 98, 14, 981000.00, 13734000.00);
INSERT INTO list_item VALUES ('V000000481', 'KLJ00231', 59, 24, 982000.00, 23568000.00);
INSERT INTO list_item VALUES ('V000000482', 'KLJ00232', 21, 10, 983000.00, 9830000.00);
INSERT INTO list_item VALUES ('V000000483', 'KLJ00233', 92, 8, 984000.00, 7872000.00);
INSERT INTO list_item VALUES ('V000000484', 'KLJ00234', 40, 65, 985000.00, 64025000.00);
INSERT INTO list_item VALUES ('V000000485', 'KLJ00235', 70, 83, 986000.00, 81838000.00);
INSERT INTO list_item VALUES ('V000000486', 'KLJ00236', 47, 5, 987000.00, 4935000.00);
INSERT INTO list_item VALUES ('V000000487', 'KLJ00237', 40, 58, 988000.00, 57304000.00);
INSERT INTO list_item VALUES ('V000000488', 'KLJ00238', 2, 28, 989000.00, 27692000.00);
INSERT INTO list_item VALUES ('V000000489', 'KLJ00239', 50, 14, 990000.00, 13860000.00);
INSERT INTO list_item VALUES ('V000000490', 'KLJ00240', 62, 52, 991000.00, 51532000.00);
INSERT INTO list_item VALUES ('V000000491', 'KLJ00241', 99, 62, 992000.00, 61504000.00);
INSERT INTO list_item VALUES ('V000000492', 'KLJ00242', 16, 99, 993000.00, 98307000.00);
INSERT INTO list_item VALUES ('V000000493', 'KLJ00243', 65, 26, 994000.00, 25844000.00);
INSERT INTO list_item VALUES ('V000000494', 'KLJ00244', 3, 14, 995000.00, 13930000.00);
INSERT INTO list_item VALUES ('V000000495', 'KLJ00245', 30, 47, 996000.00, 46812000.00);
INSERT INTO list_item VALUES ('V000000496', 'KLJ00246', 13, 7, 997000.00, 6979000.00);
INSERT INTO list_item VALUES ('V000000497', 'KLJ00247', 63, 99, 998000.00, 98802000.00);
INSERT INTO list_item VALUES ('V000000498', 'KLJ00248', 78, 82, 999000.00, 81918000.00);
INSERT INTO list_item VALUES ('V000000499', 'KLJ00249', 65, 30, 1000000.00, 30000000.00);
INSERT INTO list_item VALUES ('V000000500', 'KLJ00001', 1, 1, 2100.00, 2100.00);
INSERT INTO list_item VALUES ('V000000501', 'KLJ00102', 10, 10, 8700.00, 87000.00);


--
-- Data for Name: pelanggan; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO pelanggan VALUES ('ncaro0@guardian.co.uk', false, NULL, 246);
INSERT INTO pelanggan VALUES ('pcuttles1@nydailynews.com', false, NULL, 630);
INSERT INTO pelanggan VALUES ('tbradlaugh2@livejournal.com', false, NULL, 324);
INSERT INTO pelanggan VALUES ('hlongcake3@macromedia.com', false, NULL, 667);
INSERT INTO pelanggan VALUES ('dbrannigan4@addtoany.com', false, NULL, 501);
INSERT INTO pelanggan VALUES ('tschimon5@rambler.ru', false, NULL, 270);
INSERT INTO pelanggan VALUES ('jkamena6@oracle.com', false, NULL, 672);
INSERT INTO pelanggan VALUES ('rfarrey7@marketwatch.com', false, NULL, 241);
INSERT INTO pelanggan VALUES ('nwagen8@dailymotion.com', false, NULL, 742);
INSERT INTO pelanggan VALUES ('stait9@goo.ne.jp', false, NULL, 584);
INSERT INTO pelanggan VALUES ('ppearmaina@nps.gov', false, NULL, 302);
INSERT INTO pelanggan VALUES ('mcivitillob@google.ru', false, NULL, 552);
INSERT INTO pelanggan VALUES ('lbrewettc@prnewswire.com', false, NULL, 575);
INSERT INTO pelanggan VALUES ('aorsd@cbc.ca', false, NULL, 688);
INSERT INTO pelanggan VALUES ('wbraunee@slashdot.org', false, NULL, 18);
INSERT INTO pelanggan VALUES ('gbassillf@ucsd.edu', false, NULL, 958);
INSERT INTO pelanggan VALUES ('adeg@facebook.com', false, NULL, 6);
INSERT INTO pelanggan VALUES ('likringillh@wordpress.com', false, NULL, 895);
INSERT INTO pelanggan VALUES ('ekelleni@jugem.jp', false, NULL, 148);
INSERT INTO pelanggan VALUES ('jtinwellj@sourceforge.net', false, NULL, 41);
INSERT INTO pelanggan VALUES ('enevek@devhub.com', false, NULL, 72);
INSERT INTO pelanggan VALUES ('rjosipovitzl@dot.gov', false, NULL, 34);
INSERT INTO pelanggan VALUES ('dwormanm@imgur.com', false, NULL, 533);
INSERT INTO pelanggan VALUES ('doveralln@biglobe.ne.jp', false, NULL, 198);
INSERT INTO pelanggan VALUES ('mromeoo@weather.com', false, NULL, 290);
INSERT INTO pelanggan VALUES ('rcullenp@amazon.co.uk', false, NULL, 657);
INSERT INTO pelanggan VALUES ('ozettlerq@washingtonpost.com', false, NULL, 1);
INSERT INTO pelanggan VALUES ('acherringtonr@bloglines.com', false, NULL, 634);
INSERT INTO pelanggan VALUES ('mpumfretts@berkeley.edu', false, NULL, 547);
INSERT INTO pelanggan VALUES ('iwilest@mediafire.com', false, NULL, 432);
INSERT INTO pelanggan VALUES ('afehelyu@delicious.com', false, NULL, 577);
INSERT INTO pelanggan VALUES ('atrickeyv@yale.edu', false, NULL, 383);
INSERT INTO pelanggan VALUES ('hbatyw@dion.ne.jp', false, NULL, 231);
INSERT INTO pelanggan VALUES ('sdornanx@epa.gov', false, NULL, 545);
INSERT INTO pelanggan VALUES ('rrathey@creativecommons.org', false, NULL, 425);
INSERT INTO pelanggan VALUES ('abramez@squidoo.com', false, NULL, 140);
INSERT INTO pelanggan VALUES ('mtitherington10@amazon.co.jp', false, NULL, 944);
INSERT INTO pelanggan VALUES ('dtraviss11@theguardian.com', false, NULL, 409);
INSERT INTO pelanggan VALUES ('slattos12@usnews.com', false, NULL, 205);
INSERT INTO pelanggan VALUES ('wgavey13@sogou.com', false, NULL, 274);
INSERT INTO pelanggan VALUES ('pholdren14@amazon.co.jp', false, NULL, 367);
INSERT INTO pelanggan VALUES ('jharcarse15@statcounter.com', false, NULL, 341);
INSERT INTO pelanggan VALUES ('hmallison16@auda.org.au', false, NULL, 575);
INSERT INTO pelanggan VALUES ('kparidge17@senate.gov', false, NULL, 20);
INSERT INTO pelanggan VALUES ('mferrelli18@vkontakte.ru', false, NULL, 653);
INSERT INTO pelanggan VALUES ('bjehu19@shinystat.com', false, NULL, 3);
INSERT INTO pelanggan VALUES ('bfardon1a@tripod.com', false, NULL, 850);
INSERT INTO pelanggan VALUES ('ftarpey1b@washington.edu', false, NULL, 67);
INSERT INTO pelanggan VALUES ('rjodrelle1c@topsy.com', false, NULL, 686);
INSERT INTO pelanggan VALUES ('cjanaud1d@virginia.edu', false, NULL, 187);
INSERT INTO pelanggan VALUES ('mwadley1e@fema.gov', false, NULL, 28);
INSERT INTO pelanggan VALUES ('awalczak1f@mit.edu', false, NULL, 556);
INSERT INTO pelanggan VALUES ('dgrenter1g@booking.com', false, NULL, 562);
INSERT INTO pelanggan VALUES ('mpinkie1h@tumblr.com', false, NULL, 404);
INSERT INTO pelanggan VALUES ('jbraikenridge1i@goo.gl', false, NULL, 886);
INSERT INTO pelanggan VALUES ('hzapater1j@xrea.com', false, NULL, 689);
INSERT INTO pelanggan VALUES ('wspinley1k@skype.com', false, NULL, 554);
INSERT INTO pelanggan VALUES ('cmeadway1l@mapy.cz', false, NULL, 680);
INSERT INTO pelanggan VALUES ('gmossman1m@de.vu', false, NULL, 510);
INSERT INTO pelanggan VALUES ('mdyball1n@netlog.com', false, NULL, 342);
INSERT INTO pelanggan VALUES ('cedington1o@omniture.com', false, NULL, 236);
INSERT INTO pelanggan VALUES ('msimione1p@sitemeter.com', false, NULL, 326);
INSERT INTO pelanggan VALUES ('nstenett1q@buzzfeed.com', false, NULL, 70);
INSERT INTO pelanggan VALUES ('efloodgate1r@stanford.edu', false, NULL, 38);
INSERT INTO pelanggan VALUES ('gvsanelli1s@timesonline.co.uk', false, NULL, 281);
INSERT INTO pelanggan VALUES ('pmaccarroll1t@umn.edu', false, NULL, 841);
INSERT INTO pelanggan VALUES ('lnolte1u@webs.com', false, NULL, 347);
INSERT INTO pelanggan VALUES ('singman1v@example.com', false, NULL, 472);
INSERT INTO pelanggan VALUES ('gboschmann1w@themeforest.net', false, NULL, 473);
INSERT INTO pelanggan VALUES ('avellden1x@seesaa.net', false, NULL, 96);
INSERT INTO pelanggan VALUES ('bjacqueminot1y@msu.edu', false, NULL, 171);
INSERT INTO pelanggan VALUES ('omasham1z@meetup.com', false, NULL, 634);
INSERT INTO pelanggan VALUES ('arowlatt20@alibaba.com', false, NULL, 735);
INSERT INTO pelanggan VALUES ('htubby21@samsung.com', false, NULL, 881);
INSERT INTO pelanggan VALUES ('rmachen22@businessinsider.com', false, NULL, 894);
INSERT INTO pelanggan VALUES ('bisard23@irs.gov', false, NULL, 78);
INSERT INTO pelanggan VALUES ('dcubin24@typepad.com', false, NULL, 306);
INSERT INTO pelanggan VALUES ('schurn25@sogou.com', false, NULL, 353);
INSERT INTO pelanggan VALUES ('pmease26@dell.com', false, NULL, 318);
INSERT INTO pelanggan VALUES ('sgarric27@google.com', false, NULL, 469);
INSERT INTO pelanggan VALUES ('durian28@phpbb.com', false, NULL, 302);
INSERT INTO pelanggan VALUES ('rdiggins29@storify.com', false, NULL, 157);
INSERT INTO pelanggan VALUES ('imiettinen2a@goodreads.com', false, NULL, 745);
INSERT INTO pelanggan VALUES ('kmowsley2b@cyberchimps.com', false, NULL, 574);
INSERT INTO pelanggan VALUES ('tdilawey2c@tinyurl.com', false, NULL, 629);
INSERT INTO pelanggan VALUES ('ttourmell2d@dailymail.co.uk', false, NULL, 555);
INSERT INTO pelanggan VALUES ('cdocherty2e@gravatar.com', false, NULL, 895);
INSERT INTO pelanggan VALUES ('cmalzard2f@acquirethisname.com', false, NULL, 799);
INSERT INTO pelanggan VALUES ('ejochens2g@ihg.com', false, NULL, 667);
INSERT INTO pelanggan VALUES ('smathen2h@telegraph.co.uk', false, NULL, 275);
INSERT INTO pelanggan VALUES ('bmakeswell2i@toplist.cz', false, NULL, 343);
INSERT INTO pelanggan VALUES ('mhache2j@typepad.com', false, NULL, 152);
INSERT INTO pelanggan VALUES ('cpidgen2k@google.fr', false, NULL, 864);
INSERT INTO pelanggan VALUES ('ghooban2l@cisco.com', false, NULL, 6);
INSERT INTO pelanggan VALUES ('xvery2m@facebook.com', false, NULL, 33);
INSERT INTO pelanggan VALUES ('srainsdon2n@bluehost.com', false, NULL, 704);
INSERT INTO pelanggan VALUES ('gtiebe2o@google.pl', false, NULL, 849);
INSERT INTO pelanggan VALUES ('mde2p@census.gov', false, NULL, 742);
INSERT INTO pelanggan VALUES ('nhubbucks2q@census.gov', false, NULL, 476);
INSERT INTO pelanggan VALUES ('lfrise2r@godaddy.com', false, NULL, 257);
INSERT INTO pelanggan VALUES ('ctembey2s@nhs.uk', false, NULL, 355);
INSERT INTO pelanggan VALUES ('dnottingam2t@marketwatch.com', false, NULL, 678);
INSERT INTO pelanggan VALUES ('jbarron2u@4shared.com', false, NULL, 545);
INSERT INTO pelanggan VALUES ('lguise2v@dagondesign.com', false, NULL, 257);
INSERT INTO pelanggan VALUES ('ppidgen2w@paginegialle.it', false, NULL, 867);
INSERT INTO pelanggan VALUES ('dterrey2x@bloglines.com', false, NULL, 171);
INSERT INTO pelanggan VALUES ('locannan2y@archive.org', false, NULL, 586);
INSERT INTO pelanggan VALUES ('btethcote2z@yale.edu', false, NULL, 10);
INSERT INTO pelanggan VALUES ('gwhitworth30@slate.com', false, NULL, 991);
INSERT INTO pelanggan VALUES ('atatters31@marketwatch.com', false, NULL, 315);
INSERT INTO pelanggan VALUES ('santonognoli32@si.edu', false, NULL, 424);
INSERT INTO pelanggan VALUES ('nleathers33@sbwire.com', false, NULL, 232);
INSERT INTO pelanggan VALUES ('amcatamney34@toplist.cz', false, NULL, 118);
INSERT INTO pelanggan VALUES ('sspohr35@symantec.com', false, NULL, 142);
INSERT INTO pelanggan VALUES ('kbrain36@cbslocal.com', false, NULL, 941);
INSERT INTO pelanggan VALUES ('poats37@squidoo.com', false, NULL, 985);
INSERT INTO pelanggan VALUES ('cjina38@tamu.edu', false, NULL, 369);
INSERT INTO pelanggan VALUES ('eboddymead39@flavors.me', false, NULL, 889);
INSERT INTO pelanggan VALUES ('dplampin3a@java.com', false, NULL, 660);
INSERT INTO pelanggan VALUES ('cround3b@kickstarter.com', false, NULL, 515);
INSERT INTO pelanggan VALUES ('tcolquete3c@goodreads.com', false, NULL, 27);
INSERT INTO pelanggan VALUES ('rjosselsohn3d@reverbnation.com', false, NULL, 130);
INSERT INTO pelanggan VALUES ('mrau3e@home.pl', false, NULL, 849);
INSERT INTO pelanggan VALUES ('mruperto3f@apple.com', false, NULL, 913);
INSERT INTO pelanggan VALUES ('amerrall3g@apple.com', false, NULL, 849);
INSERT INTO pelanggan VALUES ('acleveland3h@rakuten.co.jp', false, NULL, 266);
INSERT INTO pelanggan VALUES ('nbaiden3i@cam.ac.uk', false, NULL, 940);
INSERT INTO pelanggan VALUES ('sjurczak3j@moonfruit.com', false, NULL, 231);
INSERT INTO pelanggan VALUES ('gkidwell3k@kickstarter.com', false, NULL, 820);
INSERT INTO pelanggan VALUES ('nrigmond3l@google.ca', false, NULL, 261);
INSERT INTO pelanggan VALUES ('nfilipychev3m@washington.edu', false, NULL, 118);
INSERT INTO pelanggan VALUES ('wgent3n@pcworld.com', false, NULL, 687);
INSERT INTO pelanggan VALUES ('cdoughty3o@i2i.jp', false, NULL, 102);
INSERT INTO pelanggan VALUES ('dde3p@wikia.com', false, NULL, 262);
INSERT INTO pelanggan VALUES ('btassaker3q@house.gov', false, NULL, 439);
INSERT INTO pelanggan VALUES ('ngagin3r@amazon.co.uk', false, NULL, 932);
INSERT INTO pelanggan VALUES ('lswinfen3s@cbc.ca', false, NULL, 508);
INSERT INTO pelanggan VALUES ('sklemke3t@lycos.com', false, NULL, 513);
INSERT INTO pelanggan VALUES ('aschmidt3u@wikia.com', false, NULL, 375);
INSERT INTO pelanggan VALUES ('mrakes3v@tinyurl.com', false, NULL, 149);
INSERT INTO pelanggan VALUES ('dspuner3w@nature.com', false, NULL, 233);
INSERT INTO pelanggan VALUES ('jluxford3x@statcounter.com', false, NULL, 500);
INSERT INTO pelanggan VALUES ('lgaskin3y@uiuc.edu', false, NULL, 871);
INSERT INTO pelanggan VALUES ('mellett3z@nhs.uk', false, NULL, 160);
INSERT INTO pelanggan VALUES ('kbalfour40@pagesperso-orange.fr', false, NULL, 92);
INSERT INTO pelanggan VALUES ('sdilleway41@unesco.org', false, NULL, 692);
INSERT INTO pelanggan VALUES ('kmohammed42@plala.or.jp', false, NULL, 495);
INSERT INTO pelanggan VALUES ('dcollinson43@usnews.com', false, NULL, 400);
INSERT INTO pelanggan VALUES ('agasgarth44@is.gd', false, NULL, 753);
INSERT INTO pelanggan VALUES ('tmerill45@google.com.br', false, NULL, 514);
INSERT INTO pelanggan VALUES ('tcloney46@alibaba.com', false, NULL, 388);
INSERT INTO pelanggan VALUES ('etomsa47@unc.edu', false, NULL, 709);
INSERT INTO pelanggan VALUES ('tbeecroft48@squarespace.com', false, NULL, 108);
INSERT INTO pelanggan VALUES ('troyal49@deliciousdays.com', false, NULL, 497);
INSERT INTO pelanggan VALUES ('htreagust4a@homestead.com', false, NULL, 117);
INSERT INTO pelanggan VALUES ('lstiggles4b@ucoz.com', false, NULL, 974);
INSERT INTO pelanggan VALUES ('showes4c@opera.com', false, NULL, 376);
INSERT INTO pelanggan VALUES ('lgoggen4d@discovery.com', false, NULL, 888);
INSERT INTO pelanggan VALUES ('obernaldez4e@mediafire.com', false, NULL, 613);
INSERT INTO pelanggan VALUES ('kjoddens4f@jimdo.com', false, NULL, 747);
INSERT INTO pelanggan VALUES ('rjozaitis4g@icio.us', false, NULL, 963);
INSERT INTO pelanggan VALUES ('mpierson4h@goo.gl', false, NULL, 999);
INSERT INTO pelanggan VALUES ('aginnaly4i@state.gov', false, NULL, 535);
INSERT INTO pelanggan VALUES ('mhavercroft4j@redcross.org', false, NULL, 929);
INSERT INTO pelanggan VALUES ('apicopp4k@uol.com.br', false, NULL, 784);
INSERT INTO pelanggan VALUES ('dollivierre4l@statcounter.com', false, NULL, 243);
INSERT INTO pelanggan VALUES ('hsiley4m@msu.edu', false, NULL, 885);
INSERT INTO pelanggan VALUES ('jtwigger4n@printfriendly.com', false, NULL, 601);
INSERT INTO pelanggan VALUES ('yduffett4o@va.gov', false, NULL, 702);
INSERT INTO pelanggan VALUES ('wmcdonand4p@sitemeter.com', false, NULL, 743);
INSERT INTO pelanggan VALUES ('kdinsale4q@gizmodo.com', false, NULL, 357);
INSERT INTO pelanggan VALUES ('rkinnin4r@odnoklassniki.ru', false, NULL, 989);
INSERT INTO pelanggan VALUES ('flapish4s@indiatimes.com', false, NULL, 478);
INSERT INTO pelanggan VALUES ('bridger4t@over-blog.com', false, NULL, 132);
INSERT INTO pelanggan VALUES ('lfairleigh4u@nymag.com', false, NULL, 36);
INSERT INTO pelanggan VALUES ('blampen4v@linkedin.com', false, NULL, 746);
INSERT INTO pelanggan VALUES ('acereceres4w@alexa.com', false, NULL, 458);
INSERT INTO pelanggan VALUES ('vlockhart4x@csmonitor.com', false, NULL, 597);
INSERT INTO pelanggan VALUES ('tcrompton4y@utexas.edu', false, NULL, 521);
INSERT INTO pelanggan VALUES ('dmcauslene4z@amazon.com', false, NULL, 989);
INSERT INTO pelanggan VALUES ('ebromhead50@tinypic.com', false, NULL, 650);
INSERT INTO pelanggan VALUES ('smockler51@un.org', false, NULL, 722);
INSERT INTO pelanggan VALUES ('tbrettle52@wsj.com', false, NULL, 577);
INSERT INTO pelanggan VALUES ('vianni53@csmonitor.com', false, NULL, 801);
INSERT INTO pelanggan VALUES ('fwasson54@goo.ne.jp', false, NULL, 443);
INSERT INTO pelanggan VALUES ('ghamberston55@foxnews.com', false, NULL, 927);
INSERT INTO pelanggan VALUES ('abury56@tmall.com', false, NULL, 491);
INSERT INTO pelanggan VALUES ('jbibbie57@hp.com', false, NULL, 488);
INSERT INTO pelanggan VALUES ('ralders58@tripod.com', false, NULL, 8);
INSERT INTO pelanggan VALUES ('dyankin59@quantcast.com', false, NULL, 496);
INSERT INTO pelanggan VALUES ('arangall5a@reference.com', false, NULL, 594);
INSERT INTO pelanggan VALUES ('otamblyn5b@arstechnica.com', false, NULL, 123);
INSERT INTO pelanggan VALUES ('jdominici5c@wp.com', false, NULL, 707);
INSERT INTO pelanggan VALUES ('kchessor5d@unc.edu', false, NULL, 228);
INSERT INTO pelanggan VALUES ('cpeizer5e@vk.com', false, NULL, 708);
INSERT INTO pelanggan VALUES ('dpartlett5f@wikia.com', false, NULL, 352);
INSERT INTO pelanggan VALUES ('hlamey5g@arstechnica.com', false, NULL, 212);
INSERT INTO pelanggan VALUES ('vedgcumbe5h@prweb.com', false, NULL, 997);
INSERT INTO pelanggan VALUES ('amcgilvray5i@soup.io', false, NULL, 932);
INSERT INTO pelanggan VALUES ('thackford5j@uiuc.edu', false, NULL, 567);
INSERT INTO pelanggan VALUES ('mhastewell5k@ask.com', false, NULL, 497);
INSERT INTO pelanggan VALUES ('llawlings5l@china.com.cn', false, NULL, 363);
INSERT INTO pelanggan VALUES ('rmaybey5m@pbs.org', false, NULL, 538);
INSERT INTO pelanggan VALUES ('tlacroutz5n@icio.us', false, NULL, 924);
INSERT INTO pelanggan VALUES ('yelger5o@trellian.com', false, NULL, 224);
INSERT INTO pelanggan VALUES ('ilerego5p@github.io', false, NULL, 593);
INSERT INTO pelanggan VALUES ('mmaymand5q@wikia.com', false, NULL, 521);
INSERT INTO pelanggan VALUES ('tdjurkovic5r@livejournal.com', false, NULL, 981);
INSERT INTO pelanggan VALUES ('jburridge5s@cloudflare.com', false, NULL, 197);
INSERT INTO pelanggan VALUES ('acappel5t@hubpages.com', false, NULL, 543);
INSERT INTO pelanggan VALUES ('pbittlestone5u@auda.org.au', false, NULL, 604);
INSERT INTO pelanggan VALUES ('ntrowel5v@bravesites.com', false, NULL, 559);
INSERT INTO pelanggan VALUES ('ejanicki5w@barnesandnoble.com', false, NULL, 104);
INSERT INTO pelanggan VALUES ('ngaudin5x@furl.net', false, NULL, 996);
INSERT INTO pelanggan VALUES ('moliphand5y@china.com.cn', false, NULL, 371);
INSERT INTO pelanggan VALUES ('aboullen5z@usgs.gov', false, NULL, 41);
INSERT INTO pelanggan VALUES ('bbilston60@wunderground.com', false, NULL, 627);
INSERT INTO pelanggan VALUES ('aespie61@yandex.ru', false, NULL, 329);
INSERT INTO pelanggan VALUES ('aeidelman62@yale.edu', false, NULL, 104);
INSERT INTO pelanggan VALUES ('rspeer63@topsy.com', false, NULL, 356);
INSERT INTO pelanggan VALUES ('bde64@smugmug.com', false, NULL, 932);
INSERT INTO pelanggan VALUES ('mmckernon65@wordpress.org', false, NULL, 585);
INSERT INTO pelanggan VALUES ('sspataro66@msu.edu', false, NULL, 210);
INSERT INTO pelanggan VALUES ('pgiovannini67@google.com.br', false, NULL, 329);
INSERT INTO pelanggan VALUES ('sarnholz68@miitbeian.gov.cn', false, NULL, 366);
INSERT INTO pelanggan VALUES ('gshilliday69@creativecommons.org', false, NULL, 693);
INSERT INTO pelanggan VALUES ('iolahy6a@yellowpages.com', false, NULL, 198);
INSERT INTO pelanggan VALUES ('dtredinnick6b@163.com', false, NULL, 443);
INSERT INTO pelanggan VALUES ('croston6c@amazon.de', false, NULL, 266);
INSERT INTO pelanggan VALUES ('bcussins6d@google.fr', false, NULL, 680);
INSERT INTO pelanggan VALUES ('grodgman6e@cargocollective.com', false, NULL, 709);
INSERT INTO pelanggan VALUES ('agilhool6f@addtoany.com', false, NULL, 180);
INSERT INTO pelanggan VALUES ('pproven6g@utexas.edu', false, NULL, 155);
INSERT INTO pelanggan VALUES ('ywestrip6h@pen.io', false, NULL, 785);
INSERT INTO pelanggan VALUES ('lfeasey6i@godaddy.com', false, NULL, 456);
INSERT INTO pelanggan VALUES ('fjeffcock6j@canalblog.com', false, NULL, 29);
INSERT INTO pelanggan VALUES ('gplenty6k@hc360.com', false, NULL, 851);
INSERT INTO pelanggan VALUES ('cvasyanin6l@mtv.com', false, NULL, 116);
INSERT INTO pelanggan VALUES ('lcallander6m@mayoclinic.com', false, NULL, 148);
INSERT INTO pelanggan VALUES ('rgraffham6n@ask.com', false, NULL, 900);
INSERT INTO pelanggan VALUES ('jfyndon6o@cdc.gov', false, NULL, 824);
INSERT INTO pelanggan VALUES ('opetigrew6p@devhub.com', false, NULL, 587);
INSERT INTO pelanggan VALUES ('nianilli6q@google.pl', false, NULL, 149);
INSERT INTO pelanggan VALUES ('fwadeson6r@discuz.net', false, NULL, 708);
INSERT INTO pelanggan VALUES ('cmcgarrell6s@dropbox.com', false, NULL, 163);
INSERT INTO pelanggan VALUES ('kasprey6t@symantec.com', false, NULL, 100);
INSERT INTO pelanggan VALUES ('jbirtwisle6u@discovery.com', false, NULL, 321);
INSERT INTO pelanggan VALUES ('jbradburne6v@odnoklassniki.ru', false, NULL, 243);
INSERT INTO pelanggan VALUES ('jwenger6w@wunderground.com', false, NULL, 843);
INSERT INTO pelanggan VALUES ('cpetruskevich6x@who.int', false, NULL, 929);
INSERT INTO pelanggan VALUES ('dummy@gmail.com', false, NULL, 929);
INSERT INTO pelanggan VALUES ('user@basdat.com', false, NULL, 929);
INSERT INTO pelanggan VALUES ('iscrogges6y@samsung.com', true, 2.9, NULL);
INSERT INTO pelanggan VALUES ('rpendergrast6z@hao123.com', true, 8.2, NULL);
INSERT INTO pelanggan VALUES ('aluetkemeyers70@miibeian.gov.cn', true, 0.2, NULL);
INSERT INTO pelanggan VALUES ('cpittford71@photobucket.com', true, 2.3, NULL);
INSERT INTO pelanggan VALUES ('kskerm72@list-manage.com', true, 8.6, NULL);
INSERT INTO pelanggan VALUES ('lsparling73@fema.gov', true, 9.3, NULL);
INSERT INTO pelanggan VALUES ('dde74@fc2.com', true, 2.0, NULL);
INSERT INTO pelanggan VALUES ('nbeale75@sohu.com', true, 6.6, NULL);
INSERT INTO pelanggan VALUES ('cegdal76@edublogs.org', true, 3.6, NULL);
INSERT INTO pelanggan VALUES ('umcjury77@hp.com', true, 4.0, NULL);
INSERT INTO pelanggan VALUES ('mramsdell78@paypal.com', true, 9.6, NULL);
INSERT INTO pelanggan VALUES ('rroffe79@smh.com.au', true, 9.5, NULL);
INSERT INTO pelanggan VALUES ('mchillingworth7a@themeforest.net', true, 5.5, NULL);
INSERT INTO pelanggan VALUES ('bcochran7b@smugmug.com', true, 6.9, NULL);
INSERT INTO pelanggan VALUES ('rbarff7c@goo.gl', true, 9.0, NULL);
INSERT INTO pelanggan VALUES ('dsketcher7d@ehow.com', true, 7.9, NULL);
INSERT INTO pelanggan VALUES ('gdecent7e@pinterest.com', true, 1.5, NULL);
INSERT INTO pelanggan VALUES ('sestcot7f@nbcnews.com', true, 7.4, NULL);
INSERT INTO pelanggan VALUES ('ishord7g@bloglines.com', true, 1.6, NULL);
INSERT INTO pelanggan VALUES ('bdaunay7h@elegantthemes.com', true, 8.1, NULL);
INSERT INTO pelanggan VALUES ('aaliman7i@wp.com', true, 7.7, NULL);
INSERT INTO pelanggan VALUES ('swoolgar7j@thetimes.co.uk', true, 6.4, NULL);
INSERT INTO pelanggan VALUES ('cborborough7k@twitter.com', true, 8.1, NULL);
INSERT INTO pelanggan VALUES ('mgoodsal7l@virginia.edu', true, 4.8, NULL);
INSERT INTO pelanggan VALUES ('gsherwyn7m@deviantart.com', true, 0.4, NULL);
INSERT INTO pelanggan VALUES ('aoldam7n@google.fr', true, 2.9, NULL);
INSERT INTO pelanggan VALUES ('mjindrich7o@twitter.com', true, 8.0, NULL);
INSERT INTO pelanggan VALUES ('bandryunin7p@cyberchimps.com', true, 5.9, NULL);
INSERT INTO pelanggan VALUES ('tfulleylove7q@nps.gov', true, 9.6, NULL);
INSERT INTO pelanggan VALUES ('ereffe7r@about.me', true, 4.5, NULL);
INSERT INTO pelanggan VALUES ('streasure7s@godaddy.com', true, 3.4, NULL);
INSERT INTO pelanggan VALUES ('psculley7t@t-online.de', true, 8.4, NULL);
INSERT INTO pelanggan VALUES ('frodbourne7u@histats.com', true, 4.4, NULL);
INSERT INTO pelanggan VALUES ('doris7v@taobao.com', true, 9.6, NULL);
INSERT INTO pelanggan VALUES ('acumberpatch7w@about.me', true, 1.5, NULL);
INSERT INTO pelanggan VALUES ('dwitt7x@forbes.com', true, 2.4, NULL);
INSERT INTO pelanggan VALUES ('preddish7y@1und1.de', true, 2.2, NULL);
INSERT INTO pelanggan VALUES ('mdivine7z@naver.com', true, 6.9, NULL);
INSERT INTO pelanggan VALUES ('hcaesar80@sina.com.cn', true, 2.6, NULL);
INSERT INTO pelanggan VALUES ('akiltie81@edublogs.org', true, 1.4, NULL);
INSERT INTO pelanggan VALUES ('dmoller82@geocities.com', true, 5.2, NULL);
INSERT INTO pelanggan VALUES ('sbendik83@independent.co.uk', true, 4.3, NULL);
INSERT INTO pelanggan VALUES ('pinsull84@de.vu', true, 5.1, NULL);
INSERT INTO pelanggan VALUES ('dcollister85@mashable.com', true, 3.4, NULL);
INSERT INTO pelanggan VALUES ('fcutmore86@walmart.com', true, 5.4, NULL);
INSERT INTO pelanggan VALUES ('mromanin87@sina.com.cn', true, 1.2, NULL);
INSERT INTO pelanggan VALUES ('mgallico88@zimbio.com', true, 6.4, NULL);
INSERT INTO pelanggan VALUES ('bmccurrie89@intel.com', true, 5.4, NULL);
INSERT INTO pelanggan VALUES ('bcostigan8a@wordpress.org', true, 5.9, NULL);
INSERT INTO pelanggan VALUES ('scaccavari8b@mozilla.com', true, 8.8, NULL);
INSERT INTO pelanggan VALUES ('awhicher8c@cisco.com', true, 8.1, NULL);
INSERT INTO pelanggan VALUES ('cwaterhowse8d@wired.com', true, 3.3, NULL);
INSERT INTO pelanggan VALUES ('garckoll8e@pinterest.com', true, 8.1, NULL);
INSERT INTO pelanggan VALUES ('jmcgeffen8f@123-reg.co.uk', true, 5.4, NULL);
INSERT INTO pelanggan VALUES ('vnewlove8g@yahoo.com', true, 1.8, NULL);
INSERT INTO pelanggan VALUES ('fsyratt8h@cpanel.net', true, 7.4, NULL);
INSERT INTO pelanggan VALUES ('vgorham8i@wikipedia.org', true, 3.1, NULL);
INSERT INTO pelanggan VALUES ('lchopping8j@aboutads.info', true, 2.4, NULL);
INSERT INTO pelanggan VALUES ('fminear8k@barnesandnoble.com', true, 3.7, NULL);
INSERT INTO pelanggan VALUES ('amcwhinnie8l@sphinn.com', true, 2.4, NULL);
INSERT INTO pelanggan VALUES ('ccallendar8m@xing.com', true, 5.9, NULL);
INSERT INTO pelanggan VALUES ('zgellier8n@a8.net', true, 4.6, NULL);
INSERT INTO pelanggan VALUES ('ctipper8o@unblog.fr', true, 2.8, NULL);
INSERT INTO pelanggan VALUES ('bseebright8p@parallels.com', true, 2.7, NULL);
INSERT INTO pelanggan VALUES ('ctrigg8q@sun.com', true, 5.6, NULL);
INSERT INTO pelanggan VALUES ('mobrallaghan8r@ebay.com', true, 8.3, NULL);
INSERT INTO pelanggan VALUES ('psummerlie8s@edublogs.org', true, 1.5, NULL);
INSERT INTO pelanggan VALUES ('dleven8t@nasa.gov', true, 5.0, NULL);
INSERT INTO pelanggan VALUES ('bstrafen8u@tinyurl.com', true, 4.0, NULL);
INSERT INTO pelanggan VALUES ('cgoldston8v@nature.com', true, 5.4, NULL);
INSERT INTO pelanggan VALUES ('jdwight8w@wikia.com', true, 2.6, NULL);
INSERT INTO pelanggan VALUES ('mmotten8x@senate.gov', true, 6.9, NULL);
INSERT INTO pelanggan VALUES ('mgilleon8y@bing.com', true, 2.8, NULL);
INSERT INTO pelanggan VALUES ('lrutt8z@hostgator.com', true, 0.2, NULL);
INSERT INTO pelanggan VALUES ('ghoonahan90@salon.com', true, 2.9, NULL);
INSERT INTO pelanggan VALUES ('hcaistor91@mtv.com', true, 9.3, NULL);
INSERT INTO pelanggan VALUES ('jmustarde92@hp.com', true, 1.4, NULL);
INSERT INTO pelanggan VALUES ('qstonestreet93@hatena.ne.jp', true, 4.0, NULL);
INSERT INTO pelanggan VALUES ('bcourtois94@ucla.edu', true, 1.3, NULL);
INSERT INTO pelanggan VALUES ('cschellig95@google.co.jp', true, 1.2, NULL);
INSERT INTO pelanggan VALUES ('etoor96@ustream.tv', true, 5.9, NULL);
INSERT INTO pelanggan VALUES ('pmarmyon97@accuweather.com', true, 1.8, NULL);
INSERT INTO pelanggan VALUES ('jpawlata98@phoca.cz', true, 6.2, NULL);
INSERT INTO pelanggan VALUES ('rivanchin99@slideshare.net', true, 8.8, NULL);
INSERT INTO pelanggan VALUES ('wmandres9a@gnu.org', true, 2.1, NULL);
INSERT INTO pelanggan VALUES ('ktonsley9b@nytimes.com', true, 1.4, NULL);
INSERT INTO pelanggan VALUES ('smilbourne9c@comcast.net', true, 7.8, NULL);
INSERT INTO pelanggan VALUES ('cduddell9d@fotki.com', true, 9.7, NULL);
INSERT INTO pelanggan VALUES ('dizaks9e@qq.com', true, 5.0, NULL);
INSERT INTO pelanggan VALUES ('rliversage9f@icio.us', true, 2.3, NULL);
INSERT INTO pelanggan VALUES ('cmcgawn9g@wix.com', true, 4.2, NULL);
INSERT INTO pelanggan VALUES ('eolland9h@vistaprint.com', true, 6.6, NULL);
INSERT INTO pelanggan VALUES ('crivard9i@cpanel.net', true, 1.0, NULL);
INSERT INTO pelanggan VALUES ('eamiss9j@jimdo.com', true, 3.9, NULL);
INSERT INTO pelanggan VALUES ('ssquibe9k@tamu.edu', true, 4.4, NULL);
INSERT INTO pelanggan VALUES ('kbrearton9l@amazon.com', true, 4.0, NULL);
INSERT INTO pelanggan VALUES ('scornelius9m@freewebs.com', true, 3.0, NULL);
INSERT INTO pelanggan VALUES ('broskams9n@hud.gov', true, 9.6, NULL);
INSERT INTO pelanggan VALUES ('hflewitt9o@unicef.org', true, 4.4, NULL);
INSERT INTO pelanggan VALUES ('rcrangle9p@cdc.gov', true, 4.8, NULL);


--
-- Data for Name: pengguna; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO pengguna VALUES ('ncaro0@guardian.co.uk', 'rdaheNe', 'Nikolai Caro', 'P', '1997-04-26', '86-(210)776-9704', '621 Brown Road');
INSERT INTO pengguna VALUES ('pcuttles1@nydailynews.com', 'lLqC2EA4F', 'Phillip Cuttles', 'P', '1988-05-02', '52-(757)841-6064', '8136 Sutteridge Center');
INSERT INTO pengguna VALUES ('tbradlaugh2@livejournal.com', 'PpqwCXHOuqk', 'Tedda Bradlaugh', 'P', '1972-12-21', '995-(703)233-6803', '4 Claremont Terrace');
INSERT INTO pengguna VALUES ('hlongcake3@macromedia.com', 'GMZE0CO', 'Hayden Longcake', 'L', '1995-09-29', '63-(540)565-4183', '3 Caliangt Street');
INSERT INTO pengguna VALUES ('dbrannigan4@addtoany.com', 'OwYjI36cWeYr', 'Dianemarie Brannigan', 'P', '1982-12-29', '30-(435)726-3032', '8332 Independence Avenue');
INSERT INTO pengguna VALUES ('tschimon5@rambler.ru', 'QXAXqf35', 'Tarah Schimon', 'P', '1971-02-14', '86-(549)880-0316', '84910 Homewood Crossing');
INSERT INTO pengguna VALUES ('jkamena6@oracle.com', '8rKJpay', 'Joan Kamena', 'L', '1970-11-10', '355-(839)392-6448', '5 Little Fleur Avenue');
INSERT INTO pengguna VALUES ('rfarrey7@marketwatch.com', 'V60UwaRp', 'Rina Farrey', 'P', '1994-09-16', '55-(176)820-0871', '7331 Hooker Circle');
INSERT INTO pengguna VALUES ('nwagen8@dailymotion.com', 'B5DEF9', 'Nolan Wagen', 'P', '1978-09-04', '34-(449)934-3716', '0 Northfield Street');
INSERT INTO pengguna VALUES ('stait9@goo.ne.jp', '4REpGF4B2Mv', 'Sebastien Tait', 'P', '1996-03-06', '374-(212)404-6925', '677 Sachtjen Road');
INSERT INTO pengguna VALUES ('ppearmaina@nps.gov', '4ByAnKV', 'Parrnell Pearmain', 'P', '1973-12-04', '375-(899)738-9523', '022 Larry Drive');
INSERT INTO pengguna VALUES ('mcivitillob@google.ru', 'Xb0Jy7woVB', 'Maribelle Civitillo', 'L', '1979-07-15', '84-(518)962-5838', '4000 Tennessee Lane');
INSERT INTO pengguna VALUES ('lbrewettc@prnewswire.com', 'QJxNXz7J9Fx', 'Lucia Brewett', 'P', '1974-09-25', '380-(401)143-5875', '0 Linden Plaza');
INSERT INTO pengguna VALUES ('aorsd@cbc.ca', 'ImB8ysAo', 'Aubert Ors', 'P', '1971-03-12', '66-(854)706-6962', '541 Southridge Way');
INSERT INTO pengguna VALUES ('wbraunee@slashdot.org', 'Dbe5eAG19d', 'Willette Braune', 'P', '1989-10-14', '7-(721)769-4639', '51843 Nelson Road');
INSERT INTO pengguna VALUES ('gbassillf@ucsd.edu', 'W4EVknV', 'Galen Bassill', 'L', '1983-02-03', '55-(982)240-2256', '2 Larry Center');
INSERT INTO pengguna VALUES ('adeg@facebook.com', 'fKVHv7mFlI', 'Aurie De Anesy', 'L', '1981-01-27', '63-(709)596-0134', '7769 Dottie Parkway');
INSERT INTO pengguna VALUES ('likringillh@wordpress.com', 'JTyWPai', 'Loy Ikringill', 'L', '1995-10-14', '504-(448)923-9381', '4230 Twin Pines Point');
INSERT INTO pengguna VALUES ('ekelleni@jugem.jp', 'xaKdmwAh', 'Evvy Kellen', 'L', '1997-05-28', '55-(924)733-1710', '12319 Mcguire Pass');
INSERT INTO pengguna VALUES ('jtinwellj@sourceforge.net', '3msBZL0', 'Johann Tinwell', 'P', '1993-08-29', '86-(748)214-5969', '51299 Golf Road');
INSERT INTO pengguna VALUES ('enevek@devhub.com', '7Ma9Wgr', 'Evania Neve', 'L', '1997-07-18', '66-(921)677-6861', '39854 Jackson Hill');
INSERT INTO pengguna VALUES ('rjosipovitzl@dot.gov', 'XtbLcANoU6', 'Raul Josipovitz', 'P', '1988-01-15', '351-(163)869-8889', '5 Buhler Place');
INSERT INTO pengguna VALUES ('dwormanm@imgur.com', 'EkoECNL8Q', 'Daryl Worman', 'L', '1993-02-20', '86-(237)550-4762', '2 Oak Valley Point');
INSERT INTO pengguna VALUES ('doveralln@biglobe.ne.jp', 'D8H1okP02', 'Dare Overall', 'P', '1990-07-22', '254-(736)858-3170', '78512 Ryan Court');
INSERT INTO pengguna VALUES ('mromeoo@weather.com', 'VOmZU6hgyX5V', 'Matti Romeo', 'P', '1980-01-01', '66-(103)333-7576', '7 Loomis Point');
INSERT INTO pengguna VALUES ('rcullenp@amazon.co.uk', 'uSZDZe', 'Raphael Cullen', 'L', '1980-09-22', '351-(425)422-6163', '5 Rowland Plaza');
INSERT INTO pengguna VALUES ('ozettlerq@washingtonpost.com', 'wDFi3o1U', 'Ophelie Zettler', 'P', '1971-12-04', '62-(529)392-9029', '9 Everett Avenue');
INSERT INTO pengguna VALUES ('acherringtonr@bloglines.com', 'OmhzLlut', 'Adrian Cherrington', 'L', '1979-02-24', '60-(399)118-3952', '8 Straubel Plaza');
INSERT INTO pengguna VALUES ('mpumfretts@berkeley.edu', 'tM9yCl', 'Murdoch Pumfrett', 'L', '1985-03-09', '46-(485)704-9934', '51149 Butternut Court');
INSERT INTO pengguna VALUES ('iwilest@mediafire.com', 'kcc4SsGEkl0a', 'Ibrahim Wiles', 'P', '1971-11-20', '86-(109)650-3396', '35283 Little Fleur Point');
INSERT INTO pengguna VALUES ('afehelyu@delicious.com', 'uRQdhm', 'Austen Fehely', 'P', '1982-09-06', '977-(687)187-5914', '9976 Merry Circle');
INSERT INTO pengguna VALUES ('atrickeyv@yale.edu', 'QtfiP5EOM', 'Abel Trickey', 'P', '1997-09-09', '51-(607)650-8647', '8 Coolidge Parkway');
INSERT INTO pengguna VALUES ('hbatyw@dion.ne.jp', 'fUo4dFVY4BFc', 'Hilary Baty', 'L', '1984-02-28', '54-(351)448-8113', '8 Nobel Way');
INSERT INTO pengguna VALUES ('sdornanx@epa.gov', '5aa5V8qI', 'Sascha Dornan', 'L', '1988-02-20', '55-(949)283-0731', '430 Prentice Point');
INSERT INTO pengguna VALUES ('rrathey@creativecommons.org', 'lFiOhhLuM3t', 'Rori Rathe', 'P', '1979-02-11', '48-(320)217-2641', '259 Scoville Plaza');
INSERT INTO pengguna VALUES ('abramez@squidoo.com', 'Fpcu94O', 'Alfonse Brame', 'L', '1984-06-03', '7-(969)673-8674', '048 Merrick Parkway');
INSERT INTO pengguna VALUES ('mtitherington10@amazon.co.jp', 'LULPWy1j', 'Morten Titherington', 'P', '1979-04-08', '355-(603)932-8774', '76 Hollow Ridge Alley');
INSERT INTO pengguna VALUES ('dtraviss11@theguardian.com', 'cH3NzkVrqt', 'Dee Traviss', 'L', '1974-12-15', '420-(395)504-0459', '5 Hintze Circle');
INSERT INTO pengguna VALUES ('slattos12@usnews.com', 'aMHlglv4U', 'Si Lattos', 'L', '1985-08-09', '255-(272)163-8016', '8337 Springs Center');
INSERT INTO pengguna VALUES ('wgavey13@sogou.com', '5tdGv1H', 'Wanids Gavey', 'P', '1974-02-26', '48-(672)148-2305', '39 Comanche Circle');
INSERT INTO pengguna VALUES ('pholdren14@amazon.co.jp', 'E36NvTshbEhb', 'Phillie Holdren', 'P', '1997-12-12', '255-(658)697-7478', '1457 Nevada Circle');
INSERT INTO pengguna VALUES ('jharcarse15@statcounter.com', '9rduse31ov5', 'Jo-ann Harcarse', 'P', '1973-02-22', '1-(651)607-4203', '78 Meadow Vale Center');
INSERT INTO pengguna VALUES ('hmallison16@auda.org.au', 'Zu79R1', 'Hermon Mallison', 'L', '1984-09-10', '48-(799)685-0394', '93825 Bluestem Plaza');
INSERT INTO pengguna VALUES ('kparidge17@senate.gov', 'e85jofz', 'Kary Paridge', 'L', '1994-04-02', '30-(494)942-0476', '58 Continental Center');
INSERT INTO pengguna VALUES ('mferrelli18@vkontakte.ru', '1rTPZg3d', 'Mateo Ferrelli', 'L', '1987-08-29', '55-(384)612-3378', '91 Becker Place');
INSERT INTO pengguna VALUES ('bjehu19@shinystat.com', 'ZmZKzCt', 'Brand Jehu', 'L', '1973-04-19', '81-(549)865-2217', '20 Hazelcrest Terrace');
INSERT INTO pengguna VALUES ('bfardon1a@tripod.com', '9wQHiC', 'Beale Fardon', 'P', '1994-05-05', '358-(670)442-4429', '92 North Place');
INSERT INTO pengguna VALUES ('ftarpey1b@washington.edu', 'w2vSjvwyLmX', 'Frederich Tarpey', 'L', '1986-11-22', '593-(929)461-3580', '01992 Portage Crossing');
INSERT INTO pengguna VALUES ('rjodrelle1c@topsy.com', 'f4qrTf', 'Raquela Jodrelle', 'L', '1991-10-23', '62-(221)888-9545', '56594 Tennyson Place');
INSERT INTO pengguna VALUES ('cjanaud1d@virginia.edu', '7108hKGPxl', 'Chauncey Janaud', 'P', '1977-06-23', '7-(117)578-2054', '6832 Farmco Park');
INSERT INTO pengguna VALUES ('mwadley1e@fema.gov', 'mM618WiZstnT', 'Mic Wadley', 'P', '1971-11-10', '62-(646)266-4121', '55 Sage Alley');
INSERT INTO pengguna VALUES ('awalczak1f@mit.edu', '1paeV6xxmIcf', 'Andris Walczak', 'P', '1976-03-12', '62-(855)687-3131', '56 Lillian Way');
INSERT INTO pengguna VALUES ('dgrenter1g@booking.com', 'plaRxRMu', 'Dewie Grenter', 'P', '1994-10-02', '81-(414)499-6501', '124 Maple Wood Point');
INSERT INTO pengguna VALUES ('mpinkie1h@tumblr.com', 's88ozSQCSMB', 'Morgana Pinkie', 'L', '1993-02-14', '33-(159)634-8262', '28989 Carey Crossing');
INSERT INTO pengguna VALUES ('jbraikenridge1i@goo.gl', 'l70O6tyV3H', 'Janeta Braikenridge', 'P', '1978-01-14', '63-(641)859-9127', '7 Cambridge Court');
INSERT INTO pengguna VALUES ('hzapater1j@xrea.com', 'vITQo4KWu5F', 'Hubert Zapater', 'P', '1973-07-01', '98-(865)666-8877', '551 Melrose Plaza');
INSERT INTO pengguna VALUES ('wspinley1k@skype.com', 'BkWH7NJF', 'Winny Spinley', 'L', '1997-07-24', '7-(499)538-1546', '949 Farmco Parkway');
INSERT INTO pengguna VALUES ('cmeadway1l@mapy.cz', '6SmmtqvygU', 'Cecilius Meadway', 'P', '1982-04-19', '856-(882)454-0748', '51 7th Alley');
INSERT INTO pengguna VALUES ('gmossman1m@de.vu', 'nL6PhAjrjkT', 'Gordy Mossman', 'L', '1989-04-19', '212-(967)337-8411', '5 Union Parkway');
INSERT INTO pengguna VALUES ('mdyball1n@netlog.com', '3I9a09Z', 'Manya Dyball', 'P', '1996-12-13', '7-(572)107-7113', '80 Porter Pass');
INSERT INTO pengguna VALUES ('cedington1o@omniture.com', 'QBbcreJS', 'Clare Edington', 'L', '1980-12-06', '55-(213)456-8830', '0 Center Avenue');
INSERT INTO pengguna VALUES ('msimione1p@sitemeter.com', 'x998Zyvvt', 'Miltie Simione', 'L', '1970-08-10', '86-(605)727-6446', '41 Shelley Pass');
INSERT INTO pengguna VALUES ('nstenett1q@buzzfeed.com', 'Ac15ApoXmT', 'Nicoli Stenett', 'P', '1995-12-22', '62-(253)891-9878', '36592 Northridge Road');
INSERT INTO pengguna VALUES ('efloodgate1r@stanford.edu', 'NK9Krmm', 'Elva Floodgate', 'P', '1971-10-17', '972-(784)744-9545', '10907 Mallory Drive');
INSERT INTO pengguna VALUES ('gvsanelli1s@timesonline.co.uk', 'wbK85MR', 'Gwyneth Vsanelli', 'L', '1996-10-09', '420-(657)145-8032', '204 Marcy Lane');
INSERT INTO pengguna VALUES ('pmaccarroll1t@umn.edu', 'Mq4Vmvf8I', 'Persis MacCarroll', 'L', '1977-04-21', '86-(335)211-6745', '7548 Kropf Lane');
INSERT INTO pengguna VALUES ('lnolte1u@webs.com', 'PJFJA4', 'Leanora Nolte', 'P', '1994-05-19', '996-(136)277-8173', '642 Glendale Parkway');
INSERT INTO pengguna VALUES ('singman1v@example.com', 'Pd6MbJjZuxVT', 'Shelden Ingman', 'P', '1971-07-24', '1-(847)467-1443', '80 Kinsman Court');
INSERT INTO pengguna VALUES ('gboschmann1w@themeforest.net', 'lKQO05NQW5', 'Giustino Boschmann', 'L', '1977-09-02', '63-(532)772-9658', '835 Welch Pass');
INSERT INTO pengguna VALUES ('avellden1x@seesaa.net', 'bvAtFp', 'Allyson Vellden', 'L', '1983-11-18', '62-(380)586-4687', '1494 Veith Circle');
INSERT INTO pengguna VALUES ('bjacqueminot1y@msu.edu', 'PPtcVdm67', 'Brana Jacqueminot', 'P', '1976-09-22', '46-(352)108-0951', '76288 Grim Terrace');
INSERT INTO pengguna VALUES ('omasham1z@meetup.com', 'Z27WFQ', 'Olia Masham', 'L', '1984-01-13', '48-(738)993-6149', '48698 Browning Junction');
INSERT INTO pengguna VALUES ('arowlatt20@alibaba.com', 'zjQujOeF', 'Adriane Rowlatt', 'P', '1990-12-03', '55-(958)726-1823', '18972 Utah Place');
INSERT INTO pengguna VALUES ('htubby21@samsung.com', '6lAm308', 'Hester Tubby', 'L', '1997-08-03', '86-(787)215-3410', '206 Magdeline Junction');
INSERT INTO pengguna VALUES ('rmachen22@businessinsider.com', 'mvfjFgL', 'Rochella Machen', 'P', '1995-08-09', '880-(589)663-7642', '2 Hovde Crossing');
INSERT INTO pengguna VALUES ('bisard23@irs.gov', 'pD9vSmN', 'Bartolomeo Isard', 'L', '1992-03-27', '351-(689)187-6745', '55 Lerdahl Lane');
INSERT INTO pengguna VALUES ('dcubin24@typepad.com', '3gfAkCEi', 'Dianne Cubin', 'L', '1985-12-12', '1-(972)588-3556', '6988 Barby Junction');
INSERT INTO pengguna VALUES ('schurn25@sogou.com', 'XIvB9mpmY', 'Stephan Churn', 'P', '1992-11-05', '64-(402)407-5957', '64 Waubesa Junction');
INSERT INTO pengguna VALUES ('pmease26@dell.com', 'eXZXlAYt', 'Paolo Mease', 'P', '1975-08-19', '1-(212)718-2768', '88 Canary Center');
INSERT INTO pengguna VALUES ('sgarric27@google.com', 'PnLedMfFoIep', 'Sharyl Garric', 'P', '1983-01-15', '86-(914)806-9644', '30 Chive Junction');
INSERT INTO pengguna VALUES ('durian28@phpbb.com', 'sTZu6xfDX', 'Datha Urian', 'P', '1992-09-24', '1-(806)289-9412', '82 Katie Center');
INSERT INTO pengguna VALUES ('rdiggins29@storify.com', 'fH1r0INr', 'Rudy Diggins', 'P', '1997-10-15', '55-(431)899-2119', '3084 Namekagon Parkway');
INSERT INTO pengguna VALUES ('imiettinen2a@goodreads.com', 'Js1yQ6s', 'Inna Miettinen', 'L', '1992-04-03', '86-(285)522-3687', '3 Norway Maple Street');
INSERT INTO pengguna VALUES ('kmowsley2b@cyberchimps.com', 'FA3ZpyW', 'Kitti Mowsley', 'L', '1980-02-22', '62-(452)600-5224', '8 3rd Point');
INSERT INTO pengguna VALUES ('tdilawey2c@tinyurl.com', 'f0DAknpj', 'Theresa Dilawey', 'L', '1985-04-26', '1-(952)487-4221', '581 Maywood Trail');
INSERT INTO pengguna VALUES ('ttourmell2d@dailymail.co.uk', 'YSHM3nhfEshK', 'Tasha Tourmell', 'P', '1991-03-27', '62-(823)546-4240', '85 South Point');
INSERT INTO pengguna VALUES ('cdocherty2e@gravatar.com', 'DP5Mawau9B2', 'Claudie Docherty', 'L', '1974-02-10', '54-(951)326-5942', '32759 Birchwood Crossing');
INSERT INTO pengguna VALUES ('cmalzard2f@acquirethisname.com', 'hsB49ZfZs', 'Christi Malzard', 'L', '1987-01-20', '62-(517)662-2679', '7134 Sunfield Trail');
INSERT INTO pengguna VALUES ('ejochens2g@ihg.com', 'WiPl2LMmTF', 'Esma Jochens', 'P', '1976-05-03', '385-(177)756-7420', '13683 Memorial Place');
INSERT INTO pengguna VALUES ('smathen2h@telegraph.co.uk', 'bRaAmHsdJ', 'Skell Mathen', 'L', '1978-07-10', '7-(434)916-8241', '42592 Warner Avenue');
INSERT INTO pengguna VALUES ('bmakeswell2i@toplist.cz', 'NHQmcres', 'Birch Makeswell', 'P', '1975-02-02', '7-(800)750-4068', '330 Prairieview Court');
INSERT INTO pengguna VALUES ('mhache2j@typepad.com', 'LBPpgSI5b', 'Mela Hache', 'L', '1992-09-30', '227-(474)269-7725', '2338 Thackeray Road');
INSERT INTO pengguna VALUES ('cpidgen2k@google.fr', 'IgmF1TU', 'Chancey Pidgen', 'P', '1981-01-23', '86-(443)637-4754', '14727 Bluestem Road');
INSERT INTO pengguna VALUES ('ghooban2l@cisco.com', 'Ak3pf7wxAW', 'Godfry Hooban', 'P', '1971-07-15', '86-(685)961-3056', '52 Oriole Court');
INSERT INTO pengguna VALUES ('xvery2m@facebook.com', 'mZzpveYRNf', 'Xerxes Very', 'L', '1981-12-12', '1-(582)920-9657', '9989 Sachs Pass');
INSERT INTO pengguna VALUES ('srainsdon2n@bluehost.com', 'gmiZ68b', 'Shandeigh Rainsdon', 'L', '1976-09-25', '86-(757)213-3290', '63 Elmside Park');
INSERT INTO pengguna VALUES ('gtiebe2o@google.pl', 'gTnvMoraeIco', 'Glen Tiebe', 'P', '1978-11-22', '63-(868)827-1644', '038 Mccormick Lane');
INSERT INTO pengguna VALUES ('mde2p@census.gov', 'Vql8qqEDw3', 'Marina De Souza', 'L', '1996-10-08', '46-(783)897-9099', '85 Corscot Road');
INSERT INTO pengguna VALUES ('nhubbucks2q@census.gov', 'YqKEopOwmu', 'Norman Hubbucks', 'P', '1973-09-26', '86-(749)854-0795', '553 Lyons Hill');
INSERT INTO pengguna VALUES ('lfrise2r@godaddy.com', 'nl39MkXRO', 'Lydon Frise', 'L', '1971-01-02', '46-(962)180-9550', '0999 Warrior Pass');
INSERT INTO pengguna VALUES ('ctembey2s@nhs.uk', 'gTvWaDNijuAJ', 'Carolann Tembey', 'P', '1982-05-03', '381-(714)972-8336', '01149 Farragut Court');
INSERT INTO pengguna VALUES ('dnottingam2t@marketwatch.com', 'VEkMso2V', 'Duffie Nottingam', 'L', '1982-05-12', '62-(878)160-4211', '493 Macpherson Place');
INSERT INTO pengguna VALUES ('jbarron2u@4shared.com', 'F7HpwHM7', 'Jaquith Barron', 'P', '1981-10-11', '356-(240)833-1500', '5 Thackeray Street');
INSERT INTO pengguna VALUES ('lguise2v@dagondesign.com', 'BXpIDGLvMYE', 'Lillian Guise', 'L', '1993-03-14', '66-(928)704-3353', '2668 Bartelt Point');
INSERT INTO pengguna VALUES ('ppidgen2w@paginegialle.it', 'ikISW8JGIzzK', 'Pattin Pidgen', 'L', '1991-04-27', '234-(895)787-7046', '729 Summer Ridge Plaza');
INSERT INTO pengguna VALUES ('dterrey2x@bloglines.com', '2HzljU202', 'Datha Terrey', 'P', '1989-09-17', '374-(957)559-7685', '9 Anthes Plaza');
INSERT INTO pengguna VALUES ('locannan2y@archive.org', 'BhbaHRpUjt', 'Lorna O''Cannan', 'L', '1972-04-25', '62-(453)786-2975', '610 Huxley Parkway');
INSERT INTO pengguna VALUES ('btethcote2z@yale.edu', 'Gg790vRGX', 'Bartolemo Tethcote', 'P', '1972-12-31', '385-(880)466-1359', '97 Hayes Place');
INSERT INTO pengguna VALUES ('gwhitworth30@slate.com', 'ku6PmLmHwwSZ', 'Grannie Whitworth', 'L', '1990-09-23', '31-(675)452-6079', '9 Hauk Plaza');
INSERT INTO pengguna VALUES ('atatters31@marketwatch.com', '2nBiS42dJdMT', 'Arny Tatters', 'L', '1975-01-30', '86-(188)689-9385', '0 Anderson Park');
INSERT INTO pengguna VALUES ('santonognoli32@si.edu', 'ppgZo4ZMH', 'Starlin Antonognoli', 'P', '1985-06-03', '33-(947)353-0317', '772 Carberry Trail');
INSERT INTO pengguna VALUES ('nleathers33@sbwire.com', 'IUeAqrQV', 'Nathalia Leathers', 'L', '1986-01-21', '7-(265)279-6141', '495 Basil Plaza');
INSERT INTO pengguna VALUES ('amcatamney34@toplist.cz', 'Hm24H2axq', 'Avis McAtamney', 'P', '1971-11-01', '383-(751)989-5173', '5471 Aberg Center');
INSERT INTO pengguna VALUES ('sspohr35@symantec.com', 'Srdw1bp9', 'Shandy Spohr', 'P', '1992-09-21', '62-(502)795-1768', '5 Express Drive');
INSERT INTO pengguna VALUES ('kbrain36@cbslocal.com', 'R9J8gt', 'Kendra Brain', 'P', '1976-01-31', '81-(251)937-5455', '93 Bobwhite Alley');
INSERT INTO pengguna VALUES ('poats37@squidoo.com', 'UaidzStq', 'Pauline Oats', 'P', '1970-05-23', '52-(549)533-9412', '021 Fulton Crossing');
INSERT INTO pengguna VALUES ('cjina38@tamu.edu', 'KZhfHSHKDHV', 'Corella Jina', 'P', '1985-05-29', '86-(241)617-5000', '059 Brown Alley');
INSERT INTO pengguna VALUES ('eboddymead39@flavors.me', '5NH5eQAhNh', 'Ethelda Boddymead', 'L', '1979-10-20', '972-(189)181-6332', '459 Tennessee Way');
INSERT INTO pengguna VALUES ('dplampin3a@java.com', 'f5jzZv', 'Danita Plampin', 'P', '1973-09-20', '60-(880)482-2976', '35426 Porter Trail');
INSERT INTO pengguna VALUES ('cround3b@kickstarter.com', 'n3vd8R', 'Chrysler Round', 'L', '1974-08-21', '33-(473)641-4111', '88881 Londonderry Road');
INSERT INTO pengguna VALUES ('tcolquete3c@goodreads.com', 'zRSS73fD73aJ', 'Toddie Colquete', 'L', '1982-11-12', '351-(975)788-2939', '27685 Arkansas Park');
INSERT INTO pengguna VALUES ('rjosselsohn3d@reverbnation.com', 'C6FxSW', 'Rubi Josselsohn', 'L', '1997-05-26', '66-(264)193-8554', '1096 Maple Wood Place');
INSERT INTO pengguna VALUES ('mrau3e@home.pl', 'jUxcbD', 'Marven Rau', 'P', '1975-12-07', '60-(341)940-9024', '7409 Kinsman Junction');
INSERT INTO pengguna VALUES ('mruperto3f@apple.com', 'NprcTKm', 'Munmro Ruperto', 'L', '1971-04-23', '62-(757)612-5885', '5461 Longview Way');
INSERT INTO pengguna VALUES ('amerrall3g@apple.com', 'xeaTxyiohXi', 'Avivah Merrall', 'L', '1971-12-02', '86-(702)242-6728', '19869 Parkside Plaza');
INSERT INTO pengguna VALUES ('acleveland3h@rakuten.co.jp', 'A90oNfsiW', 'Aubry Cleveland', 'P', '1983-08-20', '358-(546)319-1856', '06 Almo Drive');
INSERT INTO pengguna VALUES ('nbaiden3i@cam.ac.uk', 'g4NLvPhmx', 'Nathaniel Baiden', 'P', '1987-02-26', '675-(157)683-6346', '49264 Monica Park');
INSERT INTO pengguna VALUES ('sjurczak3j@moonfruit.com', 'vwkfVjd', 'Sampson Jurczak', 'P', '1970-07-31', '7-(757)152-6212', '7952 David Drive');
INSERT INTO pengguna VALUES ('gkidwell3k@kickstarter.com', 'lZdoRxh', 'Gregor Kidwell', 'P', '1974-08-14', '970-(353)993-3683', '72 Summit Parkway');
INSERT INTO pengguna VALUES ('nrigmond3l@google.ca', '4zKS1ht6s8', 'Nikolos Rigmond', 'P', '1978-01-24', '84-(126)409-7097', '61954 Warrior Hill');
INSERT INTO pengguna VALUES ('nfilipychev3m@washington.edu', 'ItRT6dR4mz1o', 'Natasha Filipychev', 'L', '1988-12-02', '420-(939)345-0158', '73 Laurel Hill');
INSERT INTO pengguna VALUES ('wgent3n@pcworld.com', 'ecLU9fJXyeyf', 'Weider Gent', 'L', '1972-03-17', '976-(182)328-7671', '5 Eagan Plaza');
INSERT INTO pengguna VALUES ('cdoughty3o@i2i.jp', 'K6LdU0usol', 'Chrisy Doughty', 'L', '1971-11-04', '355-(805)329-9472', '8 Vahlen Hill');
INSERT INTO pengguna VALUES ('dde3p@wikia.com', '5VpWQegRkL2z', 'De De Ath', 'P', '1986-02-24', '55-(455)358-5877', '698 Acker Avenue');
INSERT INTO pengguna VALUES ('btassaker3q@house.gov', 'lWl6Ji', 'Binky Tassaker', 'L', '1979-10-13', '387-(782)478-9649', '66481 Hagan Lane');
INSERT INTO pengguna VALUES ('ngagin3r@amazon.co.uk', 'mxOVxAK9', 'Nick Gagin', 'L', '1985-11-06', '51-(585)440-4828', '63230 Acker Plaza');
INSERT INTO pengguna VALUES ('lswinfen3s@cbc.ca', 'Rz8iSA7', 'Lucilia Swinfen', 'L', '1971-11-01', '63-(223)913-0157', '1 Amoth Way');
INSERT INTO pengguna VALUES ('sklemke3t@lycos.com', 'tx2mIZHv', 'Siana Klemke', 'P', '1994-09-15', '60-(659)924-2368', '52370 Fallview Point');
INSERT INTO pengguna VALUES ('aschmidt3u@wikia.com', 'gCqP0sJd', 'Aloysius Schmidt', 'L', '1978-08-26', '66-(115)843-0871', '9754 Farragut Crossing');
INSERT INTO pengguna VALUES ('mrakes3v@tinyurl.com', 'HYn1jYJUmMTt', 'Myrtle Rakes', 'L', '1988-07-06', '86-(950)631-4210', '9 Pierstorff Drive');
INSERT INTO pengguna VALUES ('dspuner3w@nature.com', 'z5OJfr', 'Dulcia Spuner', 'P', '1991-08-08', '86-(241)677-5160', '4 Havey Lane');
INSERT INTO pengguna VALUES ('jluxford3x@statcounter.com', '37BIyd', 'Jerad Luxford', 'P', '1984-04-28', '234-(901)578-8658', '90662 Drewry Circle');
INSERT INTO pengguna VALUES ('lgaskin3y@uiuc.edu', 'MvMQql', 'Lulita Gaskin', 'L', '1981-12-18', '46-(273)870-2339', '4 Marquette Avenue');
INSERT INTO pengguna VALUES ('mellett3z@nhs.uk', 'YHgleV', 'Melissa Ellett', 'L', '1985-06-04', '687-(261)964-2603', '21 Eliot Park');
INSERT INTO pengguna VALUES ('kbalfour40@pagesperso-orange.fr', 'qZPidP3', 'Kary Balfour', 'L', '1997-10-22', '7-(579)809-8770', '79 Goodland Park');
INSERT INTO pengguna VALUES ('sdilleway41@unesco.org', 'dWq6Fvj', 'Sanders Dilleway', 'L', '1984-03-20', '1-(963)513-0418', '3749 Oxford Court');
INSERT INTO pengguna VALUES ('kmohammed42@plala.or.jp', '33orr5d7wP', 'Kassi Mohammed', 'P', '1995-07-24', '47-(724)425-1658', '47409 Schurz Way');
INSERT INTO pengguna VALUES ('dcollinson43@usnews.com', 'O6zdIv4b', 'Dido Collinson', 'L', '1975-10-02', '63-(647)536-8710', '24 Glacier Hill Junction');
INSERT INTO pengguna VALUES ('agasgarth44@is.gd', 'A3U8ay', 'Anabella Gasgarth', 'P', '1994-10-16', '380-(887)689-4824', '8 Cascade Alley');
INSERT INTO pengguna VALUES ('tmerill45@google.com.br', 'wKzfDHCLJQ', 'Terencio Merill', 'L', '1971-07-24', '595-(790)731-2235', '0 Pleasure Trail');
INSERT INTO pengguna VALUES ('tcloney46@alibaba.com', 'N7mKd9P7MYTw', 'Tallie Cloney', 'L', '1970-10-13', '62-(167)694-6015', '494 Bunting Drive');
INSERT INTO pengguna VALUES ('etomsa47@unc.edu', 'DYrB8SEaidV', 'Earvin Tomsa', 'L', '1989-08-07', '62-(301)799-0918', '90930 Garrison Junction');
INSERT INTO pengguna VALUES ('tbeecroft48@squarespace.com', 'anEvlWIcSw', 'Tania Beecroft', 'P', '1992-12-10', '86-(897)662-0434', '0 Tony Lane');
INSERT INTO pengguna VALUES ('troyal49@deliciousdays.com', 'LQWK5hk', 'Tamra Royal', 'P', '1972-11-11', '62-(872)869-5783', '39697 Amoth Avenue');
INSERT INTO pengguna VALUES ('htreagust4a@homestead.com', 'ZtoHS2YCAwF', 'Harriot Treagust', 'P', '1983-08-04', '7-(820)371-9827', '49 Hoard Place');
INSERT INTO pengguna VALUES ('lstiggles4b@ucoz.com', '3uVQXnL4de0K', 'Lay Stiggles', 'L', '1978-09-08', '240-(297)267-7435', '588 Atwood Street');
INSERT INTO pengguna VALUES ('showes4c@opera.com', 'Mb6AbH', 'Storm Howes', 'P', '1979-06-09', '62-(674)104-4574', '6901 Harper Trail');
INSERT INTO pengguna VALUES ('lgoggen4d@discovery.com', 'upcZv8h7vT', 'Lavinie Goggen', 'L', '1991-01-28', '7-(678)520-7762', '804 Fuller Park');
INSERT INTO pengguna VALUES ('obernaldez4e@mediafire.com', 'gHLNPhti', 'Ophelie Bernaldez', 'P', '1985-03-02', '86-(683)798-8324', '09914 Myrtle Court');
INSERT INTO pengguna VALUES ('kjoddens4f@jimdo.com', 'nChHCXquBCRN', 'Kaycee Joddens', 'P', '1982-05-31', '86-(407)861-3269', '58 Autumn Leaf Crossing');
INSERT INTO pengguna VALUES ('rjozaitis4g@icio.us', 'nSCqO7Al', 'Ruben Jozaitis', 'P', '1986-10-28', '48-(126)899-8395', '621 Forster Street');
INSERT INTO pengguna VALUES ('mpierson4h@goo.gl', 'DUMYWuFH5jQn', 'Melissa Pierson', 'P', '1972-11-12', '355-(702)832-9837', '2999 Forster Plaza');
INSERT INTO pengguna VALUES ('aginnaly4i@state.gov', 'EEzSiMj02', 'Addy Ginnaly', 'P', '1986-06-07', '46-(742)227-5711', '54460 Hintze Park');
INSERT INTO pengguna VALUES ('mhavercroft4j@redcross.org', 'bRatdWoV', 'Miriam Havercroft', 'L', '1971-04-09', '1-(321)954-2294', '4 Derek Crossing');
INSERT INTO pengguna VALUES ('apicopp4k@uol.com.br', '3xMPXrd', 'Amandi Picopp', 'P', '1979-08-25', '62-(255)150-0301', '5 Carpenter Parkway');
INSERT INTO pengguna VALUES ('dollivierre4l@statcounter.com', 'v5z1cjh3Y0I', 'Danna Ollivierre', 'L', '1970-09-16', '63-(871)813-6977', '730 Goodland Road');
INSERT INTO pengguna VALUES ('hsiley4m@msu.edu', 'FhoIxU', 'Harp Siley', 'L', '1989-01-12', '46-(267)447-6708', '5 Lerdahl Terrace');
INSERT INTO pengguna VALUES ('jtwigger4n@printfriendly.com', 'CUbkcko', 'Jodi Twigger', 'L', '1993-07-09', '57-(235)448-3079', '41 Pleasure Park');
INSERT INTO pengguna VALUES ('yduffett4o@va.gov', 'X6iWdIV', 'Yank Duffett', 'P', '1993-01-10', '381-(414)995-8371', '52228 Sugar Crossing');
INSERT INTO pengguna VALUES ('wmcdonand4p@sitemeter.com', 'GxEKuMp0T', 'Wood McDonand', 'L', '1975-01-29', '55-(531)777-3785', '60 Maryland Pass');
INSERT INTO pengguna VALUES ('kdinsale4q@gizmodo.com', 'Qv12uCrl', 'Karyn Dinsale', 'L', '1992-10-07', '56-(841)585-5390', '3 Cardinal Parkway');
INSERT INTO pengguna VALUES ('rkinnin4r@odnoklassniki.ru', 'ixXYWbC', 'Rozalie Kinnin', 'L', '1971-04-22', '36-(246)356-6086', '08 Old Shore Circle');
INSERT INTO pengguna VALUES ('flapish4s@indiatimes.com', 'BZnA4D34yjx', 'Fayina Lapish', 'P', '1985-10-23', '234-(594)910-9499', '8729 Blaine Center');
INSERT INTO pengguna VALUES ('bridger4t@over-blog.com', '9cqs1yZ', 'Blanca Ridger', 'L', '1991-08-04', '46-(368)161-8575', '97 Rusk Park');
INSERT INTO pengguna VALUES ('lfairleigh4u@nymag.com', 'Nq3qrI3hRU', 'Leicester Fairleigh', 'P', '1994-06-27', '234-(217)683-2058', '450 Division Alley');
INSERT INTO pengguna VALUES ('blampen4v@linkedin.com', '0nXo8PHtuacb', 'Brigida Lampen', 'L', '1977-02-03', '86-(487)802-0763', '8371 Anzinger Point');
INSERT INTO pengguna VALUES ('acereceres4w@alexa.com', 'fEL2YibbJt', 'Adelind Cereceres', 'P', '1980-08-26', '51-(751)752-8226', '73 Bunting Place');
INSERT INTO pengguna VALUES ('vlockhart4x@csmonitor.com', 'DIFQ1pC', 'Valina Lockhart', 'P', '1970-07-21', '963-(522)558-6424', '7526 Moulton Crossing');
INSERT INTO pengguna VALUES ('tcrompton4y@utexas.edu', 'sncIGVX', 'Taylor Crompton', 'L', '1977-09-08', '1-(682)895-5792', '568 Glendale Point');
INSERT INTO pengguna VALUES ('dmcauslene4z@amazon.com', 'T0AnlYW', 'Dannel McAuslene', 'P', '1971-03-28', '84-(593)580-9168', '9 Mariners Cove Place');
INSERT INTO pengguna VALUES ('ebromhead50@tinypic.com', 'wrCByS63Cat', 'Egbert Bromhead', 'L', '1975-09-08', '63-(540)859-4441', '85 7th Alley');
INSERT INTO pengguna VALUES ('smockler51@un.org', '9lwjkYzdJ', 'Sydelle Mockler', 'L', '1986-11-30', '373-(148)229-9557', '4637 Village Green Way');
INSERT INTO pengguna VALUES ('tbrettle52@wsj.com', 'PVklxPsUhF', 'Titos Brettle', 'P', '1993-12-16', '33-(548)348-0158', '0 Daystar Plaza');
INSERT INTO pengguna VALUES ('vianni53@csmonitor.com', '5fif4Bw', 'Valentine Ianni', 'P', '1983-01-25', '62-(409)478-7650', '4 Emmet Pass');
INSERT INTO pengguna VALUES ('fwasson54@goo.ne.jp', 'bAWobX', 'Frieda Wasson', 'P', '1971-06-12', '33-(791)757-7686', '24 Pankratz Point');
INSERT INTO pengguna VALUES ('ghamberston55@foxnews.com', 'O4PxrX3h1', 'Giorgia Hamberston', 'P', '1983-09-03', '7-(783)471-6075', '1 Kipling Crossing');
INSERT INTO pengguna VALUES ('abury56@tmall.com', 'dfK5JSDs9', 'Arnold Bury', 'P', '1996-07-19', '66-(393)782-4892', '50605 Melvin Avenue');
INSERT INTO pengguna VALUES ('jbibbie57@hp.com', 'wQen1a', 'Jess Bibbie', 'L', '1982-07-03', '62-(238)400-9593', '35 Westport Pass');
INSERT INTO pengguna VALUES ('ralders58@tripod.com', '3O1CP7cuJj', 'Robers Alders', 'P', '1977-06-09', '46-(265)378-3994', '944 Meadow Valley Way');
INSERT INTO pengguna VALUES ('dyankin59@quantcast.com', 'KDGu0KE1c3VH', 'Dode Yankin', 'L', '1988-02-21', '995-(891)137-8917', '143 Pleasure Park');
INSERT INTO pengguna VALUES ('arangall5a@reference.com', 'zEP0LGl9', 'Ardine Rangall', 'L', '1984-05-10', '7-(776)123-9418', '97609 Randy Circle');
INSERT INTO pengguna VALUES ('otamblyn5b@arstechnica.com', 'PSycjpY2B', 'Obadiah Tamblyn', 'L', '1987-01-06', '33-(770)529-0185', '382 Lakewood Gardens Avenue');
INSERT INTO pengguna VALUES ('jdominici5c@wp.com', 'EQIAYsp', 'Jacky Dominici', 'P', '1994-12-27', '66-(996)151-9780', '4549 Barby Drive');
INSERT INTO pengguna VALUES ('kchessor5d@unc.edu', 'Sgk3m1P7', 'Karol Chessor', 'P', '1995-03-23', '60-(938)304-9093', '9807 Almo Street');
INSERT INTO pengguna VALUES ('cpeizer5e@vk.com', 'gbOm6HwRaF2', 'Corrine Peizer', 'P', '1973-03-28', '86-(794)697-5237', '4 Dryden Crossing');
INSERT INTO pengguna VALUES ('dpartlett5f@wikia.com', 'CgtLXpbCg0', 'Devonne Partlett', 'L', '1992-08-23', '263-(276)873-5466', '422 Magdeline Court');
INSERT INTO pengguna VALUES ('hlamey5g@arstechnica.com', 'tVzOTicl', 'Hortense Lamey', 'P', '1997-08-04', '86-(611)356-3887', '91 Fairfield Crossing');
INSERT INTO pengguna VALUES ('vedgcumbe5h@prweb.com', 'dzGPrAP', 'Veronika Edgcumbe', 'P', '1987-03-23', '351-(289)259-7281', '8526 Charing Cross Park');
INSERT INTO pengguna VALUES ('amcgilvray5i@soup.io', 'oq9babp3', 'Angelina McGilvray', 'P', '1992-07-31', '47-(622)224-6844', '99 Norway Maple Crossing');
INSERT INTO pengguna VALUES ('thackford5j@uiuc.edu', '9eD5LA', 'Tades Hackford', 'L', '1989-08-22', '234-(235)869-8615', '115 Logan Place');
INSERT INTO pengguna VALUES ('mhastewell5k@ask.com', 'hEdVMYLMb3Ex', 'Madeleine Hastewell', 'P', '1981-06-30', '86-(975)522-9270', '5636 Nevada Alley');
INSERT INTO pengguna VALUES ('llawlings5l@china.com.cn', '0o9Ukl', 'Link Lawlings', 'P', '1996-06-15', '86-(490)849-3056', '94 Talisman Alley');
INSERT INTO pengguna VALUES ('rmaybey5m@pbs.org', 'oLTRVq', 'Raddy Maybey', 'L', '1978-12-09', '62-(106)162-9997', '83 Oakridge Place');
INSERT INTO pengguna VALUES ('tlacroutz5n@icio.us', 'bSCj43I77', 'Terry Lacroutz', 'P', '1981-02-28', '7-(374)146-9514', '977 Thompson Street');
INSERT INTO pengguna VALUES ('yelger5o@trellian.com', '0puQGy966', 'Yehudi Elger', 'L', '1980-06-27', '33-(829)434-8678', '947 Anhalt Plaza');
INSERT INTO pengguna VALUES ('ilerego5p@github.io', 'efRee7Dx', 'Ingra Lerego', 'P', '1986-06-24', '57-(124)414-2960', '620 Vidon Parkway');
INSERT INTO pengguna VALUES ('mmaymand5q@wikia.com', '3GKC1EakA', 'Marthe Maymand', 'P', '1996-05-29', '86-(799)281-6560', '31 Dayton Pass');
INSERT INTO pengguna VALUES ('tdjurkovic5r@livejournal.com', 'k0eeOu4zHUf', 'Tanner Djurkovic', 'L', '1972-04-05', '33-(474)153-8280', '84072 Beilfuss Circle');
INSERT INTO pengguna VALUES ('jburridge5s@cloudflare.com', '71QzrN', 'Jody Burridge', 'L', '1995-03-31', '254-(515)371-3205', '5962 Paget Point');
INSERT INTO pengguna VALUES ('acappel5t@hubpages.com', 'ZkHzuQuJx', 'Alanson Cappel', 'P', '1976-12-03', '86-(307)814-0404', '086 Messerschmidt Pass');
INSERT INTO pengguna VALUES ('pbittlestone5u@auda.org.au', 'ihmMkxHMI3', 'Park Bittlestone', 'P', '1980-08-15', '7-(237)797-4566', '8 Randy Park');
INSERT INTO pengguna VALUES ('ntrowel5v@bravesites.com', 'lTlmHRpg5z', 'Neysa Trowel', 'L', '1994-11-22', '86-(189)229-2045', '714 Hayes Drive');
INSERT INTO pengguna VALUES ('ejanicki5w@barnesandnoble.com', 'wiCfDn4SZzi', 'Enrica Janicki', 'P', '1978-12-09', '86-(724)346-4275', '1035 Tomscot Drive');
INSERT INTO pengguna VALUES ('ngaudin5x@furl.net', '82OgADWYmiQS', 'Noam Gaudin', 'P', '1971-12-09', '1-(847)185-0757', '695 Crownhardt Center');
INSERT INTO pengguna VALUES ('moliphand5y@china.com.cn', 'zK4AlkcG0wlQ', 'Minette Oliphand', 'L', '1975-09-17', '48-(159)387-2240', '18047 Pankratz Pass');
INSERT INTO pengguna VALUES ('aboullen5z@usgs.gov', '27ZUhxv', 'Adlai Boullen', 'L', '1994-05-20', '48-(280)264-5272', '028 Carey Drive');
INSERT INTO pengguna VALUES ('bbilston60@wunderground.com', 'tHoLVfZVh6K', 'Brit Bilston', 'P', '1972-08-14', '216-(467)409-1259', '429 Miller Road');
INSERT INTO pengguna VALUES ('aespie61@yandex.ru', 'BfsCzRVe25Ck', 'Arnuad Espie', 'P', '1972-12-06', '51-(140)777-3704', '3 Dennis Junction');
INSERT INTO pengguna VALUES ('aeidelman62@yale.edu', '3Mz86soEt', 'Audry Eidelman', 'L', '1986-10-22', '7-(446)396-0581', '0 Ramsey Crossing');
INSERT INTO pengguna VALUES ('rspeer63@topsy.com', 'sHlAw3', 'Robbie Speer', 'P', '1997-07-05', '258-(715)851-9053', '9 Hayes Street');
INSERT INTO pengguna VALUES ('bde64@smugmug.com', '70YbU4iG5iD3', 'Bonny de Amaya', 'L', '1989-07-08', '63-(612)656-3404', '70731 Declaration Circle');
INSERT INTO pengguna VALUES ('mmckernon65@wordpress.org', 'v5bbJY6U7qmr', 'Mortie McKernon', 'P', '1971-01-25', '967-(225)143-9199', '3 Dexter Court');
INSERT INTO pengguna VALUES ('sspataro66@msu.edu', 'UCudwVdCqd', 'Saudra Spataro', 'P', '1992-02-23', '86-(344)630-3639', '8034 Doe Crossing Circle');
INSERT INTO pengguna VALUES ('pgiovannini67@google.com.br', 'gdPC5TtPS', 'Pail Giovannini', 'P', '1992-10-12', '63-(440)180-2464', '5165 Eliot Terrace');
INSERT INTO pengguna VALUES ('sarnholz68@miitbeian.gov.cn', 'wZDz2Tec67', 'Scott Arnholz', 'P', '1982-05-04', '7-(765)703-6207', '58 Sloan Court');
INSERT INTO pengguna VALUES ('gshilliday69@creativecommons.org', '9l0z261UM', 'Gilligan Shilliday', 'P', '1972-01-27', '216-(724)668-1190', '9205 Anhalt Crossing');
INSERT INTO pengguna VALUES ('iolahy6a@yellowpages.com', '8QxXxSi1ca', 'Ingunna O''Lahy', 'L', '1980-07-12', '86-(948)109-6129', '61282 Farragut Pass');
INSERT INTO pengguna VALUES ('dtredinnick6b@163.com', 'TgGqoR9u', 'Deidre Tredinnick', 'P', '1983-08-27', '27-(300)620-2497', '1 Dakota Junction');
INSERT INTO pengguna VALUES ('croston6c@amazon.de', 'ICt0WkM', 'Cullin Roston', 'L', '1986-11-09', '81-(491)785-2606', '2 Continental Park');
INSERT INTO pengguna VALUES ('bcussins6d@google.fr', 'KesHJMv', 'Barnabas Cussins', 'L', '1992-03-23', '62-(861)366-0636', '9425 1st Place');
INSERT INTO pengguna VALUES ('grodgman6e@cargocollective.com', 'PHHxinLau', 'Glendon Rodgman', 'P', '1996-01-20', '86-(736)405-5668', '5 Burrows Avenue');
INSERT INTO pengguna VALUES ('agilhool6f@addtoany.com', 'IYAPLFGE', 'Alair Gilhool', 'L', '1983-08-08', '351-(274)134-0052', '642 Sommers Road');
INSERT INTO pengguna VALUES ('pproven6g@utexas.edu', 'icfWbB', 'Pattin Proven', 'P', '1994-09-02', '502-(792)150-0720', '7336 Mockingbird Crossing');
INSERT INTO pengguna VALUES ('ywestrip6h@pen.io', 'D3pOx01u', 'Yoko Westrip', 'P', '1984-05-30', '63-(194)414-9365', '60 Sloan Center');
INSERT INTO pengguna VALUES ('lfeasey6i@godaddy.com', 'xJxN4zUhkLO', 'Lynnet Feasey', 'P', '1980-03-28', '380-(512)706-6824', '163 Bluejay Place');
INSERT INTO pengguna VALUES ('fjeffcock6j@canalblog.com', 'YnXIYMo', 'Ferdinanda Jeffcock', 'L', '1979-05-09', '86-(169)179-8984', '8540 Hermina Crossing');
INSERT INTO pengguna VALUES ('gplenty6k@hc360.com', 'jqiGWY5WXs', 'Giusto Plenty', 'P', '1991-10-03', '251-(466)382-1840', '22 High Crossing Road');
INSERT INTO pengguna VALUES ('cvasyanin6l@mtv.com', 'O7BC3X', 'Crin Vasyanin', 'L', '1984-08-25', '62-(597)590-9581', '92889 Harper Junction');
INSERT INTO pengguna VALUES ('lcallander6m@mayoclinic.com', 'AygH9ptMrVp4', 'Loydie Callander', 'P', '1992-05-10', '46-(400)724-2180', '5907 American Trail');
INSERT INTO pengguna VALUES ('rgraffham6n@ask.com', 'kyzPbkT', 'Raddy Graffham', 'P', '1976-08-19', '58-(374)430-7495', '41 Darwin Way');
INSERT INTO pengguna VALUES ('jfyndon6o@cdc.gov', 'emv63uMMy', 'Jess Fyndon', 'L', '1970-12-22', '84-(607)461-0964', '563 Southridge Lane');
INSERT INTO pengguna VALUES ('opetigrew6p@devhub.com', 'SAzhk2P2oAP', 'Olvan Petigrew', 'L', '1987-03-09', '48-(961)487-6019', '0184 Ramsey Road');
INSERT INTO pengguna VALUES ('nianilli6q@google.pl', 'TeN2OeL', 'Nealson Ianilli', 'P', '1996-08-31', '1-(404)592-7374', '7 Veith Circle');
INSERT INTO pengguna VALUES ('fwadeson6r@discuz.net', 'aTOpJp2M2HL', 'Fayre Wadeson', 'L', '1988-05-14', '351-(672)523-3344', '114 Rigney Street');
INSERT INTO pengguna VALUES ('cmcgarrell6s@dropbox.com', 'p3s8ZQg4s', 'Chelsae McGarrell', 'L', '1994-07-07', '227-(347)641-7211', '5117 Anthes Terrace');
INSERT INTO pengguna VALUES ('kasprey6t@symantec.com', '3rHu6RNC80', 'Keith Asprey', 'L', '1977-09-03', '46-(168)453-6053', '11 Pawling Court');
INSERT INTO pengguna VALUES ('jbirtwisle6u@discovery.com', '3KWaTNrMRU', 'Jill Birtwisle', 'P', '1971-12-26', '63-(274)896-9834', '87 Florence Way');
INSERT INTO pengguna VALUES ('jbradburne6v@odnoklassniki.ru', '8CQQlo9', 'Jerrilyn Bradburne', 'P', '1991-01-03', '63-(775)738-3829', '5639 Fuller Plaza');
INSERT INTO pengguna VALUES ('jwenger6w@wunderground.com', 'YCznzP7uzKBh', 'Joannes Wenger', 'P', '1983-01-21', '57-(551)387-1206', '094 Killdeer Crossing');
INSERT INTO pengguna VALUES ('cpetruskevich6x@who.int', 'CqJDS2', 'Chandler Petruskevich', 'L', '1993-04-05', '47-(394)466-4632', '304 Farmco Pass');
INSERT INTO pengguna VALUES ('iscrogges6y@samsung.com', 'bnkC6drhzhK', 'Ingaborg Scrogges', 'L', '1990-10-22', '381-(940)311-6420', '1 Debs Hill');
INSERT INTO pengguna VALUES ('rpendergrast6z@hao123.com', 'gBVlrXBW', 'Rebecca Pendergrast', 'P', '1998-04-02', '7-(344)393-8753', '9 Claremont Avenue');
INSERT INTO pengguna VALUES ('aluetkemeyers70@miibeian.gov.cn', '5uQJF4hftU', 'Antonin Luetkemeyers', 'P', '1992-08-09', '31-(626)791-6153', '114 Heath Way');
INSERT INTO pengguna VALUES ('cpittford71@photobucket.com', 'c4aUnf3jAKp', 'Cecil Pittford', 'P', '1983-04-07', '62-(279)769-4221', '90935 Kim Street');
INSERT INTO pengguna VALUES ('kskerm72@list-manage.com', 'v8Ia2MkAIQ', 'Kevin Skerm', 'P', '1980-02-11', '1-(602)889-6291', '70 Thierer Avenue');
INSERT INTO pengguna VALUES ('lsparling73@fema.gov', 'w5XqFI5f', 'Leonardo Sparling', 'P', '1989-05-22', '505-(547)304-9010', '534 Macpherson Point');
INSERT INTO pengguna VALUES ('dde74@fc2.com', 'cLjGGmq', 'Davida De Pero', 'P', '1995-10-04', '86-(268)952-2480', '5 Stang Trail');
INSERT INTO pengguna VALUES ('nbeale75@sohu.com', 'bsJEK0DAe', 'Nadiya Beale', 'P', '1971-09-22', '62-(397)667-1788', '07 Vermont Place');
INSERT INTO pengguna VALUES ('cegdal76@edublogs.org', 'iV5FZLX', 'Cassandra Egdal', 'L', '1998-04-19', '351-(206)492-4140', '6301 Washington Hill');
INSERT INTO pengguna VALUES ('umcjury77@hp.com', 'QDinKsSXW7c3', 'Uri McJury', 'P', '1990-08-25', '351-(826)838-9403', '74 International Pass');
INSERT INTO pengguna VALUES ('mramsdell78@paypal.com', 'G59PAlVIeDwP', 'Myriam Ramsdell', 'L', '1985-09-10', '86-(643)466-9757', '5 Loftsgordon Way');
INSERT INTO pengguna VALUES ('rroffe79@smh.com.au', 'h7pTNj3opdje', 'Ray Roffe', 'L', '1982-04-03', '420-(250)660-2569', '8414 Dunning Plaza');
INSERT INTO pengguna VALUES ('mchillingworth7a@themeforest.net', '1k81dwUVoxTI', 'Mick Chillingworth', 'P', '1991-10-23', '30-(982)973-5247', '86 Mayfield Parkway');
INSERT INTO pengguna VALUES ('bcochran7b@smugmug.com', 'RIPuTghzrZ', 'Bernhard Cochran', 'L', '1988-02-26', '86-(247)244-9025', '83160 Dovetail Way');
INSERT INTO pengguna VALUES ('rbarff7c@goo.gl', 'J01b1zuJMNf', 'Ramona Barff', 'P', '1979-11-19', '62-(772)339-8455', '2 Heffernan Plaza');
INSERT INTO pengguna VALUES ('dsketcher7d@ehow.com', '7OwkJbw', 'Dexter Sketcher', 'L', '1980-09-22', '63-(866)320-9846', '6 Fisk Place');
INSERT INTO pengguna VALUES ('gdecent7e@pinterest.com', '7R9e7tM', 'Gerda Decent', 'P', '1983-06-19', '48-(750)839-8711', '4684 Shoshone Terrace');
INSERT INTO pengguna VALUES ('sestcot7f@nbcnews.com', 'nMPUiMQ', 'Sharon Estcot', 'L', '1977-02-13', '86-(286)284-8077', '82931 Clemons Pass');
INSERT INTO pengguna VALUES ('ishord7g@bloglines.com', 'vkySgj17pO', 'Ivett Shord', 'P', '1990-04-13', '52-(771)199-5347', '5141 Elmside Plaza');
INSERT INTO pengguna VALUES ('bdaunay7h@elegantthemes.com', 'nlBMND0DlS', 'Bailie Daunay', 'L', '1991-02-23', '7-(325)901-8710', '3 Mariners Cove Drive');
INSERT INTO pengguna VALUES ('aaliman7i@wp.com', 'ZM8iGrR1EBo', 'Aubree Aliman', 'L', '1973-06-14', '62-(183)428-4525', '5 Shasta Trail');
INSERT INTO pengguna VALUES ('swoolgar7j@thetimes.co.uk', 'n7MIjkWbO', 'Steffen Woolgar', 'L', '1979-02-02', '86-(394)818-1697', '3 Independence Circle');
INSERT INTO pengguna VALUES ('cborborough7k@twitter.com', '8Qd2Koh', 'Catrina Borborough', 'L', '1988-05-16', '51-(784)595-7733', '5 Chive Court');
INSERT INTO pengguna VALUES ('mgoodsal7l@virginia.edu', 'BfaZnm8', 'Margalo Goodsal', 'L', '1970-12-07', '86-(423)370-8656', '651 Hauk Avenue');
INSERT INTO pengguna VALUES ('gsherwyn7m@deviantart.com', 'bwPZwszojhE', 'Gran Sherwyn', 'P', '1978-11-18', '351-(917)391-0839', '2347 Myrtle Junction');
INSERT INTO pengguna VALUES ('aoldam7n@google.fr', 'm7H2Xhm2X', 'Aggie Oldam', 'P', '1988-06-13', '46-(609)516-8299', '2725 Hintze Place');
INSERT INTO pengguna VALUES ('mjindrich7o@twitter.com', 'Kipedb3ocnA4', 'Meriel Jindrich', 'L', '1979-06-07', '420-(307)931-1673', '409 Muir Place');
INSERT INTO pengguna VALUES ('bandryunin7p@cyberchimps.com', 'MzjI3gW7we', 'Blane Andryunin', 'P', '1974-04-24', '81-(399)653-4882', '4638 Troy Street');
INSERT INTO pengguna VALUES ('tfulleylove7q@nps.gov', 'AcmCaLfnzudA', 'Tallou Fulleylove', 'P', '1994-06-09', '84-(731)928-9349', '9 Schmedeman Drive');
INSERT INTO pengguna VALUES ('ereffe7r@about.me', 'tf6mQBUpgV', 'Ediva Reffe', 'L', '1971-05-06', '351-(717)504-2065', '03 Saint Paul Point');
INSERT INTO pengguna VALUES ('streasure7s@godaddy.com', 'kXwzCl', 'Stanley Treasure', 'P', '1982-01-06', '386-(499)203-0322', '16371 Del Mar Center');
INSERT INTO pengguna VALUES ('psculley7t@t-online.de', '2A8nsk', 'Paddie Sculley', 'L', '1987-01-07', '62-(307)100-6838', '2743 Veith Circle');
INSERT INTO pengguna VALUES ('frodbourne7u@histats.com', '8S1It9hPYsE0', 'Fern Rodbourne', 'L', '1973-05-02', '62-(776)839-3625', '52 Erie Avenue');
INSERT INTO pengguna VALUES ('doris7v@taobao.com', 'fL5a6vceYma', 'Doroteya Oris', 'P', '1984-12-02', '62-(389)250-8313', '509 Lunder Trail');
INSERT INTO pengguna VALUES ('acumberpatch7w@about.me', 'LnPmKaQM7s', 'Anatol Cumberpatch', 'L', '1977-10-02', '46-(407)513-0546', '459 Blaine Court');
INSERT INTO pengguna VALUES ('dwitt7x@forbes.com', '3PQwZw', 'De witt Buxcey', 'P', '1985-06-21', '86-(350)104-3710', '04813 Armistice Parkway');
INSERT INTO pengguna VALUES ('preddish7y@1und1.de', 'EjQWvkbo0', 'Pippo Reddish', 'P', '1972-01-21', '86-(525)203-0875', '52070 Fallview Street');
INSERT INTO pengguna VALUES ('mdivine7z@naver.com', 'eUeev9BUZrL', 'Mabel Divine', 'L', '1982-07-31', '255-(794)843-6368', '41 Brentwood Place');
INSERT INTO pengguna VALUES ('hcaesar80@sina.com.cn', 'izVwUyWoKV', 'Hasheem Caesar', 'P', '1993-12-01', '880-(314)102-0344', '203 Redwing Junction');
INSERT INTO pengguna VALUES ('akiltie81@edublogs.org', '0ssn4w48rwi3', 'Annora Kiltie', 'L', '1971-11-26', '372-(411)865-6970', '5 Pierstorff Point');
INSERT INTO pengguna VALUES ('dmoller82@geocities.com', 'ue63B1Q', 'Deane Moller', 'P', '1978-09-21', '55-(638)994-1874', '7173 La Follette Park');
INSERT INTO pengguna VALUES ('sbendik83@independent.co.uk', 'kShNdMbwX', 'Shirley Bendik', 'P', '1986-03-12', '49-(672)158-1814', '632 Goodland Alley');
INSERT INTO pengguna VALUES ('pinsull84@de.vu', 'naOsX56Cvcr', 'Pembroke Insull', 'L', '1996-01-17', '84-(492)242-7451', '10 Goodland Street');
INSERT INTO pengguna VALUES ('dcollister85@mashable.com', 'zuSpMfB1hK1F', 'Des Collister', 'L', '1973-04-18', '62-(354)976-9190', '13334 Oakridge Circle');
INSERT INTO pengguna VALUES ('fcutmore86@walmart.com', 'VAGUjYxh', 'Flin Cutmore', 'L', '1982-12-13', '255-(781)972-4291', '613 Manley Alley');
INSERT INTO pengguna VALUES ('mromanin87@sina.com.cn', '3iMyI2', 'Mikel Romanin', 'L', '1996-09-29', '7-(710)138-9619', '1 Hintze Pass');
INSERT INTO pengguna VALUES ('mgallico88@zimbio.com', 'WJpqfj5Y', 'Marco Gallico', 'L', '1996-08-26', '86-(704)221-2878', '01995 Mosinee Parkway');
INSERT INTO pengguna VALUES ('bmccurrie89@intel.com', 'QqJsmYSVw', 'Bryanty McCurrie', 'L', '1985-03-15', '48-(731)888-8671', '6512 Prairieview Alley');
INSERT INTO pengguna VALUES ('bcostigan8a@wordpress.org', 'EaivsQGmTV', 'Brice Costigan', 'L', '1973-03-24', '380-(644)844-7189', '29 Northridge Lane');
INSERT INTO pengguna VALUES ('scaccavari8b@mozilla.com', '9W2Tuqcr', 'Sheila-kathryn Caccavari', 'P', '1998-01-18', '351-(783)647-7957', '28 Elgar Plaza');
INSERT INTO pengguna VALUES ('awhicher8c@cisco.com', '2dSxLu', 'Allina Whicher', 'P', '1989-08-01', '380-(923)762-4659', '586 Ryan Alley');
INSERT INTO pengguna VALUES ('cwaterhowse8d@wired.com', 'mM1WCrsg', 'Clyde Waterhowse', 'L', '1987-06-08', '976-(547)553-1330', '45 Nelson Crossing');
INSERT INTO pengguna VALUES ('garckoll8e@pinterest.com', '7u3T4SBoJp', 'Grantham Arckoll', 'L', '1986-03-03', '62-(428)707-3829', '864 Anniversary Pass');
INSERT INTO pengguna VALUES ('jmcgeffen8f@123-reg.co.uk', 'vornIXafCYU', 'Jayme McGeffen', 'P', '1993-06-21', '372-(700)256-5314', '93554 Bluestem Crossing');
INSERT INTO pengguna VALUES ('vnewlove8g@yahoo.com', 'BdY12lOJ', 'Valma Newlove', 'P', '1975-06-12', '55-(166)208-7235', '61393 Mcbride Circle');
INSERT INTO pengguna VALUES ('fsyratt8h@cpanel.net', 'WGV6qxB', 'Flory Syratt', 'P', '1995-07-19', '234-(953)267-7233', '48 Goodland Court');
INSERT INTO pengguna VALUES ('vgorham8i@wikipedia.org', 'avd6O05', 'Velma Gorham', 'P', '1984-02-27', '86-(158)608-6283', '01 Waxwing Way');
INSERT INTO pengguna VALUES ('lchopping8j@aboutads.info', '51x8uvumwf', 'Leda Chopping', 'L', '1996-09-01', '86-(283)698-3778', '9591 Bunting Center');
INSERT INTO pengguna VALUES ('fminear8k@barnesandnoble.com', 'Hx4MeRhJ8qgp', 'Fiona Minear', 'P', '1979-01-22', '63-(457)893-3925', '5 Twin Pines Drive');
INSERT INTO pengguna VALUES ('amcwhinnie8l@sphinn.com', 'zloyuu', 'Archibaldo McWhinnie', 'L', '1991-07-04', '380-(376)138-8697', '015 Sunbrook Way');
INSERT INTO pengguna VALUES ('ccallendar8m@xing.com', 'DdqB1xzDK', 'Cori Callendar', 'L', '1994-11-20', '86-(360)287-2157', '003 Walton Road');
INSERT INTO pengguna VALUES ('zgellier8n@a8.net', 'hRkwfLx6uH3p', 'Zach Gellier', 'P', '1979-04-09', '46-(922)873-7321', '44319 Columbus Junction');
INSERT INTO pengguna VALUES ('ctipper8o@unblog.fr', 'sdRlVEhzu', 'Cort Tipper', 'P', '1996-09-04', '33-(303)918-0414', '170 Daystar Plaza');
INSERT INTO pengguna VALUES ('bseebright8p@parallels.com', '5rihToY', 'Barrie Seebright', 'P', '1996-05-08', '351-(215)273-7665', '70273 Sheridan Alley');
INSERT INTO pengguna VALUES ('ctrigg8q@sun.com', 'SK8O6K', 'Charlean Trigg', 'L', '1975-02-11', '63-(546)628-8027', '90 Pawling Park');
INSERT INTO pengguna VALUES ('mobrallaghan8r@ebay.com', 'wfOnpOKC8', 'Morley O''Brallaghan', 'L', '1977-03-23', '351-(337)519-7618', '34530 Southridge Hill');
INSERT INTO pengguna VALUES ('psummerlie8s@edublogs.org', 'LsoQ3IpvqMhb', 'Paolo Summerlie', 'P', '1991-12-12', '62-(446)794-7650', '9 Melrose Junction');
INSERT INTO pengguna VALUES ('dleven8t@nasa.gov', 'HMryrBDS49u', 'Davida Leven', 'P', '1989-08-04', '62-(236)265-6239', '61394 Morrow Hill');
INSERT INTO pengguna VALUES ('bstrafen8u@tinyurl.com', 'wkUxiVe5', 'Barbabra Strafen', 'P', '1973-02-18', '358-(579)893-6852', '8186 Utah Alley');
INSERT INTO pengguna VALUES ('cgoldston8v@nature.com', 'hoyqs2C7YH', 'Casi Goldston', 'L', '1971-06-18', '504-(363)659-8351', '5409 Dayton Street');
INSERT INTO pengguna VALUES ('jdwight8w@wikia.com', '2M6xexm7yGcQ', 'Jobina Dwight', 'P', '1983-07-30', '967-(272)636-5355', '818 Steensland Junction');
INSERT INTO pengguna VALUES ('mmotten8x@senate.gov', 'gNYm8Q', 'Moreen Motten', 'P', '1990-08-18', '212-(460)143-3574', '3637 Monterey Center');
INSERT INTO pengguna VALUES ('mgilleon8y@bing.com', 'OlVDC6R7D', 'Minta Gilleon', 'P', '1974-09-08', '86-(932)144-3734', '22 Express Circle');
INSERT INTO pengguna VALUES ('lrutt8z@hostgator.com', 'iYQhRGX', 'Loralyn Rutt', 'L', '1995-01-11', '7-(351)922-2343', '40 Kropf Crossing');
INSERT INTO pengguna VALUES ('ghoonahan90@salon.com', '8GQk8YSD', 'Godfrey Hoonahan', 'P', '1972-04-23', '374-(544)203-5700', '98 Ridgeway Circle');
INSERT INTO pengguna VALUES ('hcaistor91@mtv.com', 'gm5tcaHJST', 'Hillard Caistor', 'P', '1976-10-24', '63-(932)633-7881', '707 New Castle Point');
INSERT INTO pengguna VALUES ('jmustarde92@hp.com', 'b3QNkp169GY', 'Jaclin Mustarde', 'P', '1977-02-02', '234-(241)776-7797', '3198 Roth Plaza');
INSERT INTO pengguna VALUES ('qstonestreet93@hatena.ne.jp', 'ig1sHhHwTi8v', 'Quintana Stonestreet', 'L', '1974-05-18', '86-(594)449-7384', '033 Vermont Pass');
INSERT INTO pengguna VALUES ('bcourtois94@ucla.edu', 'YIleoqDQ4', 'Beth Courtois', 'L', '1971-09-04', '66-(727)313-7974', '07291 Barnett Terrace');
INSERT INTO pengguna VALUES ('cschellig95@google.co.jp', 'MQzuPhR9', 'Clarinda Schellig', 'L', '1981-08-09', '56-(990)938-8231', '5 Killdeer Road');
INSERT INTO pengguna VALUES ('etoor96@ustream.tv', 'y2LrZ96ZYdN', 'Ebenezer Toor', 'P', '1988-02-07', '86-(319)899-2241', '005 Morningstar Center');
INSERT INTO pengguna VALUES ('pmarmyon97@accuweather.com', 'OwkjhIW32', 'Parry Marmyon', 'L', '1998-02-12', '86-(874)285-0633', '1 Graceland Alley');
INSERT INTO pengguna VALUES ('jpawlata98@phoca.cz', '8i7himcYM1', 'Jakob Pawlata', 'L', '1980-03-26', '57-(784)473-7289', '7154 Lindbergh Center');
INSERT INTO pengguna VALUES ('rivanchin99@slideshare.net', 'fMAmKh', 'Rene Ivanchin', 'P', '1977-12-05', '380-(414)526-0273', '53 Bluestem Terrace');
INSERT INTO pengguna VALUES ('wmandres9a@gnu.org', 'ly2tQflrD5wq', 'Wallache Mandres', 'L', '1974-12-07', '63-(710)811-7363', '992 Glacier Hill Road');
INSERT INTO pengguna VALUES ('ktonsley9b@nytimes.com', 'LRdePx', 'Kellia Tonsley', 'P', '1973-09-01', '66-(432)183-7538', '1799 Vernon Plaza');
INSERT INTO pengguna VALUES ('smilbourne9c@comcast.net', 'WxqRvbAW6', 'Sanford Milbourne', 'L', '1979-12-07', '63-(214)529-6416', '0 Sloan Park');
INSERT INTO pengguna VALUES ('cduddell9d@fotki.com', 'XogOjh', 'Corabelle Duddell', 'P', '1982-01-01', '1-(650)689-5567', '4 Sheridan Pass');
INSERT INTO pengguna VALUES ('dizaks9e@qq.com', 'If4qQbF', 'Dore Izaks', 'L', '1996-07-07', '33-(465)884-0372', '841 Rusk Court');
INSERT INTO pengguna VALUES ('rliversage9f@icio.us', 'OTZlmuzCXX', 'Randy Liversage', 'P', '1996-05-26', '86-(711)498-0138', '8463 Truax Point');
INSERT INTO pengguna VALUES ('cmcgawn9g@wix.com', 'YqhyBRB', 'Cord McGawn', 'L', '1977-07-17', '62-(607)607-4477', '7185 Harbort Trail');
INSERT INTO pengguna VALUES ('eolland9h@vistaprint.com', 'XogH6FrM', 'Elisha Olland', 'L', '1979-09-01', '86-(254)337-7880', '4 Aberg Point');
INSERT INTO pengguna VALUES ('crivard9i@cpanel.net', 'e1P71FTgw', 'Carmina Rivard', 'P', '1972-04-05', '51-(366)968-4092', '34812 Saint Paul Road');
INSERT INTO pengguna VALUES ('eamiss9j@jimdo.com', 'rg5nEyB', 'Eliot Amiss', 'L', '1976-07-26', '380-(596)307-2813', '7 Raven Lane');
INSERT INTO pengguna VALUES ('ssquibe9k@tamu.edu', 'Aql9tf', 'Salvador Squibe', 'L', '1986-10-08', '98-(488)476-3251', '68489 Ilene Drive');
INSERT INTO pengguna VALUES ('kbrearton9l@amazon.com', 'vDtpoe13s', 'Kylie Brearton', 'P', '1980-02-01', '63-(207)505-7279', '7 Elka Crossing');
INSERT INTO pengguna VALUES ('scornelius9m@freewebs.com', 'XgKrgU06Wvw', 'Sapphira Cornelius', 'P', '1977-07-05', '86-(979)290-2838', '41888 Shoshone Pass');
INSERT INTO pengguna VALUES ('broskams9n@hud.gov', 'yfz08Ir7WOJ', 'Britta Roskams', 'L', '1975-06-29', '7-(680)575-8509', '8 Warbler Terrace');
INSERT INTO pengguna VALUES ('hflewitt9o@unicef.org', '9PMZ7dM', 'Heriberto Flewitt', 'L', '1972-05-10', '63-(830)585-8043', '0 Pawling Street');
INSERT INTO pengguna VALUES ('rcrangle9p@cdc.gov', '24mP4u', 'Richart Crangle', 'L', '1971-03-28', '385-(679)573-7236', '06 Mitchell Court');
INSERT INTO pengguna VALUES ('dummy@gmail.com', 'dummy', 'dummy', 'L', '1971-03-28', '385-(679)573-7236', '06 Mitchell Court');
INSERT INTO pengguna VALUES ('user@basdat.com', 'user', 'user', 'L', '1971-03-28', '385-(679)573-7236', '06 Mitchell Court');
INSERT INTO pengguna VALUES ('pthacke0@fema.gov', 'C7WJBCWC6', 'Parry Thacke', 'L', '1971-07-10', '86-(563)139-9022', '76 Pennsylvania Drive');
INSERT INTO pengguna VALUES ('awigzell1@ucoz.com', 'L0aoGEEf9MlN', 'Alec Wigzell', 'L', '1972-05-03', '63-(435)399-3887', '591 East Lane');
INSERT INTO pengguna VALUES ('mpaynton2@oracle.com', 'HA74KNVveQ', 'Marcella Paynton', 'P', '1989-07-02', '33-(579)636-3293', '65 Scott Street');
INSERT INTO pengguna VALUES ('twilding3@so-net.ne.jp', 'pxzDvE', 'Tiffy Wilding', 'L', '1978-10-19', '52-(250)729-3322', '839 Daystar Circle');
INSERT INTO pengguna VALUES ('rbollis4@imageshack.us', 'TsOVhMbNZz', 'Ryon Bollis', 'P', '1984-09-22', '86-(468)732-6070', '99689 Troy Place');
INSERT INTO pengguna VALUES ('admin@dummy.com', 'dummy', 'Ryon Bollis', 'P', '1984-09-22', '86-(468)732-6070', '99689 Troy Place');
INSERT INTO pengguna VALUES ('admin@basdat.com', 'basdat', 'Ryon Bollis', 'P', '1984-09-22', '86-(468)732-6070', '99689 Troy Place');


--
-- Data for Name: produk; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO produk VALUES ('KLJ00001', 'Atasan', 2100.00, 'Atasan S');
INSERT INTO produk VALUES ('KLJ00002', 'Atasan', 5400.00, 'Atasan M');
INSERT INTO produk VALUES ('KLJ00003', 'Atasan', 6200.00, 'Atasan XL');
INSERT INTO produk VALUES ('KLJ00004', 'Celana', 5200.00, 'Celana S');
INSERT INTO produk VALUES ('KLJ00005', 'Celana', 1500.00, 'Celana M');
INSERT INTO produk VALUES ('KLJ00006', 'Celana', 5500.00, 'Celana XL');
INSERT INTO produk VALUES ('KLJ00007', 'Dress', 9400.00, 'Dress S');
INSERT INTO produk VALUES ('KLJ00008', 'Dress', 8400.00, 'Dress M');
INSERT INTO produk VALUES ('KLJ00009', 'Dress', 7900.00, 'Dress XL');
INSERT INTO produk VALUES ('KLJ00010', 'Outerwear', 700.00, 'Outerwear S');
INSERT INTO produk VALUES ('KLJ00011', 'Outerwear', 5000.00, 'Outerwear M');
INSERT INTO produk VALUES ('KLJ00012', 'Outerwear', 7800.00, 'Outerwear XL');
INSERT INTO produk VALUES ('KLJ00013', 'Setelan', 4500.00, 'Setelan S');
INSERT INTO produk VALUES ('KLJ00014', 'Setelan', 9000.00, 'Setelan M');
INSERT INTO produk VALUES ('KLJ00015', 'Setelan', 7600.00, 'Setelan XL');
INSERT INTO produk VALUES ('KLJ00016', 'Batik Wanita', 4700.00, 'Batik Wanita S');
INSERT INTO produk VALUES ('KLJ00017', 'Batik Wanita', 6600.00, 'Batik Wanita M');
INSERT INTO produk VALUES ('KLJ00018', 'Batik Wanita', 4400.00, 'Batik Wanita XL');
INSERT INTO produk VALUES ('KLJ00019', 'Pakaian Dalam Wanita', 4500.00, 'Pakaian Dalam Wanita S');
INSERT INTO produk VALUES ('KLJ00020', 'Pakaian Dalam Wanita', 5900.00, 'Pakaian Dalam Wanita M');
INSERT INTO produk VALUES ('KLJ00021', 'Pakaian Dalam Wanita', 7900.00, 'Pakaian Dalam Wanita XL');
INSERT INTO produk VALUES ('KLJ00022', 'Tas', 2700.00, 'Tas S');
INSERT INTO produk VALUES ('KLJ00023', 'Tas', 6900.00, 'Tas M');
INSERT INTO produk VALUES ('KLJ00024', 'Tas', 5100.00, 'Tas XL');
INSERT INTO produk VALUES ('KLJ00025', 'Sepatu', 2900.00, 'Sepatu S');
INSERT INTO produk VALUES ('KLJ00026', 'Sepatu', 9000.00, 'Sepatu M');
INSERT INTO produk VALUES ('KLJ00027', 'Sepatu', 9200.00, 'Sepatu XL');
INSERT INTO produk VALUES ('KLJ00028', 'Jam Tangan', 7400.00, 'Jam Tangan S');
INSERT INTO produk VALUES ('KLJ00029', 'Jam Tangan', 9300.00, 'Jam Tangan M');
INSERT INTO produk VALUES ('KLJ00030', 'Jam Tangan', 1800.00, 'Jam Tangan XL');
INSERT INTO produk VALUES ('KLJ00031', 'Perhiasan', 5200.00, 'Perhiasan S');
INSERT INTO produk VALUES ('KLJ00032', 'Perhiasan', 4500.00, 'Perhiasan M');
INSERT INTO produk VALUES ('KLJ00033', 'Perhiasan', 8400.00, 'Perhiasan XL');
INSERT INTO produk VALUES ('KLJ00034', 'Aksesoris', 7000.00, 'Aksesoris S');
INSERT INTO produk VALUES ('KLJ00035', 'Aksesoris', 7700.00, 'Aksesoris M');
INSERT INTO produk VALUES ('KLJ00036', 'Aksesoris', 5400.00, 'Aksesoris XL');
INSERT INTO produk VALUES ('KLJ00037', 'Aksesoris Rambut', 9900.00, 'Aksesoris Rambut S');
INSERT INTO produk VALUES ('KLJ00038', 'Aksesoris Rambut', 600.00, 'Aksesoris Rambut M');
INSERT INTO produk VALUES ('KLJ00039', 'Aksesoris Rambut', 3400.00, 'Aksesoris Rambut XL');
INSERT INTO produk VALUES ('KLJ00040', 'Perlengkapan Couple', 8700.00, 'Perlengkapan Couple S');
INSERT INTO produk VALUES ('KLJ00041', 'Perlengkapan Couple', 4000.00, 'Perlengkapan Couple M');
INSERT INTO produk VALUES ('KLJ00042', 'Perlengkapan Couple', 3300.00, 'Perlengkapan Couple XL');
INSERT INTO produk VALUES ('KLJ00043', 'Baju Tidur', 9700.00, 'Baju Tidur S');
INSERT INTO produk VALUES ('KLJ00044', 'Baju Tidur', 9800.00, 'Baju Tidur M');
INSERT INTO produk VALUES ('KLJ00045', 'Baju Tidur', 4100.00, 'Baju Tidur XL');
INSERT INTO produk VALUES ('KLJ00046', 'Perlengkapan Jahit', 9500.00, 'Perlengkapan Jahit S');
INSERT INTO produk VALUES ('KLJ00047', 'Perlengkapan Jahit', 600.00, 'Perlengkapan Jahit M');
INSERT INTO produk VALUES ('KLJ00048', 'Perlengkapan Jahit', 3500.00, 'Perlengkapan Jahit XL');
INSERT INTO produk VALUES ('KLJ00049', 'Jam Tangan', 5600.00, 'Jam Tangan S');
INSERT INTO produk VALUES ('KLJ00050', 'Jam Tangan', 4700.00, 'Jam Tangan M');
INSERT INTO produk VALUES ('KLJ00051', 'Jam Tangan', 7300.00, 'Jam Tangan XL');
INSERT INTO produk VALUES ('KLJ00052', 'Baju Tidur', 5700.00, 'Baju Tidur S');
INSERT INTO produk VALUES ('KLJ00053', 'Baju Tidur', 5800.00, 'Baju Tidur M');
INSERT INTO produk VALUES ('KLJ00054', 'Baju Tidur', 4600.00, 'Baju Tidur XL');
INSERT INTO produk VALUES ('KLJ00055', 'Pakaian Dalam Pria', 9000.00, 'Pakaian Dalam Pria S');
INSERT INTO produk VALUES ('KLJ00056', 'Pakaian Dalam Pria', 7900.00, 'Pakaian Dalam Pria M');
INSERT INTO produk VALUES ('KLJ00057', 'Pakaian Dalam Pria', 800.00, 'Pakaian Dalam Pria XL');
INSERT INTO produk VALUES ('KLJ00058', 'Outerwear', 4200.00, 'Outerwear S');
INSERT INTO produk VALUES ('KLJ00059', 'Outerwear', 4300.00, 'Outerwear M');
INSERT INTO produk VALUES ('KLJ00060', 'Outerwear', 8500.00, 'Outerwear XL');
INSERT INTO produk VALUES ('KLJ00061', 'Sepatu', 2000.00, 'Sepatu S');
INSERT INTO produk VALUES ('KLJ00062', 'Sepatu', 2500.00, 'Sepatu M');
INSERT INTO produk VALUES ('KLJ00063', 'Sepatu', 2400.00, 'Sepatu XL');
INSERT INTO produk VALUES ('KLJ00064', 'Tas', 300.00, 'Tas S');
INSERT INTO produk VALUES ('KLJ00065', 'Tas', 3200.00, 'Tas M');
INSERT INTO produk VALUES ('KLJ00066', 'Tas', 3300.00, 'Tas XL');
INSERT INTO produk VALUES ('KLJ00067', 'Perhiasan Fashion', 2400.00, 'Perhiasan Fashion S');
INSERT INTO produk VALUES ('KLJ00068', 'Perhiasan Fashion', 6700.00, 'Perhiasan Fashion M');
INSERT INTO produk VALUES ('KLJ00069', 'Perhiasan Fashion', 1000.00, 'Perhiasan Fashion XL');
INSERT INTO produk VALUES ('KLJ00070', 'Aksesoris', 5000.00, 'Aksesoris S');
INSERT INTO produk VALUES ('KLJ00071', 'Aksesoris', 7400.00, 'Aksesoris M');
INSERT INTO produk VALUES ('KLJ00072', 'Aksesoris', 7900.00, 'Aksesoris XL');
INSERT INTO produk VALUES ('KLJ00073', 'Celana', 6900.00, 'Celana S');
INSERT INTO produk VALUES ('KLJ00074', 'Celana', 1600.00, 'Celana M');
INSERT INTO produk VALUES ('KLJ00075', 'Celana', 3800.00, 'Celana XL');
INSERT INTO produk VALUES ('KLJ00076', 'Batik Pria', 3700.00, 'Batik Pria S');
INSERT INTO produk VALUES ('KLJ00077', 'Batik Pria', 6700.00, 'Batik Pria M');
INSERT INTO produk VALUES ('KLJ00078', 'Batik Pria', 3900.00, 'Batik Pria S');
INSERT INTO produk VALUES ('KLJ00079', 'Atasan', 9300.00, 'Atasan M');
INSERT INTO produk VALUES ('KLJ00080', 'Atasan', 4400.00, 'Atasan XL');
INSERT INTO produk VALUES ('KLJ00081', 'Atasan', 900.00, 'Atasan S');
INSERT INTO produk VALUES ('KLJ00082', 'Outerwear', 4100.00, 'Outerwear M');
INSERT INTO produk VALUES ('KLJ00083', 'Outerwear', 10000.00, 'Outerwear XL');
INSERT INTO produk VALUES ('KLJ00084', 'Outerwear', 9700.00, 'Outerwear S');
INSERT INTO produk VALUES ('KLJ00085', 'Setelan Muslim', 5400.00, 'Setelan Muslim M');
INSERT INTO produk VALUES ('KLJ00086', 'Setelan Muslim', 8200.00, 'Setelan Muslim XL');
INSERT INTO produk VALUES ('KLJ00087', 'Setelan Muslim', 7300.00, 'Setelan Muslim S');
INSERT INTO produk VALUES ('KLJ00088', 'Dress', 4300.00, 'Dress M');
INSERT INTO produk VALUES ('KLJ00089', 'Dress', 5200.00, 'Dress XL');
INSERT INTO produk VALUES ('KLJ00090', 'Dress', 5400.00, 'Dress S');
INSERT INTO produk VALUES ('KLJ00091', 'Scarf', 9300.00, 'Scarf M');
INSERT INTO produk VALUES ('KLJ00092', 'Scarf', 4800.00, 'Scarf XL');
INSERT INTO produk VALUES ('KLJ00093', 'Scarf', 2200.00, 'Scarf S');
INSERT INTO produk VALUES ('KLJ00094', 'Baju Muslim Anak', 6000.00, 'Baju Muslim Anak M');
INSERT INTO produk VALUES ('KLJ00095', 'Baju Muslim Anak', 6800.00, 'Baju Muslim Anak XL');
INSERT INTO produk VALUES ('KLJ00096', 'Baju Muslim Anak', 5400.00, 'Baju Muslim Anak S');
INSERT INTO produk VALUES ('KLJ00097', 'Atasan', 1900.00, 'Atasan M');
INSERT INTO produk VALUES ('KLJ00098', 'Atasan', 8800.00, 'Atasan XL');
INSERT INTO produk VALUES ('KLJ00099', 'Atasan', 1400.00, 'Atasan S');
INSERT INTO produk VALUES ('KLJ00100', 'Aksesoris Jilbab', 3000.00, 'Aksesoris Jilbab M');
INSERT INTO produk VALUES ('KLJ00101', 'Aksesoris Jilbab', 6300.00, 'Aksesoris Jilbab XL');
INSERT INTO produk VALUES ('KLJ00102', 'Aksesoris Jilbab', 8700.00, 'Aksesoris Jilbab S');
INSERT INTO produk VALUES ('KLJ00103', 'Bawahan', 600.00, 'Bawahan M');
INSERT INTO produk VALUES ('KLJ00104', 'Bawahan', 1300.00, 'Bawahan XL');
INSERT INTO produk VALUES ('KLJ00105', 'Bawahan', 3100.00, 'Bawahan S');
INSERT INTO produk VALUES ('KLJ00106', 'Perlengkapan Ibadah', 1900.00, 'Perlengkapan Ibadah M');
INSERT INTO produk VALUES ('KLJ00107', 'Perlengkapan Ibadah', 9600.00, 'Perlengkapan Ibadah XL');
INSERT INTO produk VALUES ('KLJ00108', 'Perlengkapan Ibadah', 7200.00, 'Perlengkapan Ibadah M');
INSERT INTO produk VALUES ('KLJ00109', 'Perhiasan Anak', 8400.00, 'Perhiasan Anak XL');
INSERT INTO produk VALUES ('KLJ00110', 'Perhiasan Anak', 3900.00, 'Perhiasan Anak S');
INSERT INTO produk VALUES ('KLJ00111', 'Perhiasan Anak', 4500.00, 'Perhiasan Anak M');
INSERT INTO produk VALUES ('KLJ00112', 'Sepatu Anak Perempuan', 2500.00, 'Sepatu Anak Perempuan XL');
INSERT INTO produk VALUES ('KLJ00113', 'Sepatu Anak Perempuan', 8600.00, 'Sepatu Anak Perempuan S');
INSERT INTO produk VALUES ('KLJ00114', 'Sepatu Anak Perempuan', 7300.00, 'Sepatu Anak Perempuan M');
INSERT INTO produk VALUES ('KLJ00115', 'Aksesoris Rambut Anak', 5300.00, 'Aksesoris Rambut Anak XL');
INSERT INTO produk VALUES ('KLJ00116', 'Aksesoris Rambut Anak', 9400.00, 'Aksesoris Rambut Anak S');
INSERT INTO produk VALUES ('KLJ00117', 'Aksesoris Rambut Anak', 2100.00, 'Aksesoris Rambut Anak M');
INSERT INTO produk VALUES ('KLJ00118', 'Aksesoris Anak', 5900.00, 'Aksesoris Anak XL');
INSERT INTO produk VALUES ('KLJ00119', 'Aksesoris Anak', 5100.00, 'Aksesoris Anak S');
INSERT INTO produk VALUES ('KLJ00120', 'Aksesoris Anak', 3200.00, 'Aksesoris Anak M');
INSERT INTO produk VALUES ('KLJ00121', 'Tas Anak', 300.00, 'Tas Anak XL');
INSERT INTO produk VALUES ('KLJ00122', 'Tas Anak', 9500.00, 'Tas Anak S');
INSERT INTO produk VALUES ('KLJ00123', 'Tas Anak', 4100.00, 'Tas Anak M');
INSERT INTO produk VALUES ('KLJ00124', 'Sepatu Anak Laki-laki', 8500.00, 'Sepatu Anak Laki-laki S');
INSERT INTO produk VALUES ('KLJ00125', 'Sepatu Anak Laki-laki', 6300.00, 'Sepatu Anak Laki-laki M');
INSERT INTO produk VALUES ('KLJ00126', 'Sepatu Anak Laki-laki', 9500.00, 'Sepatu Anak Laki-laki XL');
INSERT INTO produk VALUES ('KLJ00127', 'Pakaian Anak Perempuan', 7400.00, 'Pakaian Anak Perempuan S');
INSERT INTO produk VALUES ('KLJ00128', 'Pakaian Anak Perempuan', 1800.00, 'Pakaian Anak Perempuan M');
INSERT INTO produk VALUES ('KLJ00129', 'Pakaian Anak Perempuan', 7000.00, 'Pakaian Anak Perempuan XL');
INSERT INTO produk VALUES ('KLJ00130', 'Pakaian Anak Laki-Laki', 2500.00, 'Pakaian Anak Laki-Laki S');
INSERT INTO produk VALUES ('KLJ00131', 'Pakaian Anak Laki-Laki', 1900.00, 'Pakaian Anak Laki-Laki M');
INSERT INTO produk VALUES ('KLJ00132', 'Pakaian Anak Laki-Laki', 9600.00, 'Pakaian Anak Laki-Laki XL');
INSERT INTO produk VALUES ('KLJ00133', 'Kosmetik', 5700.00, 'Kosmetik S');
INSERT INTO produk VALUES ('KLJ00134', 'Kosmetik', 200.00, 'Kosmetik M');
INSERT INTO produk VALUES ('KLJ00135', 'Kosmetik', 7500.00, 'Kosmetik XL');
INSERT INTO produk VALUES ('KLJ00136', 'Perawatan Wajah', 2900.00, 'Perawatan Wajah S');
INSERT INTO produk VALUES ('KLJ00137', 'Perawatan Wajah', 1900.00, 'Perawatan Wajah M');
INSERT INTO produk VALUES ('KLJ00138', 'Perawatan Wajah', 9800.00, 'Perawatan Wajah XL');
INSERT INTO produk VALUES ('KLJ00139', 'Perawatan Tangan, Kaki dan Kuku', 4000.00, 'Perawatan Tangan, Kaki dan Kuku S');
INSERT INTO produk VALUES ('KLJ00140', 'Perawatan Tangan, Kaki dan Kuku', 7300.00, 'Perawatan Tangan, Kaki dan Kuku M');
INSERT INTO produk VALUES ('KLJ00141', 'Perawatan Tangan, Kaki dan Kuku', 800.00, 'Perawatan Tangan, Kaki dan Kuku XL');
INSERT INTO produk VALUES ('KLJ00142', 'Perawatan Rambut', 7500.00, 'Perawatan Rambut S');
INSERT INTO produk VALUES ('KLJ00143', 'Perawatan Rambut', 2700.00, 'Perawatan Rambut M');
INSERT INTO produk VALUES ('KLJ00144', 'Perawatan Rambut', 10000.00, 'Perawatan Rambut XL');
INSERT INTO produk VALUES ('KLJ00145', 'Perawatan Mata', 9700.00, 'Perawatan Mata S');
INSERT INTO produk VALUES ('KLJ00146', 'Perawatan Mata', 3600.00, 'Perawatan Mata M');
INSERT INTO produk VALUES ('KLJ00147', 'Perawatan Mata', 3300.00, 'Perawatan Mata S');
INSERT INTO produk VALUES ('KLJ00148', 'Styling Rambut', 2200.00, 'Styling Rambut M');
INSERT INTO produk VALUES ('KLJ00149', 'Styling Rambut', 800.00, 'Styling Rambut XL');
INSERT INTO produk VALUES ('KLJ00150', 'Styling Rambut', 5700.00, 'Styling Rambut S');
INSERT INTO produk VALUES ('KLJ00151', 'Peralatan Make Up', 6300.00, 'Peralatan Make Up M');
INSERT INTO produk VALUES ('KLJ00152', 'Peralatan Make Up', 7000.00, 'Peralatan Make Up XL');
INSERT INTO produk VALUES ('KLJ00153', 'Peralatan Make Up', 7200.00, 'Peralatan Make Up S');
INSERT INTO produk VALUES ('KLJ00154', 'Grooming', 7800.00, 'Grooming M');
INSERT INTO produk VALUES ('KLJ00155', 'Grooming', 2000.00, 'Grooming XL');
INSERT INTO produk VALUES ('KLJ00156', 'Grooming', 6400.00, 'Grooming S');
INSERT INTO produk VALUES ('KLJ00157', 'Mandi & Perawatan Tubuh', 7400.00, 'Mandi & Perawatan Tubuh M');
INSERT INTO produk VALUES ('KLJ00158', 'Mandi & Perawatan Tubuh', 8100.00, 'Mandi & Perawatan Tubuh XL');
INSERT INTO produk VALUES ('KLJ00159', 'Mandi & Perawatan Tubuh', 600.00, 'Mandi & Perawatan Tubuh S');
INSERT INTO produk VALUES ('KLJ00160', 'Telinga', 4600.00, 'Telinga M');
INSERT INTO produk VALUES ('KLJ00161', 'Telinga', 800.00, 'Telinga XL');
INSERT INTO produk VALUES ('KLJ00162', 'Telinga', 6700.00, 'Telinga S');
INSERT INTO produk VALUES ('KLJ00163', 'Kesehatan Wanita', 5700.00, 'Kesehatan Wanita M');
INSERT INTO produk VALUES ('KLJ00164', 'Kesehatan Wanita', 5400.00, 'Kesehatan Wanita XL');
INSERT INTO produk VALUES ('KLJ00165', 'Kesehatan Wanita', 9500.00, 'Kesehatan Wanita S');
INSERT INTO produk VALUES ('KLJ00166', 'Obat & Alat Kesehatan', 8000.00, 'Obat & Alat Kesehatan M');
INSERT INTO produk VALUES ('KLJ00167', 'Obat & Alat Kesehatan', 3700.00, 'Obat & Alat Kesehatan XL');
INSERT INTO produk VALUES ('KLJ00168', 'Obat & Alat Kesehatan', 5300.00, 'Obat & Alat Kesehatan S');
INSERT INTO produk VALUES ('KLJ00169', 'Health Products', 9600.00, 'Health Products M');
INSERT INTO produk VALUES ('KLJ00170', 'Health Products', 7000.00, 'Health Products S');
INSERT INTO produk VALUES ('KLJ00171', 'Health Products', 1900.00, 'Health Products M');
INSERT INTO produk VALUES ('KLJ00172', 'Kesehatan Gigi & Mulut', 900.00, 'Kesehatan Gigi & Mulut XL');
INSERT INTO produk VALUES ('KLJ00173', 'Kesehatan Gigi & Mulut', 4300.00, 'Kesehatan Gigi & Mulut S');
INSERT INTO produk VALUES ('KLJ00174', 'Kesehatan Gigi & Mulut', 1700.00, 'Kesehatan Gigi & Mulut M');
INSERT INTO produk VALUES ('KLJ00175', 'Diet & Vitamin', 8400.00, 'Diet & Vitamin XL');
INSERT INTO produk VALUES ('KLJ00176', 'Diet & Vitamin', 9700.00, 'Diet & Vitamin S');
INSERT INTO produk VALUES ('KLJ00177', 'Diet & Vitamin', 5100.00, 'Diet & Vitamin M');
INSERT INTO produk VALUES ('KLJ00178', 'Kesehatan Mata', 8500.00, 'Kesehatan Mata XL');
INSERT INTO produk VALUES ('KLJ00179', 'Kesehatan Mata', 1600.00, 'Kesehatan Mata S');
INSERT INTO produk VALUES ('KLJ00180', 'Kesehatan Mata', 6600.00, 'Kesehatan Mata M');
INSERT INTO produk VALUES ('KLJ00181', 'Perlengkapan Medis', 9600.00, 'Perlengkapan Medis XL');
INSERT INTO produk VALUES ('KLJ00182', 'Perlengkapan Medis', 8200.00, 'Perlengkapan Medis S');
INSERT INTO produk VALUES ('KLJ00183', 'Perlengkapan Medis', 5000.00, 'Perlengkapan Medis M');
INSERT INTO produk VALUES ('KLJ00184', 'Kesehatan Lainnya', 7600.00, 'Kesehatan Lainnya XL');
INSERT INTO produk VALUES ('KLJ00185', 'Kesehatan Lainnya', 1000.00, 'Kesehatan Lainnya S');
INSERT INTO produk VALUES ('KLJ00186', 'Kesehatan Lainnya', 6300.00, 'Kesehatan Lainnya M');
INSERT INTO produk VALUES ('KLJ00187', 'Aksesoris Bayi', 9600.00, 'Aksesoris Bayi XL');
INSERT INTO produk VALUES ('KLJ00188', 'Aksesoris Bayi', 9500.00, 'Aksesoris Bayi S');
INSERT INTO produk VALUES ('KLJ00189', 'Aksesoris Bayi', 2400.00, 'Aksesoris Bayi M');
INSERT INTO produk VALUES ('KLJ00190', 'Kamar Tidur', 5900.00, 'Kamar Tidur XL');
INSERT INTO produk VALUES ('KLJ00191', 'Kamar Tidur', 9000.00, 'Kamar Tidur S');
INSERT INTO produk VALUES ('KLJ00192', 'Kamar Tidur', 9200.00, 'Kamar Tidur M');
INSERT INTO produk VALUES ('KLJ00193', 'Handphone', 700.00, 'Handphone S');
INSERT INTO produk VALUES ('KLJ00194', 'Handphone', 2300.00, 'Handphone M');
INSERT INTO produk VALUES ('KLJ00195', 'Handphone', 3300.00, 'Handphone XL');
INSERT INTO produk VALUES ('KLJ00196', 'Laptop', 8200.00, 'Laptop S');
INSERT INTO produk VALUES ('KLJ00197', 'Laptop', 5300.00, 'Laptop M');
INSERT INTO produk VALUES ('KLJ00198', 'Laptop', 1100.00, 'Laptop XL');
INSERT INTO produk VALUES ('KLJ00199', 'Komputer', 4300.00, 'Komputer S');
INSERT INTO produk VALUES ('KLJ00200', 'Komputer', 4500.00, 'Komputer M');
INSERT INTO produk VALUES ('KLJ00201', 'Komputer', 7400.00, 'Komputer XL');
INSERT INTO produk VALUES ('KLJ00202', 'TV', 8300.00, 'TV S');
INSERT INTO produk VALUES ('KLJ00203', 'TV', 8400.00, 'TV M');
INSERT INTO produk VALUES ('KLJ00204', 'TV', 1400.00, 'TV XL');
INSERT INTO produk VALUES ('KLJ00205', 'Kamera', 900.00, 'Kamera S');
INSERT INTO produk VALUES ('KLJ00206', 'Kamera', 100.00, 'Kamera M');
INSERT INTO produk VALUES ('KLJ00207', 'Kamera', 800.00, 'Kamera XL');
INSERT INTO produk VALUES ('KLJ00208', 'Aksesoris Mobil', 5200.00, 'Aksesoris Mobil S');
INSERT INTO produk VALUES ('KLJ00209', 'Aksesoris Mobil', 9100.00, 'Aksesoris Mobil M');
INSERT INTO produk VALUES ('KLJ00210', 'Aksesoris Mobil', 1600.00, 'Aksesoris Mobil XL');
INSERT INTO produk VALUES ('KLJ00211', 'Basket', 300.00, 'Basket S');
INSERT INTO produk VALUES ('KLJ00212', 'Basket', 5600.00, 'Basket M');
INSERT INTO produk VALUES ('KLJ00213', 'Basket', 2900.00, 'Basket XL');
INSERT INTO produk VALUES ('KLJ00214', 'Musik', 8100.00, 'Musik S');
INSERT INTO produk VALUES ('KLJ00215', 'Musik', 3700.00, 'Musik M');
INSERT INTO produk VALUES ('KLJ00216', 'Musik', 9100.00, 'Musik S');
INSERT INTO produk VALUES ('KLJ00217', 'Peralatan Dapur', 1200.00, 'Peralatan Dapur M');
INSERT INTO produk VALUES ('KLJ00218', 'Peralatan Dapur', 4900.00, 'Peralatan Dapur XL');
INSERT INTO produk VALUES ('KLJ00219', 'Peralatan Dapur', 9200.00, 'Peralatan Dapur S');
INSERT INTO produk VALUES ('KLJ00220', 'Alat Tulis', 3100.00, 'Alat Tulis M');
INSERT INTO produk VALUES ('KLJ00221', 'Alat Tulis', 3000.00, 'Alat Tulis XL');
INSERT INTO produk VALUES ('KLJ00222', 'Alat Tulis', 5500.00, 'Alat Tulis S');
INSERT INTO produk VALUES ('KLJ00223', 'Boneka', 4000.00, 'Boneka M');
INSERT INTO produk VALUES ('KLJ00224', 'Boneka', 6800.00, 'Boneka XL');
INSERT INTO produk VALUES ('KLJ00225', 'Boneka', 2000.00, 'Boneka S');
INSERT INTO produk VALUES ('KLJ00226', 'Figure', 7700.00, 'Figure M');
INSERT INTO produk VALUES ('KLJ00227', 'Figure', 6600.00, 'Figure XL');
INSERT INTO produk VALUES ('KLJ00228', 'Figure', 4700.00, 'Figure S');
INSERT INTO produk VALUES ('KLJ00229', 'Makanan', 1300.00, 'Makanan M');
INSERT INTO produk VALUES ('KLJ00230', 'Makanan', 5300.00, 'Makanan XL');
INSERT INTO produk VALUES ('KLJ00231', 'Makanan', 9800.00, 'Makanan S');
INSERT INTO produk VALUES ('KLJ00232', 'Minuman', 9200.00, 'Minuman M');
INSERT INTO produk VALUES ('KLJ00233', 'Minuman', 6900.00, 'Minuman XL');
INSERT INTO produk VALUES ('KLJ00234', 'Minuman', 8200.00, 'Minuman S');
INSERT INTO produk VALUES ('KLJ00235', 'Buku Sekolah', 8400.00, 'Buku Sekolah M');
INSERT INTO produk VALUES ('KLJ00236', 'Buku Sekolah', 6100.00, 'Buku Sekolah XL');
INSERT INTO produk VALUES ('KLJ00237', 'Buku Sekolah', 2700.00, 'Buku Sekolah S');
INSERT INTO produk VALUES ('KLJ00238', 'Novel Sastra', 4400.00, 'Novel Sastra M');
INSERT INTO produk VALUES ('KLJ00239', 'Novel Sastra', 1400.00, 'Novel Sastra XL');
INSERT INTO produk VALUES ('KLJ00240', 'Novel Sastra', 5000.00, 'Novel Sastra S');
INSERT INTO produk VALUES ('KLJ00241', 'Atasan', 1600.00, 'Atasan M');
INSERT INTO produk VALUES ('KLJ00242', 'Atasan', 8400.00, 'Atasan XL');
INSERT INTO produk VALUES ('KLJ00243', 'Atasan', 7400.00, 'Atasan S');
INSERT INTO produk VALUES ('KLJ00244', 'Celana', 9400.00, 'Celana M');
INSERT INTO produk VALUES ('KLJ00245', 'Celana', 8000.00, 'Celana XL');
INSERT INTO produk VALUES ('KLJ00246', 'Celana', 3800.00, 'Celana M');
INSERT INTO produk VALUES ('KLJ00247', 'Dress', 400.00, 'Dress M');
INSERT INTO produk VALUES ('KLJ00248', 'Dress', 9200.00, 'Dress M');
INSERT INTO produk VALUES ('KLJ00249', 'Dress', 8600.00, 'Dress XL');
INSERT INTO produk VALUES ('KLJ00250', 'Outerwear', 1700.00, 'Outerwear S');
INSERT INTO produk VALUES ('KLJ00251', 'Pulsa XL 1', 1100.00, 'Pulsa XL 1000');
INSERT INTO produk VALUES ('KLJ00252', 'Pulsa XL 2', 2100.00, 'Pulsa XL 2000');
INSERT INTO produk VALUES ('KLJ00253', 'Pulsa XL 5', 5150.00, 'Pulsa XL 5000');
INSERT INTO produk VALUES ('KLJ00254', 'Pulsa XL 10', 11000.00, 'Pulsa XL 10000');
INSERT INTO produk VALUES ('KLJ00255', 'Pulsa XL 20', 21500.00, 'Pulsa XL 20000');
INSERT INTO produk VALUES ('KLJ00256', 'Pulsa XL 25', 26000.00, 'Pulsa XL 25000');
INSERT INTO produk VALUES ('KLJ00257', 'Pulsa XL 50', 52000.00, 'Pulsa XL 50000');
INSERT INTO produk VALUES ('KLJ00258', 'Pulsa XL 100', 101000.00, 'Pulsa XL 100000');
INSERT INTO produk VALUES ('KLJ00259', 'Pulsa XL 200', 201500.00, 'Pulsa XL 200000');
INSERT INTO produk VALUES ('KLJ00260', 'Pulsa XL 500', 502000.00, 'Pulsa XL 500000');
INSERT INTO produk VALUES ('KLJ00261', 'Pulsa Telkomsel 1', 1100.00, 'Pulsa Telkomsel 1000');
INSERT INTO produk VALUES ('KLJ00262', 'Pulsa Telkomsel 2', 2100.00, 'Pulsa Telkomsel 2000');
INSERT INTO produk VALUES ('KLJ00263', 'Pulsa Telkomsel 5', 5150.00, 'Pulsa Telkomsel 5000');
INSERT INTO produk VALUES ('KLJ00264', 'Pulsa Telkomsel 10', 11000.00, 'Pulsa Telkomsel 10000');
INSERT INTO produk VALUES ('KLJ00265', 'Pulsa Telkomsel 20', 21500.00, 'Pulsa Telkomsel 20000');
INSERT INTO produk VALUES ('KLJ00266', 'Pulsa Telkomsel 25', 26000.00, 'Pulsa Telkomsel 25000');
INSERT INTO produk VALUES ('KLJ00267', 'Pulsa Telkomsel 50', 52000.00, 'Pulsa Telkomsel 50000');
INSERT INTO produk VALUES ('KLJ00268', 'Pulsa Telkomsel 100', 101000.00, 'Pulsa Telkomsel 100000');
INSERT INTO produk VALUES ('KLJ00269', 'Pulsa Telkomsel 200', 201500.00, 'Pulsa Telkomsel 200000');
INSERT INTO produk VALUES ('KLJ00270', 'Pulsa Telkomsel 500', 502000.00, 'Pulsa Telkomsel 500000');
INSERT INTO produk VALUES ('KLJ00271', 'Pulsa Axis 1', 1100.00, 'Pulsa Axis 1000');
INSERT INTO produk VALUES ('KLJ00272', 'Pulsa Axis 2', 2100.00, 'Pulsa Axis 2000');
INSERT INTO produk VALUES ('KLJ00273', 'Pulsa Axis 5', 5150.00, 'Pulsa Axis 5000');
INSERT INTO produk VALUES ('KLJ00274', 'Pulsa Axis 10', 11000.00, 'Pulsa Axis 10000');
INSERT INTO produk VALUES ('KLJ00275', 'Pulsa Axis 20', 21500.00, 'Pulsa Axis 20000');
INSERT INTO produk VALUES ('KLJ00276', 'Pulsa Axis 25', 26000.00, 'Pulsa Axis 25000');
INSERT INTO produk VALUES ('KLJ00277', 'Pulsa Axis 50', 52000.00, 'Pulsa Axis 50000');
INSERT INTO produk VALUES ('KLJ00278', 'Pulsa Axis 100', 101000.00, 'Pulsa Axis 100000');
INSERT INTO produk VALUES ('KLJ00279', 'Pulsa Axis 200', 201500.00, 'Pulsa Axis 200000');
INSERT INTO produk VALUES ('KLJ00280', 'Pulsa Axis 500', 502000.00, 'Pulsa Axis 500000');
INSERT INTO produk VALUES ('KLJ00281', 'Pulsa Indosat 1', 1100.00, 'Pulsa Indosat 1000');
INSERT INTO produk VALUES ('KLJ00282', 'Pulsa Indosat 2', 2100.00, 'Pulsa Indosat 2000');
INSERT INTO produk VALUES ('KLJ00283', 'Pulsa Indosat 5', 5150.00, 'Pulsa Indosat 5000');
INSERT INTO produk VALUES ('KLJ00284', 'Pulsa Indosat 10', 11000.00, 'Pulsa Indosat 10000');
INSERT INTO produk VALUES ('KLJ00285', 'Pulsa Indosat 20', 21500.00, 'Pulsa Indosat 20000');
INSERT INTO produk VALUES ('KLJ00286', 'Pulsa Indosat 25', 26000.00, 'Pulsa Indosat 25000');
INSERT INTO produk VALUES ('KLJ00287', 'Pulsa Indosat 50', 52000.00, 'Pulsa Indosat 50000');
INSERT INTO produk VALUES ('KLJ00288', 'Pulsa Indosat 100', 101000.00, 'Pulsa Indosat 100000');
INSERT INTO produk VALUES ('KLJ00289', 'Pulsa Indosat 200', 201500.00, 'Pulsa Indosat 200000');
INSERT INTO produk VALUES ('KLJ00290', 'Pulsa Indosat 500', 502000.00, 'Pulsa Indosat 500000');
INSERT INTO produk VALUES ('KLJ00291', 'Pulsa Tri 1', 1100.00, 'Pulsa Tri 1000');
INSERT INTO produk VALUES ('KLJ00292', 'Pulsa Tri 2', 2100.00, 'Pulsa Tri 2000');
INSERT INTO produk VALUES ('KLJ00293', 'Pulsa Tri 5', 5150.00, 'Pulsa Tri 5000');
INSERT INTO produk VALUES ('KLJ00294', 'Pulsa Tri 10', 11000.00, 'Pulsa Tri 10000');
INSERT INTO produk VALUES ('KLJ00295', 'Pulsa Tri 20', 21500.00, 'Pulsa Tri 20000');
INSERT INTO produk VALUES ('KLJ00296', 'Pulsa Tri 25', 26000.00, 'Pulsa Tri 25000');
INSERT INTO produk VALUES ('KLJ00297', 'Pulsa Tri 50', 52000.00, 'Pulsa Tri 50000');
INSERT INTO produk VALUES ('KLJ00298', 'Pulsa Tri 100', 101000.00, 'Pulsa Tri 100000');
INSERT INTO produk VALUES ('KLJ00299', 'Pulsa Tri 200', 201500.00, 'Pulsa Tri 200000');
INSERT INTO produk VALUES ('KLJ00300', 'Pulsa Tri 500', 502000.00, 'Pulsa Tri 500000');
INSERT INTO produk VALUES ('KLJ00301', 'Voucher Gemscool 1', 1100.00, 'Voucher Gemscool 1000');
INSERT INTO produk VALUES ('KLJ00302', 'Voucher Gemscool 2', 2100.00, 'Voucher Gemscool 2000');
INSERT INTO produk VALUES ('KLJ00303', 'Voucher Gemscool 5', 5150.00, 'Voucher Gemscool 5000');
INSERT INTO produk VALUES ('KLJ00304', 'Voucher Gemscool 10', 11000.00, 'Voucher Gemscool 10000');
INSERT INTO produk VALUES ('KLJ00305', 'Voucher Gemscool 20', 21500.00, 'Voucher Gemscool 20000');
INSERT INTO produk VALUES ('KLJ00306', 'Voucher Gemscool 25', 26000.00, 'Voucher Gemscool 25000');
INSERT INTO produk VALUES ('KLJ00307', 'Voucher Gemscool 50', 52000.00, 'Voucher Gemscool 50000');
INSERT INTO produk VALUES ('KLJ00308', 'Voucher Gemscool 100', 101000.00, 'Voucher Gemscool 100000');
INSERT INTO produk VALUES ('KLJ00309', 'Voucher Gemscool 200', 201500.00, 'Voucher Gemscool 200000');
INSERT INTO produk VALUES ('KLJ00310', 'Voucher Gemscool 500', 502000.00, 'Voucher Gemscool 500000');
INSERT INTO produk VALUES ('KLJ00311', 'Voucher Game-On 1', 1100.00, 'Voucher Game-On 1000');
INSERT INTO produk VALUES ('KLJ00312', 'Voucher Game-On 2', 2100.00, 'Voucher Game-On 2000');
INSERT INTO produk VALUES ('KLJ00313', 'Voucher Game-On 5', 5150.00, 'Voucher Game-On 5000');
INSERT INTO produk VALUES ('KLJ00314', 'Voucher Game-On 10', 11000.00, 'Voucher Game-On 10000');
INSERT INTO produk VALUES ('KLJ00315', 'Voucher Game-On 20', 21500.00, 'Voucher Game-On 20000');
INSERT INTO produk VALUES ('KLJ00316', 'Voucher Game-On 25', 26000.00, 'Voucher Game-On 25000');
INSERT INTO produk VALUES ('KLJ00317', 'Voucher Game-On 50', 52000.00, 'Voucher Game-On 50000');
INSERT INTO produk VALUES ('KLJ00318', 'Voucher Game-On 100', 101000.00, 'Voucher Game-On 100000');
INSERT INTO produk VALUES ('KLJ00319', 'Voucher Game-On 200', 201500.00, 'Voucher Game-On 200000');
INSERT INTO produk VALUES ('KLJ00320', 'Voucher Game-On 500', 502000.00, 'Voucher Game-On 500000');
INSERT INTO produk VALUES ('KLJ00321', 'Pulsa GO-PAY 1', 1100.00, 'Pulsa GO-PAY 1000');
INSERT INTO produk VALUES ('KLJ00322', 'Pulsa GO-PAY 2', 2100.00, 'Pulsa GO-PAY 2000');
INSERT INTO produk VALUES ('KLJ00323', 'Pulsa GO-PAY 5', 5150.00, 'Pulsa GO-PAY 5000');
INSERT INTO produk VALUES ('KLJ00324', 'Pulsa GO-PAY 10', 11000.00, 'Pulsa GO-PAY 10000');
INSERT INTO produk VALUES ('KLJ00325', 'Pulsa GO-PAY 20', 21500.00, 'Pulsa GO-PAY 20000');
INSERT INTO produk VALUES ('KLJ00326', 'Pulsa GO-PAY 25', 26000.00, 'Pulsa GO-PAY 25000');
INSERT INTO produk VALUES ('KLJ00327', 'Pulsa GO-PAY 50', 52000.00, 'Pulsa GO-PAY 50000');
INSERT INTO produk VALUES ('KLJ00328', 'Pulsa GO-PAY 100', 101000.00, 'Pulsa GO-PAY 100000');
INSERT INTO produk VALUES ('KLJ00329', 'Pulsa GO-PAY 200', 201500.00, 'Pulsa GO-PAY 200000');
INSERT INTO produk VALUES ('KLJ00330', 'Pulsa GO-PAY 500', 502000.00, 'Pulsa GO-PAY 500000');
INSERT INTO produk VALUES ('KLJ00331', 'Pulsa GrabPay 1', 1100.00, 'Pulsa GrabPay 1000');
INSERT INTO produk VALUES ('KLJ00332', 'Pulsa GrabPay 2', 2100.00, 'Pulsa GrabPay 2000');
INSERT INTO produk VALUES ('KLJ00333', 'Pulsa GrabPay 5', 5150.00, 'Pulsa GrabPay 5000');
INSERT INTO produk VALUES ('KLJ00334', 'Pulsa GrabPay 10', 11000.00, 'Pulsa GrabPay 10000');
INSERT INTO produk VALUES ('KLJ00335', 'Pulsa GrabPay 20', 21500.00, 'Pulsa GrabPay 20000');
INSERT INTO produk VALUES ('KLJ00336', 'Pulsa GrabPay 25', 26000.00, 'Pulsa GrabPay 25000');
INSERT INTO produk VALUES ('KLJ00337', 'Pulsa GrabPay 50', 52000.00, 'Pulsa GrabPay 50000');
INSERT INTO produk VALUES ('KLJ00338', 'Pulsa GrabPay 100', 101000.00, 'Pulsa GrabPay 100000');
INSERT INTO produk VALUES ('KLJ00339', 'Pulsa GrabPay 200', 201500.00, 'Pulsa GrabPay 200000');
INSERT INTO produk VALUES ('KLJ00340', 'Pulsa GrabPay 500', 502000.00, 'Pulsa GrabPay 500000');
INSERT INTO produk VALUES ('KLJ00341', 'Pulsa Simpati 1', 1100.00, 'Pulsa Simpati 1000');
INSERT INTO produk VALUES ('KLJ00342', 'Pulsa Simpati 2', 2100.00, 'Pulsa Simpati 2000');
INSERT INTO produk VALUES ('KLJ00343', 'Pulsa Simpati 5', 5150.00, 'Pulsa Simpati 5000');
INSERT INTO produk VALUES ('KLJ00344', 'Pulsa Simpati 10', 11000.00, 'Pulsa Simpati 10000');
INSERT INTO produk VALUES ('KLJ00345', 'Pulsa Simpati 20', 21500.00, 'Pulsa Simpati 20000');
INSERT INTO produk VALUES ('KLJ00346', 'Pulsa Simpati 25', 26000.00, 'Pulsa Simpati 25000');
INSERT INTO produk VALUES ('KLJ00347', 'Pulsa Simpati 50', 52000.00, 'Pulsa Simpati 50000');
INSERT INTO produk VALUES ('KLJ00348', 'Pulsa Simpati 100', 101000.00, 'Pulsa Simpati 100000');
INSERT INTO produk VALUES ('KLJ00349', 'Pulsa Simpati 200', 201500.00, 'Pulsa Simpati 200000');
INSERT INTO produk VALUES ('KLJ00350', 'Pulsa Simpati 500', 502000.00, 'Pulsa Simpati 500000');
INSERT INTO produk VALUES ('KLJ00351', 'Voucher GARENA 1', 1100.00, 'Voucher GARENA 1000');
INSERT INTO produk VALUES ('KLJ00352', 'Voucher GARENA 2', 2100.00, 'Voucher GARENA 2000');
INSERT INTO produk VALUES ('KLJ00353', 'Voucher GARENA 5', 5150.00, 'Voucher GARENA 5000');
INSERT INTO produk VALUES ('KLJ00354', 'Voucher GARENA 10', 11000.00, 'Voucher GARENA 10000');
INSERT INTO produk VALUES ('KLJ00355', 'Voucher GARENA 20', 21500.00, 'Voucher GARENA 20000');
INSERT INTO produk VALUES ('KLJ00356', 'Voucher GARENA 25', 26000.00, 'Voucher GARENA 25000');
INSERT INTO produk VALUES ('KLJ00357', 'Voucher GARENA 50', 52000.00, 'Voucher GARENA 50000');
INSERT INTO produk VALUES ('KLJ00358', 'Voucher GARENA 100', 101000.00, 'Voucher GARENA 100000');
INSERT INTO produk VALUES ('KLJ00359', 'Voucher GARENA 200', 201500.00, 'Voucher GARENA 200000');
INSERT INTO produk VALUES ('KLJ00360', 'Voucher GARENA 500', 502000.00, 'Voucher GARENA 500000');
INSERT INTO produk VALUES ('KLJ00361', 'Voucher Megaxus 1', 1100.00, 'Voucher Megaxus 1000');
INSERT INTO produk VALUES ('KLJ00362', 'Voucher Megaxus 2', 2100.00, 'Voucher Megaxus 2000');
INSERT INTO produk VALUES ('KLJ00363', 'Voucher Megaxus 5', 5150.00, 'Voucher Megaxus 5000');
INSERT INTO produk VALUES ('KLJ00364', 'Voucher Megaxus 10', 11000.00, 'Voucher Megaxus 10000');
INSERT INTO produk VALUES ('KLJ00365', 'Voucher Megaxus 20', 21500.00, 'Voucher Megaxus 20000');
INSERT INTO produk VALUES ('KLJ00366', 'Voucher Megaxus 25', 26000.00, 'Voucher Megaxus 25000');
INSERT INTO produk VALUES ('KLJ00367', 'Voucher Megaxus 50', 52000.00, 'Voucher Megaxus 50000');
INSERT INTO produk VALUES ('KLJ00368', 'Voucher Megaxus 100', 101000.00, 'Voucher Megaxus 100000');
INSERT INTO produk VALUES ('KLJ00369', 'Voucher Megaxus 200', 201500.00, 'Voucher Megaxus 200000');
INSERT INTO produk VALUES ('KLJ00370', 'Voucher Megaxus 500', 502000.00, 'Voucher Megaxus 500000');
INSERT INTO produk VALUES ('KLJ00371', 'Voucher STEAM 1', 1100.00, 'Voucher STEAM 1000');
INSERT INTO produk VALUES ('KLJ00372', 'Voucher STEAM 2', 2100.00, 'Voucher STEAM 2000');
INSERT INTO produk VALUES ('KLJ00373', 'Voucher STEAM 5', 5150.00, 'Voucher STEAM 5000');
INSERT INTO produk VALUES ('KLJ00374', 'Voucher STEAM 10', 11000.00, 'Voucher STEAM 10000');
INSERT INTO produk VALUES ('KLJ00375', 'Voucher STEAM 20', 21500.00, 'Voucher STEAM 20000');
INSERT INTO produk VALUES ('KLJ00376', 'Voucher STEAM 25', 26000.00, 'Voucher STEAM 25000');
INSERT INTO produk VALUES ('KLJ00377', 'Voucher STEAM 50', 52000.00, 'Voucher STEAM 50000');
INSERT INTO produk VALUES ('KLJ00378', 'Voucher STEAM 100', 101000.00, 'Voucher STEAM 100000');
INSERT INTO produk VALUES ('KLJ00379', 'Voucher STEAM 200', 201500.00, 'Voucher STEAM 200000');
INSERT INTO produk VALUES ('KLJ00380', 'Voucher STEAM 500', 502000.00, 'Voucher STEAM 500000');
INSERT INTO produk VALUES ('KLJ00381', 'Pulsa Loop 1', 1100.00, 'Pulsa Loop 1000');
INSERT INTO produk VALUES ('KLJ00382', 'Pulsa Loop 2', 2100.00, 'Pulsa Loop 2000');
INSERT INTO produk VALUES ('KLJ00383', 'Pulsa Loop 5', 5150.00, 'Pulsa Loop 5000');
INSERT INTO produk VALUES ('KLJ00384', 'Pulsa Loop 10', 11000.00, 'Pulsa Loop 10000');
INSERT INTO produk VALUES ('KLJ00385', 'Pulsa Loop 20', 21500.00, 'Pulsa Loop 20000');
INSERT INTO produk VALUES ('KLJ00386', 'Pulsa Loop 25', 26000.00, 'Pulsa Loop 25000');
INSERT INTO produk VALUES ('KLJ00387', 'Pulsa Loop 50', 52000.00, 'Pulsa Loop 50000');
INSERT INTO produk VALUES ('KLJ00388', 'Pulsa Loop 100', 101000.00, 'Pulsa Loop 100000');
INSERT INTO produk VALUES ('KLJ00389', 'Pulsa Loop 200', 201500.00, 'Pulsa Loop 200000');
INSERT INTO produk VALUES ('KLJ00390', 'Pulsa Loop 500', 502000.00, 'Pulsa Loop 500000');
INSERT INTO produk VALUES ('KLJ00391', 'Pulsa Mentari 1', 1100.00, 'Pulsa Mentari 1000');
INSERT INTO produk VALUES ('KLJ00392', 'Pulsa Mentari 2', 2100.00, 'Pulsa Mentari 2000');
INSERT INTO produk VALUES ('KLJ00393', 'Pulsa Mentari 5', 5150.00, 'Pulsa Mentari 5000');
INSERT INTO produk VALUES ('KLJ00394', 'Pulsa Mentari 10', 11000.00, 'Pulsa Mentari 10000');
INSERT INTO produk VALUES ('KLJ00395', 'Pulsa Mentari 20', 21500.00, 'Pulsa Mentari 20000');
INSERT INTO produk VALUES ('KLJ00396', 'Pulsa Mentari 25', 26000.00, 'Pulsa Mentari 25000');
INSERT INTO produk VALUES ('KLJ00397', 'Pulsa Mentari 50', 52000.00, 'Pulsa Mentari 50000');
INSERT INTO produk VALUES ('KLJ00398', 'Pulsa Mentari 100', 101000.00, 'Pulsa Mentari 100000');
INSERT INTO produk VALUES ('KLJ00399', 'Pulsa Mentari 200', 201500.00, 'Pulsa Mentari 200000');
INSERT INTO produk VALUES ('KLJ00400', 'Pulsa Mentari 500', 502000.00, 'Pulsa Mentari 500000');
INSERT INTO produk VALUES ('KLJ00401', 'Pulsa Kartu As 1', 1100.00, 'Pulsa Kartu As 1000');
INSERT INTO produk VALUES ('KLJ00402', 'Pulsa Kartu As 2', 2100.00, 'Pulsa Kartu As 2000');
INSERT INTO produk VALUES ('KLJ00403', 'Pulsa Kartu As 5', 5150.00, 'Pulsa Kartu As 5000');
INSERT INTO produk VALUES ('KLJ00404', 'Pulsa Kartu As 10', 11000.00, 'Pulsa Kartu As 10000');
INSERT INTO produk VALUES ('KLJ00405', 'Pulsa Kartu As 20', 21500.00, 'Pulsa Kartu As 20000');
INSERT INTO produk VALUES ('KLJ00406', 'Pulsa Kartu As 25', 26000.00, 'Pulsa Kartu As 25000');
INSERT INTO produk VALUES ('KLJ00407', 'Pulsa Kartu As 50', 52000.00, 'Pulsa Kartu As 50000');
INSERT INTO produk VALUES ('KLJ00408', 'Pulsa Kartu As 100', 101000.00, 'Pulsa Kartu As 100000');
INSERT INTO produk VALUES ('KLJ00409', 'Pulsa Kartu As 200', 201500.00, 'Pulsa Kartu As 200000');
INSERT INTO produk VALUES ('KLJ00410', 'Pulsa Kartu As 500', 502000.00, 'Pulsa Kartu As 500000');
INSERT INTO produk VALUES ('KLJ00411', 'Pulsa IM3 1', 1100.00, 'Pulsa IM3 1000');
INSERT INTO produk VALUES ('KLJ00412', 'Pulsa IM3 2', 2100.00, 'Pulsa IM3 2000');
INSERT INTO produk VALUES ('KLJ00413', 'Pulsa IM3 5', 5150.00, 'Pulsa IM3 5000');
INSERT INTO produk VALUES ('KLJ00414', 'Pulsa IM3 10', 11000.00, 'Pulsa IM3 10000');
INSERT INTO produk VALUES ('KLJ00415', 'Pulsa IM3 20', 21500.00, 'Pulsa IM3 20000');
INSERT INTO produk VALUES ('KLJ00416', 'Pulsa IM3 25', 26000.00, 'Pulsa IM3 25000');
INSERT INTO produk VALUES ('KLJ00417', 'Pulsa IM3 50', 52000.00, 'Pulsa IM3 50000');
INSERT INTO produk VALUES ('KLJ00418', 'Pulsa IM3 100', 101000.00, 'Pulsa IM3 100000');
INSERT INTO produk VALUES ('KLJ00419', 'Pulsa IM3 200', 201500.00, 'Pulsa IM3 200000');
INSERT INTO produk VALUES ('KLJ00420', 'Pulsa IM3 500', 502000.00, 'Pulsa IM3 500000');
INSERT INTO produk VALUES ('KLJ00421', 'Pulsa SmartFren 1', 1100.00, 'Pulsa SmartFren 1000');
INSERT INTO produk VALUES ('KLJ00422', 'Pulsa SmartFren 2', 2100.00, 'Pulsa SmartFren 2000');
INSERT INTO produk VALUES ('KLJ00423', 'Pulsa SmartFren 5', 5150.00, 'Pulsa SmartFren 5000');
INSERT INTO produk VALUES ('KLJ00424', 'Pulsa SmartFren 10', 11000.00, 'Pulsa SmartFren 10000');
INSERT INTO produk VALUES ('KLJ00425', 'Pulsa SmartFren 20', 21500.00, 'Pulsa SmartFren 20000');
INSERT INTO produk VALUES ('KLJ00426', 'Pulsa SmartFren 25', 26000.00, 'Pulsa SmartFren 25000');
INSERT INTO produk VALUES ('KLJ00427', 'Pulsa SmartFren 50', 52000.00, 'Pulsa SmartFren 50000');
INSERT INTO produk VALUES ('KLJ00428', 'Pulsa SmartFren 100', 101000.00, 'Pulsa SmartFren 100000');
INSERT INTO produk VALUES ('KLJ00429', 'Pulsa SmartFren 200', 201500.00, 'Pulsa SmartFren 200000');
INSERT INTO produk VALUES ('KLJ00430', 'Pulsa SmartFren 500', 502000.00, 'Pulsa SmartFren 500000');
INSERT INTO produk VALUES ('KLJ00431', 'Pulsa Bolt 1', 1100.00, 'Pulsa Bolt 1000');
INSERT INTO produk VALUES ('KLJ00432', 'Pulsa Bolt 2', 2100.00, 'Pulsa Bolt 2000');
INSERT INTO produk VALUES ('KLJ00433', 'Pulsa Bolt 5', 5150.00, 'Pulsa Bolt 5000');
INSERT INTO produk VALUES ('KLJ00434', 'Pulsa Bolt 10', 11000.00, 'Pulsa Bolt 10000');
INSERT INTO produk VALUES ('KLJ00435', 'Pulsa Bolt 20', 21500.00, 'Pulsa Bolt 20000');
INSERT INTO produk VALUES ('KLJ00436', 'Pulsa Bolt 25', 26000.00, 'Pulsa Bolt 25000');
INSERT INTO produk VALUES ('KLJ00437', 'Pulsa Bolt 50', 52000.00, 'Pulsa Bolt 50000');
INSERT INTO produk VALUES ('KLJ00438', 'Pulsa Bolt 100', 101000.00, 'Pulsa Bolt 100000');
INSERT INTO produk VALUES ('KLJ00439', 'Pulsa Bolt 200', 201500.00, 'Pulsa Bolt 200000');
INSERT INTO produk VALUES ('KLJ00440', 'Pulsa Bolt 500', 502000.00, 'Pulsa Bolt 500000');
INSERT INTO produk VALUES ('KLJ00441', 'Token Listrik 1', 1100.00, 'Token Listrik 1000');
INSERT INTO produk VALUES ('KLJ00442', 'Token Listrik 2', 2100.00, 'Token Listrik 2000');
INSERT INTO produk VALUES ('KLJ00443', 'Token Listrik 5', 5150.00, 'Token Listrik 5000');
INSERT INTO produk VALUES ('KLJ00444', 'Token Listrik 10', 11000.00, 'Token Listrik 10000');
INSERT INTO produk VALUES ('KLJ00445', 'Token Listrik 20', 21500.00, 'Token Listrik 20000');
INSERT INTO produk VALUES ('KLJ00446', 'Token Listrik 25', 26000.00, 'Token Listrik 25000');
INSERT INTO produk VALUES ('KLJ00447', 'Token Listrik 50', 52000.00, 'Token Listrik 50000');
INSERT INTO produk VALUES ('KLJ00448', 'Token Listrik 100', 101000.00, 'Token Listrik 100000');
INSERT INTO produk VALUES ('KLJ00449', 'Token Listrik 200', 201500.00, 'Token Listrik 200000');
INSERT INTO produk VALUES ('KLJ00450', 'Token Listrik 500', 502000.00, 'Token Listrik 500000');


--
-- Data for Name: produk_pulsa; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO produk_pulsa VALUES ('KLJ00251', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00252', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00253', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00254', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00255', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00256', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00257', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00258', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00259', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00260', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00261', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00262', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00263', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00264', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00265', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00266', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00267', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00268', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00269', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00270', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00271', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00272', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00273', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00274', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00275', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00276', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00277', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00278', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00279', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00280', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00281', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00282', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00283', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00284', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00285', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00286', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00287', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00288', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00289', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00290', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00291', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00292', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00293', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00294', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00295', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00296', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00297', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00298', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00299', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00300', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00301', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00302', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00303', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00304', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00305', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00306', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00307', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00308', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00309', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00310', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00311', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00312', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00313', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00314', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00315', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00316', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00317', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00318', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00319', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00320', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00321', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00322', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00323', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00324', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00325', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00326', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00327', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00328', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00329', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00330', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00331', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00332', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00333', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00334', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00335', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00336', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00337', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00338', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00339', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00340', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00341', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00342', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00343', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00344', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00345', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00346', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00347', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00348', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00349', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00350', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00351', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00352', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00353', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00354', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00355', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00356', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00357', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00358', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00359', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00360', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00361', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00362', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00363', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00364', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00365', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00366', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00367', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00368', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00369', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00370', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00371', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00372', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00373', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00374', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00375', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00376', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00377', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00378', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00379', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00380', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00381', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00382', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00383', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00384', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00385', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00386', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00387', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00388', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00389', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00390', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00391', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00392', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00393', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00394', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00395', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00396', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00397', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00398', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00399', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00400', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00401', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00402', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00403', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00404', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00405', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00406', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00407', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00408', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00409', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00410', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00411', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00412', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00413', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00414', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00415', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00416', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00417', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00418', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00419', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00420', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00421', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00422', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00423', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00424', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00425', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00426', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00427', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00428', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00429', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00430', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00431', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00432', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00433', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00434', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00435', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00436', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00437', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00438', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00439', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00440', 500);
INSERT INTO produk_pulsa VALUES ('KLJ00441', 1);
INSERT INTO produk_pulsa VALUES ('KLJ00442', 2);
INSERT INTO produk_pulsa VALUES ('KLJ00443', 5);
INSERT INTO produk_pulsa VALUES ('KLJ00444', 10);
INSERT INTO produk_pulsa VALUES ('KLJ00445', 20);
INSERT INTO produk_pulsa VALUES ('KLJ00446', 25);
INSERT INTO produk_pulsa VALUES ('KLJ00447', 50);
INSERT INTO produk_pulsa VALUES ('KLJ00448', 100);
INSERT INTO produk_pulsa VALUES ('KLJ00449', 200);
INSERT INTO produk_pulsa VALUES ('KLJ00450', 500);


--
-- Data for Name: promo; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO promo VALUES ('R00001', 'Diskon 25% all item', '2017-08-02', '2017-08-10', 'TASMURAH');
INSERT INTO promo VALUES ('R00002', 'Diskon 5% all item', '2017-06-13', '2017-06-14', 'AKHIRTAHUN');
INSERT INTO promo VALUES ('R00003', 'Diskon 5% all item', '2017-05-15', '2017-05-31', 'BAJUCHEAP');
INSERT INTO promo VALUES ('R00004', 'Buy 1 get 2', '2017-04-17', '2017-04-20', 'CELANAK');
INSERT INTO promo VALUES ('R00005', 'Buy 1 get 3', '2017-10-01', '2017-10-15', 'TOPIH');


--
-- Data for Name: promo_produk; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO promo_produk VALUES ('R00001', 'KLJ00001');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00002');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00003');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00004');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00005');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00006');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00007');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00008');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00009');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00010');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00011');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00012');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00013');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00014');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00015');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00016');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00017');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00018');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00019');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00020');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00021');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00022');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00023');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00024');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00025');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00026');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00027');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00028');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00029');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00030');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00031');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00032');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00033');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00034');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00035');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00036');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00037');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00038');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00039');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00040');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00041');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00042');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00043');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00044');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00045');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00046');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00047');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00048');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00049');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00050');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00051');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00052');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00053');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00054');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00055');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00056');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00057');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00058');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00059');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00060');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00061');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00062');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00063');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00064');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00065');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00066');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00067');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00068');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00069');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00070');
INSERT INTO promo_produk VALUES ('R00001', 'KLJ00071');
INSERT INTO promo_produk VALUES ('R00002', 'KLJ00072');
INSERT INTO promo_produk VALUES ('R00003', 'KLJ00073');
INSERT INTO promo_produk VALUES ('R00004', 'KLJ00074');
INSERT INTO promo_produk VALUES ('R00005', 'KLJ00075');


--
-- Data for Name: shipped_produk; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO shipped_produk VALUES ('KLJ00001', 'SK001', 'Ward Inc', false, 3996, true, 4, 41, 707, 212214.00, 'PlaceratAnte.gif');
INSERT INTO shipped_produk VALUES ('KLJ00002', 'SK001', 'Kreiger-Deckow and Paucek', true, 1144, false, 14, 100, 412, 548505.00, 'Amet.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00003', 'SK001', 'Schulist and Sons', true, 155, true, 8, 66, 637, 621776.00, 'ElitSodalesScelerisque.png');
INSERT INTO shipped_produk VALUES ('KLJ00004', 'SK002', 'Grant Inc', true, 9895, false, 17, 80, 651, 515775.00, 'LiberoConvallisEget.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00005', 'SK002', 'Larson-Bode and Spencer', true, 1359, true, 12, 54, 773, 150639.00, 'In.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00006', 'SK002', 'Gusikowski LLC', true, 2332, true, 17, 82, 336, 551610.00, 'PretiumNisl.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00007', 'SK003', 'Mitchell-Carroll and Von', false, 8807, true, 11, 62, 395, 944836.00, 'Nulla.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00008', 'SK003', 'Gerhold-Brown', false, 3344, true, 2, 72, 991, 843184.00, 'RidiculusMusEtiam.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00009', 'SK003', 'Green-Ondricka and Kutch', false, 8788, true, 15, 30, 892, 793155.00, 'Hendrerit.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00010', 'SK004', 'Hickle Group', false, 3025, false, 3, 63, 222, 69461.00, 'MiInPorttitor.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00011', 'SK004', 'Ondricka-Funk and Abernathy', true, 3044, false, 17, 44, 492, 500409.00, 'In.png');
INSERT INTO shipped_produk VALUES ('KLJ00012', 'SK004', 'Leuschke-Pouros and Daugherty', true, 8255, true, 9, 94, 279, 780154.00, 'AeneanLectusPellentesque.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00013', 'SK005', 'Gaylord-Haley', true, 3139, false, 11, 63, 541, 450790.00, 'EratCurabitur.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00014', 'SK005', 'Cruickshank LLC', false, 3617, false, 16, 52, 799, 896667.00, 'DuisAtVelit.png');
INSERT INTO shipped_produk VALUES ('KLJ00015', 'SK005', 'Wolf-Metz and Langosh', false, 1947, true, 6, 100, 277, 761656.00, 'EtMagnis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00016', 'SK006', 'Hudson-Johnson', false, 9151, true, 19, 53, 915, 469737.00, 'IaculisCongue.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00017', 'SK006', 'Schimmel-Nicolas', true, 2075, true, 4, 47, 972, 656071.00, 'IpsumInteger.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00018', 'SK006', 'Senger-Nikolaus', false, 8919, false, 8, 63, 742, 436770.00, 'DuisBibendum.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00019', 'SK007', 'Gulgowski-Hartmann', false, 5425, false, 3, 75, 323, 452461.00, 'Vestibulum.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00020', 'SK007', 'Kessler-Fisher and Murphy', true, 13, false, 7, 53, 551, 591349.00, 'Non.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00021', 'SK007', 'Cummings-Pollich and Ankunding', true, 3915, true, 6, 97, 886, 794433.00, 'Molestie.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00022', 'SK008', 'Bashirian-Ratke and Schmitt', false, 6691, true, 14, 77, 824, 265179.00, 'EtTempusSemper.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00023', 'SK008', 'Kuhn-Wehner', false, 3024, true, 6, 96, 518, 685856.00, 'Non.png');
INSERT INTO shipped_produk VALUES ('KLJ00024', 'SK008', 'Wilkinson Inc', false, 3984, true, 10, 43, 837, 513950.00, 'IdMaurisVulputate.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00025', 'SK009', 'Baumbach-Wiegand and Spencer', true, 1071, false, 1, 76, 275, 285639.00, 'OrciVehicula.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00026', 'SK009', 'Turner-Kuphal and Dooley', true, 9429, true, 14, 44, 896, 904165.00, 'Elit.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00027', 'SK009', 'Hackett-Bogan and Price', true, 9723, false, 4, 50, 910, 917650.00, 'Sed.png');
INSERT INTO shipped_produk VALUES ('KLJ00028', 'SK010', 'Hansen-Schulist and Corkery', true, 7787, true, 3, 79, 892, 742257.00, 'RutrumAt.gif');
INSERT INTO shipped_produk VALUES ('KLJ00029', 'SK010', 'Koelpin-Denesik', true, 4113, true, 17, 35, 947, 927752.00, 'PorttitorId.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00030', 'SK010', 'Torphy-Zboncak and Upton', false, 499, false, 3, 65, 977, 180293.00, 'IdMassa.png');
INSERT INTO shipped_produk VALUES ('KLJ00031', 'SK011', 'Boyle-Funk', true, 7193, true, 4, 50, 243, 518420.00, 'EratNulla.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00032', 'SK011', 'Gerhold Inc', true, 591, true, 19, 90, 608, 454382.00, 'QuamPede.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00033', 'SK011', 'Heidenreich and Sons', true, 3514, true, 3, 64, 987, 837510.00, 'Justo.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00034', 'SK012', 'Schuster Group', true, 222, false, 2, 59, 860, 704324.00, 'Pretium.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00035', 'SK012', 'Erdman-Bayer', false, 1603, false, 11, 30, 731, 766267.00, 'In.gif');
INSERT INTO shipped_produk VALUES ('KLJ00036', 'SK012', 'Friesen-Brakus', false, 8843, true, 15, 79, 553, 539578.00, 'CrasPellentesque.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00037', 'SK013', 'Medhurst-Walsh', true, 4217, false, 9, 58, 650, 985950.00, 'CondimentumNeque.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00038', 'SK013', 'Johnston LLC', false, 4156, false, 18, 76, 282, 61995.00, 'HabitassePlatea.png');
INSERT INTO shipped_produk VALUES ('KLJ00039', 'SK013', 'Runolfsson-O''Hara', true, 5481, true, 8, 94, 739, 336592.00, 'InFelisDonec.png');
INSERT INTO shipped_produk VALUES ('KLJ00040', 'SK014', 'Hilll-Stanton', true, 730, false, 10, 37, 797, 869262.00, 'PharetraMagnaAc.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00041', 'SK014', 'Mraz Inc', false, 6021, false, 15, 94, 254, 399314.00, 'FeugiatNonPretium.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00042', 'SK014', 'VonRueden-Pacocha and Dibbert', true, 1935, false, 10, 94, 288, 331544.00, 'Tristique.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00043', 'SK015', 'Bailey and Sons', true, 1237, true, 16, 31, 670, 968613.00, 'CrasInPurus.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00044', 'SK015', 'Lueilwitz-Bogan and Osinski', false, 3466, false, 10, 37, 476, 976939.00, 'SemPraesentId.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00045', 'SK015', 'Dooley-Wisoky', false, 2064, false, 20, 45, 212, 409469.00, 'LaoreetUtRhoncus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00046', 'SK016', 'Simonis-Grimes and Turcotte', true, 7564, true, 19, 70, 607, 952553.00, 'InterdumVenenatisTurpis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00047', 'SK016', 'King-Spinka', false, 1008, false, 20, 64, 681, 59990.00, 'Ut.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00048', 'SK016', 'Carroll-Lubowitz', true, 9448, true, 1, 94, 879, 354392.00, 'Dignissim.png');
INSERT INTO shipped_produk VALUES ('KLJ00049', 'SK017', 'Parisian-Maggio and Bins', true, 9993, false, 19, 75, 769, 558404.00, 'Diam.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00050', 'SK017', 'Rowe-Dicki and Conroy', false, 9978, false, 1, 43, 210, 468791.00, 'Lobortis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00051', 'SK017', 'Pfeffer-Rohan and Fadel', false, 4886, true, 9, 81, 575, 732132.00, 'AeneanAuctor.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00052', 'SK018', 'Nienow and Sons', false, 81, true, 7, 75, 228, 568874.00, 'AmetLobortis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00053', 'SK018', 'Ratke LLC', true, 3109, false, 13, 73, 694, 576628.00, 'QuamTurpisAdipiscing.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00054', 'SK018', 'Yost Group', true, 1810, false, 2, 87, 509, 457435.00, 'TristiqueEst.gif');
INSERT INTO shipped_produk VALUES ('KLJ00055', 'SK019', 'Kiehn-Steuber', true, 3510, true, 1, 61, 422, 896401.00, 'UtMassaQuis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00056', 'SK019', 'Kshlerin-Heaney and Mills', true, 6144, true, 7, 32, 261, 794146.00, 'Orci.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00057', 'SK019', 'Bogisich and Sons', true, 2117, false, 17, 45, 972, 77428.00, 'CurabiturConvallisDuis.png');
INSERT INTO shipped_produk VALUES ('KLJ00058', 'SK020', 'Abshire-Veum and Stiedemann', false, 9770, true, 13, 43, 669, 423062.00, 'Iaculis.gif');
INSERT INTO shipped_produk VALUES ('KLJ00059', 'SK020', 'Kris Group', true, 6691, false, 18, 76, 949, 434838.00, 'DiamNeque.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00060', 'SK020', 'Konopelski-Lehner and Moore', false, 5621, true, 3, 30, 336, 854247.00, 'Venenatis.png');
INSERT INTO shipped_produk VALUES ('KLJ00061', 'SK021', 'Vandervort LLC', false, 5959, false, 10, 54, 271, 196690.00, 'EleifendQuam.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00062', 'SK021', 'McGlynn-Aufderhar', true, 6054, true, 3, 63, 989, 248191.00, 'EuNibh.gif');
INSERT INTO shipped_produk VALUES ('KLJ00063', 'SK021', 'Williamson-Harber and Russel', false, 5375, true, 18, 71, 832, 238100.00, 'MattisEgestas.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00064', 'SK022', 'Raynor Inc', true, 3227, false, 11, 71, 809, 27744.00, 'EstEtTempus.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00065', 'SK022', 'Gleichner Group', false, 6415, false, 2, 75, 454, 317504.00, 'Pharetra.png');
INSERT INTO shipped_produk VALUES ('KLJ00066', 'SK022', 'Steuber and Sons', false, 6943, false, 15, 66, 706, 325119.00, 'Tortor.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00067', 'SK023', 'Zulauf-Waelchi', false, 9245, false, 3, 59, 232, 241990.00, 'Aliquam.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00068', 'SK023', 'Ebert-Brekke and Romaguera', false, 8129, false, 5, 56, 528, 671849.00, 'ConsequatDuiNec.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00069', 'SK023', 'Zemlak Group', false, 4538, true, 9, 40, 442, 97919.00, 'Penatibus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00070', 'SK024', 'Labadie-Ortiz and Bradtke', true, 5769, false, 17, 97, 755, 501988.00, 'MiInPorttitor.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00071', 'SK024', 'Baumbach-Koepp and Ritchie', true, 1456, true, 7, 93, 792, 737025.00, 'ConsectetuerAdipiscingElit.png');
INSERT INTO shipped_produk VALUES ('KLJ00072', 'SK024', 'Rath Inc', false, 1116, false, 18, 70, 606, 785606.00, 'Augue.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00073', 'SK025', 'Dibbert-Batz and Fahey', true, 5937, true, 9, 92, 736, 692400.00, 'Suspendisse.png');
INSERT INTO shipped_produk VALUES ('KLJ00074', 'SK025', 'Jacobson-Kunde', false, 717, false, 12, 73, 895, 156584.00, 'TortorDuisMattis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00075', 'SK025', 'Mertz LLC', false, 1903, false, 9, 83, 206, 384808.00, 'AcLobortisVel.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00076', 'SK026', 'Gorczany-Hilll and Halvorson', false, 2421, false, 4, 92, 453, 365921.00, 'HabitassePlatea.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00077', 'SK026', 'Kuphal-Bosco and Tremblay', true, 7095, false, 14, 34, 940, 674414.00, 'In.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00078', 'SK026', 'Kreiger-Leannon and Maggio', false, 4290, true, 16, 43, 748, 390729.00, 'AccumsanOdio.gif');
INSERT INTO shipped_produk VALUES ('KLJ00079', 'SK027', 'Keeling-Streich', false, 5519, true, 5, 93, 618, 933818.00, 'PorttitorLacus.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00080', 'SK027', 'Emard Inc', false, 5356, false, 8, 30, 803, 439959.00, 'Consequat.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00081', 'SK027', 'Hagenes-Lubowitz', true, 2745, true, 5, 100, 421, 85441.00, 'AliquetUltricesErat.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00082', 'SK028', 'Greenholt-Willms and Stehr', false, 3554, true, 18, 56, 695, 410912.00, 'HacHabitasse.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00083', 'SK028', 'Powlowski and Sons', false, 5288, false, 8, 63, 496, 999908.00, 'AliquetMaecenas.gif');
INSERT INTO shipped_produk VALUES ('KLJ00084', 'SK028', 'Stamm Group', true, 3052, true, 15, 62, 986, 965411.00, 'Ut.png');
INSERT INTO shipped_produk VALUES ('KLJ00085', 'SK029', 'Kreiger-Ward and D''Amore', false, 8646, false, 11, 73, 580, 540182.00, 'InAnte.png');
INSERT INTO shipped_produk VALUES ('KLJ00086', 'SK029', 'Johns-Ward and Veum', true, 6328, false, 6, 76, 468, 821534.00, 'AugueVestibulumRutrum.gif');
INSERT INTO shipped_produk VALUES ('KLJ00087', 'SK029', 'Crona Inc', true, 3180, true, 3, 34, 825, 727016.00, 'Nulla.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00088', 'SK030', 'Kreiger-Torp', true, 5581, false, 4, 50, 242, 427276.00, 'Duis.png');
INSERT INTO shipped_produk VALUES ('KLJ00089', 'SK030', 'Sipes LLC', false, 8660, false, 11, 49, 348, 519816.00, 'NibhInHac.gif');
INSERT INTO shipped_produk VALUES ('KLJ00090', 'SK030', 'Lindgren-Cartwright and Emard', true, 7793, true, 12, 46, 301, 539075.00, 'NuncPurus.png');
INSERT INTO shipped_produk VALUES ('KLJ00091', 'SK031', 'Homenick-Treutel and Kuhlman', false, 9492, false, 9, 69, 750, 932528.00, 'QuamSapienVarius.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00092', 'SK031', 'Christiansen-Mitchell and Morissette', false, 2756, false, 11, 87, 633, 475036.00, 'Justo.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00093', 'SK031', 'Nader-Pagac and Buckridge', false, 6054, false, 17, 88, 935, 218775.00, 'NisiNamUltrices.png');
INSERT INTO shipped_produk VALUES ('KLJ00094', 'SK032', 'Hansen-Mosciski and Swaniawski', true, 142, true, 15, 47, 350, 597739.00, 'InBlandit.gif');
INSERT INTO shipped_produk VALUES ('KLJ00095', 'SK032', 'Braun-Oberbrunner', false, 9700, true, 19, 92, 202, 680002.00, 'PenatibusEtMagnis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00096', 'SK032', 'Abernathy-Grady', true, 8849, false, 14, 38, 238, 544273.00, 'Montes.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00097', 'SK033', 'Lemke-Nienow and Stroman', true, 7726, false, 18, 37, 739, 192843.00, 'NuncDonecQuis.gif');
INSERT INTO shipped_produk VALUES ('KLJ00098', 'SK033', 'O''Kon Inc', false, 2320, false, 3, 40, 859, 877484.00, 'VivamusIn.gif');
INSERT INTO shipped_produk VALUES ('KLJ00099', 'SK033', 'Tromp-Gleason', false, 4395, false, 9, 60, 798, 143577.00, 'IdJustoSit.gif');
INSERT INTO shipped_produk VALUES ('KLJ00100', 'SK034', 'McDermott-Berge', true, 1207, false, 13, 65, 392, 297783.00, 'DonecPosuere.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00101', 'SK034', 'McDermott-Berge', true, 4383, true, 15, 71, 213, 632275.00, 'AliquetMassa.gif');
INSERT INTO shipped_produk VALUES ('KLJ00102', 'SK034', 'Ward Inc', false, 6988, true, 14, 33, 840, 872411.00, 'PorttitorLacusAt.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00103', 'SK035', 'Kreiger-Deckow and Paucek', false, 1272, true, 3, 89, 802, 60726.00, 'ArcuAdipiscing.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00104', 'SK035', 'Schulist and Sons', false, 164, true, 20, 47, 754, 127984.00, 'Dapibus.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00105', 'SK035', 'Grant Inc', true, 397, false, 17, 44, 998, 308323.00, 'ProinAt.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00106', 'SK036', 'Larson-Bode and Spencer', true, 5019, false, 4, 48, 800, 191236.00, 'Turpis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00107', 'SK036', 'Gusikowski LLC', false, 4834, false, 15, 59, 536, 964115.00, 'FelisSed.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00108', 'SK036', 'Mitchell-Carroll and Von', true, 8583, false, 11, 96, 319, 718007.00, 'NislNunc.gif');
INSERT INTO shipped_produk VALUES ('KLJ00109', 'SK037', 'Gerhold-Brown', false, 96, false, 11, 62, 309, 835704.00, 'DisParturient.png');
INSERT INTO shipped_produk VALUES ('KLJ00110', 'SK037', 'Green-Ondricka and Kutch', true, 6484, true, 5, 52, 868, 392162.00, 'InHacHabitasse.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00111', 'SK037', 'Hickle Group', false, 4714, false, 3, 94, 760, 450582.00, 'Condimentum.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00112', 'SK038', 'Ondricka-Funk and Abernathy', true, 5157, false, 16, 41, 351, 251756.00, 'SemperEstQuam.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00113', 'SK038', 'Leuschke-Pouros and Daugherty', false, 8680, true, 14, 67, 750, 857066.00, 'Mus.gif');
INSERT INTO shipped_produk VALUES ('KLJ00114', 'SK038', 'Gaylord-Haley', false, 3705, true, 6, 97, 200, 732605.00, 'Habitasse.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00115', 'SK039', 'Cruickshank LLC', false, 9714, false, 18, 31, 416, 525931.00, 'UltricesPosuere.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00116', 'SK039', 'Wolf-Metz and Langosh', false, 6848, true, 19, 98, 750, 943895.00, 'PedeLibero.gif');
INSERT INTO shipped_produk VALUES ('KLJ00117', 'SK039', 'Hudson-Johnson', true, 5194, true, 12, 62, 961, 213078.00, 'Cubilia.gif');
INSERT INTO shipped_produk VALUES ('KLJ00118', 'SK040', 'Schimmel-Nicolas', false, 2881, true, 19, 64, 428, 594335.00, 'FaucibusOrciLuctus.png');
INSERT INTO shipped_produk VALUES ('KLJ00119', 'SK040', 'Senger-Nikolaus', true, 9803, false, 1, 52, 228, 507975.00, 'ConsequatVariusInteger.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00120', 'SK040', 'Gulgowski-Hartmann', true, 7002, true, 17, 89, 321, 315136.00, 'Tortor.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00121', 'SK041', 'Kessler-Fisher and Murphy', false, 7528, false, 1, 81, 967, 27879.00, 'PretiumQuis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00122', 'SK041', 'Cummings-Pollich and Ankunding', true, 2713, false, 20, 87, 677, 951583.00, 'LigulaIn.png');
INSERT INTO shipped_produk VALUES ('KLJ00123', 'SK041', 'Bashirian-Ratke and Schmitt', true, 986, false, 18, 87, 325, 407364.00, 'InQuis.png');
INSERT INTO shipped_produk VALUES ('KLJ00124', 'SK042', 'Kuhn-Wehner', true, 8346, false, 17, 59, 482, 845066.00, 'UllamcorperPurusSit.png');
INSERT INTO shipped_produk VALUES ('KLJ00125', 'SK042', 'Wilkinson Inc', false, 4793, true, 17, 91, 367, 630402.00, 'Nisl.gif');
INSERT INTO shipped_produk VALUES ('KLJ00126', 'SK042', 'Baumbach-Wiegand and Spencer', false, 9916, true, 15, 33, 877, 953363.00, 'JustoPellentesque.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00127', 'SK043', 'Turner-Kuphal and Dooley', true, 1472, true, 19, 77, 201, 738952.00, 'BlanditUltricesEnim.png');
INSERT INTO shipped_produk VALUES ('KLJ00128', 'SK043', 'Hackett-Bogan and Price', true, 2205, false, 3, 84, 661, 180116.00, 'AcNequeDuis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00129', 'SK043', 'Hansen-Schulist and Corkery', false, 3275, false, 4, 30, 641, 698216.00, 'LeoOdio.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00130', 'SK044', 'Koelpin-Denesik', false, 4123, false, 18, 83, 282, 250711.00, 'Nunc.png');
INSERT INTO shipped_produk VALUES ('KLJ00131', 'SK044', 'Torphy-Zboncak and Upton', false, 3218, false, 14, 73, 699, 186516.00, 'EuMiNulla.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00132', 'SK044', 'Boyle-Funk', false, 6132, false, 4, 49, 954, 964266.00, 'PraesentBlanditLacinia.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00133', 'SK045', 'Gerhold Inc', true, 678, false, 10, 98, 749, 569307.00, 'LacusMorbi.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00134', 'SK045', 'Heidenreich and Sons', false, 9800, false, 11, 68, 561, 18015.00, 'Quam.png');
INSERT INTO shipped_produk VALUES ('KLJ00135', 'SK045', 'Schuster Group', true, 7894, false, 16, 85, 469, 746080.00, 'SuscipitLigula.png');
INSERT INTO shipped_produk VALUES ('KLJ00136', 'SK046', 'Erdman-Bayer', true, 9607, true, 5, 36, 416, 285136.00, 'CurabiturAt.gif');
INSERT INTO shipped_produk VALUES ('KLJ00137', 'SK046', 'Friesen-Brakus', true, 7169, false, 18, 42, 283, 192069.00, 'NamDuiProin.gif');
INSERT INTO shipped_produk VALUES ('KLJ00138', 'SK046', 'Medhurst-Walsh', false, 3664, true, 19, 30, 360, 978054.00, 'LuctusEtUltrices.png');
INSERT INTO shipped_produk VALUES ('KLJ00139', 'SK047', 'Johnston LLC', true, 3238, true, 13, 47, 808, 400671.00, 'VelLectus.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00140', 'SK047', 'Runolfsson-O''Hara', false, 2086, false, 3, 83, 672, 732545.00, 'LobortisVelDapibus.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00141', 'SK047', 'Hilll-Stanton', false, 2374, true, 16, 38, 373, 78391.00, 'Tincidunt.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00142', 'SK048', 'Mraz Inc', false, 2581, true, 10, 55, 412, 752910.00, 'Consequat.gif');
INSERT INTO shipped_produk VALUES ('KLJ00143', 'SK048', 'VonRueden-Pacocha and Dibbert', false, 5401, true, 18, 52, 463, 268918.00, 'VestibulumProinEu.png');
INSERT INTO shipped_produk VALUES ('KLJ00144', 'SK048', 'Bailey and Sons', true, 852, false, 5, 30, 534, 995582.00, 'NullamMolestie.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00145', 'SK049', 'Lueilwitz-Bogan and Osinski', false, 2477, false, 3, 31, 210, 971312.00, 'VolutpatConvallis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00146', 'SK049', 'Dooley-Wisoky', false, 4187, false, 15, 66, 469, 358928.00, 'DuiLuctusRutrum.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00147', 'SK049', 'Simonis-Grimes and Turcotte', true, 3185, false, 7, 64, 348, 327165.00, 'DolorQuisOdio.gif');
INSERT INTO shipped_produk VALUES ('KLJ00148', 'SK050', 'King-Spinka', false, 4128, true, 13, 67, 457, 222911.00, 'Donec.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00149', 'SK050', 'Ward Inc', false, 4018, true, 18, 59, 211, 78087.00, 'AnteVestibulum.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00150', 'SK050', 'Kreiger-Deckow and Paucek', false, 8737, false, 13, 57, 831, 570246.00, 'PotentiCras.png');
INSERT INTO shipped_produk VALUES ('KLJ00151', 'SK051', 'Schulist and Sons', false, 5942, false, 15, 39, 487, 630878.00, 'SapienPlacerat.gif');
INSERT INTO shipped_produk VALUES ('KLJ00152', 'SK051', 'Grant Inc', false, 7371, false, 4, 39, 592, 697424.00, 'NisiVulputateNonummy.png');
INSERT INTO shipped_produk VALUES ('KLJ00153', 'SK051', 'Larson-Bode and Spencer', false, 7049, false, 7, 61, 771, 717044.00, 'Consequat.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00154', 'SK052', 'Gusikowski LLC', true, 9003, false, 19, 71, 208, 784490.00, 'JustoEu.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00155', 'SK052', 'Mitchell-Carroll and Von', true, 5669, false, 13, 56, 929, 199824.00, 'In.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00156', 'SK052', 'Gerhold-Brown', true, 6125, false, 13, 72, 829, 641612.00, 'Non.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00157', 'SK053', 'Green-Ondricka and Kutch', true, 2369, false, 15, 83, 688, 740104.00, 'TinciduntEget.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00158', 'SK053', 'Hickle Group', false, 8254, false, 6, 79, 955, 811602.00, 'LacusMorbiQuis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00159', 'SK053', 'Ondricka-Funk and Abernathy', false, 9600, true, 3, 50, 862, 64691.00, 'NisiNamUltrices.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00160', 'SK054', 'Leuschke-Pouros and Daugherty', true, 5245, false, 7, 92, 888, 455872.00, 'EgetMassaTempor.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00161', 'SK054', 'Gaylord-Haley', false, 2291, true, 20, 41, 338, 84497.00, 'Est.png');
INSERT INTO shipped_produk VALUES ('KLJ00162', 'SK054', 'Cruickshank LLC', true, 5724, true, 10, 59, 431, 667263.00, 'PulvinarSedNisl.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00163', 'SK055', 'Wolf-Metz and Langosh', false, 1324, false, 18, 35, 765, 572333.00, 'CommodoPlacerat.gif');
INSERT INTO shipped_produk VALUES ('KLJ00164', 'SK055', 'Hudson-Johnson', false, 3166, true, 5, 65, 586, 535800.00, 'NullaEget.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00165', 'SK055', 'Schimmel-Nicolas', false, 7802, false, 1, 73, 773, 954400.00, 'Eleifend.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00166', 'SK056', 'Senger-Nikolaus', false, 8548, true, 20, 73, 422, 802804.00, 'Lectus.png');
INSERT INTO shipped_produk VALUES ('KLJ00167', 'SK056', 'Gulgowski-Hartmann', false, 6727, false, 7, 46, 246, 373686.00, 'Id.png');
INSERT INTO shipped_produk VALUES ('KLJ00168', 'SK056', 'Kessler-Fisher and Murphy', false, 4641, false, 15, 81, 995, 533476.00, 'PosuereCubiliaCurae.png');
INSERT INTO shipped_produk VALUES ('KLJ00169', 'SK057', 'Cummings-Pollich and Ankunding', true, 9529, true, 5, 56, 395, 960113.00, 'VelAccumsanTellus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00170', 'SK057', 'Bashirian-Ratke and Schmitt', false, 9620, false, 11, 86, 645, 700714.00, 'SuscipitLigulaIn.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00171', 'SK057', 'Kuhn-Wehner', true, 345, true, 9, 46, 976, 187386.00, 'ProinInterdumMauris.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00172', 'SK058', 'Wilkinson Inc', false, 6036, false, 7, 35, 890, 85109.00, 'Convallis.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00173', 'SK058', 'Baumbach-Wiegand and Spencer', false, 58, true, 4, 61, 390, 429158.00, 'EleifendQuam.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00174', 'SK058', 'Turner-Kuphal and Dooley', true, 9517, true, 20, 36, 240, 172741.00, 'LuctusEtUltrices.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00175', 'SK059', 'Hackett-Bogan and Price', false, 7616, true, 15, 30, 835, 838016.00, 'At.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00176', 'SK059', 'Hansen-Schulist and Corkery', false, 2289, false, 7, 30, 215, 967426.00, 'Venenatis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00177', 'SK059', 'Koelpin-Denesik', true, 4744, false, 7, 80, 219, 505767.00, 'InFaucibus.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00178', 'SK060', 'Torphy-Zboncak and Upton', true, 8152, true, 11, 81, 738, 853023.00, 'Maecenas.png');
INSERT INTO shipped_produk VALUES ('KLJ00179', 'SK060', 'Boyle-Funk', false, 3959, true, 16, 73, 796, 163216.00, 'PosuereFelis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00180', 'SK060', 'Gerhold Inc', false, 2165, true, 15, 67, 484, 659005.00, 'Sapien.gif');
INSERT INTO shipped_produk VALUES ('KLJ00181', 'SK061', 'Heidenreich and Sons', true, 1393, true, 1, 39, 499, 964496.00, 'InLectusPellentesque.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00182', 'SK061', 'Schuster Group', false, 8566, false, 12, 77, 593, 819528.00, 'InterdumEuTincidunt.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00183', 'SK061', 'Erdman-Bayer', false, 3781, false, 8, 89, 907, 501549.00, 'IdTurpis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00184', 'SK062', 'Friesen-Brakus', false, 4270, false, 15, 73, 443, 759899.00, 'LectusPellentesque.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00185', 'SK062', 'Medhurst-Walsh', true, 2041, true, 3, 79, 383, 99863.00, 'DonecDiamNeque.gif');
INSERT INTO shipped_produk VALUES ('KLJ00186', 'SK062', 'Johnston LLC', false, 6705, false, 18, 68, 840, 630827.00, 'AliquamSit.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00187', 'SK063', 'Runolfsson-O''Hara', false, 2649, true, 7, 35, 228, 958244.00, 'SedMagnaAt.gif');
INSERT INTO shipped_produk VALUES ('KLJ00188', 'SK063', 'Hilll-Stanton', true, 7964, true, 2, 70, 812, 948687.00, 'NibhLigulaNec.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00189', 'SK063', 'Mraz Inc', true, 4713, false, 15, 67, 871, 244956.00, 'Mattis.gif');
INSERT INTO shipped_produk VALUES ('KLJ00190', 'SK064', 'VonRueden-Pacocha and Dibbert', true, 6504, true, 9, 99, 831, 587018.00, 'EuFelisFusce.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00191', 'SK064', 'Bailey and Sons', false, 9814, false, 10, 58, 838, 897307.00, 'Massa.gif');
INSERT INTO shipped_produk VALUES ('KLJ00192', 'SK064', 'Lueilwitz-Bogan and Osinski', false, 9029, true, 16, 76, 600, 922710.00, 'InTempusSit.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00193', 'SK065', 'Dooley-Wisoky', true, 2591, false, 11, 30, 622, 74043.00, 'EgetVulputate.gif');
INSERT INTO shipped_produk VALUES ('KLJ00194', 'SK065', 'Simonis-Grimes and Turcotte', false, 6709, true, 5, 77, 818, 231001.00, 'NibhInQuis.png');
INSERT INTO shipped_produk VALUES ('KLJ00195', 'SK065', 'King-Spinka', true, 4346, true, 14, 37, 468, 332790.00, 'DuiMaecenasTristique.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00196', 'SK066', 'Carroll-Lubowitz', false, 5647, true, 1, 65, 812, 818292.00, 'SedTincidunt.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00197', 'SK066', 'Parisian-Maggio and Bins', true, 7182, false, 5, 70, 931, 531975.00, 'EstQuamPharetra.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00198', 'SK066', 'Rowe-Dicki and Conroy', true, 585, false, 4, 33, 426, 109819.00, 'PlaceratPraesent.png');
INSERT INTO shipped_produk VALUES ('KLJ00199', 'SK067', 'Pfeffer-Rohan and Fadel', true, 2608, true, 16, 90, 264, 434031.00, 'Tristique.gif');
INSERT INTO shipped_produk VALUES ('KLJ00200', 'SK067', 'Nienow and Sons', false, 3507, false, 20, 83, 760, 447909.00, 'AdipiscingMolestie.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00201', 'SK067', 'Ratke LLC', true, 9667, false, 4, 62, 567, 744054.00, 'NullaUt.gif');
INSERT INTO shipped_produk VALUES ('KLJ00202', 'SK068', 'Yost Group', true, 4866, true, 17, 36, 980, 834538.00, 'Dapibus.png');
INSERT INTO shipped_produk VALUES ('KLJ00203', 'SK068', 'Kiehn-Steuber', true, 8908, true, 11, 100, 636, 839780.00, 'LiberoRutrum.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00204', 'SK068', 'Kshlerin-Heaney and Mills', true, 8724, false, 11, 79, 841, 137418.00, 'VelEnim.gif');
INSERT INTO shipped_produk VALUES ('KLJ00205', 'SK069', 'Bogisich and Sons', true, 1780, false, 11, 94, 271, 92033.00, 'TemporConvallisNulla.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00206', 'SK069', 'Abshire-Veum and Stiedemann', true, 7850, true, 14, 95, 464, 14815.00, 'VariusInteger.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00207', 'SK069', 'Kris Group', false, 7736, false, 8, 47, 595, 75241.00, 'NullaAcEnim.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00208', 'SK070', 'Konopelski-Lehner and Moore', false, 4316, false, 2, 43, 865, 516104.00, 'DonecQuis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00209', 'SK070', 'Vandervort LLC', true, 4407, false, 14, 41, 280, 906105.00, 'Tempus.gif');
INSERT INTO shipped_produk VALUES ('KLJ00210', 'SK070', 'McGlynn-Aufderhar', false, 4370, true, 8, 56, 205, 156544.00, 'BlanditLaciniaErat.gif');
INSERT INTO shipped_produk VALUES ('KLJ00211', 'SK071', 'Williamson-Harber and Russel', true, 3464, true, 1, 95, 737, 29642.00, 'AtVelitVivamus.gif');
INSERT INTO shipped_produk VALUES ('KLJ00212', 'SK071', 'Raynor Inc', false, 4471, false, 7, 56, 506, 563832.00, 'AliquamConvallisNunc.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00213', 'SK071', 'Gleichner Group', true, 7000, true, 5, 40, 634, 290493.00, 'SedAnteVivamus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00214', 'SK072', 'Steuber and Sons', false, 1844, false, 18, 37, 807, 810212.00, 'Nunc.png');
INSERT INTO shipped_produk VALUES ('KLJ00215', 'SK072', 'Zulauf-Waelchi', true, 2894, true, 2, 80, 307, 368383.00, 'Eget.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00216', 'SK072', 'Ebert-Brekke and Romaguera', false, 831, true, 20, 85, 593, 909615.00, 'MorbiVestibulumVelit.png');
INSERT INTO shipped_produk VALUES ('KLJ00217', 'SK073', 'Zemlak Group', true, 8518, false, 6, 98, 701, 117697.00, 'SitAmetEros.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00218', 'SK073', 'Labadie-Ortiz and Bradtke', false, 5468, false, 19, 50, 863, 485360.00, 'PosuereCubiliaCurae.png');
INSERT INTO shipped_produk VALUES ('KLJ00219', 'SK073', 'Baumbach-Koepp and Ritchie', false, 7424, false, 4, 30, 545, 915454.00, 'NonummyIntegerNon.png');
INSERT INTO shipped_produk VALUES ('KLJ00220', 'SK074', 'Rath Inc', true, 9008, true, 5, 74, 615, 308714.00, 'AliquamAugue.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00221', 'SK074', 'Dibbert-Batz and Fahey', true, 3173, false, 14, 30, 723, 297203.00, 'InHac.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00222', 'SK074', 'Jacobson-Kunde', true, 8771, true, 14, 82, 438, 553685.00, 'AcConsequatMetus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00223', 'SK075', 'Mertz LLC', false, 9123, true, 20, 61, 234, 401134.00, 'ProinInterdum.png');
INSERT INTO shipped_produk VALUES ('KLJ00224', 'SK075', 'Gorczany-Hilll and Halvorson', true, 58, true, 3, 96, 365, 676265.00, 'CondimentumNeque.png');
INSERT INTO shipped_produk VALUES ('KLJ00225', 'SK075', 'Kuphal-Bosco and Tremblay', false, 6489, false, 10, 94, 792, 201436.00, 'ConsectetuerAdipiscingElit.png');
INSERT INTO shipped_produk VALUES ('KLJ00226', 'SK076', 'Kreiger-Leannon and Maggio', false, 336, false, 2, 44, 485, 765119.00, 'MassaTempor.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00227', 'SK076', 'Keeling-Streich', false, 7621, true, 5, 53, 671, 662669.00, 'Vivamus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00228', 'SK076', 'Emard Inc', true, 3140, false, 12, 34, 514, 470638.00, 'Quam.png');
INSERT INTO shipped_produk VALUES ('KLJ00229', 'SK077', 'Hagenes-Lubowitz', true, 2475, true, 2, 92, 735, 129399.00, 'FaucibusOrci.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00230', 'SK077', 'Greenholt-Willms and Stehr', false, 9432, false, 1, 43, 325, 531602.00, 'Ultrices.png');
INSERT INTO shipped_produk VALUES ('KLJ00231', 'SK077', 'Powlowski and Sons', true, 8026, false, 16, 85, 807, 976167.00, 'Id.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00232', 'SK078', 'Stamm Group', true, 3881, false, 4, 57, 841, 921881.00, 'Arcu.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00233', 'SK078', 'Kreiger-Ward and D''Amore', true, 84, false, 13, 82, 749, 686646.00, 'InFaucibus.gif');
INSERT INTO shipped_produk VALUES ('KLJ00234', 'SK078', 'Johns-Ward and Veum', false, 622, true, 5, 98, 229, 823112.00, 'AccumsanFelisUt.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00235', 'SK079', 'Crona Inc', false, 8285, false, 1, 56, 618, 842193.00, 'PurusPhasellus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00236', 'SK079', 'Kreiger-Torp', false, 1068, false, 19, 34, 372, 612235.00, 'Ac.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00237', 'SK079', 'Sipes LLC', false, 8756, false, 9, 64, 417, 272832.00, 'Morbi.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00238', 'SK080', 'Lindgren-Cartwright and Emard', false, 1561, false, 6, 43, 853, 442866.00, 'In.gif');
INSERT INTO shipped_produk VALUES ('KLJ00239', 'SK080', 'Homenick-Treutel and Kuhlman', true, 5673, false, 2, 50, 616, 140614.00, 'FermentumDonec.gif');
INSERT INTO shipped_produk VALUES ('KLJ00240', 'SK080', 'Christiansen-Mitchell and Morissette', true, 1647, false, 4, 30, 455, 502605.00, 'PotentiNullam.png');
INSERT INTO shipped_produk VALUES ('KLJ00241', 'SK001', 'Nader-Pagac and Buckridge', false, 7215, false, 5, 74, 394, 161166.00, 'Magna.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00242', 'SK001', 'Hansen-Mosciski and Swaniawski', false, 7749, false, 14, 95, 324, 837829.00, 'PrimisInFaucibus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00243', 'SK001', 'Braun-Oberbrunner', false, 8692, true, 18, 35, 939, 735598.00, 'InAnteVestibulum.png');
INSERT INTO shipped_produk VALUES ('KLJ00244', 'SK002', 'Abernathy-Grady', true, 7956, true, 1, 64, 577, 936251.00, 'TortorRisus.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00245', 'SK002', 'Lemke-Nienow and Stroman', false, 3137, false, 8, 92, 495, 797035.00, 'Sed.gif');
INSERT INTO shipped_produk VALUES ('KLJ00246', 'SK002', 'O''Kon Inc', true, 6439, false, 7, 68, 219, 383899.00, 'Interdum.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00247', 'SK003', 'Tromp-Gleason', false, 5911, false, 1, 39, 904, 39673.00, 'VestibulumAnte.tiff');
INSERT INTO shipped_produk VALUES ('KLJ00248', 'SK003', 'McDermott-Berge', true, 1350, false, 1, 100, 628, 920515.00, 'SitAmet.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00249', 'SK003', 'McDermott-Berge', false, 6581, false, 7, 59, 206, 858247.00, 'PenatibusEtMagnis.jpeg');
INSERT INTO shipped_produk VALUES ('KLJ00250', 'SK004', 'Ward Inc', true, 6195, true, 20, 86, 403, 167359.00, 'NonQuamNec.tiff');


--
-- Data for Name: sub_kategori; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO sub_kategori VALUES ('SK001', 'K01', 'Atasan');
INSERT INTO sub_kategori VALUES ('SK002', 'K01', 'Celana');
INSERT INTO sub_kategori VALUES ('SK003', 'K01', 'Dress');
INSERT INTO sub_kategori VALUES ('SK004', 'K01', 'Outerwear');
INSERT INTO sub_kategori VALUES ('SK005', 'K01', 'Setelan');
INSERT INTO sub_kategori VALUES ('SK006', 'K01', 'Batik Wanita');
INSERT INTO sub_kategori VALUES ('SK007', 'K01', 'Pakaian Dalam Wanita');
INSERT INTO sub_kategori VALUES ('SK008', 'K01', 'Tas');
INSERT INTO sub_kategori VALUES ('SK009', 'K01', 'Sepatu');
INSERT INTO sub_kategori VALUES ('SK010', 'K01', 'Jam Tangan');
INSERT INTO sub_kategori VALUES ('SK011', 'K01', 'Perhiasan');
INSERT INTO sub_kategori VALUES ('SK012', 'K01', 'Aksesoris');
INSERT INTO sub_kategori VALUES ('SK013', 'K01', 'Aksesoris Rambut');
INSERT INTO sub_kategori VALUES ('SK014', 'K01', 'Perlengkapan Couple');
INSERT INTO sub_kategori VALUES ('SK015', 'K01', 'Baju Tidur');
INSERT INTO sub_kategori VALUES ('SK016', 'K01', 'Perlengkapan Jahit');
INSERT INTO sub_kategori VALUES ('SK017', 'K02', 'Jam Tangan');
INSERT INTO sub_kategori VALUES ('SK018', 'K02', 'Baju Tidur');
INSERT INTO sub_kategori VALUES ('SK019', 'K02', 'Pakaian Dalam Pria');
INSERT INTO sub_kategori VALUES ('SK020', 'K02', 'Outerwear');
INSERT INTO sub_kategori VALUES ('SK021', 'K02', 'Sepatu');
INSERT INTO sub_kategori VALUES ('SK022', 'K02', 'Tas');
INSERT INTO sub_kategori VALUES ('SK023', 'K02', 'Perhiasan Fashion');
INSERT INTO sub_kategori VALUES ('SK024', 'K02', 'Aksesoris');
INSERT INTO sub_kategori VALUES ('SK025', 'K02', 'Celana');
INSERT INTO sub_kategori VALUES ('SK026', 'K02', 'Batik Pria');
INSERT INTO sub_kategori VALUES ('SK027', 'K02', 'Atasan');
INSERT INTO sub_kategori VALUES ('SK028', 'K03', 'Outerwear');
INSERT INTO sub_kategori VALUES ('SK029', 'K03', 'Setelan Muslim');
INSERT INTO sub_kategori VALUES ('SK030', 'K03', 'Dress');
INSERT INTO sub_kategori VALUES ('SK031', 'K03', 'Scarf');
INSERT INTO sub_kategori VALUES ('SK032', 'K03', 'Baju Muslim Anak');
INSERT INTO sub_kategori VALUES ('SK033', 'K03', 'Atasan');
INSERT INTO sub_kategori VALUES ('SK034', 'K03', 'Aksesoris Jilbab');
INSERT INTO sub_kategori VALUES ('SK035', 'K03', 'Bawahan');
INSERT INTO sub_kategori VALUES ('SK036', 'K03', 'Perlengkapan Ibadah');
INSERT INTO sub_kategori VALUES ('SK037', 'K04', 'Perhiasan Anak');
INSERT INTO sub_kategori VALUES ('SK038', 'K04', 'Sepatu Anak Perempuan');
INSERT INTO sub_kategori VALUES ('SK039', 'K04', 'Aksesoris Rambut Anak');
INSERT INTO sub_kategori VALUES ('SK040', 'K04', 'Aksesoris Anak');
INSERT INTO sub_kategori VALUES ('SK041', 'K04', 'Tas Anak');
INSERT INTO sub_kategori VALUES ('SK042', 'K04', 'Sepatu Anak Laki-laki');
INSERT INTO sub_kategori VALUES ('SK043', 'K04', 'Pakaian Anak Perempuan');
INSERT INTO sub_kategori VALUES ('SK044', 'K04', 'Pakaian Anak Laki-Laki');
INSERT INTO sub_kategori VALUES ('SK045', 'K05', 'Kosmetik');
INSERT INTO sub_kategori VALUES ('SK046', 'K05', 'Perawatan Wajah');
INSERT INTO sub_kategori VALUES ('SK047', 'K05', 'Perawatan Tangan, Kaki dan Kuku');
INSERT INTO sub_kategori VALUES ('SK048', 'K05', 'Perawatan Rambut');
INSERT INTO sub_kategori VALUES ('SK049', 'K05', 'Perawatan Mata');
INSERT INTO sub_kategori VALUES ('SK050', 'K05', 'Styling Rambut');
INSERT INTO sub_kategori VALUES ('SK051', 'K05', 'Peralatan Make Up');
INSERT INTO sub_kategori VALUES ('SK052', 'K05', 'Grooming');
INSERT INTO sub_kategori VALUES ('SK053', 'K05', 'Mandi & Perawatan Tubuh');
INSERT INTO sub_kategori VALUES ('SK054', 'K06', 'Telinga');
INSERT INTO sub_kategori VALUES ('SK055', 'K06', 'Kesehatan Wanita');
INSERT INTO sub_kategori VALUES ('SK056', 'K06', 'Obat & Alat Kesehatan');
INSERT INTO sub_kategori VALUES ('SK057', 'K06', 'Health Products');
INSERT INTO sub_kategori VALUES ('SK058', 'K06', 'Kesehatan Gigi & Mulut');
INSERT INTO sub_kategori VALUES ('SK059', 'K06', 'Diet & Vitamin');
INSERT INTO sub_kategori VALUES ('SK060', 'K06', 'Kesehatan Mata');
INSERT INTO sub_kategori VALUES ('SK061', 'K06', 'Perlengkapan Medis');
INSERT INTO sub_kategori VALUES ('SK062', 'K06', 'Kesehatan Lainnya');
INSERT INTO sub_kategori VALUES ('SK063', 'K07', 'Aksesoris Bayi');
INSERT INTO sub_kategori VALUES ('SK064', 'K08', 'Kamar Tidur');
INSERT INTO sub_kategori VALUES ('SK065', 'K09', 'Handphone');
INSERT INTO sub_kategori VALUES ('SK066', 'K10', 'Laptop');
INSERT INTO sub_kategori VALUES ('SK067', 'K11', 'Komputer');
INSERT INTO sub_kategori VALUES ('SK068', 'K12', 'TV');
INSERT INTO sub_kategori VALUES ('SK069', 'K13', 'Kamera');
INSERT INTO sub_kategori VALUES ('SK070', 'K14', 'Aksesoris Mobil');
INSERT INTO sub_kategori VALUES ('SK071', 'K15', 'Basket');
INSERT INTO sub_kategori VALUES ('SK072', 'K16', 'Musik');
INSERT INTO sub_kategori VALUES ('SK073', 'K17', 'Peralatan Dapur');
INSERT INTO sub_kategori VALUES ('SK074', 'K18', 'Alat Tulis');
INSERT INTO sub_kategori VALUES ('SK075', 'K19', 'Boneka');
INSERT INTO sub_kategori VALUES ('SK076', 'K20', 'Figure');
INSERT INTO sub_kategori VALUES ('SK077', 'K21', 'Makanan');
INSERT INTO sub_kategori VALUES ('SK078', 'K21', 'Minuman');
INSERT INTO sub_kategori VALUES ('SK079', 'K22', 'Buku Sekolah');
INSERT INTO sub_kategori VALUES ('SK080', 'K22', 'Novel Sastra');


--
-- Data for Name: toko; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO toko VALUES ('Ward Inc', 'Toko yang menghadirkan barang berkualitas tinggi', 'embrace rich deliverables', '4 Fallview Crossing', 'iscrogges6y@samsung.com');
INSERT INTO toko VALUES ('Kreiger-Deckow and Paucek', 'Toko yang menghadirkan barang berkualitas tinggi', 'recontextualize cutting-edge platforms', '71 Randy Hill', 'rpendergrast6z@hao123.com');
INSERT INTO toko VALUES ('Schulist and Sons', 'Toko yang menghadirkan barang berkualitas tinggi', 'synergize dot-com metrics', '7 Mosinee Trail', 'aluetkemeyers70@miibeian.gov.cn');
INSERT INTO toko VALUES ('Grant Inc', 'Toko yang menghadirkan barang berkualitas tinggi', 'architect holistic networks', '64 Oneill Circle', 'cpittford71@photobucket.com');
INSERT INTO toko VALUES ('Larson-Bode and Spencer', 'Toko yang menghadirkan barang berkualitas tinggi', 'utilize one-to-one applications', '9036 Shelley Parkway', 'kskerm72@list-manage.com');
INSERT INTO toko VALUES ('Gusikowski LLC', 'Toko yang menghadirkan barang berkualitas tinggi', 'iterate revolutionary deliverables', '880 Park Meadow Lane', 'lsparling73@fema.gov');
INSERT INTO toko VALUES ('Mitchell-Carroll and Von', 'Toko yang menghadirkan barang berkualitas tinggi', 'transform efficient metrics', '75 Oak Valley Way', 'dde74@fc2.com');
INSERT INTO toko VALUES ('Gerhold-Brown', 'Toko yang menghadirkan barang berkualitas tinggi', 'engage collaborative channels', '9790 Delaware Terrace', 'nbeale75@sohu.com');
INSERT INTO toko VALUES ('Green-Ondricka and Kutch', 'Toko yang menghadirkan barang berkualitas tinggi', 'deliver rich platforms', '55 Clove Court', 'cegdal76@edublogs.org');
INSERT INTO toko VALUES ('Hickle Group', 'Toko yang menghadirkan barang berkualitas tinggi', 'reintermediate visionary systems', '60 Amoth Way', 'umcjury77@hp.com');
INSERT INTO toko VALUES ('Ondricka-Funk and Abernathy', 'Toko yang menghadirkan barang berkualitas tinggi', 'aggregate vertical e-commerce', '40 Holmberg Parkway', 'mramsdell78@paypal.com');
INSERT INTO toko VALUES ('Leuschke-Pouros and Daugherty', 'Toko elektronik murah meriah', 'whiteboard B2B vortals', '18 Lakeland Court', 'rroffe79@smh.com.au');
INSERT INTO toko VALUES ('Gaylord-Haley', 'Toko elektronik murah meriah', 'engineer intuitive platforms', '69 Upham Way', 'mchillingworth7a@themeforest.net');
INSERT INTO toko VALUES ('Cruickshank LLC', 'Toko elektronik murah meriah', 'leverage vertical communities', '98446 Sugar Parkway', 'bcochran7b@smugmug.com');
INSERT INTO toko VALUES ('Wolf-Metz and Langosh', 'Toko elektronik murah meriah', 'whiteboard ubiquitous web-readiness', '87469 Dwight Lane', 'rbarff7c@goo.gl');
INSERT INTO toko VALUES ('Hudson-Johnson', 'Toko elektronik murah meriah', 'transform innovative markets', '43 Debs Way', 'dsketcher7d@ehow.com');
INSERT INTO toko VALUES ('Schimmel-Nicolas', 'Toko elektronik murah meriah', 'disintermediate sticky web-readiness', '7 Meadow Valley Court', 'gdecent7e@pinterest.com');
INSERT INTO toko VALUES ('Senger-Nikolaus', 'Toko elektronik murah meriah', 'disintermediate efficient e-tailers', '41072 Birchwood Junction', 'sestcot7f@nbcnews.com');
INSERT INTO toko VALUES ('Gulgowski-Hartmann', 'Toko elektronik murah meriah', 'revolutionize transparent solutions', '6468 Ryan Pass', 'ishord7g@bloglines.com');
INSERT INTO toko VALUES ('Kessler-Fisher and Murphy', 'Toko elektronik murah meriah', 'aggregate leading-edge applications', '21 Rusk Park', 'bdaunay7h@elegantthemes.com');
INSERT INTO toko VALUES ('Cummings-Pollich and Ankunding', 'Toko elektronik murah meriah', 'deliver integrated architectures', '09 Mayer Road', 'aaliman7i@wp.com');
INSERT INTO toko VALUES ('Bashirian-Ratke and Schmitt', 'Toko elektronik murah meriah', 'enable impactful relationships', '144 East Crossing', 'swoolgar7j@thetimes.co.uk');
INSERT INTO toko VALUES ('Kuhn-Wehner', 'Toko elektronik murah meriah', 'integrate visionary platforms', '1237 Main Drive', 'cborborough7k@twitter.com');
INSERT INTO toko VALUES ('Wilkinson Inc', 'Toko elektronik murah meriah', 'productize innovative synergies', '17404 Carpenter Plaza', 'mgoodsal7l@virginia.edu');
INSERT INTO toko VALUES ('Baumbach-Wiegand and Spencer', 'Toko kualitas tinggi harga murah meriah', 'deploy world-class platforms', '60 Lakewood Gardens Street', 'gsherwyn7m@deviantart.com');
INSERT INTO toko VALUES ('Turner-Kuphal and Dooley', 'Toko kualitas tinggi harga murah meriah', 'implement front-end mindshare', '76 Helena Terrace', 'aoldam7n@google.fr');
INSERT INTO toko VALUES ('Hackett-Bogan and Price', 'Toko kualitas tinggi harga murah meriah', 'transform world-class e-markets', '42238 Corscot Place', 'mjindrich7o@twitter.com');
INSERT INTO toko VALUES ('Hansen-Schulist and Corkery', 'Toko kualitas tinggi harga murah meriah', 'benchmark holistic solutions', '36244 Lakewood Street', 'bandryunin7p@cyberchimps.com');
INSERT INTO toko VALUES ('Koelpin-Denesik', 'Toko kualitas tinggi harga murah meriah', 'synthesize back-end users', '971 Vera Trail', 'tfulleylove7q@nps.gov');
INSERT INTO toko VALUES ('Torphy-Zboncak and Upton', 'Toko kualitas tinggi harga murah meriah', 'generate B2B web services', '99 Claremont Crossing', 'ereffe7r@about.me');
INSERT INTO toko VALUES ('Boyle-Funk', 'Toko kualitas tinggi harga murah meriah', 'enable efficient vortals', '990 International Center', 'streasure7s@godaddy.com');
INSERT INTO toko VALUES ('Gerhold Inc', 'Toko kualitas tinggi harga murah meriah', 'synergize B2B networks', '5 Weeping Birch Lane', 'psculley7t@t-online.de');
INSERT INTO toko VALUES ('Heidenreich and Sons', 'Toko kualitas tinggi harga murah meriah', 'empower collaborative infomediaries', '3 Thierer Avenue', 'frodbourne7u@histats.com');
INSERT INTO toko VALUES ('Schuster Group', 'Toko kualitas tinggi harga murah meriah', 'strategize B2B applications', '62355 Northwestern Place', 'doris7v@taobao.com');
INSERT INTO toko VALUES ('Erdman-Bayer', 'Toko kualitas tinggi harga murah meriah', 'incubate efficient e-commerce', '69430 Blaine Circle', 'acumberpatch7w@about.me');
INSERT INTO toko VALUES ('Friesen-Brakus', 'Toko obat obatan murah', 'optimize clicks-and-mortar ROI', '4 Milwaukee Trail', 'dwitt7x@forbes.com');
INSERT INTO toko VALUES ('Medhurst-Walsh', 'Toko obat obatan murah', 'whiteboard cross-media communities', '501 Esker Drive', 'preddish7y@1und1.de');
INSERT INTO toko VALUES ('Johnston LLC', 'Toko obat obatan murah', 'engage strategic interfaces', '6560 Esch Hill', 'mdivine7z@naver.com');
INSERT INTO toko VALUES ('Runolfsson-O''Hara', 'Toko obat obatan murah', 'transition vertical web services', '7706 Browning Park', 'hcaesar80@sina.com.cn');
INSERT INTO toko VALUES ('Hilll-Stanton', 'Toko obat obatan murah', 'enhance scalable architectures', '704 Manufacturers Hill', 'akiltie81@edublogs.org');
INSERT INTO toko VALUES ('Mraz Inc', 'Toko obat obatan murah', 'synergize value-added communities', '793 Anzinger Avenue', 'dmoller82@geocities.com');
INSERT INTO toko VALUES ('VonRueden-Pacocha and Dibbert', 'Toko obat obatan murah', 'integrate magnetic channels', '835 Linden Road', 'sbendik83@independent.co.uk');
INSERT INTO toko VALUES ('Bailey and Sons', 'Toko obat obatan murah', 'deliver strategic models', '7 Linden Circle', 'pinsull84@de.vu');
INSERT INTO toko VALUES ('Lueilwitz-Bogan and Osinski', 'Toko obat obatan murah', 'engage granular e-business', '111 Stuart Plaza', 'dcollister85@mashable.com');
INSERT INTO toko VALUES ('Dooley-Wisoky', 'Toko obat obatan murah', 'utilize customized systems', '945 Troy Avenue', 'fcutmore86@walmart.com');
INSERT INTO toko VALUES ('Simonis-Grimes and Turcotte', 'Toko obat obatan murah', 'iterate interactive ROI', '35 Logan Point', 'mromanin87@sina.com.cn');
INSERT INTO toko VALUES ('King-Spinka', 'Toko obat obatan murah', 'deploy plug-and-play e-services', '175 Pierstorff Junction', 'mgallico88@zimbio.com');
INSERT INTO toko VALUES ('Carroll-Lubowitz', 'Toko obat obatan murah', 'transition out-of-the-box action-items', '37489 Westend Circle', 'bmccurrie89@intel.com');
INSERT INTO toko VALUES ('Parisian-Maggio and Bins', 'Toko obat obatan murah', 'brand 24/7 experiences', '43 Hazelcrest Lane', 'bcostigan8a@wordpress.org');
INSERT INTO toko VALUES ('Rowe-Dicki and Conroy', 'Toko obat obatan murah', 'innovate innovative content', '31739 Reindahl Way', 'scaccavari8b@mozilla.com');
INSERT INTO toko VALUES ('Pfeffer-Rohan and Fadel', 'Toko murah dan selalu diskon', 'generate interactive communities', '07548 Lighthouse Bay Pass', 'awhicher8c@cisco.com');
INSERT INTO toko VALUES ('Nienow and Sons', 'Toko murah dan selalu diskon', 'transform holistic content', '745 Burrows Point', 'cwaterhowse8d@wired.com');
INSERT INTO toko VALUES ('Ratke LLC', 'Toko murah dan selalu diskon', 'leverage global infrastructures', '43889 Sunbrook Court', 'garckoll8e@pinterest.com');
INSERT INTO toko VALUES ('Yost Group', 'Toko murah dan selalu diskon', 'integrate viral technologies', '71 Alpine Center', 'jmcgeffen8f@123-reg.co.uk');
INSERT INTO toko VALUES ('Kiehn-Steuber', 'Toko murah dan selalu diskon', 'syndicate enterprise niches', '229 Rieder Hill', 'vnewlove8g@yahoo.com');
INSERT INTO toko VALUES ('Kshlerin-Heaney and Mills', 'Toko murah dan selalu diskon', 'iterate e-business portals', '929 Bayside Alley', 'fsyratt8h@cpanel.net');
INSERT INTO toko VALUES ('Bogisich and Sons', 'Toko murah dan selalu diskon', 'e-enable value-added communities', '5312 Coleman Hill', 'vgorham8i@wikipedia.org');
INSERT INTO toko VALUES ('Abshire-Veum and Stiedemann', 'Toko murah dan selalu diskon', 'monetize back-end niches', '44 Forest Place', 'lchopping8j@aboutads.info');
INSERT INTO toko VALUES ('Kris Group', 'Toko murah dan selalu diskon', 'cultivate world-class niches', '12628 Harper Trail', 'fminear8k@barnesandnoble.com');
INSERT INTO toko VALUES ('Konopelski-Lehner and Moore', 'Toko murah dan selalu diskon', 'morph plug-and-play functionalities', '04 Saint Paul Alley', 'amcwhinnie8l@sphinn.com');
INSERT INTO toko VALUES ('Vandervort LLC', 'Toko murah dan selalu diskon', 'optimize ubiquitous architectures', '1312 Brown Plaza', 'ccallendar8m@xing.com');
INSERT INTO toko VALUES ('McGlynn-Aufderhar', 'Toko sayur-sayuran', 'exploit vertical partnerships', '84712 Chinook Way', 'zgellier8n@a8.net');
INSERT INTO toko VALUES ('Williamson-Harber and Russel', 'Toko sayur-sayuran', 'embrace value-added models', '031 Sunfield Trail', 'ctipper8o@unblog.fr');
INSERT INTO toko VALUES ('Raynor Inc', 'Toko sayur-sayuran', 'exploit wireless e-tailers', '43 Fulton Park', 'bseebright8p@parallels.com');
INSERT INTO toko VALUES ('Gleichner Group', 'Toko sayur-sayuran', 'brand proactive interfaces', '5620 Forest Run Park', 'ctrigg8q@sun.com');
INSERT INTO toko VALUES ('Steuber and Sons', 'Toko sayur-sayuran', 'aggregate 24/7 e-markets', '9313 Jay Terrace', 'mobrallaghan8r@ebay.com');
INSERT INTO toko VALUES ('Zulauf-Waelchi', 'Toko sayur-sayuran', 'transition customized e-markets', '17982 Manley Avenue', 'psummerlie8s@edublogs.org');
INSERT INTO toko VALUES ('Ebert-Brekke and Romaguera', 'Toko sayur-sayuran', 'integrate wireless deliverables', '22733 Annamark Terrace', 'dleven8t@nasa.gov');
INSERT INTO toko VALUES ('Zemlak Group', 'Toko sayur-sayuran', 'productize extensible infrastructures', '5 Pine View Trail', 'bstrafen8u@tinyurl.com');
INSERT INTO toko VALUES ('Labadie-Ortiz and Bradtke', 'Toko sayur-sayuran', 'streamline wireless e-commerce', '64200 Washington Circle', 'cgoldston8v@nature.com');
INSERT INTO toko VALUES ('Baumbach-Koepp and Ritchie', 'Toko sayur-sayuran', 'exploit back-end niches', '68405 Burning Wood Trail', 'jdwight8w@wikia.com');
INSERT INTO toko VALUES ('Rath Inc', 'Toko sayur-sayuran', 'generate user-centric infomediaries', '7 Westerfield Court', 'mmotten8x@senate.gov');
INSERT INTO toko VALUES ('Dibbert-Batz and Fahey', 'Toko sayur-sayuran', 'envisioneer intuitive niches', '380 Melrose Crossing', 'mgilleon8y@bing.com');
INSERT INTO toko VALUES ('Jacobson-Kunde', 'Toko sayur-sayuran', 'target interactive relationships', '6769 Barby Park', 'lrutt8z@hostgator.com');
INSERT INTO toko VALUES ('Mertz LLC', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'facilitate virtual deliverables', '1 West Court', 'ghoonahan90@salon.com');
INSERT INTO toko VALUES ('Gorczany-Hilll and Halvorson', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'engage value-added networks', '37566 David Pass', 'hcaistor91@mtv.com');
INSERT INTO toko VALUES ('Kuphal-Bosco and Tremblay', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'target next-generation e-commerce', '018 Sheridan Hill', 'jmustarde92@hp.com');
INSERT INTO toko VALUES ('Kreiger-Leannon and Maggio', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'brand transparent vortals', '885 Sherman Hill', 'qstonestreet93@hatena.ne.jp');
INSERT INTO toko VALUES ('Keeling-Streich', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'deploy customized methodologies', '4 Dunning Circle', 'bcourtois94@ucla.edu');
INSERT INTO toko VALUES ('Emard Inc', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'synthesize magnetic synergies', '9891 Hoepker Crossing', 'cschellig95@google.co.jp');
INSERT INTO toko VALUES ('Hagenes-Lubowitz', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'seize intuitive users', '0 Melby Circle', 'etoor96@ustream.tv');
INSERT INTO toko VALUES ('Greenholt-Willms and Stehr', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'drive user-centric action-items', '134 Birchwood Place', 'pmarmyon97@accuweather.com');
INSERT INTO toko VALUES ('Powlowski and Sons', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'engage customized eyeballs', '67 Toban Parkway', 'jpawlata98@phoca.cz');
INSERT INTO toko VALUES ('Stamm Group', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'cultivate world-class web services', '3436 Declaration Terrace', 'rivanchin99@slideshare.net');
INSERT INTO toko VALUES ('Kreiger-Ward and D''Amore', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'innovate robust technologies', '23996 Lyons Park', 'wmandres9a@gnu.org');
INSERT INTO toko VALUES ('Johns-Ward and Veum', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'reinvent B2C markets', '2644 7th Hill', 'ktonsley9b@nytimes.com');
INSERT INTO toko VALUES ('Crona Inc', 'Toko yang menghadirkan barang barang baru yang sedang tren', 'repurpose best-of-breed deliverables', '6953 Crest Line Point', 'smilbourne9c@comcast.net');
INSERT INTO toko VALUES ('Kreiger-Torp', 'Toko alat olahraga', 'exploit customized action-items', '2 Bay Lane', 'cduddell9d@fotki.com');
INSERT INTO toko VALUES ('Sipes LLC', 'Toko alat olahraga', 'visualize viral vortals', '3 Maryland Point', 'dizaks9e@qq.com');
INSERT INTO toko VALUES ('Lindgren-Cartwright and Emard', 'Toko alat olahraga', 'redefine transparent supply-chains', '27 Sutteridge Place', 'rliversage9f@icio.us');
INSERT INTO toko VALUES ('Homenick-Treutel and Kuhlman', 'Toko alat olahraga', 'matrix global relationships', '662 Mifflin Street', 'cmcgawn9g@wix.com');
INSERT INTO toko VALUES ('Christiansen-Mitchell and Morissette', 'Toko alat olahraga', 'synthesize value-added platforms', '92725 Bunker Hill Way', 'eolland9h@vistaprint.com');
INSERT INTO toko VALUES ('Nader-Pagac and Buckridge', 'Toko alat olahraga', 'envisioneer front-end technologies', '171 Mcbride Way', 'crivard9i@cpanel.net');
INSERT INTO toko VALUES ('Hansen-Mosciski and Swaniawski', 'Toko alat olahraga', 'expedite 24/365 solutions', '1 Buell Alley', 'eamiss9j@jimdo.com');
INSERT INTO toko VALUES ('Braun-Oberbrunner', 'Toko alat olahraga', 'deploy open-source supply-chains', '9 Glendale Crossing', 'ssquibe9k@tamu.edu');
INSERT INTO toko VALUES ('Abernathy-Grady', 'Toko alat olahraga', 'recontextualize scalable convergence', '715 Raven Avenue', 'kbrearton9l@amazon.com');
INSERT INTO toko VALUES ('Lemke-Nienow and Stroman', 'Toko alat olahraga', 'envisioneer strategic relationships', '80242 Service Plaza', 'scornelius9m@freewebs.com');
INSERT INTO toko VALUES ('O''Kon Inc', 'Toko alat olahraga', 'maximize robust models', '261 Heath Plaza', 'broskams9n@hud.gov');
INSERT INTO toko VALUES ('Tromp-Gleason', 'Toko alat olahraga', 'enable bleeding-edge ROI', '694 Mcbride Junction', 'hflewitt9o@unicef.org');
INSERT INTO toko VALUES ('McDermott-Berge', 'Toko alat olahraga', 'embrace bleeding-edge metrics', '34712 Washington Point', 'rcrangle9p@cdc.gov');


--
-- Data for Name: toko_jasa_kirim; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO toko_jasa_kirim VALUES ('Ward Inc', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Kreiger-Deckow and Paucek', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Schulist and Sons', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Grant Inc', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Larson-Bode and Spencer', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Gusikowski LLC', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Mitchell-Carroll and Von', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Gerhold-Brown', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Green-Ondricka and Kutch', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Hickle Group', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Ondricka-Funk and Abernathy', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Leuschke-Pouros and Daugherty', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Gaylord-Haley', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Cruickshank LLC', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Wolf-Metz and Langosh', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Hudson-Johnson', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Schimmel-Nicolas', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Senger-Nikolaus', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Gulgowski-Hartmann', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Kessler-Fisher and Murphy', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Cummings-Pollich and Ankunding', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Bashirian-Ratke and Schmitt', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Kuhn-Wehner', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Wilkinson Inc', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Baumbach-Wiegand and Spencer', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Turner-Kuphal and Dooley', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Hackett-Bogan and Price', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Hansen-Schulist and Corkery', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Koelpin-Denesik', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Torphy-Zboncak and Upton', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Boyle-Funk', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Gerhold Inc', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Heidenreich and Sons', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Schuster Group', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Erdman-Bayer', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Friesen-Brakus', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Medhurst-Walsh', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Johnston LLC', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Runolfsson-O''Hara', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Hilll-Stanton', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Mraz Inc', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('VonRueden-Pacocha and Dibbert', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Bailey and Sons', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Lueilwitz-Bogan and Osinski', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Dooley-Wisoky', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Simonis-Grimes and Turcotte', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('King-Spinka', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Carroll-Lubowitz', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Parisian-Maggio and Bins', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Rowe-Dicki and Conroy', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Pfeffer-Rohan and Fadel', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Nienow and Sons', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Ratke LLC', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Yost Group', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Kiehn-Steuber', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Kshlerin-Heaney and Mills', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Bogisich and Sons', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Abshire-Veum and Stiedemann', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Kris Group', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Konopelski-Lehner and Moore', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Vandervort LLC', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('McGlynn-Aufderhar', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Williamson-Harber and Russel', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Raynor Inc', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Gleichner Group', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Steuber and Sons', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Zulauf-Waelchi', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Ebert-Brekke and Romaguera', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Zemlak Group', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Labadie-Ortiz and Bradtke', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Baumbach-Koepp and Ritchie', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Rath Inc', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Dibbert-Batz and Fahey', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Jacobson-Kunde', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Mertz LLC', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Gorczany-Hilll and Halvorson', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Kuphal-Bosco and Tremblay', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Kreiger-Leannon and Maggio', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Keeling-Streich', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Emard Inc', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Hagenes-Lubowitz', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Greenholt-Willms and Stehr', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Powlowski and Sons', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Stamm Group', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Kreiger-Ward and D''Amore', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Johns-Ward and Veum', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Crona Inc', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Kreiger-Torp', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Sipes LLC', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Lindgren-Cartwright and Emard', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Homenick-Treutel and Kuhlman', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Christiansen-Mitchell and Morissette', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Nader-Pagac and Buckridge', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Hansen-Mosciski and Swaniawski', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Braun-Oberbrunner', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Abernathy-Grady', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Lemke-Nienow and Stroman', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('O''Kon Inc', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Tromp-Gleason', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('McDermott-Berge', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('McDermott-Berge', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Ward Inc', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Kreiger-Deckow and Paucek', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Schulist and Sons', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Grant Inc', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Larson-Bode and Spencer', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Gusikowski LLC', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Mitchell-Carroll and Von', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Gerhold-Brown', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Green-Ondricka and Kutch', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Hickle Group', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Ondricka-Funk and Abernathy', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Leuschke-Pouros and Daugherty', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Gaylord-Haley', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Cruickshank LLC', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Wolf-Metz and Langosh', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Hudson-Johnson', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Schimmel-Nicolas', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Senger-Nikolaus', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Gulgowski-Hartmann', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Kessler-Fisher and Murphy', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Cummings-Pollich and Ankunding', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Bashirian-Ratke and Schmitt', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Kuhn-Wehner', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Wilkinson Inc', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Baumbach-Wiegand and Spencer', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Turner-Kuphal and Dooley', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Hackett-Bogan and Price', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Hansen-Schulist and Corkery', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Koelpin-Denesik', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Torphy-Zboncak and Upton', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Boyle-Funk', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('Gerhold Inc', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Heidenreich and Sons', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Schuster Group', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Erdman-Bayer', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Friesen-Brakus', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Medhurst-Walsh', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Johnston LLC', 'WAHANA');
INSERT INTO toko_jasa_kirim VALUES ('Runolfsson-O''Hara', 'J&T EXPRESS');
INSERT INTO toko_jasa_kirim VALUES ('Hilll-Stanton', 'PAHALA');
INSERT INTO toko_jasa_kirim VALUES ('Mraz Inc', 'LION PARCEL');
INSERT INTO toko_jasa_kirim VALUES ('VonRueden-Pacocha and Dibbert', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Bailey and Sons', 'JNE REGULER');
INSERT INTO toko_jasa_kirim VALUES ('Lueilwitz-Bogan and Osinski', 'JNE YES');
INSERT INTO toko_jasa_kirim VALUES ('Dooley-Wisoky', 'JNE OKE');
INSERT INTO toko_jasa_kirim VALUES ('Simonis-Grimes and Turcotte', 'TIKI REGULER');
INSERT INTO toko_jasa_kirim VALUES ('King-Spinka', 'POS PAKET BIASA');
INSERT INTO toko_jasa_kirim VALUES ('Carroll-Lubowitz', 'POS PAKET KILAT');
INSERT INTO toko_jasa_kirim VALUES ('Parisian-Maggio and Bins', 'WAHANA');


--
-- Data for Name: transaksi_pulsa; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO transaksi_pulsa VALUES ('V000000001', '2016-04-01', '2016-04-01 19:11:00', 2, 12000.00, 'ilerego5p@github.io', 10, '085267354627', 'KLJ00251');
INSERT INTO transaksi_pulsa VALUES ('V000000002', '2017-01-22', '2017-01-22 13:12:00', 2, 22000.00, 'fwadeson6r@discuz.net', 20, '084118147353', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000003', '2017-04-06', '2017-04-06 15:18:00', 1, 102000.00, 'ctipper8o@unblog.fr', 100, '089392809033', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000004', '2017-04-06', '2017-04-06 15:21:00', 1, 22000.00, 'jbraikenridge1i@goo.gl', 20, '082670533544', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000005', '2017-01-14', '2017-01-14 19:24:00', 2, 102000.00, 'jdominici5c@wp.com', 100, '087418753932', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000006', '2017-03-17', '2017-03-17 21:17:00', 2, 22000.00, 'mromeoo@weather.com', 20, '089510371756', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000007', '2017-01-04', '2017-01-04 12:29:00', 2, 82000.00, 'smilbourne9c@comcast.net', 80, '085404976100', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000008', '2017-03-11', '2017-03-11 23:12:00', 2, 22000.00, 'cdoughty3o@i2i.jp', 20, '087604072783', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000009', '2017-02-21', '2017-02-21 22:15:00', 1, 62000.00, 'mramsdell78@paypal.com', 60, '087750663966', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000010', '2017-03-21', '2017-03-21 22:28:00', 2, 42000.00, 'sestcot7f@nbcnews.com', 40, '087930360581', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000011', '2017-01-31', '2017-01-31 18:03:00', 2, 62000.00, 'ghamberston55@foxnews.com', 60, '087451431418', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000012', '2017-02-01', '2017-02-01 12:00:00', 1, 102000.00, 'rjodrelle1c@topsy.com', 100, '085576168433', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000013', '2017-01-12', '2017-01-12 18:58:00', 2, 22000.00, 'dpartlett5f@wikia.com', 20, '088891567388', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000014', '2017-03-23', '2017-03-23 16:04:00', 2, 42000.00, 'mgallico88@zimbio.com', 40, '081800924870', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000015', '2017-02-06', '2017-02-06 19:38:00', 1, 62000.00, 'adeg@facebook.com', 60, '087996311093', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000016', '2017-03-08', '2017-03-08 10:38:00', 1, 82000.00, 'fsyratt8h@cpanel.net', 80, '084086876568', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000017', '2017-04-22', '2017-04-22 16:10:00', 1, 82000.00, 'fsyratt8h@cpanel.net', 80, '084068150725', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000018', '2017-01-25', '2017-01-25 19:19:00', 1, 22000.00, 'vnewlove8g@yahoo.com', 20, '081387510975', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000019', '2017-02-04', '2017-02-04 19:07:00', 2, 42000.00, 'kasprey6t@symantec.com', 40, '081687658109', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000020', '2017-01-18', '2017-01-18 15:07:00', 2, 62000.00, 'ralders58@tripod.com', 60, '086317387836', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000021', '2017-02-21', '2017-02-21 13:52:00', 2, 42000.00, 'mjindrich7o@twitter.com', 40, '088083382701', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000022', '2017-04-04', '2017-04-04 23:06:00', 2, 42000.00, 'cpittford71@photobucket.com', 40, '087951242925', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000023', '2017-01-19', '2017-01-19 10:15:00', 2, 62000.00, 'ppidgen2w@paginegialle.it', 60, '084355206912', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000024', '2017-04-11', '2017-04-11 15:02:00', 2, 22000.00, 'yduffett4o@va.gov', 20, '081672907724', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000025', '2017-01-09', '2017-01-09 13:22:00', 1, 22000.00, 'lstiggles4b@ucoz.com', 20, '086067409473', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000026', '2017-01-25', '2017-01-25 17:24:00', 1, 22000.00, 'llawlings5l@china.com.cn', 20, '085402595716', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000027', '2017-02-05', '2017-02-05 20:17:00', 1, 102000.00, 'ppidgen2w@paginegialle.it', 100, '084104710612', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000028', '2017-03-06', '2017-03-06 23:33:00', 1, 42000.00, 'ctembey2s@nhs.uk', 40, '088649228874', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000029', '2017-01-01', '2017-01-01 13:28:00', 2, 42000.00, 'mtitherington10@amazon.co.jp', 40, '089486702000', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000030', '2017-04-11', '2017-04-11 19:49:00', 1, 82000.00, 'tschimon5@rambler.ru', 80, '083337114642', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000031', '2017-03-19', '2017-03-19 23:37:00', 1, 82000.00, 'mcivitillob@google.ru', 80, '081388881719', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000032', '2017-01-09', '2017-01-09 23:46:00', 2, 102000.00, 'eboddymead39@flavors.me', 100, '081677663070', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000033', '2017-01-01', '2017-01-01 16:57:00', 2, 62000.00, 'preddish7y@1und1.de', 60, '086266617689', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000034', '2017-01-22', '2017-01-22 19:54:00', 2, 42000.00, 'gboschmann1w@themeforest.net', 40, '087249586466', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000035', '2017-03-29', '2017-03-29 17:41:00', 1, 22000.00, 'lgoggen4d@discovery.com', 20, '082102073393', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000036', '2017-04-15', '2017-04-15 14:27:00', 1, 82000.00, 'jluxford3x@statcounter.com', 80, '085574903309', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000037', '2017-04-13', '2017-04-13 16:45:00', 1, 82000.00, 'cmcgarrell6s@dropbox.com', 80, '088361322763', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000038', '2017-01-25', '2017-01-25 15:27:00', 2, 42000.00, 'dcollinson43@usnews.com', 40, '088465357628', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000039', '2017-02-13', '2017-02-13 22:29:00', 2, 42000.00, 'cdoughty3o@i2i.jp', 40, '085421923031', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000040', '2017-02-17', '2017-02-17 12:32:00', 2, 42000.00, 'gwhitworth30@slate.com', 40, '085195870382', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000041', '2017-03-25', '2017-03-25 10:41:00', 2, 22000.00, 'rkinnin4r@odnoklassniki.ru', 20, '088035303574', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000042', '2017-04-01', '2017-04-01 20:38:00', 2, 62000.00, 'dtredinnick6b@163.com', 60, '088119111260', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000043', '2017-04-13', '2017-04-13 19:13:00', 1, 22000.00, 'sgarric27@google.com', 20, '082109799274', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000044', '2017-02-17', '2017-02-17 14:49:00', 2, 102000.00, 'lfeasey6i@godaddy.com', 100, '082195128958', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000045', '2017-01-08', '2017-01-08 10:19:00', 1, 102000.00, 'ekelleni@jugem.jp', 100, '085023978784', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000046', '2017-04-01', '2017-04-01 21:30:00', 1, 82000.00, 'vedgcumbe5h@prweb.com', 80, '085439450869', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000047', '2017-03-02', '2017-03-02 16:12:00', 1, 62000.00, 'akiltie81@edublogs.org', 60, '083219503971', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000048', '2017-03-08', '2017-03-08 19:08:00', 1, 102000.00, 'dcollister85@mashable.com', 100, '085854599149', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000049', '2017-02-17', '2017-02-17 10:30:00', 1, 42000.00, 'mdyball1n@netlog.com', 40, '089457902288', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000050', '2017-03-18', '2017-03-18 14:44:00', 1, 62000.00, 'rdiggins29@storify.com', 60, '084878657065', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000051', '2017-01-01', '2017-01-01 14:03:00', 2, 82000.00, 'tbeecroft48@squarespace.com', 80, '083829405664', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000052', '2017-03-12', '2017-03-12 13:40:00', 2, 102000.00, 'rmachen22@businessinsider.com', 100, '082534149200', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000053', '2017-03-25', '2017-03-25 15:26:00', 1, 62000.00, 'dterrey2x@bloglines.com', 60, '088037420304', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000054', '2017-01-07', '2017-01-07 13:02:00', 2, 62000.00, 'ngagin3r@amazon.co.uk', 60, '082198018211', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000055', '2017-02-21', '2017-02-21 15:53:00', 2, 82000.00, 'cpittford71@photobucket.com', 80, '086336167991', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000056', '2017-04-22', '2017-04-22 10:41:00', 2, 82000.00, 'sbendik83@independent.co.uk', 80, '082517526210', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000057', '2017-02-04', '2017-02-04 21:10:00', 2, 42000.00, 'jbarron2u@4shared.com', 40, '088808874726', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000058', '2017-03-29', '2017-03-29 12:54:00', 2, 102000.00, 'hbatyw@dion.ne.jp', 100, '087301898424', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000059', '2017-03-31', '2017-03-31 16:20:00', 2, 22000.00, 'mtitherington10@amazon.co.jp', 20, '089689810936', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000060', '2017-01-24', '2017-01-24 15:31:00', 1, 22000.00, 'vedgcumbe5h@prweb.com', 20, '084053439076', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000061', '2017-02-11', '2017-02-11 23:01:00', 2, 42000.00, 'sklemke3t@lycos.com', 40, '084834765794', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000062', '2017-03-07', '2017-03-07 22:35:00', 2, 42000.00, 'tbeecroft48@squarespace.com', 40, '088416906118', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000063', '2017-02-05', '2017-02-05 15:34:00', 2, 82000.00, 'smilbourne9c@comcast.net', 80, '085832914288', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000064', '2017-01-28', '2017-01-28 20:11:00', 1, 102000.00, 'mtitherington10@amazon.co.jp', 100, '083213192679', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000065', '2017-01-20', '2017-01-20 21:54:00', 2, 82000.00, 'bstrafen8u@tinyurl.com', 80, '082890588281', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000066', '2017-04-06', '2017-04-06 14:48:00', 2, 102000.00, 'ejochens2g@ihg.com', 100, '085345864248', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000067', '2017-03-31', '2017-03-31 23:14:00', 2, 82000.00, 'flapish4s@indiatimes.com', 80, '089108010567', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000068', '2017-01-19', '2017-01-19 17:18:00', 1, 62000.00, 'ejochens2g@ihg.com', 60, '084984884576', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000069', '2017-01-19', '2017-01-19 18:25:00', 1, 102000.00, 'jdwight8w@wikia.com', 100, '087335298211', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000070', '2017-03-31', '2017-03-31 10:57:00', 2, 62000.00, 'jpawlata98@phoca.cz', 60, '084373021963', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000071', '2017-01-10', '2017-01-10 10:08:00', 2, 82000.00, 'cgoldston8v@nature.com', 80, '087338994769', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000072', '2017-04-14', '2017-04-14 20:32:00', 1, 42000.00, 'ctipper8o@unblog.fr', 40, '082534977621', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000073', '2017-02-06', '2017-02-06 16:47:00', 1, 22000.00, 'dizaks9e@qq.com', 20, '082270256517', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000074', '2017-01-19', '2017-01-19 15:47:00', 1, 82000.00, 'lbrewettc@prnewswire.com', 80, '089346013441', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000075', '2017-04-04', '2017-04-04 22:11:00', 1, 82000.00, 'nbaiden3i@cam.ac.uk', 80, '084187845601', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000076', '2017-04-14', '2017-04-14 20:01:00', 1, 62000.00, 'mromeoo@weather.com', 60, '089532484212', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000077', '2017-03-24', '2017-03-24 17:52:00', 1, 82000.00, 'fwasson54@goo.ne.jp', 80, '085297219066', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000078', '2017-04-17', '2017-04-17 18:42:00', 2, 102000.00, 'pmease26@dell.com', 100, '082579626928', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000079', '2017-01-25', '2017-01-25 21:03:00', 2, 42000.00, 'dterrey2x@bloglines.com', 40, '082508397007', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000080', '2017-04-08', '2017-04-08 20:53:00', 2, 42000.00, 'hbatyw@dion.ne.jp', 40, '086730981646', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000081', '2017-01-31', '2017-01-31 13:38:00', 1, 42000.00, 'otamblyn5b@arstechnica.com', 40, '082680637025', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000082', '2017-03-26', '2017-03-26 22:17:00', 1, 22000.00, 'mhavercroft4j@redcross.org', 20, '084293373235', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000083', '2017-03-13', '2017-03-13 10:08:00', 2, 62000.00, 'ngagin3r@amazon.co.uk', 60, '084484836902', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000084', '2017-01-05', '2017-01-05 16:56:00', 1, 102000.00, 'mgoodsal7l@virginia.edu', 100, '082456046462', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000085', '2017-01-25', '2017-01-25 20:22:00', 1, 42000.00, 'efloodgate1r@stanford.edu', 40, '089637782962', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000086', '2017-02-25', '2017-02-25 21:21:00', 1, 42000.00, 'mwadley1e@fema.gov', 40, '087457785313', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000087', '2017-01-19', '2017-01-19 22:29:00', 2, 62000.00, 'fwasson54@goo.ne.jp', 60, '089003892970', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000088', '2017-03-21', '2017-03-21 15:35:00', 1, 102000.00, 'vianni53@csmonitor.com', 100, '084854340344', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000089', '2017-01-29', '2017-01-29 10:48:00', 1, 22000.00, 'dmcauslene4z@amazon.com', 20, '089171628763', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000090', '2017-01-29', '2017-01-29 12:50:00', 2, 42000.00, 'nhubbucks2q@census.gov', 40, '084410683831', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000091', '2017-03-28', '2017-03-28 23:35:00', 1, 62000.00, 'hcaesar80@sina.com.cn', 60, '089719255220', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000092', '2017-04-10', '2017-04-10 15:45:00', 2, 82000.00, 'ktonsley9b@nytimes.com', 80, '086582043911', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000093', '2017-02-17', '2017-02-17 13:03:00', 1, 22000.00, 'efloodgate1r@stanford.edu', 20, '088450789675', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000094', '2017-03-14', '2017-03-14 23:50:00', 2, 42000.00, 'tdjurkovic5r@livejournal.com', 40, '086990118690', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000095', '2017-02-08', '2017-02-08 13:24:00', 1, 22000.00, 'abury56@tmall.com', 20, '087577997090', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000096', '2017-03-01', '2017-03-01 17:55:00', 1, 42000.00, 'lgoggen4d@discovery.com', 40, '089887003488', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000097', '2017-01-04', '2017-01-04 13:33:00', 2, 22000.00, 'zgellier8n@a8.net', 20, '085749694923', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000098', '2017-02-13', '2017-02-13 21:12:00', 1, 102000.00, 'amcatamney34@toplist.cz', 100, '084630999713', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000099', '2017-01-15', '2017-01-15 11:03:00', 1, 42000.00, 'cschellig95@google.co.jp', 40, '087512156855', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000100', '2017-02-17', '2017-02-17 17:43:00', 2, 102000.00, 'rcullenp@amazon.co.uk', 100, '087840669357', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000101', '2017-02-11', '2017-02-11 15:17:00', 1, 102000.00, 'mcivitillob@google.ru', 100, '085373257956', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000102', '2017-02-07', '2017-02-07 17:30:00', 1, 82000.00, 'gboschmann1w@themeforest.net', 80, '086897600282', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000103', '2017-02-13', '2017-02-13 16:30:00', 1, 42000.00, 'ppearmaina@nps.gov', 40, '088694257500', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000104', '2017-01-04', '2017-01-04 23:16:00', 2, 102000.00, 'ywestrip6h@pen.io', 100, '081365347097', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000105', '2017-03-26', '2017-03-26 15:11:00', 1, 42000.00, 'mferrelli18@vkontakte.ru', 40, '082993063142', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000106', '2017-04-21', '2017-04-21 11:36:00', 1, 42000.00, 'kmohammed42@plala.or.jp', 40, '081925527799', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000107', '2017-01-21', '2017-01-21 17:46:00', 1, 22000.00, 'bstrafen8u@tinyurl.com', 20, '082758497894', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000108', '2017-02-12', '2017-02-12 14:16:00', 1, 82000.00, 'sbendik83@independent.co.uk', 80, '081839481290', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000109', '2017-02-05', '2017-02-05 22:12:00', 2, 62000.00, 'dspuner3w@nature.com', 60, '085040420016', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000110', '2017-02-16', '2017-02-16 10:18:00', 2, 22000.00, 'dmcauslene4z@amazon.com', 20, '082527649457', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000111', '2017-01-03', '2017-01-03 10:18:00', 1, 102000.00, 'enevek@devhub.com', 100, '086850373437', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000112', '2017-04-16', '2017-04-16 13:24:00', 2, 62000.00, 'mpumfretts@berkeley.edu', 60, '087635948277', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000113', '2017-03-17', '2017-03-17 17:41:00', 2, 102000.00, 'agilhool6f@addtoany.com', 100, '086244507952', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000114', '2017-01-31', '2017-01-31 12:30:00', 2, 82000.00, 'rliversage9f@icio.us', 80, '088162481904', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000115', '2017-02-28', '2017-02-28 12:58:00', 1, 102000.00, 'dizaks9e@qq.com', 100, '089626913319', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000116', '2017-02-23', '2017-02-23 22:19:00', 2, 42000.00, 'mhache2j@typepad.com', 40, '082755851238', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000117', '2017-04-25', '2017-04-25 13:42:00', 1, 22000.00, 'dollivierre4l@statcounter.com', 20, '089332108147', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000118', '2017-04-08', '2017-04-08 13:40:00', 2, 42000.00, 'ncaro0@guardian.co.uk', 40, '087067128656', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000119', '2017-03-22', '2017-03-22 17:50:00', 2, 42000.00, 'dpartlett5f@wikia.com', 40, '081608913959', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000120', '2017-03-17', '2017-03-17 20:35:00', 1, 62000.00, 'ccallendar8m@xing.com', 60, '083367319785', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000121', '2017-01-09', '2017-01-09 20:50:00', 2, 102000.00, 'likringillh@wordpress.com', 100, '087918637777', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000122', '2017-02-08', '2017-02-08 16:23:00', 2, 82000.00, 'dizaks9e@qq.com', 80, '083520355727', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000123', '2017-01-04', '2017-01-04 19:57:00', 2, 42000.00, 'dollivierre4l@statcounter.com', 40, '082989962231', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000124', '2017-04-19', '2017-04-19 18:28:00', 2, 22000.00, 'tfulleylove7q@nps.gov', 20, '085925919892', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000125', '2017-03-30', '2017-03-30 10:17:00', 1, 62000.00, 'ozettlerq@washingtonpost.com', 60, '087013955587', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000126', '2017-01-05', '2017-01-05 19:25:00', 2, 42000.00, 'yelger5o@trellian.com', 40, '083598340409', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000127', '2017-01-28', '2017-01-28 15:13:00', 2, 22000.00, 'hsiley4m@msu.edu', 20, '088675634842', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000128', '2017-01-29', '2017-01-29 22:10:00', 2, 22000.00, 'nhubbucks2q@census.gov', 20, '081758971728', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000129', '2017-01-16', '2017-01-16 20:09:00', 1, 22000.00, 'gshilliday69@creativecommons.org', 20, '084475672673', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000130', '2017-02-01', '2017-02-01 16:47:00', 1, 82000.00, 'tcolquete3c@goodreads.com', 80, '081422517471', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000131', '2017-02-19', '2017-02-19 12:06:00', 1, 42000.00, 'jluxford3x@statcounter.com', 40, '085743589826', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000132', '2017-01-26', '2017-01-26 10:30:00', 1, 22000.00, 'rmaybey5m@pbs.org', 20, '082574985948', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000133', '2017-03-30', '2017-03-30 23:05:00', 2, 22000.00, 'dollivierre4l@statcounter.com', 20, '083365592558', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000134', '2017-02-03', '2017-02-03 19:15:00', 2, 22000.00, 'tfulleylove7q@nps.gov', 20, '081415957329', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000135', '2017-04-04', '2017-04-04 12:39:00', 2, 82000.00, 'ozettlerq@washingtonpost.com', 80, '081447307289', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000136', '2017-01-09', '2017-01-09 18:48:00', 1, 42000.00, 'yelger5o@trellian.com', 40, '087916038988', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000137', '2017-01-11', '2017-01-11 22:21:00', 2, 62000.00, 'hsiley4m@msu.edu', 60, '084070158230', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000138', '2017-01-18', '2017-01-18 14:37:00', 2, 62000.00, 'nhubbucks2q@census.gov', 60, '086016271005', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000139', '2017-02-22', '2017-02-22 11:45:00', 1, 82000.00, 'gshilliday69@creativecommons.org', 80, '083894425335', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000140', '2017-04-06', '2017-04-06 19:52:00', 2, 102000.00, 'tcolquete3c@goodreads.com', 100, '082831103542', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000141', '2017-03-04', '2017-03-04 11:16:00', 2, 22000.00, 'jluxford3x@statcounter.com', 20, '084078210873', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000142', '2017-04-10', '2017-04-10 19:49:00', 2, 102000.00, 'rmaybey5m@pbs.org', 100, '086822944891', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000143', '2017-01-24', '2017-01-24 19:10:00', 1, 82000.00, 'sestcot7f@nbcnews.com', 80, '081794352471', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000144', '2017-01-02', '2017-01-02 21:08:00', 2, 42000.00, 'atrickeyv@yale.edu', 40, '084609174596', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000145', '2017-01-26', '2017-01-26 16:43:00', 2, 22000.00, 'sjurczak3j@moonfruit.com', 20, '082124001269', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000146', '2017-02-28', '2017-02-28 21:27:00', 1, 82000.00, 'rcrangle9p@cdc.gov', 80, '083994626226', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000147', '2017-03-13', '2017-03-13 10:54:00', 1, 42000.00, 'mhavercroft4j@redcross.org', 40, '081413139342', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000148', '2017-02-23', '2017-02-23 23:29:00', 1, 22000.00, 'bbilston60@wunderground.com', 20, '083402491802', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000149', '2017-03-23', '2017-03-23 23:02:00', 2, 42000.00, 'doveralln@biglobe.ne.jp', 40, '083191160882', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000150', '2017-04-25', '2017-04-25 22:04:00', 1, 22000.00, 'mpierson4h@goo.gl', 20, '087773061706', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000151', '2017-04-13', '2017-04-13 19:31:00', 2, 42000.00, 'amerrall3g@apple.com', 40, '082864444186', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000152', '2017-02-22', '2017-02-22 12:46:00', 1, 82000.00, 'ghoonahan90@salon.com', 80, '089628836022', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000153', '2017-03-06', '2017-03-06 17:11:00', 2, 82000.00, 'ghooban2l@cisco.com', 80, '081857432565', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000154', '2017-04-18', '2017-04-18 17:55:00', 2, 102000.00, 'jmustarde92@hp.com', 100, '087200467638', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000155', '2017-03-29', '2017-03-29 17:39:00', 2, 62000.00, 'kparidge17@senate.gov', 60, '086784939615', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000156', '2017-02-25', '2017-02-25 19:12:00', 2, 102000.00, 'wgent3n@pcworld.com', 100, '089328837052', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000157', '2017-04-06', '2017-04-06 15:54:00', 1, 102000.00, 'amerrall3g@apple.com', 100, '088702392572', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000158', '2017-01-17', '2017-01-17 14:29:00', 1, 42000.00, 'abramez@squidoo.com', 40, '082039787384', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000159', '2017-03-18', '2017-03-18 10:08:00', 1, 62000.00, 'ilerego5p@github.io', 60, '087074947203', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000160', '2017-04-18', '2017-04-18 10:26:00', 2, 22000.00, 'ralders58@tripod.com', 20, '086413055105', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000161', '2017-04-13', '2017-04-13 23:12:00', 1, 42000.00, 'mhavercroft4j@redcross.org', 40, '082064381416', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000162', '2017-04-02', '2017-04-02 17:01:00', 1, 22000.00, 'enevek@devhub.com', 20, '087218206264', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000163', '2017-02-07', '2017-02-07 16:02:00', 2, 22000.00, 'amcatamney34@toplist.cz', 20, '087424773708', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000164', '2017-01-07', '2017-01-07 14:09:00', 2, 102000.00, 'cdoughty3o@i2i.jp', 100, '085053664104', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000165', '2017-03-03', '2017-03-03 21:49:00', 2, 22000.00, 'cmalzard2f@acquirethisname.com', 20, '083433232590', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000166', '2017-01-19', '2017-01-19 17:23:00', 2, 62000.00, 'aginnaly4i@state.gov', 60, '083021692089', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000167', '2017-03-18', '2017-03-18 21:47:00', 1, 62000.00, 'rkinnin4r@odnoklassniki.ru', 60, '089485325530', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000168', '2017-02-24', '2017-02-24 22:26:00', 2, 42000.00, 'bcourtois94@ucla.edu', 40, '085854953106', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000169', '2017-04-08', '2017-04-08 17:23:00', 1, 42000.00, 'zgellier8n@a8.net', 40, '083520957466', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000170', '2017-02-05', '2017-02-05 22:07:00', 1, 82000.00, 'blampen4v@linkedin.com', 80, '081858120689', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000171', '2017-02-22', '2017-02-22 23:40:00', 2, 102000.00, 'ngaudin5x@furl.net', 100, '089494666821', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000172', '2017-04-10', '2017-04-10 13:51:00', 2, 42000.00, 'sspohr35@symantec.com', 40, '084529583407', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000173', '2017-04-12', '2017-04-12 21:44:00', 2, 62000.00, 'singman1v@example.com', 60, '081563985856', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000174', '2017-02-24', '2017-02-24 22:41:00', 2, 62000.00, 'cjanaud1d@virginia.edu', 60, '083294410561', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000175', '2017-01-16', '2017-01-16 14:32:00', 2, 22000.00, 'tbrettle52@wsj.com', 20, '087244549556', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000176', '2017-02-20', '2017-02-20 23:26:00', 2, 22000.00, 'bstrafen8u@tinyurl.com', 20, '088349746976', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000177', '2017-04-16', '2017-04-16 13:51:00', 1, 42000.00, 'bandryunin7p@cyberchimps.com', 40, '087676268465', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000178', '2017-02-21', '2017-02-21 18:13:00', 1, 102000.00, 'locannan2y@archive.org', 100, '086989424112', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000179', '2017-04-03', '2017-04-03 22:25:00', 1, 82000.00, 'hsiley4m@msu.edu', 80, '089580277941', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000180', '2017-03-13', '2017-03-13 21:43:00', 1, 82000.00, 'ctrigg8q@sun.com', 80, '082661679255', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000181', '2017-04-04', '2017-04-04 11:58:00', 2, 62000.00, 'acumberpatch7w@about.me', 60, '084665612344', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000182', '2017-03-03', '2017-03-03 22:29:00', 1, 82000.00, 'cround3b@kickstarter.com', 80, '082176315047', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000183', '2017-03-08', '2017-03-08 21:24:00', 2, 102000.00, 'aginnaly4i@state.gov', 100, '084152770902', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000184', '2017-02-19', '2017-02-19 23:40:00', 2, 42000.00, 'mgilleon8y@bing.com', 40, '088434367494', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000185', '2017-02-15', '2017-02-15 11:03:00', 1, 62000.00, 'cgoldston8v@nature.com', 60, '085477129232', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000186', '2017-04-14', '2017-04-14 16:14:00', 1, 82000.00, 'rjosselsohn3d@reverbnation.com', 80, '085411900940', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000187', '2017-04-18', '2017-04-18 23:32:00', 1, 22000.00, 'ttourmell2d@dailymail.co.uk', 20, '085972314825', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000188', '2017-01-12', '2017-01-12 15:35:00', 1, 62000.00, 'mferrelli18@vkontakte.ru', 60, '082025525833', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000189', '2017-03-22', '2017-03-22 13:04:00', 2, 42000.00, 'dnottingam2t@marketwatch.com', 40, '085772450409', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000190', '2017-02-16', '2017-02-16 16:23:00', 2, 42000.00, 'mchillingworth7a@themeforest.net', 40, '084064588298', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000191', '2017-03-25', '2017-03-25 15:23:00', 2, 62000.00, 'kmowsley2b@cyberchimps.com', 60, '088008190352', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000192', '2017-04-12', '2017-04-12 14:13:00', 1, 62000.00, 'nwagen8@dailymotion.com', 60, '088023953120', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000193', '2017-04-01', '2017-04-01 20:12:00', 1, 22000.00, 'vgorham8i@wikipedia.org', 20, '085683731588', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000194', '2017-02-20', '2017-02-20 17:30:00', 1, 102000.00, 'kparidge17@senate.gov', 100, '085833663841', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000195', '2017-02-26', '2017-02-26 14:43:00', 2, 62000.00, 'sestcot7f@nbcnews.com', 60, '089109319595', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000196', '2017-03-23', '2017-03-23 11:47:00', 2, 62000.00, 'broskams9n@hud.gov', 60, '087564989774', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000197', '2017-03-31', '2017-03-31 11:14:00', 2, 102000.00, 'nrigmond3l@google.ca', 100, '081979514220', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000198', '2017-02-13', '2017-02-13 10:50:00', 2, 62000.00, 'dspuner3w@nature.com', 60, '087298758389', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000199', '2017-01-18', '2017-01-18 12:18:00', 1, 42000.00, 'cschellig95@google.co.jp', 40, '086165827226', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000200', '2017-01-12', '2017-01-12 20:04:00', 2, 62000.00, 'slattos12@usnews.com', 60, '084262683791', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000201', '2017-02-18', '2017-02-18 18:04:00', 2, 82000.00, 'mde2p@census.gov', 80, '085031002878', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000202', '2017-04-01', '2017-04-01 22:36:00', 2, 62000.00, 'stait9@goo.ne.jp', 60, '089430900500', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000203', '2017-03-05', '2017-03-05 14:43:00', 1, 82000.00, 'hcaistor91@mtv.com', 80, '086021487364', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000204', '2017-03-11', '2017-03-11 21:51:00', 2, 102000.00, 'scornelius9m@freewebs.com', 100, '085434009869', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000205', '2017-04-10', '2017-04-10 16:40:00', 1, 42000.00, 'amcgilvray5i@soup.io', 40, '081662912329', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000206', '2017-02-14', '2017-02-14 12:43:00', 1, 102000.00, 'dwitt7x@forbes.com', 100, '089300306173', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000207', '2017-02-04', '2017-02-04 17:47:00', 2, 62000.00, 'showes4c@opera.com', 60, '088443317731', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000208', '2017-02-10', '2017-02-10 21:04:00', 2, 42000.00, 'apicopp4k@uol.com.br', 40, '088831649333', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000209', '2017-02-06', '2017-02-06 22:59:00', 1, 102000.00, 'aschmidt3u@wikia.com', 100, '087987884844', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000210', '2017-03-08', '2017-03-08 18:31:00', 1, 22000.00, 'cborborough7k@twitter.com', 20, '087969498917', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000211', '2017-03-06', '2017-03-06 23:11:00', 2, 22000.00, 'slattos12@usnews.com', 20, '089247158856', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000212', '2017-03-03', '2017-03-03 18:39:00', 1, 42000.00, 'tlacroutz5n@icio.us', 40, '083330646118', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000213', '2017-02-13', '2017-02-13 14:46:00', 1, 102000.00, 'ktonsley9b@nytimes.com', 100, '084777902511', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000214', '2017-01-08', '2017-01-08 14:32:00', 1, 42000.00, 'qstonestreet93@hatena.ne.jp', 40, '089105227749', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000215', '2017-01-16', '2017-01-16 14:32:00', 2, 62000.00, 'dgrenter1g@booking.com', 60, '086461491486', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000216', '2017-03-08', '2017-03-08 23:21:00', 1, 82000.00, 'iscrogges6y@samsung.com', 80, '088701628769', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000217', '2017-03-25', '2017-03-25 12:18:00', 1, 22000.00, 'croston6c@amazon.de', 20, '087572867050', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000218', '2017-03-24', '2017-03-24 16:42:00', 1, 82000.00, 'jdwight8w@wikia.com', 80, '089203745307', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000219', '2017-01-20', '2017-01-20 10:09:00', 2, 102000.00, 'tdjurkovic5r@livejournal.com', 100, '086284165050', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000220', '2017-04-10', '2017-04-10 18:02:00', 2, 62000.00, 'kmohammed42@plala.or.jp', 60, '089281719379', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000221', '2017-02-08', '2017-02-08 17:29:00', 2, 22000.00, 'ishord7g@bloglines.com', 20, '085458800249', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000222', '2017-03-31', '2017-03-31 10:39:00', 2, 22000.00, 'singman1v@example.com', 20, '088790719529', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000223', '2017-01-15', '2017-01-15 18:44:00', 2, 82000.00, 'troyal49@deliciousdays.com', 80, '088393435711', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000224', '2017-04-13', '2017-04-13 19:07:00', 2, 42000.00, 'dpartlett5f@wikia.com', 40, '089399495649', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000225', '2017-03-21', '2017-03-21 15:17:00', 1, 42000.00, 'mhastewell5k@ask.com', 40, '089961902445', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000226', '2017-01-17', '2017-01-17 21:54:00', 1, 42000.00, 'aluetkemeyers70@miibeian.gov.cn', 40, '088755089135', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000227', '2017-01-31', '2017-01-31 20:14:00', 1, 82000.00, 'acereceres4w@alexa.com', 80, '082483581656', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000228', '2017-04-25', '2017-04-25 11:32:00', 2, 82000.00, 'yduffett4o@va.gov', 80, '085441411498', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000229', '2017-01-19', '2017-01-19 18:20:00', 1, 102000.00, 'fwadeson6r@discuz.net', 100, '087618278238', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000230', '2017-03-09', '2017-03-09 22:07:00', 1, 22000.00, 'sklemke3t@lycos.com', 20, '086874704450', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000231', '2017-03-27', '2017-03-27 13:55:00', 2, 42000.00, 'awalczak1f@mit.edu', 40, '083566797158', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000232', '2017-02-16', '2017-02-16 18:14:00', 1, 22000.00, 'streasure7s@godaddy.com', 20, '087012262529', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000233', '2017-02-06', '2017-02-06 20:38:00', 2, 22000.00, 'kmowsley2b@cyberchimps.com', 20, '084470984450', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000234', '2017-01-05', '2017-01-05 16:25:00', 1, 62000.00, 'mmotten8x@senate.gov', 60, '089950639447', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000235', '2017-04-06', '2017-04-06 21:15:00', 1, 102000.00, 'cjanaud1d@virginia.edu', 100, '088806350042', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000236', '2017-02-08', '2017-02-08 22:56:00', 1, 102000.00, 'rjodrelle1c@topsy.com', 100, '085681914826', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000237', '2017-03-22', '2017-03-22 16:12:00', 2, 82000.00, 'dollivierre4l@statcounter.com', 80, '086092411560', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000238', '2017-04-10', '2017-04-10 19:53:00', 1, 82000.00, 'psummerlie8s@edublogs.org', 80, '088468221236', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000239', '2017-03-27', '2017-03-27 10:57:00', 1, 62000.00, 'pbittlestone5u@auda.org.au', 60, '089291700137', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000240', '2017-01-10', '2017-01-10 13:59:00', 2, 102000.00, 'obernaldez4e@mediafire.com', 100, '087165556294', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000241', '2017-03-03', '2017-03-03 11:25:00', 1, 62000.00, 'sgarric27@google.com', 60, '083923390624', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000242', '2017-04-15', '2017-04-15 20:07:00', 2, 102000.00, 'rspeer63@topsy.com', 100, '082410852315', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000243', '2017-01-12', '2017-01-12 20:24:00', 2, 102000.00, 'htreagust4a@homestead.com', 100, '086999297750', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000244', '2017-03-19', '2017-03-19 21:46:00', 2, 42000.00, 'nstenett1q@buzzfeed.com', 40, '081981074772', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000245', '2017-04-22', '2017-04-22 19:45:00', 2, 22000.00, 'acumberpatch7w@about.me', 20, '086538138857', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000246', '2017-01-23', '2017-01-23 22:09:00', 1, 62000.00, 'aorsd@cbc.ca', 60, '083551043303', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000247', '2017-03-17', '2017-03-17 21:48:00', 1, 82000.00, 'vedgcumbe5h@prweb.com', 80, '089215080471', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000248', '2017-02-10', '2017-02-10 11:32:00', 2, 82000.00, 'apicopp4k@uol.com.br', 80, '081577417586', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000249', '2017-01-09', '2017-01-09 11:55:00', 1, 22000.00, 'lstiggles4b@ucoz.com', 20, '083810488541', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000250', '2017-04-14', '2017-04-14 18:21:00', 2, 62000.00, 'poats37@squidoo.com', 60, '086107502712', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000251', '2017-03-27', '2017-03-27 23:04:00', 2, 102000.00, 'scaccavari8b@mozilla.com', 100, '089055688013', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000252', '2017-03-02', '2017-03-02 21:45:00', 1, 42000.00, 'qstonestreet93@hatena.ne.jp', 40, '087417335894', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000253', '2017-03-16', '2017-03-16 11:01:00', 2, 22000.00, 'dwormanm@imgur.com', 20, '085100553193', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000254', '2017-03-14', '2017-03-14 11:13:00', 2, 22000.00, 'mromanin87@sina.com.cn', 20, '081644120951', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000255', '2017-02-16', '2017-02-16 22:13:00', 2, 62000.00, 'bmccurrie89@intel.com', 60, '082576333291', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000256', '2017-02-01', '2017-02-01 15:07:00', 1, 102000.00, 'hflewitt9o@unicef.org', 100, '088080320665', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000257', '2017-02-14', '2017-02-14 19:40:00', 2, 42000.00, 'atrickeyv@yale.edu', 40, '084889862902', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000258', '2017-03-27', '2017-03-27 13:39:00', 1, 82000.00, 'sbendik83@independent.co.uk', 80, '087728423791', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000259', '2017-03-07', '2017-03-07 16:04:00', 2, 42000.00, 'stait9@goo.ne.jp', 40, '086939063895', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000260', '2017-04-16', '2017-04-16 12:13:00', 1, 42000.00, 'atatters31@marketwatch.com', 40, '086912857211', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000261', '2017-04-12', '2017-04-12 15:30:00', 2, 102000.00, 'bandryunin7p@cyberchimps.com', 100, '086710968978', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000262', '2017-01-09', '2017-01-09 19:23:00', 1, 102000.00, 'dmcauslene4z@amazon.com', 100, '082098156767', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000263', '2017-04-25', '2017-04-25 16:15:00', 2, 42000.00, 'dnottingam2t@marketwatch.com', 40, '088726149097', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000264', '2017-01-04', '2017-01-04 14:51:00', 2, 62000.00, 'vianni53@csmonitor.com', 60, '088458880289', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000265', '2017-03-20', '2017-03-20 11:06:00', 1, 82000.00, 'eamiss9j@jimdo.com', 80, '086993449903', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000266', '2017-01-22', '2017-01-22 20:03:00', 1, 82000.00, 'sdornanx@epa.gov', 80, '086794223920', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000267', '2017-01-03', '2017-01-03 19:25:00', 2, 102000.00, 'gmossman1m@de.vu', 100, '086777390752', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000268', '2017-04-01', '2017-04-01 14:38:00', 2, 82000.00, 'ywestrip6h@pen.io', 80, '085957910212', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000269', '2017-02-20', '2017-02-20 12:58:00', 2, 22000.00, 'mromanin87@sina.com.cn', 20, '086319032914', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000270', '2017-02-22', '2017-02-22 21:05:00', 1, 22000.00, 'flapish4s@indiatimes.com', 20, '088102364219', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000271', '2017-03-13', '2017-03-13 17:55:00', 2, 82000.00, 'rjozaitis4g@icio.us', 80, '083178438422', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000272', '2017-04-04', '2017-04-04 19:40:00', 1, 42000.00, 'swoolgar7j@thetimes.co.uk', 40, '083640541583', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000273', '2017-01-07', '2017-01-07 20:36:00', 2, 42000.00, 'mtitherington10@amazon.co.jp', 40, '082716701931', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000274', '2017-01-19', '2017-01-19 12:58:00', 1, 82000.00, 'ghamberston55@foxnews.com', 80, '089433877816', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000275', '2017-02-27', '2017-02-27 23:42:00', 1, 62000.00, 'sbendik83@independent.co.uk', 60, '086532234565', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000276', '2017-03-05', '2017-03-05 18:29:00', 2, 22000.00, 'hflewitt9o@unicef.org', 20, '086293818238', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000277', '2017-04-10', '2017-04-10 23:14:00', 2, 42000.00, 'dsketcher7d@ehow.com', 40, '084259389195', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000278', '2017-02-25', '2017-02-25 23:41:00', 2, 42000.00, 'dde74@fc2.com', 40, '085628449538', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000279', '2017-04-19', '2017-04-19 22:15:00', 1, 62000.00, 'aoldam7n@google.fr', 60, '083179021927', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000280', '2017-01-05', '2017-01-05 19:28:00', 1, 102000.00, 'sdornanx@epa.gov', 100, '088756413584', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000281', '2017-03-06', '2017-03-06 22:25:00', 2, 62000.00, 'mgallico88@zimbio.com', 60, '082659519706', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000282', '2017-01-22', '2017-01-22 15:21:00', 1, 42000.00, 'ozettlerq@washingtonpost.com', 40, '083497355491', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000283', '2017-03-07', '2017-03-07 16:44:00', 2, 82000.00, 'tdjurkovic5r@livejournal.com', 80, '086142192308', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000284', '2017-04-15', '2017-04-15 16:55:00', 1, 42000.00, 'akiltie81@edublogs.org', 40, '082962754292', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000285', '2017-03-26', '2017-03-26 10:27:00', 1, 42000.00, 'tmerill45@google.com.br', 40, '089570700639', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000286', '2017-03-29', '2017-03-29 20:16:00', 2, 22000.00, 'iolahy6a@yellowpages.com', 20, '082975470271', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000287', '2017-02-24', '2017-02-24 12:18:00', 2, 22000.00, 'msimione1p@sitemeter.com', 20, '081566691636', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000288', '2017-02-18', '2017-02-18 23:21:00', 1, 82000.00, 'gkidwell3k@kickstarter.com', 80, '084727826306', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000289', '2017-01-30', '2017-01-30 17:33:00', 1, 62000.00, 'broskams9n@hud.gov', 60, '083586293127', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000290', '2017-01-15', '2017-01-15 13:42:00', 2, 102000.00, 'acumberpatch7w@about.me', 100, '086407309197', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000291', '2017-01-10', '2017-01-10 13:52:00', 2, 82000.00, 'cmalzard2f@acquirethisname.com', 80, '081345801391', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000292', '2017-02-06', '2017-02-06 20:38:00', 1, 22000.00, 'opetigrew6p@devhub.com', 20, '086878467496', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000293', '2017-03-19', '2017-03-19 16:38:00', 1, 102000.00, 'scaccavari8b@mozilla.com', 100, '083202220661', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000294', '2017-04-05', '2017-04-05 13:32:00', 2, 102000.00, 'llawlings5l@china.com.cn', 100, '087396443168', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000295', '2017-04-20', '2017-04-20 22:55:00', 2, 22000.00, 'rdiggins29@storify.com', 20, '087118916551', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000296', '2017-02-25', '2017-02-25 23:01:00', 1, 42000.00, 'pcuttles1@nydailynews.com', 40, '084457036014', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000297', '2017-03-02', '2017-03-02 15:31:00', 2, 82000.00, 'mromeoo@weather.com', 80, '082616725536', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000298', '2017-04-04', '2017-04-04 14:35:00', 1, 42000.00, 'troyal49@deliciousdays.com', 40, '088207970804', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000299', '2017-01-07', '2017-01-07 21:45:00', 1, 22000.00, 'cdocherty2e@gravatar.com', 20, '086260237395', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000300', '2017-04-15', '2017-04-15 16:56:00', 2, 22000.00, 'bisard23@irs.gov', 20, '089554977103', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000301', '2017-04-15', '2017-04-15 20:42:00', 1, 102000.00, 'awalczak1f@mit.edu', 100, '086110299178', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000302', '2017-03-10', '2017-03-10 17:47:00', 2, 42000.00, 'nfilipychev3m@washington.edu', 40, '089624762825', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000303', '2017-02-27', '2017-02-27 21:26:00', 2, 22000.00, 'streasure7s@godaddy.com', 20, '082944284632', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000304', '2017-03-14', '2017-03-14 18:34:00', 1, 82000.00, 'dterrey2x@bloglines.com', 80, '081833756965', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000305', '2017-02-17', '2017-02-17 19:06:00', 2, 102000.00, 'rcrangle9p@cdc.gov', 100, '083626616893', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000306', '2017-03-03', '2017-03-03 10:30:00', 1, 42000.00, 'tbrettle52@wsj.com', 40, '087260814283', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000307', '2017-01-12', '2017-01-12 19:38:00', 2, 22000.00, 'locannan2y@archive.org', 20, '081864058843', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000308', '2017-03-09', '2017-03-09 16:07:00', 2, 102000.00, 'bisard23@irs.gov', 100, '084151100924', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000309', '2017-02-11', '2017-02-11 10:21:00', 2, 22000.00, 'ghoonahan90@salon.com', 20, '085391150194', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000310', '2017-03-10', '2017-03-10 23:16:00', 1, 22000.00, 'lfairleigh4u@nymag.com', 20, '083765889779', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000311', '2017-03-09', '2017-03-09 13:44:00', 1, 22000.00, 'kskerm72@list-manage.com', 20, '086295659960', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000312', '2017-03-28', '2017-03-28 10:26:00', 2, 22000.00, 'locannan2y@archive.org', 20, '085320916236', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000313', '2017-02-15', '2017-02-15 17:06:00', 2, 22000.00, 'lbrewettc@prnewswire.com', 20, '087289177447', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000314', '2017-02-22', '2017-02-22 17:20:00', 2, 22000.00, 'pmarmyon97@accuweather.com', 20, '087519020392', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000315', '2017-02-08', '2017-02-08 21:52:00', 2, 22000.00, 'fsyratt8h@cpanel.net', 20, '084983163366', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000316', '2017-02-11', '2017-02-11 20:22:00', 1, 22000.00, 'gkidwell3k@kickstarter.com', 20, '081717547194', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000317', '2017-02-03', '2017-02-03 14:14:00', 1, 22000.00, 'gboschmann1w@themeforest.net', 20, '089042332399', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000318', '2017-02-22', '2017-02-22 10:05:00', 1, 22000.00, 'psummerlie8s@edublogs.org', 20, '085716354429', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000319', '2017-04-25', '2017-04-25 14:45:00', 1, 102000.00, 'iolahy6a@yellowpages.com', 100, '085361775348', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000320', '2017-03-01', '2017-03-01 10:15:00', 2, 82000.00, 'tdjurkovic5r@livejournal.com', 80, '082782398683', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000321', '2017-02-08', '2017-02-08 18:11:00', 1, 62000.00, 'omasham1z@meetup.com', 60, '081948826520', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000322', '2017-03-21', '2017-03-21 16:43:00', 2, 42000.00, 'amcatamney34@toplist.cz', 40, '085806086062', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000323', '2017-03-31', '2017-03-31 13:26:00', 2, 82000.00, 'jbarron2u@4shared.com', 80, '081825709347', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000324', '2017-03-02', '2017-03-02 18:29:00', 1, 42000.00, 'bde64@smugmug.com', 40, '087869963914', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000325', '2017-01-31', '2017-01-31 11:58:00', 1, 102000.00, 'srainsdon2n@bluehost.com', 100, '088034063059', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000326', '2017-03-18', '2017-03-18 21:50:00', 1, 82000.00, 'acappel5t@hubpages.com', 80, '085075141798', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000327', '2017-04-05', '2017-04-05 19:24:00', 2, 102000.00, 'jdominici5c@wp.com', 100, '082820457515', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000328', '2017-01-03', '2017-01-03 15:43:00', 2, 102000.00, 'abramez@squidoo.com', 100, '084785282542', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000329', '2017-03-31', '2017-03-31 21:52:00', 2, 102000.00, 'bfardon1a@tripod.com', 100, '087157557279', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000330', '2017-01-06', '2017-01-06 20:07:00', 1, 82000.00, 'agasgarth44@is.gd', 80, '088786426434', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000331', '2017-01-12', '2017-01-12 23:14:00', 2, 22000.00, 'afehelyu@delicious.com', 20, '089203125366', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000332', '2017-04-12', '2017-04-12 23:13:00', 1, 82000.00, 'ywestrip6h@pen.io', 80, '088698444758', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000333', '2017-02-13', '2017-02-13 15:25:00', 2, 22000.00, 'efloodgate1r@stanford.edu', 20, '086233173377', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000334', '2017-04-10', '2017-04-10 12:51:00', 2, 22000.00, 'streasure7s@godaddy.com', 20, '082509246947', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000335', '2017-02-13', '2017-02-13 10:39:00', 2, 42000.00, 'ilerego5p@github.io', 40, '086103007770', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000336', '2017-02-23', '2017-02-23 13:57:00', 1, 42000.00, 'dsketcher7d@ehow.com', 40, '087423354861', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000337', '2017-01-18', '2017-01-18 15:29:00', 1, 42000.00, 'rjosipovitzl@dot.gov', 40, '086683987041', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000338', '2017-02-23', '2017-02-23 20:38:00', 1, 22000.00, 'tmerill45@google.com.br', 20, '087217161598', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000339', '2017-03-19', '2017-03-19 14:20:00', 1, 42000.00, 'lnolte1u@webs.com', 40, '088153424627', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000340', '2017-02-07', '2017-02-07 10:20:00', 2, 22000.00, 'bde64@smugmug.com', 20, '085978534134', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000341', '2017-04-04', '2017-04-04 23:38:00', 2, 42000.00, 'mdivine7z@naver.com', 40, '083474569904', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000342', '2017-01-26', '2017-01-26 19:56:00', 1, 22000.00, 'dwitt7x@forbes.com', 20, '088508263509', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000343', '2017-04-22', '2017-04-22 16:30:00', 2, 42000.00, 'pgiovannini67@google.com.br', 40, '089035065848', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000344', '2017-01-08', '2017-01-08 13:30:00', 1, 102000.00, 'agasgarth44@is.gd', 100, '082737806009', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000345', '2017-02-16', '2017-02-16 11:02:00', 1, 62000.00, 'afehelyu@delicious.com', 60, '083191692219', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000346', '2017-03-18', '2017-03-18 13:03:00', 2, 22000.00, 'ywestrip6h@pen.io', 20, '088503383409', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000347', '2017-04-24', '2017-04-24 16:32:00', 2, 42000.00, 'efloodgate1r@stanford.edu', 40, '082850125258', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000348', '2017-03-23', '2017-03-23 19:13:00', 1, 62000.00, 'streasure7s@godaddy.com', 60, '082954706293', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000349', '2017-04-11', '2017-04-11 10:57:00', 1, 102000.00, 'ilerego5p@github.io', 100, '086692722070', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000350', '2017-02-18', '2017-02-18 17:04:00', 1, 62000.00, 'dsketcher7d@ehow.com', 60, '083578701213', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000351', '2017-01-06', '2017-01-06 16:20:00', 2, 62000.00, 'rjosipovitzl@dot.gov', 60, '083108690599', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000352', '2017-03-05', '2017-03-05 11:10:00', 2, 22000.00, 'tmerill45@google.com.br', 20, '081428636901', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000353', '2017-02-07', '2017-02-07 14:03:00', 2, 62000.00, 'lnolte1u@webs.com', 60, '088347793683', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000354', '2017-02-06', '2017-02-06 16:26:00', 1, 42000.00, 'bde64@smugmug.com', 40, '088263278968', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000355', '2017-02-20', '2017-02-20 13:20:00', 1, 102000.00, 'mdivine7z@naver.com', 100, '087532375099', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000356', '2017-01-11', '2017-01-11 14:23:00', 1, 22000.00, 'dwitt7x@forbes.com', 20, '089688907886', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000357', '2017-04-21', '2017-04-21 23:12:00', 2, 62000.00, 'pgiovannini67@google.com.br', 60, '089340902492', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000358', '2017-03-11', '2017-03-11 21:57:00', 1, 102000.00, 'mdyball1n@netlog.com', 100, '086413363927', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000359', '2017-02-13', '2017-02-13 15:26:00', 2, 82000.00, 'dmcauslene4z@amazon.com', 80, '086886397218', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000360', '2017-04-25', '2017-04-25 17:54:00', 2, 102000.00, 'etomsa47@unc.edu', 100, '088932678703', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000361', '2017-01-09', '2017-01-09 13:46:00', 1, 42000.00, 'tschimon5@rambler.ru', 40, '088727474620', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000362', '2017-01-17', '2017-01-17 17:02:00', 2, 22000.00, 'agasgarth44@is.gd', 20, '088608408713', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000363', '2017-01-19', '2017-01-19 20:13:00', 2, 62000.00, 'afehelyu@delicious.com', 60, '089350173041', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000364', '2017-01-02', '2017-01-02 15:55:00', 2, 62000.00, 'ywestrip6h@pen.io', 60, '083421855050', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000365', '2017-03-27', '2017-03-27 11:58:00', 1, 102000.00, 'efloodgate1r@stanford.edu', 100, '084568671967', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000366', '2017-04-18', '2017-04-18 17:21:00', 2, 102000.00, 'streasure7s@godaddy.com', 100, '085482950609', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000367', '2017-01-11', '2017-01-11 10:43:00', 1, 22000.00, 'ilerego5p@github.io', 20, '089924348519', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000368', '2017-04-03', '2017-04-03 13:05:00', 1, 102000.00, 'dsketcher7d@ehow.com', 100, '088091277047', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000369', '2017-04-20', '2017-04-20 14:05:00', 1, 102000.00, 'rjosipovitzl@dot.gov', 100, '086834785865', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000370', '2017-02-09', '2017-02-09 21:49:00', 1, 82000.00, 'tmerill45@google.com.br', 80, '087179670598', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000371', '2017-04-11', '2017-04-11 12:26:00', 1, 62000.00, 'lnolte1u@webs.com', 60, '085521272381', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000372', '2017-02-07', '2017-02-07 10:14:00', 2, 82000.00, 'bde64@smugmug.com', 80, '089895962901', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000373', '2017-04-13', '2017-04-13 22:25:00', 1, 22000.00, 'mdivine7z@naver.com', 20, '083438426027', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000374', '2017-02-10', '2017-02-10 16:05:00', 2, 42000.00, 'dwitt7x@forbes.com', 40, '089655741349', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000375', '2017-02-07', '2017-02-07 14:00:00', 2, 62000.00, 'pgiovannini67@google.com.br', 60, '085227446374', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000376', '2017-04-03', '2017-04-03 22:14:00', 1, 102000.00, 'mdyball1n@netlog.com', 100, '086382919013', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000377', '2017-02-14', '2017-02-14 14:53:00', 1, 22000.00, 'dmcauslene4z@amazon.com', 20, '089694201925', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000378', '2017-04-08', '2017-04-08 22:06:00', 1, 22000.00, 'etomsa47@unc.edu', 20, '082287145574', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000379', '2017-02-06', '2017-02-06 20:43:00', 1, 22000.00, 'tschimon5@rambler.ru', 20, '082478387216', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000380', '2017-01-14', '2017-01-14 17:30:00', 2, 62000.00, 'aginnaly4i@state.gov', 60, '086951457480', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000381', '2017-04-04', '2017-04-04 19:14:00', 1, 42000.00, 'rkinnin4r@odnoklassniki.ru', 40, '089649216956', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000382', '2017-04-11', '2017-04-11 13:27:00', 1, 102000.00, 'bcourtois94@ucla.edu', 100, '084177548823', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000383', '2017-04-06', '2017-04-06 16:48:00', 1, 62000.00, 'zgellier8n@a8.net', 60, '082007013082', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000384', '2017-01-25', '2017-01-25 17:10:00', 1, 82000.00, 'blampen4v@linkedin.com', 80, '089153210017', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000385', '2017-04-06', '2017-04-06 20:58:00', 1, 82000.00, 'ngaudin5x@furl.net', 80, '088067524866', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000386', '2017-03-07', '2017-03-07 18:34:00', 1, 102000.00, 'sspohr35@symantec.com', 100, '085904761780', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000387', '2017-02-13', '2017-02-13 19:20:00', 1, 42000.00, 'singman1v@example.com', 40, '083792141422', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000388', '2017-03-19', '2017-03-19 14:00:00', 2, 22000.00, 'cjanaud1d@virginia.edu', 20, '082092358616', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000389', '2017-01-14', '2017-01-14 17:57:00', 1, 22000.00, 'tbrettle52@wsj.com', 20, '088459185768', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000390', '2017-02-06', '2017-02-06 10:31:00', 2, 62000.00, 'bstrafen8u@tinyurl.com', 60, '088844550245', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000391', '2017-01-02', '2017-01-02 19:40:00', 1, 62000.00, 'bandryunin7p@cyberchimps.com', 60, '083042298358', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000392', '2017-02-27', '2017-02-27 17:47:00', 2, 42000.00, 'locannan2y@archive.org', 40, '082631260873', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000393', '2017-02-28', '2017-02-28 14:47:00', 2, 62000.00, 'hsiley4m@msu.edu', 60, '085958210897', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000394', '2017-04-12', '2017-04-12 18:35:00', 1, 22000.00, 'ctrigg8q@sun.com', 20, '084948255073', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000395', '2017-03-30', '2017-03-30 14:25:00', 2, 82000.00, 'acumberpatch7w@about.me', 80, '087647089778', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000396', '2017-04-25', '2017-04-25 23:45:00', 1, 102000.00, 'cround3b@kickstarter.com', 100, '088881129342', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000397', '2017-03-10', '2017-03-10 20:05:00', 2, 62000.00, 'aginnaly4i@state.gov', 60, '089345129508', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000398', '2017-04-14', '2017-04-14 19:10:00', 1, 22000.00, 'mgilleon8y@bing.com', 20, '086765993766', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000399', '2017-01-24', '2017-01-24 16:46:00', 1, 102000.00, 'cgoldston8v@nature.com', 100, '085687903435', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000400', '2017-02-17', '2017-02-17 20:10:00', 1, 62000.00, 'rjosselsohn3d@reverbnation.com', 60, '083868582115', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000401', '2017-02-24', '2017-02-24 19:08:00', 1, 82000.00, 'ttourmell2d@dailymail.co.uk', 80, '084176251551', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000402', '2017-04-16', '2017-04-16 13:46:00', 2, 82000.00, 'mferrelli18@vkontakte.ru', 80, '082093063843', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000403', '2017-03-30', '2017-03-30 10:57:00', 1, 102000.00, 'dnottingam2t@marketwatch.com', 100, '089945639728', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000404', '2017-03-22', '2017-03-22 16:10:00', 1, 82000.00, 'mchillingworth7a@themeforest.net', 80, '082017223357', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000405', '2017-01-22', '2017-01-22 23:41:00', 1, 22000.00, 'kmowsley2b@cyberchimps.com', 20, '085611423482', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000406', '2017-01-16', '2017-01-16 14:55:00', 1, 42000.00, 'nwagen8@dailymotion.com', 40, '086090483346', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000407', '2017-01-17', '2017-01-17 21:43:00', 2, 102000.00, 'vgorham8i@wikipedia.org', 100, '083916364003', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000408', '2017-02-11', '2017-02-11 17:23:00', 2, 62000.00, 'kparidge17@senate.gov', 60, '085819950168', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000409', '2017-04-09', '2017-04-09 18:19:00', 1, 42000.00, 'sestcot7f@nbcnews.com', 40, '083520893460', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000410', '2017-04-01', '2017-04-01 14:45:00', 2, 42000.00, 'broskams9n@hud.gov', 40, '081794674908', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000411', '2017-03-11', '2017-03-11 19:04:00', 2, 82000.00, 'nrigmond3l@google.ca', 80, '085504031745', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000412', '2017-02-04', '2017-02-04 23:11:00', 2, 42000.00, 'dspuner3w@nature.com', 40, '081349736329', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000413', '2017-01-23', '2017-01-23 10:38:00', 2, 22000.00, 'cschellig95@google.co.jp', 20, '082165751581', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000414', '2017-01-24', '2017-01-24 19:10:00', 2, 42000.00, 'slattos12@usnews.com', 40, '082023510048', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000415', '2017-03-27', '2017-03-27 13:08:00', 1, 42000.00, 'mde2p@census.gov', 40, '085256563749', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000416', '2017-02-14', '2017-02-14 10:04:00', 2, 22000.00, 'stait9@goo.ne.jp', 20, '084659564003', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000417', '2017-02-05', '2017-02-05 17:24:00', 2, 62000.00, 'hcaistor91@mtv.com', 60, '085295943906', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000418', '2017-01-04', '2017-01-04 15:31:00', 2, 42000.00, 'scornelius9m@freewebs.com', 40, '084901351973', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000419', '2017-04-09', '2017-04-09 22:23:00', 1, 102000.00, 'amcgilvray5i@soup.io', 100, '083571835724', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000420', '2017-04-22', '2017-04-22 10:03:00', 2, 82000.00, 'dwitt7x@forbes.com', 80, '086847849384', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000421', '2017-02-23', '2017-02-23 11:22:00', 1, 82000.00, 'showes4c@opera.com', 80, '083219533695', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000422', '2017-03-13', '2017-03-13 12:06:00', 2, 82000.00, 'apicopp4k@uol.com.br', 80, '084461926876', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000423', '2017-01-25', '2017-01-25 22:13:00', 1, 22000.00, 'aschmidt3u@wikia.com', 20, '088149518297', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000424', '2017-01-31', '2017-01-31 13:30:00', 2, 62000.00, 'cborborough7k@twitter.com', 60, '082251426805', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000425', '2017-04-02', '2017-04-02 18:39:00', 1, 42000.00, 'slattos12@usnews.com', 40, '088030207118', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000426', '2017-01-02', '2017-01-02 20:45:00', 1, 42000.00, 'tlacroutz5n@icio.us', 40, '081591719035', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000427', '2017-02-03', '2017-02-03 13:11:00', 1, 82000.00, 'ktonsley9b@nytimes.com', 80, '089372535423', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000428', '2017-02-23', '2017-02-23 15:51:00', 2, 42000.00, 'qstonestreet93@hatena.ne.jp', 40, '089856735151', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000429', '2017-01-03', '2017-01-03 10:45:00', 2, 62000.00, 'dgrenter1g@booking.com', 60, '089293582585', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000430', '2017-03-02', '2017-03-02 17:12:00', 1, 62000.00, 'iscrogges6y@samsung.com', 60, '089821481028', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000431', '2017-04-24', '2017-04-24 20:04:00', 1, 42000.00, 'croston6c@amazon.de', 40, '087663175640', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000432', '2017-03-07', '2017-03-07 19:26:00', 1, 102000.00, 'jdwight8w@wikia.com', 100, '082662901985', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000433', '2017-01-21', '2017-01-21 15:40:00', 1, 82000.00, 'tdjurkovic5r@livejournal.com', 80, '083412705240', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000434', '2017-03-07', '2017-03-07 16:37:00', 2, 42000.00, 'kmohammed42@plala.or.jp', 40, '081340384596', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000435', '2017-03-29', '2017-03-29 16:25:00', 2, 42000.00, 'ishord7g@bloglines.com', 40, '086690335534', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000436', '2017-01-30', '2017-01-30 14:38:00', 1, 82000.00, 'singman1v@example.com', 80, '083867573062', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000437', '2017-03-27', '2017-03-27 12:05:00', 2, 42000.00, 'troyal49@deliciousdays.com', 40, '089895716601', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000438', '2017-03-22', '2017-03-22 11:21:00', 2, 42000.00, 'dpartlett5f@wikia.com', 40, '088752319074', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000439', '2017-02-04', '2017-02-04 13:04:00', 2, 62000.00, 'mhastewell5k@ask.com', 60, '081675425841', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000440', '2017-01-31', '2017-01-31 17:22:00', 1, 102000.00, 'aluetkemeyers70@miibeian.gov.cn', 100, '089533498262', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000441', '2017-02-16', '2017-02-16 17:03:00', 2, 42000.00, 'acereceres4w@alexa.com', 40, '088361383072', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000442', '2017-01-01', '2017-01-01 19:19:00', 2, 82000.00, 'yduffett4o@va.gov', 80, '088531443304', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000443', '2017-03-09', '2017-03-09 14:20:00', 2, 102000.00, 'fwadeson6r@discuz.net', 100, '083486943798', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000444', '2017-03-05', '2017-03-05 13:12:00', 1, 102000.00, 'sklemke3t@lycos.com', 100, '081614467102', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000445', '2017-03-11', '2017-03-11 22:22:00', 2, 62000.00, 'awalczak1f@mit.edu', 60, '089144684113', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000446', '2017-04-08', '2017-04-08 19:55:00', 2, 62000.00, 'streasure7s@godaddy.com', 60, '083678680142', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000447', '2017-01-12', '2017-01-12 22:26:00', 1, 82000.00, 'kmowsley2b@cyberchimps.com', 80, '083688600642', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000448', '2017-04-03', '2017-04-03 16:06:00', 1, 22000.00, 'mmotten8x@senate.gov', 20, '084197093696', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000449', '2017-03-28', '2017-03-28 13:40:00', 1, 62000.00, 'cjanaud1d@virginia.edu', 60, '086183126957', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000450', '2017-03-30', '2017-03-30 14:52:00', 2, 42000.00, 'rjodrelle1c@topsy.com', 40, '089703652041', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000451', '2017-03-02', '2017-03-02 19:59:00', 1, 82000.00, 'dollivierre4l@statcounter.com', 80, '083354835073', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000452', '2017-04-09', '2017-04-09 12:07:00', 2, 22000.00, 'psummerlie8s@edublogs.org', 20, '081430741760', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000453', '2017-01-10', '2017-01-10 16:48:00', 2, 82000.00, 'pbittlestone5u@auda.org.au', 80, '082754544565', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000454', '2017-04-05', '2017-04-05 15:52:00', 1, 82000.00, 'obernaldez4e@mediafire.com', 80, '081980627401', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000455', '2017-01-09', '2017-01-09 21:08:00', 2, 42000.00, 'sgarric27@google.com', 40, '086747561812', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000456', '2017-02-28', '2017-02-28 18:35:00', 1, 102000.00, 'rspeer63@topsy.com', 100, '087049900457', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000457', '2017-01-31', '2017-01-31 19:15:00', 1, 42000.00, 'htreagust4a@homestead.com', 40, '082451143184', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000458', '2017-03-09', '2017-03-09 11:20:00', 1, 42000.00, 'nstenett1q@buzzfeed.com', 40, '088761843744', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000459', '2017-01-13', '2017-01-13 22:19:00', 2, 22000.00, 'bde64@smugmug.com', 20, '083829188129', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000460', '2017-02-12', '2017-02-12 16:44:00', 2, 22000.00, 'srainsdon2n@bluehost.com', 20, '083535599606', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000461', '2017-03-18', '2017-03-18 22:38:00', 2, 22000.00, 'acappel5t@hubpages.com', 20, '084378591766', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000462', '2017-01-26', '2017-01-26 20:02:00', 2, 82000.00, 'jdominici5c@wp.com', 80, '084235784900', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000463', '2017-02-13', '2017-02-13 14:31:00', 2, 62000.00, 'abramez@squidoo.com', 60, '088727286932', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000464', '2017-02-16', '2017-02-16 10:59:00', 1, 42000.00, 'bfardon1a@tripod.com', 40, '084200304763', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000465', '2017-04-21', '2017-04-21 17:49:00', 1, 82000.00, 'agasgarth44@is.gd', 80, '088500712737', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000466', '2017-03-05', '2017-03-05 14:39:00', 2, 102000.00, 'afehelyu@delicious.com', 100, '087707679072', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000467', '2017-01-26', '2017-01-26 13:19:00', 2, 62000.00, 'ywestrip6h@pen.io', 60, '084912969453', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000468', '2017-01-17', '2017-01-17 23:30:00', 2, 22000.00, 'efloodgate1r@stanford.edu', 20, '088663857392', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000469', '2017-04-14', '2017-04-14 16:21:00', 2, 22000.00, 'streasure7s@godaddy.com', 20, '089550194951', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000470', '2017-02-28', '2017-02-28 22:53:00', 1, 62000.00, 'ilerego5p@github.io', 60, '081846049552', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000471', '2017-01-08', '2017-01-08 14:49:00', 2, 102000.00, 'dsketcher7d@ehow.com', 100, '082385061617', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000472', '2017-02-26', '2017-02-26 22:39:00', 2, 62000.00, 'rjosipovitzl@dot.gov', 60, '081774001387', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000473', '2017-03-31', '2017-03-31 17:00:00', 1, 62000.00, 'tmerill45@google.com.br', 60, '082376041259', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000474', '2017-02-01', '2017-02-01 17:28:00', 2, 62000.00, 'lnolte1u@webs.com', 60, '087513041918', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000475', '2017-02-13', '2017-02-13 23:24:00', 2, 22000.00, 'bde64@smugmug.com', 20, '086715811061', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000476', '2017-03-04', '2017-03-04 22:48:00', 2, 82000.00, 'mdivine7z@naver.com', 80, '087573648433', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000477', '2017-03-25', '2017-03-25 23:35:00', 2, 102000.00, 'dwitt7x@forbes.com', 100, '084972029367', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000478', '2017-04-17', '2017-04-17 16:30:00', 2, 62000.00, 'pgiovannini67@google.com.br', 60, '085056975932', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000479', '2017-01-28', '2017-01-28 20:02:00', 2, 22000.00, 'agasgarth44@is.gd', 20, '086686133372', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000480', '2017-01-19', '2017-01-19 21:38:00', 2, 22000.00, 'afehelyu@delicious.com', 20, '082735935112', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000481', '2017-02-06', '2017-02-06 16:53:00', 2, 102000.00, 'ywestrip6h@pen.io', 100, '084651457070', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000482', '2017-02-26', '2017-02-26 14:35:00', 1, 62000.00, 'efloodgate1r@stanford.edu', 60, '087898512049', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000483', '2017-01-04', '2017-01-04 22:05:00', 2, 42000.00, 'streasure7s@godaddy.com', 40, '083106708337', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000484', '2017-02-18', '2017-02-18 11:12:00', 1, 22000.00, 'ilerego5p@github.io', 20, '087386881578', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000485', '2017-01-21', '2017-01-21 20:49:00', 2, 62000.00, 'dsketcher7d@ehow.com', 60, '085096642848', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000486', '2017-04-04', '2017-04-04 13:37:00', 1, 62000.00, 'rjosipovitzl@dot.gov', 60, '083871372710', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000487', '2017-03-09', '2017-03-09 17:36:00', 2, 102000.00, 'tmerill45@google.com.br', 100, '089338628110', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000488', '2017-04-20', '2017-04-20 17:11:00', 2, 102000.00, 'lnolte1u@webs.com', 100, '081751425711', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000489', '2017-02-26', '2017-02-26 20:09:00', 2, 102000.00, 'bde64@smugmug.com', 100, '082368578161', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000490', '2017-04-02', '2017-04-02 23:09:00', 2, 82000.00, 'mdivine7z@naver.com', 80, '081606827746', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000491', '2017-01-21', '2017-01-21 23:34:00', 2, 82000.00, 'dwitt7x@forbes.com', 80, '081970487957', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000492', '2017-01-08', '2017-01-08 23:45:00', 2, 22000.00, 'pgiovannini67@google.com.br', 20, '084099856033', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000493', '2017-01-09', '2017-01-09 12:50:00', 1, 82000.00, 'mdyball1n@netlog.com', 80, '085571036189', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000494', '2017-04-25', '2017-04-25 12:42:00', 2, 42000.00, 'dmcauslene4z@amazon.com', 40, '083158883183', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000495', '2017-02-11', '2017-02-11 14:08:00', 1, 102000.00, 'etomsa47@unc.edu', 100, '087083624080', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000496', '2017-02-14', '2017-02-14 13:04:00', 1, 62000.00, 'tschimon5@rambler.ru', 60, '088514658423', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000497', '2017-02-05', '2017-02-05 21:16:00', 2, 42000.00, 'agasgarth44@is.gd', 40, '088474715400', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000498', '2017-04-15', '2017-04-15 18:57:00', 1, 42000.00, 'afehelyu@delicious.com', 40, '083932436805', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000499', '2017-03-08', '2017-03-08 13:46:00', 1, 62000.00, 'ywestrip6h@pen.io', 60, '082093903880', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000500', '2017-01-30', '2017-01-30 16:16:00', 1, 62000.00, 'efloodgate1r@stanford.edu', 60, '088705015340', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000501', '2017-03-10', '2017-03-10 20:35:00', 2, 62000.00, 'streasure7s@godaddy.com', 60, '087792070789', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000502', '2017-02-24', '2017-02-24 22:53:00', 1, 82000.00, 'ilerego5p@github.io', 80, '083608367081', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000503', '2017-01-29', '2017-01-29 18:39:00', 1, 82000.00, 'dsketcher7d@ehow.com', 80, '083593898902', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000504', '2017-04-21', '2017-04-21 10:46:00', 2, 42000.00, 'rjosipovitzl@dot.gov', 40, '087906384933', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000505', '2017-01-24', '2017-01-24 19:30:00', 2, 62000.00, 'tmerill45@google.com.br', 60, '081689394182', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000506', '2017-04-20', '2017-04-20 14:38:00', 2, 102000.00, 'lnolte1u@webs.com', 100, '083795583494', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000507', '2017-02-02', '2017-02-02 21:17:00', 2, 102000.00, 'bde64@smugmug.com', 100, '089072619202', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000508', '2017-04-06', '2017-04-06 20:58:00', 2, 22000.00, 'mdivine7z@naver.com', 20, '088269118331', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000509', '2017-03-01', '2017-03-01 23:01:00', 1, 22000.00, 'dwitt7x@forbes.com', 20, '089895057074', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000510', '2017-01-08', '2017-01-08 15:23:00', 1, 82000.00, 'pgiovannini67@google.com.br', 80, '089575799127', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000511', '2017-03-25', '2017-03-25 10:12:00', 2, 22000.00, 'mdyball1n@netlog.com', 20, '089609963687', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000512', '2017-04-09', '2017-04-09 14:40:00', 2, 42000.00, 'dmcauslene4z@amazon.com', 40, '089351050674', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000513', '2017-03-30', '2017-03-30 17:13:00', 2, 42000.00, 'etomsa47@unc.edu', 40, '088847852718', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000514', '2017-01-08', '2017-01-08 18:53:00', 1, 102000.00, 'tschimon5@rambler.ru', 100, '088213624988', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000515', '2017-03-18', '2017-03-18 11:08:00', 1, 42000.00, 'aginnaly4i@state.gov', 40, '081825022814', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000516', '2017-02-28', '2017-02-28 20:12:00', 2, 102000.00, 'rkinnin4r@odnoklassniki.ru', 100, '086088170597', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000517', '2017-04-06', '2017-04-06 22:56:00', 2, 22000.00, 'bcourtois94@ucla.edu', 20, '084484115606', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000518', '2017-03-13', '2017-03-13 14:11:00', 2, 82000.00, 'zgellier8n@a8.net', 80, '089951510224', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000519', '2017-01-13', '2017-01-13 21:06:00', 2, 42000.00, 'blampen4v@linkedin.com', 40, '084794074833', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000520', '2017-04-13', '2017-04-13 11:52:00', 2, 102000.00, 'ngaudin5x@furl.net', 100, '083205843888', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000521', '2017-03-21', '2017-03-21 12:40:00', 1, 42000.00, 'sspohr35@symantec.com', 40, '084189421045', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000522', '2017-02-18', '2017-02-18 10:13:00', 1, 82000.00, 'singman1v@example.com', 80, '087786524733', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000523', '2017-03-19', '2017-03-19 14:04:00', 1, 82000.00, 'cjanaud1d@virginia.edu', 80, '087012812068', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000524', '2017-03-15', '2017-03-15 14:39:00', 1, 82000.00, 'tbrettle52@wsj.com', 80, '086044337126', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000525', '2017-04-04', '2017-04-04 23:19:00', 1, 42000.00, 'bstrafen8u@tinyurl.com', 40, '086156056480', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000526', '2017-02-25', '2017-02-25 22:57:00', 2, 102000.00, 'bandryunin7p@cyberchimps.com', 100, '089626806071', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000527', '2017-02-06', '2017-02-06 14:20:00', 1, 102000.00, 'locannan2y@archive.org', 100, '088200784201', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000528', '2017-03-12', '2017-03-12 15:46:00', 2, 102000.00, 'hsiley4m@msu.edu', 100, '083870315510', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000529', '2017-01-22', '2017-01-22 20:24:00', 1, 102000.00, 'ctrigg8q@sun.com', 100, '089948862924', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000530', '2017-03-13', '2017-03-13 11:23:00', 1, 102000.00, 'acumberpatch7w@about.me', 100, '089184882317', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000531', '2017-01-22', '2017-01-22 19:53:00', 1, 62000.00, 'cround3b@kickstarter.com', 60, '081765917189', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000532', '2017-02-06', '2017-02-06 22:51:00', 2, 22000.00, 'aginnaly4i@state.gov', 20, '085151995654', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000533', '2017-01-31', '2017-01-31 12:58:00', 1, 62000.00, 'mgilleon8y@bing.com', 60, '088388419492', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000534', '2017-04-03', '2017-04-03 20:48:00', 2, 102000.00, 'cgoldston8v@nature.com', 100, '087779642328', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000535', '2017-02-08', '2017-02-08 20:21:00', 1, 102000.00, 'rjosselsohn3d@reverbnation.com', 100, '081441768634', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000536', '2017-04-10', '2017-04-10 18:18:00', 1, 82000.00, 'ttourmell2d@dailymail.co.uk', 80, '089125192907', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000537', '2017-02-11', '2017-02-11 14:13:00', 2, 102000.00, 'mferrelli18@vkontakte.ru', 100, '089249311838', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000538', '2017-01-12', '2017-01-12 14:08:00', 1, 42000.00, 'dnottingam2t@marketwatch.com', 40, '088855392630', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000539', '2017-02-19', '2017-02-19 16:14:00', 2, 42000.00, 'mchillingworth7a@themeforest.net', 40, '085494618404', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000540', '2017-04-25', '2017-04-25 10:12:00', 2, 22000.00, 'kmowsley2b@cyberchimps.com', 20, '086223568352', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000541', '2017-02-24', '2017-02-24 10:53:00', 2, 82000.00, 'nwagen8@dailymotion.com', 80, '089750240212', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000542', '2017-04-14', '2017-04-14 13:25:00', 1, 62000.00, 'vgorham8i@wikipedia.org', 60, '084291809929', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000543', '2017-03-23', '2017-03-23 15:18:00', 1, 42000.00, 'kparidge17@senate.gov', 40, '083822898605', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000544', '2017-04-04', '2017-04-04 19:00:00', 2, 42000.00, 'sestcot7f@nbcnews.com', 40, '081697940188', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000545', '2017-04-05', '2017-04-05 21:14:00', 1, 82000.00, 'broskams9n@hud.gov', 80, '082508652753', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000546', '2017-02-16', '2017-02-16 12:51:00', 2, 62000.00, 'nrigmond3l@google.ca', 60, '088550694721', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000547', '2017-02-21', '2017-02-21 21:29:00', 2, 82000.00, 'dspuner3w@nature.com', 80, '084942332693', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000548', '2017-02-01', '2017-02-01 14:30:00', 1, 22000.00, 'cschellig95@google.co.jp', 20, '084538723906', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000549', '2017-02-23', '2017-02-23 18:31:00', 2, 102000.00, 'slattos12@usnews.com', 100, '087366635063', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000550', '2017-01-11', '2017-01-11 17:07:00', 1, 62000.00, 'mde2p@census.gov', 60, '083386115219', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000551', '2017-04-05', '2017-04-05 17:44:00', 1, 42000.00, 'stait9@goo.ne.jp', 40, '088304732418', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000552', '2017-01-06', '2017-01-06 12:01:00', 1, 82000.00, 'hcaistor91@mtv.com', 80, '086240822854', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000553', '2017-02-16', '2017-02-16 23:03:00', 1, 62000.00, 'scornelius9m@freewebs.com', 60, '088912005105', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000554', '2017-01-03', '2017-01-03 18:08:00', 2, 82000.00, 'amcgilvray5i@soup.io', 80, '089867921674', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000555', '2017-01-03', '2017-01-03 14:48:00', 1, 82000.00, 'dwitt7x@forbes.com', 80, '082756171707', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000556', '2017-03-07', '2017-03-07 17:49:00', 2, 62000.00, 'showes4c@opera.com', 60, '081651247290', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000557', '2017-04-07', '2017-04-07 13:13:00', 2, 82000.00, 'apicopp4k@uol.com.br', 80, '081344194146', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000558', '2017-02-09', '2017-02-09 15:20:00', 2, 62000.00, 'aschmidt3u@wikia.com', 60, '083710967141', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000559', '2017-04-03', '2017-04-03 17:26:00', 2, 62000.00, 'cborborough7k@twitter.com', 60, '086725971011', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000560', '2017-01-26', '2017-01-26 14:53:00', 1, 22000.00, 'slattos12@usnews.com', 20, '081506165510', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000561', '2017-02-24', '2017-02-24 11:03:00', 1, 102000.00, 'tlacroutz5n@icio.us', 100, '086865961466', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000562', '2017-01-18', '2017-01-18 18:09:00', 2, 42000.00, 'ktonsley9b@nytimes.com', 40, '084698779366', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000563', '2017-04-18', '2017-04-18 14:01:00', 2, 102000.00, 'qstonestreet93@hatena.ne.jp', 100, '087004858679', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000564', '2017-01-25', '2017-01-25 12:52:00', 1, 42000.00, 'dgrenter1g@booking.com', 40, '082911482353', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000565', '2017-01-21', '2017-01-21 21:28:00', 2, 22000.00, 'iscrogges6y@samsung.com', 20, '088214968436', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000566', '2017-04-02', '2017-04-02 19:05:00', 1, 82000.00, 'croston6c@amazon.de', 80, '081606028688', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000567', '2017-01-18', '2017-01-18 18:11:00', 2, 82000.00, 'jdwight8w@wikia.com', 80, '089322161355', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000568', '2017-04-05', '2017-04-05 10:58:00', 1, 82000.00, 'tdjurkovic5r@livejournal.com', 80, '088131141859', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000569', '2017-03-18', '2017-03-18 20:31:00', 1, 102000.00, 'kmohammed42@plala.or.jp', 100, '082701943887', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000570', '2017-01-01', '2017-01-01 15:11:00', 1, 102000.00, 'ishord7g@bloglines.com', 100, '081361914357', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000571', '2017-03-14', '2017-03-14 19:06:00', 1, 62000.00, 'singman1v@example.com', 60, '088918555658', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000572', '2017-02-22', '2017-02-22 21:03:00', 2, 22000.00, 'troyal49@deliciousdays.com', 20, '083738492485', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000573', '2017-04-14', '2017-04-14 14:19:00', 1, 102000.00, 'dpartlett5f@wikia.com', 100, '081889529158', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000574', '2017-03-11', '2017-03-11 15:14:00', 2, 62000.00, 'mhastewell5k@ask.com', 60, '087486457061', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000575', '2017-03-24', '2017-03-24 21:27:00', 1, 22000.00, 'aluetkemeyers70@miibeian.gov.cn', 20, '086770478587', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000576', '2017-04-25', '2017-04-25 17:00:00', 1, 102000.00, 'acereceres4w@alexa.com', 100, '088521478498', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000577', '2017-02-20', '2017-02-20 16:40:00', 1, 102000.00, 'yduffett4o@va.gov', 100, '085777882127', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000578', '2017-02-06', '2017-02-06 23:12:00', 2, 62000.00, 'fwadeson6r@discuz.net', 60, '082693286894', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000579', '2017-02-16', '2017-02-16 12:17:00', 1, 102000.00, 'sklemke3t@lycos.com', 100, '086117693185', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000580', '2017-04-05', '2017-04-05 11:02:00', 1, 82000.00, 'awalczak1f@mit.edu', 80, '084566118773', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000581', '2017-04-19', '2017-04-19 23:11:00', 2, 82000.00, 'streasure7s@godaddy.com', 80, '082785649218', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000582', '2017-02-14', '2017-02-14 14:58:00', 2, 102000.00, 'kmowsley2b@cyberchimps.com', 100, '083247692371', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000583', '2017-01-10', '2017-01-10 21:08:00', 1, 22000.00, 'mmotten8x@senate.gov', 20, '085434835175', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000584', '2017-01-12', '2017-01-12 13:16:00', 1, 62000.00, 'cjanaud1d@virginia.edu', 60, '083784566802', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000585', '2017-04-06', '2017-04-06 16:26:00', 1, 82000.00, 'rjodrelle1c@topsy.com', 80, '087990611336', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000586', '2017-02-08', '2017-02-08 19:06:00', 2, 102000.00, 'dollivierre4l@statcounter.com', 100, '084109379770', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000587', '2017-04-04', '2017-04-04 13:15:00', 1, 42000.00, 'rpendergrast6z@hao123.com', 40, '087848455350', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000588', '2017-04-25', '2017-04-25 22:23:00', 1, 62000.00, 'lsparling73@fema.gov', 60, '087418044817', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000589', '2017-02-22', '2017-02-22 10:46:00', 2, 42000.00, 'bde64@smugmug.com', 40, '087442377272', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000590', '2017-03-15', '2017-03-15 19:39:00', 1, 22000.00, 'dyankin59@quantcast.com', 20, '087699895025', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000591', '2017-02-10', '2017-02-10 15:02:00', 2, 42000.00, 'tbrettle52@wsj.com', 40, '083607418951', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000592', '2017-03-13', '2017-03-13 12:52:00', 1, 42000.00, 'cpeizer5e@vk.com', 40, '086166583433', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000593', '2017-01-25', '2017-01-25 13:22:00', 1, 42000.00, 'fwadeson6r@discuz.net', 40, '084541713897', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000594', '2017-01-13', '2017-01-13 22:52:00', 1, 42000.00, 'ctipper8o@unblog.fr', 40, '087912358094', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000595', '2017-01-31', '2017-01-31 18:37:00', 2, 42000.00, 'jbraikenridge1i@goo.gl', 40, '083650927330', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000596', '2017-02-07', '2017-02-07 16:58:00', 2, 102000.00, 'jdominici5c@wp.com', 100, '084057863794', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000597', '2017-04-22', '2017-04-22 10:49:00', 1, 42000.00, 'mromeoo@weather.com', 40, '083328021160', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000598', '2017-03-04', '2017-03-04 21:28:00', 1, 42000.00, 'smilbourne9c@comcast.net', 40, '084782952958', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000599', '2017-04-10', '2017-04-10 18:23:00', 1, 22000.00, 'cdoughty3o@i2i.jp', 20, '087920689988', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000600', '2017-04-03', '2017-04-03 11:33:00', 1, 42000.00, 'mramsdell78@paypal.com', 40, '082677148285', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000601', '2017-02-04', '2017-02-04 14:15:00', 1, 62000.00, 'sestcot7f@nbcnews.com', 60, '087271429271', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000602', '2017-04-19', '2017-04-19 18:23:00', 2, 102000.00, 'ghamberston55@foxnews.com', 100, '087665302233', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000603', '2017-03-04', '2017-03-04 19:51:00', 1, 22000.00, 'rjodrelle1c@topsy.com', 20, '082793598408', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000604', '2017-03-22', '2017-03-22 23:19:00', 1, 82000.00, 'dpartlett5f@wikia.com', 80, '083763955870', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000605', '2017-02-12', '2017-02-12 18:54:00', 2, 82000.00, 'mgallico88@zimbio.com', 80, '082703784354', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000606', '2017-03-13', '2017-03-13 21:10:00', 2, 82000.00, 'adeg@facebook.com', 80, '087189921523', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000607', '2017-03-18', '2017-03-18 12:38:00', 2, 102000.00, 'fsyratt8h@cpanel.net', 100, '085939037594', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000608', '2017-04-07', '2017-04-07 11:55:00', 1, 62000.00, 'fsyratt8h@cpanel.net', 60, '083506926829', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000609', '2017-04-11', '2017-04-11 17:19:00', 2, 82000.00, 'vnewlove8g@yahoo.com', 80, '089644021106', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000610', '2017-01-12', '2017-01-12 18:51:00', 1, 82000.00, 'kasprey6t@symantec.com', 80, '087094005180', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000611', '2017-02-04', '2017-02-04 12:29:00', 2, 42000.00, 'ralders58@tripod.com', 40, '081478219677', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000612', '2017-03-05', '2017-03-05 22:59:00', 2, 22000.00, 'mjindrich7o@twitter.com', 20, '085958718178', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000613', '2017-01-25', '2017-01-25 19:54:00', 2, 22000.00, 'cpittford71@photobucket.com', 20, '086449376348', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000614', '2017-01-04', '2017-01-04 19:26:00', 2, 82000.00, 'ppidgen2w@paginegialle.it', 80, '086369448356', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000615', '2017-01-19', '2017-01-19 21:46:00', 2, 22000.00, 'yduffett4o@va.gov', 20, '081397610526', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000616', '2017-04-18', '2017-04-18 19:08:00', 1, 62000.00, 'lstiggles4b@ucoz.com', 60, '087315703639', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000617', '2017-04-11', '2017-04-11 23:30:00', 1, 102000.00, 'llawlings5l@china.com.cn', 100, '084430636823', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000618', '2017-03-02', '2017-03-02 19:47:00', 2, 42000.00, 'ppidgen2w@paginegialle.it', 40, '083938805819', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000619', '2017-02-15', '2017-02-15 11:44:00', 1, 22000.00, 'ctembey2s@nhs.uk', 20, '083767609095', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000620', '2017-03-16', '2017-03-16 10:54:00', 2, 22000.00, 'mtitherington10@amazon.co.jp', 20, '087515137911', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000621', '2017-02-10', '2017-02-10 23:02:00', 1, 42000.00, 'tschimon5@rambler.ru', 40, '082518132682', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000622', '2017-01-05', '2017-01-05 15:25:00', 1, 62000.00, 'mcivitillob@google.ru', 60, '088111023743', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000623', '2017-01-29', '2017-01-29 12:37:00', 1, 62000.00, 'eboddymead39@flavors.me', 60, '087905812583', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000624', '2017-01-06', '2017-01-06 21:46:00', 2, 102000.00, 'preddish7y@1und1.de', 100, '088113087253', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000625', '2017-02-05', '2017-02-05 11:20:00', 2, 22000.00, 'gboschmann1w@themeforest.net', 20, '087698102106', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000626', '2017-02-17', '2017-02-17 11:37:00', 2, 62000.00, 'lgoggen4d@discovery.com', 60, '089240390752', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000627', '2017-03-31', '2017-03-31 17:47:00', 2, 62000.00, 'jluxford3x@statcounter.com', 60, '082024584262', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000628', '2017-02-06', '2017-02-06 17:55:00', 2, 22000.00, 'cmcgarrell6s@dropbox.com', 20, '085494802543', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000629', '2017-02-20', '2017-02-20 14:05:00', 1, 62000.00, 'dcollinson43@usnews.com', 60, '082243696173', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000630', '2017-01-07', '2017-01-07 19:39:00', 1, 42000.00, 'cdoughty3o@i2i.jp', 40, '083461123568', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000631', '2017-01-01', '2017-01-01 14:28:00', 1, 62000.00, 'gwhitworth30@slate.com', 60, '084097185394', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000632', '2017-02-24', '2017-02-24 22:21:00', 2, 62000.00, 'rkinnin4r@odnoklassniki.ru', 60, '084928890937', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000633', '2017-03-19', '2017-03-19 13:37:00', 2, 82000.00, 'dtredinnick6b@163.com', 80, '089166159998', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000634', '2017-01-06', '2017-01-06 21:21:00', 2, 42000.00, 'sgarric27@google.com', 40, '086349546270', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000635', '2017-01-02', '2017-01-02 16:44:00', 1, 82000.00, 'lfeasey6i@godaddy.com', 80, '086809045577', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000636', '2017-03-07', '2017-03-07 13:04:00', 1, 62000.00, 'ekelleni@jugem.jp', 60, '087741257661', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000637', '2017-03-31', '2017-03-31 15:03:00', 2, 22000.00, 'vedgcumbe5h@prweb.com', 20, '084356695626', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000638', '2017-03-31', '2017-03-31 22:23:00', 1, 102000.00, 'akiltie81@edublogs.org', 100, '084171204180', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000639', '2017-03-28', '2017-03-28 20:43:00', 1, 42000.00, 'dcollister85@mashable.com', 40, '084759521899', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000640', '2017-04-12', '2017-04-12 10:30:00', 1, 102000.00, 'mdyball1n@netlog.com', 100, '087131798880', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000641', '2017-02-19', '2017-02-19 11:38:00', 2, 42000.00, 'rdiggins29@storify.com', 40, '089760040960', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000642', '2017-03-21', '2017-03-21 10:51:00', 2, 62000.00, 'tbeecroft48@squarespace.com', 60, '087606223438', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000643', '2017-01-17', '2017-01-17 22:19:00', 2, 82000.00, 'rmachen22@businessinsider.com', 80, '084548136132', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000644', '2017-01-26', '2017-01-26 18:14:00', 1, 42000.00, 'dterrey2x@bloglines.com', 40, '087210292937', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000645', '2017-02-04', '2017-02-04 18:06:00', 2, 82000.00, 'ngagin3r@amazon.co.uk', 80, '089834643164', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000646', '2017-02-17', '2017-02-17 12:48:00', 2, 22000.00, 'cpittford71@photobucket.com', 20, '084395633639', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000647', '2017-01-31', '2017-01-31 10:50:00', 2, 22000.00, 'sbendik83@independent.co.uk', 20, '089279631717', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000648', '2017-01-24', '2017-01-24 14:27:00', 1, 82000.00, 'jbarron2u@4shared.com', 80, '088975064988', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000649', '2017-02-15', '2017-02-15 16:30:00', 1, 42000.00, 'hbatyw@dion.ne.jp', 40, '086988976023', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000650', '2017-03-17', '2017-03-17 22:51:00', 2, 62000.00, 'mtitherington10@amazon.co.jp', 60, '081406302220', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000651', '2017-03-30', '2017-03-30 15:20:00', 2, 102000.00, 'vedgcumbe5h@prweb.com', 100, '084390876623', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000652', '2017-02-16', '2017-02-16 15:10:00', 1, 22000.00, 'sklemke3t@lycos.com', 20, '086878600427', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000653', '2017-03-26', '2017-03-26 23:13:00', 1, 82000.00, 'tbeecroft48@squarespace.com', 80, '081445222647', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000654', '2017-02-09', '2017-02-09 23:43:00', 2, 42000.00, 'smilbourne9c@comcast.net', 40, '086063498053', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000655', '2017-03-30', '2017-03-30 19:40:00', 2, 22000.00, 'mtitherington10@amazon.co.jp', 20, '085278034124', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000656', '2017-03-25', '2017-03-25 22:39:00', 2, 82000.00, 'bstrafen8u@tinyurl.com', 80, '085350463359', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000657', '2017-03-12', '2017-03-12 18:21:00', 2, 62000.00, 'ejochens2g@ihg.com', 60, '089225275786', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000658', '2017-03-12', '2017-03-12 20:16:00', 2, 82000.00, 'flapish4s@indiatimes.com', 80, '085000625495', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000659', '2017-04-07', '2017-04-07 16:54:00', 1, 42000.00, 'ejochens2g@ihg.com', 40, '082151621005', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000660', '2017-03-06', '2017-03-06 14:48:00', 1, 62000.00, 'jdwight8w@wikia.com', 60, '089185954893', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000661', '2017-01-10', '2017-01-10 21:13:00', 2, 102000.00, 'jpawlata98@phoca.cz', 100, '089393842781', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000662', '2017-02-05', '2017-02-05 21:25:00', 1, 62000.00, 'cgoldston8v@nature.com', 60, '086373794420', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000663', '2017-01-20', '2017-01-20 19:04:00', 2, 42000.00, 'ctipper8o@unblog.fr', 40, '082983310512', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000664', '2017-02-28', '2017-02-28 23:38:00', 1, 42000.00, 'dizaks9e@qq.com', 40, '089554039890', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000665', '2017-01-25', '2017-01-25 11:07:00', 2, 82000.00, 'lbrewettc@prnewswire.com', 80, '085241259435', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000666', '2017-03-25', '2017-03-25 20:20:00', 1, 62000.00, 'nbaiden3i@cam.ac.uk', 60, '085084059804', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000667', '2017-02-04', '2017-02-04 14:46:00', 2, 102000.00, 'mromeoo@weather.com', 100, '086352735685', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000668', '2017-01-23', '2017-01-23 14:44:00', 1, 82000.00, 'fwasson54@goo.ne.jp', 80, '085299648817', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000669', '2017-04-14', '2017-04-14 17:51:00', 1, 102000.00, 'pmease26@dell.com', 100, '089025002764', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000670', '2017-02-11', '2017-02-11 13:20:00', 2, 22000.00, 'dterrey2x@bloglines.com', 20, '083215106196', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000671', '2017-04-22', '2017-04-22 12:22:00', 2, 62000.00, 'hbatyw@dion.ne.jp', 60, '081747000230', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000672', '2017-03-16', '2017-03-16 10:29:00', 1, 82000.00, 'otamblyn5b@arstechnica.com', 80, '087497427568', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000673', '2017-03-18', '2017-03-18 18:23:00', 1, 62000.00, 'mhavercroft4j@redcross.org', 60, '082700560421', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000674', '2017-04-20', '2017-04-20 22:01:00', 1, 82000.00, 'ngagin3r@amazon.co.uk', 80, '088567934994', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000675', '2017-02-10', '2017-02-10 14:05:00', 2, 42000.00, 'mgoodsal7l@virginia.edu', 40, '081992130694', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000676', '2017-03-28', '2017-03-28 13:25:00', 1, 102000.00, 'efloodgate1r@stanford.edu', 100, '081953918946', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000677', '2017-01-03', '2017-01-03 22:10:00', 2, 42000.00, 'mwadley1e@fema.gov', 40, '082454431853', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000678', '2017-03-26', '2017-03-26 13:34:00', 1, 102000.00, 'fwasson54@goo.ne.jp', 100, '084334407376', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000679', '2017-01-14', '2017-01-14 13:33:00', 1, 82000.00, 'vianni53@csmonitor.com', 80, '084841489140', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000680', '2017-04-11', '2017-04-11 13:04:00', 2, 42000.00, 'dmcauslene4z@amazon.com', 40, '089188549149', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000681', '2017-01-30', '2017-01-30 23:38:00', 2, 82000.00, 'nhubbucks2q@census.gov', 80, '085751844722', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000682', '2017-01-31', '2017-01-31 15:52:00', 2, 82000.00, 'hcaesar80@sina.com.cn', 80, '089113885751', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000683', '2017-01-27', '2017-01-27 12:25:00', 2, 102000.00, 'ktonsley9b@nytimes.com', 100, '083377572102', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000684', '2017-04-05', '2017-04-05 15:30:00', 1, 62000.00, 'efloodgate1r@stanford.edu', 60, '081901135621', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000685', '2017-03-22', '2017-03-22 19:34:00', 2, 42000.00, 'tdjurkovic5r@livejournal.com', 40, '082785337556', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000686', '2017-04-19', '2017-04-19 22:54:00', 1, 62000.00, 'abury56@tmall.com', 60, '085778547719', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000687', '2017-03-20', '2017-03-20 16:44:00', 2, 22000.00, 'lgoggen4d@discovery.com', 20, '086364012925', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000688', '2017-02-25', '2017-02-25 13:17:00', 1, 62000.00, 'zgellier8n@a8.net', 60, '084114375358', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000689', '2017-04-05', '2017-04-05 23:10:00', 2, 82000.00, 'amcatamney34@toplist.cz', 80, '088931438170', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000690', '2017-02-06', '2017-02-06 16:49:00', 2, 22000.00, 'cschellig95@google.co.jp', 20, '087039681294', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000691', '2017-04-08', '2017-04-08 19:43:00', 2, 62000.00, 'rcullenp@amazon.co.uk', 60, '084062232579', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000692', '2017-03-17', '2017-03-17 22:16:00', 2, 102000.00, 'mcivitillob@google.ru', 100, '086387746645', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000693', '2017-03-17', '2017-03-17 12:58:00', 1, 82000.00, 'gboschmann1w@themeforest.net', 80, '085775398640', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000694', '2017-03-20', '2017-03-20 23:15:00', 1, 22000.00, 'ppearmaina@nps.gov', 20, '089599648106', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000695', '2017-03-10', '2017-03-10 18:50:00', 2, 42000.00, 'ywestrip6h@pen.io', 40, '085112168798', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000696', '2017-03-26', '2017-03-26 11:36:00', 1, 22000.00, 'mferrelli18@vkontakte.ru', 20, '082992993987', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000697', '2017-01-12', '2017-01-12 18:19:00', 2, 82000.00, 'kmohammed42@plala.or.jp', 80, '084518516647', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000698', '2017-01-27', '2017-01-27 19:36:00', 2, 22000.00, 'bstrafen8u@tinyurl.com', 20, '087067523212', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000699', '2017-02-16', '2017-02-16 11:46:00', 1, 102000.00, 'sbendik83@independent.co.uk', 100, '089985432313', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000700', '2017-04-24', '2017-04-24 16:59:00', 2, 42000.00, 'dspuner3w@nature.com', 40, '083863571662', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000701', '2017-03-18', '2017-03-18 11:57:00', 2, 42000.00, 'dmcauslene4z@amazon.com', 40, '089550113001', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000702', '2017-04-14', '2017-04-14 13:38:00', 2, 22000.00, 'enevek@devhub.com', 20, '083026769526', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000703', '2017-04-23', '2017-04-23 19:23:00', 2, 22000.00, 'mpumfretts@berkeley.edu', 20, '088904199603', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000704', '2017-03-21', '2017-03-21 20:21:00', 1, 82000.00, 'agilhool6f@addtoany.com', 80, '089753819964', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000705', '2017-03-16', '2017-03-16 19:23:00', 2, 22000.00, 'rliversage9f@icio.us', 20, '082181087657', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000706', '2017-04-18', '2017-04-18 22:07:00', 2, 42000.00, 'dizaks9e@qq.com', 40, '085491778400', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000707', '2017-03-11', '2017-03-11 21:03:00', 1, 82000.00, 'mhache2j@typepad.com', 80, '089641678880', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000708', '2017-01-13', '2017-01-13 16:12:00', 1, 82000.00, 'dollivierre4l@statcounter.com', 80, '083023717715', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000709', '2017-03-05', '2017-03-05 15:57:00', 2, 82000.00, 'ncaro0@guardian.co.uk', 80, '089094518712', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000710', '2017-04-08', '2017-04-08 16:08:00', 1, 62000.00, 'dpartlett5f@wikia.com', 60, '089973365139', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000711', '2017-03-16', '2017-03-16 11:14:00', 1, 62000.00, 'ccallendar8m@xing.com', 60, '083194940538', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000712', '2017-03-16', '2017-03-16 17:38:00', 1, 22000.00, 'likringillh@wordpress.com', 20, '081553205761', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000713', '2017-01-10', '2017-01-10 17:01:00', 2, 22000.00, 'dizaks9e@qq.com', 20, '089175007315', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000714', '2017-03-16', '2017-03-16 18:49:00', 1, 22000.00, 'dollivierre4l@statcounter.com', 20, '083818108320', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000715', '2017-01-14', '2017-01-14 20:55:00', 2, 62000.00, 'tfulleylove7q@nps.gov', 60, '083171054750', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000716', '2017-04-12', '2017-04-12 18:32:00', 1, 42000.00, 'ozettlerq@washingtonpost.com', 40, '089608348362', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000717', '2017-01-16', '2017-01-16 16:11:00', 2, 62000.00, 'yelger5o@trellian.com', 60, '087561319427', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000718', '2017-03-17', '2017-03-17 21:07:00', 1, 102000.00, 'hsiley4m@msu.edu', 100, '084483753060', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000719', '2017-02-23', '2017-02-23 13:51:00', 2, 62000.00, 'nhubbucks2q@census.gov', 60, '088531331118', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000720', '2017-03-31', '2017-03-31 13:27:00', 1, 62000.00, 'gshilliday69@creativecommons.org', 60, '086924927919', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000721', '2017-03-12', '2017-03-12 17:55:00', 1, 42000.00, 'tcolquete3c@goodreads.com', 40, '086330410501', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000722', '2017-03-10', '2017-03-10 17:22:00', 1, 42000.00, 'jluxford3x@statcounter.com', 40, '086492294103', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000723', '2017-03-18', '2017-03-18 16:12:00', 2, 82000.00, 'rmaybey5m@pbs.org', 80, '084863884543', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000724', '2017-04-04', '2017-04-04 23:40:00', 1, 102000.00, 'sestcot7f@nbcnews.com', 100, '084137091625', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000725', '2017-02-09', '2017-02-09 12:05:00', 2, 22000.00, 'atrickeyv@yale.edu', 20, '087908267255', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000726', '2017-01-21', '2017-01-21 15:17:00', 1, 42000.00, 'sjurczak3j@moonfruit.com', 40, '082655380134', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000727', '2017-01-21', '2017-01-21 23:22:00', 2, 62000.00, 'rcrangle9p@cdc.gov', 60, '081387907064', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000728', '2017-03-30', '2017-03-30 23:44:00', 1, 62000.00, 'mhavercroft4j@redcross.org', 60, '082855907748', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000729', '2017-01-09', '2017-01-09 23:53:00', 2, 22000.00, 'bbilston60@wunderground.com', 20, '088000571753', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000730', '2017-01-18', '2017-01-18 23:17:00', 2, 42000.00, 'doveralln@biglobe.ne.jp', 40, '083429920456', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000731', '2017-02-09', '2017-02-09 15:27:00', 2, 62000.00, 'mpierson4h@goo.gl', 60, '083996055364', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000732', '2017-04-13', '2017-04-13 15:08:00', 1, 102000.00, 'amerrall3g@apple.com', 100, '088431828839', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000733', '2017-03-09', '2017-03-09 20:46:00', 1, 42000.00, 'ghoonahan90@salon.com', 40, '089070267332', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000734', '2017-01-25', '2017-01-25 10:25:00', 2, 82000.00, 'ghooban2l@cisco.com', 80, '087042305501', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000735', '2017-01-16', '2017-01-16 21:13:00', 1, 42000.00, 'jmustarde92@hp.com', 40, '089818854094', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000736', '2017-02-16', '2017-02-16 23:12:00', 1, 62000.00, 'kparidge17@senate.gov', 60, '083680926630', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000737', '2017-02-16', '2017-02-16 19:03:00', 1, 102000.00, 'wgent3n@pcworld.com', 100, '082553659205', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000738', '2017-04-08', '2017-04-08 16:31:00', 2, 82000.00, 'amerrall3g@apple.com', 80, '085837166990', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000739', '2017-01-30', '2017-01-30 13:43:00', 1, 102000.00, 'abramez@squidoo.com', 100, '087049031457', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000740', '2017-02-18', '2017-02-18 21:41:00', 2, 82000.00, 'ilerego5p@github.io', 80, '081976652257', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000741', '2017-01-13', '2017-01-13 13:35:00', 2, 22000.00, 'ralders58@tripod.com', 20, '086154509059', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000742', '2017-02-15', '2017-02-15 17:59:00', 1, 82000.00, 'mhavercroft4j@redcross.org', 80, '082376611037', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000743', '2017-02-03', '2017-02-03 12:53:00', 2, 82000.00, 'enevek@devhub.com', 80, '086248973127', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000744', '2017-04-20', '2017-04-20 11:38:00', 2, 42000.00, 'amcatamney34@toplist.cz', 40, '082848654533', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000745', '2017-01-16', '2017-01-16 23:02:00', 1, 102000.00, 'cdoughty3o@i2i.jp', 100, '087218199565', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000746', '2017-01-04', '2017-01-04 18:58:00', 1, 62000.00, 'cmalzard2f@acquirethisname.com', 60, '081493171684', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000747', '2017-03-15', '2017-03-15 23:46:00', 2, 102000.00, 'aginnaly4i@state.gov', 100, '081548388415', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000748', '2017-03-29', '2017-03-29 19:15:00', 1, 102000.00, 'rkinnin4r@odnoklassniki.ru', 100, '081378353918', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000749', '2017-01-25', '2017-01-25 18:56:00', 2, 102000.00, 'bcourtois94@ucla.edu', 100, '085884739724', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000750', '2017-03-11', '2017-03-11 13:50:00', 2, 82000.00, 'zgellier8n@a8.net', 80, '081530815541', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000751', '2017-01-10', '2017-01-10 18:34:00', 2, 102000.00, 'blampen4v@linkedin.com', 100, '087163790852', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000752', '2017-01-30', '2017-01-30 12:59:00', 1, 102000.00, 'ngaudin5x@furl.net', 100, '082787345071', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000753', '2017-04-14', '2017-04-14 17:27:00', 1, 62000.00, 'sspohr35@symantec.com', 60, '089228286785', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000754', '2017-04-22', '2017-04-22 19:17:00', 2, 62000.00, 'singman1v@example.com', 60, '084825071604', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000755', '2017-01-24', '2017-01-24 17:57:00', 1, 82000.00, 'cjanaud1d@virginia.edu', 80, '088131002829', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000756', '2017-01-10', '2017-01-10 14:30:00', 2, 102000.00, 'tbrettle52@wsj.com', 100, '088011306557', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000757', '2017-02-28', '2017-02-28 14:02:00', 1, 62000.00, 'bstrafen8u@tinyurl.com', 60, '084794571403', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000758', '2017-01-22', '2017-01-22 22:23:00', 1, 22000.00, 'bandryunin7p@cyberchimps.com', 20, '088034387449', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000759', '2017-04-18', '2017-04-18 23:00:00', 1, 42000.00, 'locannan2y@archive.org', 40, '084711846271', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000760', '2017-04-11', '2017-04-11 20:29:00', 1, 102000.00, 'hsiley4m@msu.edu', 100, '087465241437', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000761', '2017-02-27', '2017-02-27 13:49:00', 1, 102000.00, 'ctrigg8q@sun.com', 100, '084063190790', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000762', '2017-01-02', '2017-01-02 10:28:00', 2, 62000.00, 'acumberpatch7w@about.me', 60, '085880678155', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000763', '2017-01-19', '2017-01-19 16:24:00', 2, 42000.00, 'cround3b@kickstarter.com', 40, '084113704522', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000764', '2017-04-01', '2017-04-01 10:15:00', 1, 102000.00, 'aginnaly4i@state.gov', 100, '087726982609', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000765', '2017-03-14', '2017-03-14 13:28:00', 1, 42000.00, 'mgilleon8y@bing.com', 40, '089228699365', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000766', '2017-01-21', '2017-01-21 12:38:00', 1, 62000.00, 'cgoldston8v@nature.com', 60, '086580182082', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000767', '2017-01-17', '2017-01-17 13:48:00', 1, 42000.00, 'rjosselsohn3d@reverbnation.com', 40, '088485218232', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000768', '2017-03-31', '2017-03-31 10:35:00', 1, 82000.00, 'ttourmell2d@dailymail.co.uk', 80, '083976033878', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000769', '2017-02-09', '2017-02-09 22:02:00', 2, 22000.00, 'mferrelli18@vkontakte.ru', 20, '084754560886', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000770', '2017-03-28', '2017-03-28 23:54:00', 2, 102000.00, 'dnottingam2t@marketwatch.com', 100, '085968573787', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000771', '2017-02-15', '2017-02-15 14:58:00', 2, 62000.00, 'mchillingworth7a@themeforest.net', 60, '081768754901', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000772', '2017-01-05', '2017-01-05 21:52:00', 1, 102000.00, 'kmowsley2b@cyberchimps.com', 100, '083339832366', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000773', '2017-03-30', '2017-03-30 10:31:00', 2, 82000.00, 'nwagen8@dailymotion.com', 80, '085933870111', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000774', '2017-02-07', '2017-02-07 19:47:00', 2, 82000.00, 'vgorham8i@wikipedia.org', 80, '088545694832', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000775', '2017-01-30', '2017-01-30 17:03:00', 2, 102000.00, 'kparidge17@senate.gov', 100, '085727791594', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000776', '2017-04-04', '2017-04-04 15:38:00', 1, 42000.00, 'sestcot7f@nbcnews.com', 40, '087542654436', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000777', '2017-04-04', '2017-04-04 21:20:00', 2, 22000.00, 'broskams9n@hud.gov', 20, '088845336522', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000778', '2017-01-11', '2017-01-11 17:21:00', 1, 62000.00, 'nrigmond3l@google.ca', 60, '082814074076', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000779', '2017-01-25', '2017-01-25 10:58:00', 2, 62000.00, 'dspuner3w@nature.com', 60, '085784826086', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000780', '2017-01-15', '2017-01-15 22:50:00', 1, 82000.00, 'cschellig95@google.co.jp', 80, '087517032555', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000781', '2017-04-03', '2017-04-03 22:23:00', 2, 102000.00, 'slattos12@usnews.com', 100, '084371890274', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000782', '2017-03-07', '2017-03-07 20:22:00', 2, 102000.00, 'mde2p@census.gov', 100, '082870237370', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000783', '2017-01-08', '2017-01-08 23:33:00', 2, 22000.00, 'stait9@goo.ne.jp', 20, '085814483260', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000784', '2017-01-12', '2017-01-12 12:07:00', 2, 22000.00, 'hcaistor91@mtv.com', 20, '086792729326', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000785', '2017-03-09', '2017-03-09 23:20:00', 2, 22000.00, 'scornelius9m@freewebs.com', 20, '081501215249', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000786', '2017-02-17', '2017-02-17 23:04:00', 1, 42000.00, 'amcgilvray5i@soup.io', 40, '084180755178', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000787', '2017-02-16', '2017-02-16 14:04:00', 2, 82000.00, 'dwitt7x@forbes.com', 80, '086877297516', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000788', '2017-01-11', '2017-01-11 23:22:00', 1, 22000.00, 'showes4c@opera.com', 20, '087888105192', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000789', '2017-04-14', '2017-04-14 17:11:00', 2, 62000.00, 'apicopp4k@uol.com.br', 60, '084784896118', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000790', '2017-04-14', '2017-04-14 23:22:00', 1, 82000.00, 'aschmidt3u@wikia.com', 80, '082811956413', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000791', '2017-02-17', '2017-02-17 10:51:00', 2, 42000.00, 'cborborough7k@twitter.com', 40, '089624190759', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000792', '2017-02-09', '2017-02-09 20:58:00', 2, 82000.00, 'slattos12@usnews.com', 80, '085844660308', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000793', '2017-04-21', '2017-04-21 19:44:00', 1, 82000.00, 'tlacroutz5n@icio.us', 80, '088406175597', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000794', '2017-03-06', '2017-03-06 14:17:00', 2, 22000.00, 'ktonsley9b@nytimes.com', 20, '086146839051', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000795', '2017-03-13', '2017-03-13 14:50:00', 1, 102000.00, 'qstonestreet93@hatena.ne.jp', 100, '087781512581', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000796', '2017-04-19', '2017-04-19 14:15:00', 1, 82000.00, 'dgrenter1g@booking.com', 80, '087917048678', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000797', '2017-01-31', '2017-01-31 16:28:00', 1, 22000.00, 'iscrogges6y@samsung.com', 20, '089778356214', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000798', '2017-03-16', '2017-03-16 14:57:00', 1, 22000.00, 'croston6c@amazon.de', 20, '088260056768', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000799', '2017-01-26', '2017-01-26 19:19:00', 1, 42000.00, 'jdwight8w@wikia.com', 40, '081741471417', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000800', '2017-04-08', '2017-04-08 18:07:00', 1, 102000.00, 'tdjurkovic5r@livejournal.com', 100, '083190695650', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000801', '2017-02-23', '2017-02-23 14:23:00', 2, 22000.00, 'kmohammed42@plala.or.jp', 20, '083211816809', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000802', '2017-04-12', '2017-04-12 23:51:00', 1, 42000.00, 'ishord7g@bloglines.com', 40, '084271474207', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000803', '2017-02-02', '2017-02-02 21:35:00', 2, 62000.00, 'singman1v@example.com', 60, '082074243700', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000804', '2017-02-24', '2017-02-24 16:19:00', 2, 22000.00, 'troyal49@deliciousdays.com', 20, '084512825630', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000805', '2017-01-30', '2017-01-30 10:50:00', 1, 82000.00, 'dpartlett5f@wikia.com', 80, '084279079227', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000806', '2017-01-16', '2017-01-16 18:40:00', 2, 22000.00, 'mhastewell5k@ask.com', 20, '084318782580', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000807', '2017-03-02', '2017-03-02 16:06:00', 1, 82000.00, 'aluetkemeyers70@miibeian.gov.cn', 80, '083599991509', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000808', '2017-02-25', '2017-02-25 10:59:00', 2, 82000.00, 'acereceres4w@alexa.com', 80, '082244459592', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000809', '2017-04-02', '2017-04-02 14:04:00', 2, 102000.00, 'yduffett4o@va.gov', 100, '088923764765', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000810', '2017-02-26', '2017-02-26 20:06:00', 1, 62000.00, 'fwadeson6r@discuz.net', 60, '085695106046', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000811', '2017-02-11', '2017-02-11 19:28:00', 1, 82000.00, 'sklemke3t@lycos.com', 80, '089060018066', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000812', '2017-03-15', '2017-03-15 13:28:00', 2, 102000.00, 'awalczak1f@mit.edu', 100, '084586615381', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000813', '2017-02-26', '2017-02-26 13:08:00', 2, 82000.00, 'streasure7s@godaddy.com', 80, '084481463407', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000814', '2017-01-20', '2017-01-20 16:52:00', 2, 102000.00, 'kmowsley2b@cyberchimps.com', 100, '089900002322', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000815', '2017-03-17', '2017-03-17 12:11:00', 2, 82000.00, 'mmotten8x@senate.gov', 80, '084997250141', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000816', '2017-02-01', '2017-02-01 11:44:00', 2, 42000.00, 'cjanaud1d@virginia.edu', 40, '088288805862', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000817', '2017-01-03', '2017-01-03 23:00:00', 1, 22000.00, 'rjodrelle1c@topsy.com', 20, '081493765810', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000818', '2017-03-25', '2017-03-25 23:31:00', 1, 62000.00, 'dollivierre4l@statcounter.com', 60, '086719181406', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000819', '2017-03-12', '2017-03-12 10:25:00', 1, 22000.00, 'psummerlie8s@edublogs.org', 20, '087854468499', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000820', '2017-04-07', '2017-04-07 21:57:00', 2, 102000.00, 'pbittlestone5u@auda.org.au', 100, '086099601007', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000821', '2017-01-14', '2017-01-14 23:30:00', 2, 22000.00, 'obernaldez4e@mediafire.com', 20, '083025628457', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000822', '2017-01-23', '2017-01-23 11:29:00', 1, 82000.00, 'sgarric27@google.com', 80, '084063161996', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000823', '2017-04-07', '2017-04-07 14:15:00', 1, 82000.00, 'rspeer63@topsy.com', 80, '084747955231', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000824', '2017-01-26', '2017-01-26 22:20:00', 2, 22000.00, 'htreagust4a@homestead.com', 20, '086606784150', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000825', '2017-04-11', '2017-04-11 20:11:00', 2, 82000.00, 'nstenett1q@buzzfeed.com', 80, '087198381499', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000826', '2017-03-11', '2017-03-11 18:24:00', 1, 102000.00, 'acumberpatch7w@about.me', 100, '087056347114', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000827', '2017-02-14', '2017-02-14 16:48:00', 2, 82000.00, 'aorsd@cbc.ca', 80, '085530340598', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000828', '2017-03-07', '2017-03-07 23:19:00', 2, 82000.00, 'vedgcumbe5h@prweb.com', 80, '083277797624', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000829', '2017-03-04', '2017-03-04 21:05:00', 2, 62000.00, 'apicopp4k@uol.com.br', 60, '089628643189', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000830', '2017-03-15', '2017-03-15 17:15:00', 1, 102000.00, 'lstiggles4b@ucoz.com', 100, '086081134765', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000831', '2017-03-22', '2017-03-22 14:38:00', 2, 102000.00, 'poats37@squidoo.com', 100, '089758589732', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000832', '2017-01-15', '2017-01-15 18:37:00', 1, 62000.00, 'scaccavari8b@mozilla.com', 60, '083764840913', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000833', '2017-01-14', '2017-01-14 10:22:00', 1, 22000.00, 'qstonestreet93@hatena.ne.jp', 20, '089079408130', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000834', '2017-02-21', '2017-02-21 18:19:00', 1, 22000.00, 'dwormanm@imgur.com', 20, '086707361128', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000835', '2017-01-07', '2017-01-07 18:38:00', 1, 22000.00, 'mromanin87@sina.com.cn', 20, '086103585038', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000836', '2017-02-10', '2017-02-10 13:23:00', 2, 22000.00, 'bmccurrie89@intel.com', 20, '081453688220', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000837', '2017-04-09', '2017-04-09 16:54:00', 1, 102000.00, 'hflewitt9o@unicef.org', 100, '086112528631', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000838', '2017-03-11', '2017-03-11 21:11:00', 1, 82000.00, 'atrickeyv@yale.edu', 80, '082454922463', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000839', '2017-04-24', '2017-04-24 15:50:00', 2, 102000.00, 'sbendik83@independent.co.uk', 100, '086384613281', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000840', '2017-01-27', '2017-01-27 20:18:00', 2, 42000.00, 'stait9@goo.ne.jp', 40, '081927840069', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000841', '2017-04-16', '2017-04-16 13:48:00', 1, 22000.00, 'atatters31@marketwatch.com', 20, '087933975721', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000842', '2017-02-22', '2017-02-22 15:37:00', 2, 42000.00, 'bandryunin7p@cyberchimps.com', 40, '083676575445', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000843', '2017-01-04', '2017-01-04 18:49:00', 2, 42000.00, 'dmcauslene4z@amazon.com', 40, '083886827435', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000844', '2017-01-09', '2017-01-09 16:16:00', 1, 22000.00, 'dnottingam2t@marketwatch.com', 20, '088230915525', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000845', '2017-01-06', '2017-01-06 18:47:00', 2, 42000.00, 'vianni53@csmonitor.com', 40, '084229397254', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000846', '2017-03-24', '2017-03-24 19:28:00', 2, 22000.00, 'eamiss9j@jimdo.com', 20, '089481759740', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000847', '2017-03-06', '2017-03-06 22:55:00', 2, 42000.00, 'sdornanx@epa.gov', 40, '085639289805', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000848', '2017-02-13', '2017-02-13 20:06:00', 1, 82000.00, 'gmossman1m@de.vu', 80, '085500017311', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000849', '2017-03-09', '2017-03-09 17:16:00', 1, 102000.00, 'ywestrip6h@pen.io', 100, '081740871930', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000850', '2017-04-23', '2017-04-23 14:48:00', 2, 82000.00, 'mromanin87@sina.com.cn', 80, '085222253159', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000851', '2017-04-10', '2017-04-10 22:32:00', 1, 22000.00, 'flapish4s@indiatimes.com', 20, '083884827704', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000852', '2017-04-21', '2017-04-21 15:12:00', 1, 62000.00, 'rjozaitis4g@icio.us', 60, '083610691070', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000853', '2017-04-02', '2017-04-02 11:20:00', 2, 62000.00, 'swoolgar7j@thetimes.co.uk', 60, '083052849632', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000854', '2017-02-18', '2017-02-18 21:44:00', 1, 42000.00, 'mtitherington10@amazon.co.jp', 40, '086809684390', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000855', '2017-04-08', '2017-04-08 19:15:00', 2, 22000.00, 'ghamberston55@foxnews.com', 20, '087534702220', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000856', '2017-01-24', '2017-01-24 15:57:00', 2, 82000.00, 'sbendik83@independent.co.uk', 80, '083467094788', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000857', '2017-02-19', '2017-02-19 16:23:00', 1, 42000.00, 'hflewitt9o@unicef.org', 40, '086393066102', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000858', '2017-03-06', '2017-03-06 14:59:00', 2, 102000.00, 'dsketcher7d@ehow.com', 100, '083474162157', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000859', '2017-01-22', '2017-01-22 12:30:00', 1, 42000.00, 'dde74@fc2.com', 40, '086717759132', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000860', '2017-01-11', '2017-01-11 20:26:00', 2, 82000.00, 'aoldam7n@google.fr', 80, '086310417612', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000861', '2017-03-24', '2017-03-24 20:14:00', 1, 22000.00, 'sdornanx@epa.gov', 20, '082851486860', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000862', '2017-02-27', '2017-02-27 12:33:00', 2, 62000.00, 'mgallico88@zimbio.com', 60, '087993679512', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000863', '2017-01-09', '2017-01-09 16:10:00', 2, 62000.00, 'ozettlerq@washingtonpost.com', 60, '083533320696', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000864', '2017-03-04', '2017-03-04 13:00:00', 1, 102000.00, 'tdjurkovic5r@livejournal.com', 100, '089136322182', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000865', '2017-04-10', '2017-04-10 23:12:00', 1, 82000.00, 'akiltie81@edublogs.org', 80, '087710398415', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000866', '2017-03-29', '2017-03-29 17:37:00', 2, 42000.00, 'tmerill45@google.com.br', 40, '085284076111', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000867', '2017-01-17', '2017-01-17 12:35:00', 1, 102000.00, 'iolahy6a@yellowpages.com', 100, '083843942599', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000868', '2017-02-07', '2017-02-07 19:20:00', 1, 82000.00, 'msimione1p@sitemeter.com', 80, '083776199081', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000869', '2017-04-21', '2017-04-21 13:27:00', 2, 62000.00, 'gkidwell3k@kickstarter.com', 60, '088324372350', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000870', '2017-01-10', '2017-01-10 15:20:00', 2, 22000.00, 'broskams9n@hud.gov', 20, '088842899036', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000871', '2017-03-25', '2017-03-25 12:05:00', 2, 82000.00, 'acumberpatch7w@about.me', 80, '085104199932', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000872', '2017-01-01', '2017-01-01 13:38:00', 1, 42000.00, 'cmalzard2f@acquirethisname.com', 40, '085479881110', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000873', '2017-03-16', '2017-03-16 14:15:00', 1, 102000.00, 'opetigrew6p@devhub.com', 100, '083298474911', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000874', '2017-01-06', '2017-01-06 21:23:00', 1, 62000.00, 'scaccavari8b@mozilla.com', 60, '082686413692', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000875', '2017-01-10', '2017-01-10 23:49:00', 1, 22000.00, 'llawlings5l@china.com.cn', 20, '084166972428', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000876', '2017-01-27', '2017-01-27 18:38:00', 2, 22000.00, 'rdiggins29@storify.com', 20, '088605625019', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000877', '2017-03-27', '2017-03-27 18:38:00', 1, 82000.00, 'pcuttles1@nydailynews.com', 80, '085735977023', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000878', '2017-04-08', '2017-04-08 19:16:00', 2, 62000.00, 'mromeoo@weather.com', 60, '087464718219', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000879', '2017-03-31', '2017-03-31 14:35:00', 1, 102000.00, 'troyal49@deliciousdays.com', 100, '088382148184', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000880', '2017-02-09', '2017-02-09 11:10:00', 2, 62000.00, 'cdocherty2e@gravatar.com', 60, '081881109895', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000881', '2017-01-11', '2017-01-11 14:19:00', 1, 22000.00, 'bisard23@irs.gov', 20, '086335500691', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000882', '2017-02-09', '2017-02-09 11:35:00', 2, 82000.00, 'awalczak1f@mit.edu', 80, '089035790335', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000883', '2017-03-30', '2017-03-30 15:34:00', 1, 82000.00, 'nfilipychev3m@washington.edu', 80, '085379481892', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000884', '2017-01-27', '2017-01-27 10:19:00', 1, 62000.00, 'streasure7s@godaddy.com', 60, '086411876455', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000885', '2017-04-13', '2017-04-13 12:28:00', 1, 62000.00, 'dterrey2x@bloglines.com', 60, '082992717628', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000886', '2017-03-14', '2017-03-14 12:50:00', 1, 102000.00, 'rcrangle9p@cdc.gov', 100, '083975709737', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000887', '2017-03-16', '2017-03-16 15:34:00', 2, 42000.00, 'tbrettle52@wsj.com', 40, '088936049989', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000888', '2017-03-13', '2017-03-13 23:19:00', 2, 62000.00, 'locannan2y@archive.org', 60, '082742370112', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000889', '2017-02-07', '2017-02-07 13:44:00', 2, 22000.00, 'bisard23@irs.gov', 20, '083318221283', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000890', '2017-03-23', '2017-03-23 19:32:00', 2, 42000.00, 'ghoonahan90@salon.com', 40, '082067414085', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000891', '2017-01-25', '2017-01-25 14:38:00', 2, 82000.00, 'lfairleigh4u@nymag.com', 80, '081586230371', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000892', '2017-02-26', '2017-02-26 21:01:00', 1, 42000.00, 'kskerm72@list-manage.com', 40, '087190976595', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000893', '2017-02-17', '2017-02-17 19:43:00', 2, 42000.00, 'locannan2y@archive.org', 40, '086082512588', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000894', '2017-03-08', '2017-03-08 22:42:00', 1, 42000.00, 'lbrewettc@prnewswire.com', 40, '082485229790', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000895', '2017-04-15', '2017-04-15 20:45:00', 1, 102000.00, 'pmarmyon97@accuweather.com', 100, '089608904508', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000896', '2017-03-31', '2017-03-31 21:14:00', 1, 82000.00, 'fsyratt8h@cpanel.net', 80, '088335681418', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000897', '2017-02-16', '2017-02-16 14:25:00', 1, 22000.00, 'gkidwell3k@kickstarter.com', 20, '083236271575', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000898', '2017-03-19', '2017-03-19 23:23:00', 2, 42000.00, 'gboschmann1w@themeforest.net', 40, '088055018929', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000899', '2017-03-27', '2017-03-27 14:46:00', 1, 42000.00, 'psummerlie8s@edublogs.org', 40, '087168856169', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000900', '2017-01-16', '2017-01-16 18:06:00', 2, 82000.00, 'iolahy6a@yellowpages.com', 80, '083124955886', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000901', '2017-01-30', '2017-01-30 20:57:00', 2, 82000.00, 'tdjurkovic5r@livejournal.com', 80, '081741896952', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000902', '2017-02-03', '2017-02-03 19:38:00', 1, 22000.00, 'omasham1z@meetup.com', 20, '087907782310', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000903', '2017-01-06', '2017-01-06 20:52:00', 1, 42000.00, 'amcatamney34@toplist.cz', 40, '082876464851', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000904', '2017-02-08', '2017-02-08 23:43:00', 2, 42000.00, 'jbarron2u@4shared.com', 40, '089229585101', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000905', '2017-01-28', '2017-01-28 18:40:00', 2, 42000.00, 'bde64@smugmug.com', 40, '085702300045', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000906', '2017-03-16', '2017-03-16 11:22:00', 1, 62000.00, 'srainsdon2n@bluehost.com', 60, '088905421739', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000907', '2017-04-15', '2017-04-15 21:54:00', 2, 62000.00, 'acappel5t@hubpages.com', 60, '085635718437', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000908', '2017-01-19', '2017-01-19 20:46:00', 1, 42000.00, 'jdominici5c@wp.com', 40, '089686051424', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000909', '2017-01-29', '2017-01-29 18:47:00', 2, 82000.00, 'abramez@squidoo.com', 80, '088642046203', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000910', '2017-02-22', '2017-02-22 13:42:00', 1, 42000.00, 'bfardon1a@tripod.com', 40, '082324339744', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000911', '2017-01-12', '2017-01-12 21:26:00', 1, 102000.00, 'agasgarth44@is.gd', 100, '083648429249', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000912', '2017-02-01', '2017-02-01 20:09:00', 2, 22000.00, 'afehelyu@delicious.com', 20, '088768368487', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000913', '2017-04-08', '2017-04-08 16:22:00', 1, 82000.00, 'ywestrip6h@pen.io', 80, '084531985660', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000914', '2017-03-16', '2017-03-16 19:27:00', 1, 82000.00, 'efloodgate1r@stanford.edu', 80, '087156768045', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000915', '2017-02-16', '2017-02-16 19:16:00', 1, 62000.00, 'streasure7s@godaddy.com', 60, '086069663278', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000916', '2017-02-17', '2017-02-17 15:05:00', 1, 82000.00, 'ilerego5p@github.io', 80, '082525742887', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000917', '2017-02-07', '2017-02-07 15:01:00', 1, 22000.00, 'dsketcher7d@ehow.com', 20, '081395041866', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000918', '2017-01-09', '2017-01-09 20:50:00', 2, 62000.00, 'rjosipovitzl@dot.gov', 60, '087707608800', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000919', '2017-04-24', '2017-04-24 14:49:00', 2, 82000.00, 'tmerill45@google.com.br', 80, '085902151208', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000920', '2017-02-12', '2017-02-12 12:36:00', 1, 62000.00, 'lnolte1u@webs.com', 60, '083951577896', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000921', '2017-02-21', '2017-02-21 20:17:00', 2, 42000.00, 'bde64@smugmug.com', 40, '081455038492', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000922', '2017-04-07', '2017-04-07 19:12:00', 2, 42000.00, 'mdivine7z@naver.com', 40, '081479339390', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000923', '2017-03-19', '2017-03-19 21:32:00', 1, 62000.00, 'dwitt7x@forbes.com', 60, '082847036095', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000924', '2017-01-17', '2017-01-17 14:42:00', 2, 42000.00, 'pgiovannini67@google.com.br', 40, '084341805294', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000925', '2017-01-29', '2017-01-29 21:37:00', 2, 22000.00, 'kskerm72@list-manage.com', 20, '083552376458', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000926', '2017-03-18', '2017-03-18 18:09:00', 2, 102000.00, 'locannan2y@archive.org', 100, '088892277464', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000927', '2017-04-21', '2017-04-21 14:58:00', 2, 22000.00, 'lbrewettc@prnewswire.com', 20, '087271869701', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000928', '2017-02-01', '2017-02-01 14:16:00', 2, 82000.00, 'pmarmyon97@accuweather.com', 80, '083537322776', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000929', '2017-03-07', '2017-03-07 16:30:00', 2, 42000.00, 'fsyratt8h@cpanel.net', 40, '088463672075', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000930', '2017-01-21', '2017-01-21 18:26:00', 2, 22000.00, 'gkidwell3k@kickstarter.com', 20, '087433678801', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000931', '2017-02-21', '2017-02-21 20:52:00', 2, 102000.00, 'gboschmann1w@themeforest.net', 100, '081524485580', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000932', '2017-01-18', '2017-01-18 15:57:00', 2, 22000.00, 'psummerlie8s@edublogs.org', 20, '083711390061', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000933', '2017-04-14', '2017-04-14 18:40:00', 2, 42000.00, 'iolahy6a@yellowpages.com', 40, '086489201196', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000934', '2017-04-19', '2017-04-19 12:43:00', 1, 42000.00, 'tdjurkovic5r@livejournal.com', 40, '088118595894', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000935', '2017-01-18', '2017-01-18 23:05:00', 1, 42000.00, 'omasham1z@meetup.com', 40, '089075907955', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000936', '2017-04-06', '2017-04-06 12:57:00', 1, 22000.00, 'amcatamney34@toplist.cz', 20, '085134911860', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000937', '2017-03-16', '2017-03-16 11:34:00', 2, 42000.00, 'jbarron2u@4shared.com', 40, '083683151843', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000938', '2017-04-04', '2017-04-04 22:06:00', 1, 62000.00, 'kskerm72@list-manage.com', 60, '081844603861', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000939', '2017-03-19', '2017-03-19 20:18:00', 2, 102000.00, 'locannan2y@archive.org', 100, '085869957889', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000940', '2017-02-20', '2017-02-20 23:35:00', 1, 42000.00, 'lbrewettc@prnewswire.com', 40, '087779602431', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000941', '2017-04-23', '2017-04-23 18:49:00', 1, 102000.00, 'pmarmyon97@accuweather.com', 100, '082060595946', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000942', '2017-02-14', '2017-02-14 14:13:00', 2, 62000.00, 'fsyratt8h@cpanel.net', 60, '081986735705', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000943', '2017-03-22', '2017-03-22 23:32:00', 2, 62000.00, 'gkidwell3k@kickstarter.com', 60, '086932050556', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000944', '2017-01-28', '2017-01-28 16:14:00', 2, 82000.00, 'gboschmann1w@themeforest.net', 80, '085381910962', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000945', '2017-01-21', '2017-01-21 12:38:00', 2, 102000.00, 'psummerlie8s@edublogs.org', 100, '088718274604', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000946', '2017-04-12', '2017-04-12 13:14:00', 1, 62000.00, 'iolahy6a@yellowpages.com', 60, '089067938109', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000947', '2017-02-05', '2017-02-05 16:13:00', 2, 42000.00, 'tdjurkovic5r@livejournal.com', 40, '089324914007', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000948', '2017-02-15', '2017-02-15 18:28:00', 2, 102000.00, 'omasham1z@meetup.com', 100, '082562749432', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000949', '2017-02-23', '2017-02-23 20:07:00', 2, 42000.00, 'amcatamney34@toplist.cz', 40, '082438309855', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000950', '2017-04-25', '2017-04-25 16:58:00', 1, 42000.00, 'jbarron2u@4shared.com', 40, '081430650437', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000951', '2017-03-30', '2017-03-30 23:33:00', 1, 82000.00, 'kskerm72@list-manage.com', 80, '083029312989', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000952', '2017-01-13', '2017-01-13 14:28:00', 1, 62000.00, 'locannan2y@archive.org', 60, '084926626032', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000953', '2017-03-20', '2017-03-20 12:59:00', 1, 62000.00, 'lbrewettc@prnewswire.com', 60, '088607094333', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000954', '2017-04-11', '2017-04-11 19:48:00', 2, 82000.00, 'pmarmyon97@accuweather.com', 80, '081649461958', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000955', '2017-02-21', '2017-02-21 14:38:00', 2, 82000.00, 'fsyratt8h@cpanel.net', 80, '086857543722', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000956', '2017-03-27', '2017-03-27 15:38:00', 2, 42000.00, 'gkidwell3k@kickstarter.com', 40, '081384521499', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000957', '2017-03-12', '2017-03-12 22:18:00', 2, 62000.00, 'gboschmann1w@themeforest.net', 60, '085186735641', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000958', '2017-04-07', '2017-04-07 20:14:00', 2, 62000.00, 'psummerlie8s@edublogs.org', 60, '082565381934', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000959', '2017-01-18', '2017-01-18 22:35:00', 2, 102000.00, 'iolahy6a@yellowpages.com', 100, '086280564360', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000960', '2017-04-10', '2017-04-10 19:37:00', 1, 22000.00, 'tdjurkovic5r@livejournal.com', 20, '088835676125', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000961', '2017-04-05', '2017-04-05 11:36:00', 2, 102000.00, 'omasham1z@meetup.com', 100, '086316082408', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000962', '2017-02-23', '2017-02-23 14:11:00', 2, 102000.00, 'amcatamney34@toplist.cz', 100, '081914754449', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000963', '2017-03-03', '2017-03-03 15:20:00', 1, 102000.00, 'jbarron2u@4shared.com', 100, '082649759076', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000964', '2017-02-07', '2017-02-07 17:45:00', 2, 22000.00, 'tdjurkovic5r@livejournal.com', 20, '083756509497', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000965', '2017-01-02', '2017-01-02 22:15:00', 2, 82000.00, 'omasham1z@meetup.com', 80, '089906204576', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000966', '2017-02-16', '2017-02-16 22:56:00', 1, 42000.00, 'amcatamney34@toplist.cz', 40, '085992783887', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000967', '2017-03-20', '2017-03-20 11:04:00', 1, 82000.00, 'jbarron2u@4shared.com', 80, '082275287311', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000968', '2017-02-23', '2017-02-23 15:26:00', 1, 62000.00, 'tdjurkovic5r@livejournal.com', 60, '082589394691', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000969', '2017-03-22', '2017-03-22 21:40:00', 2, 42000.00, 'omasham1z@meetup.com', 40, '085942032290', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000970', '2017-03-06', '2017-03-06 23:45:00', 2, 62000.00, 'amcatamney34@toplist.cz', 60, '082771614650', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000971', '2017-03-10', '2017-03-10 17:15:00', 2, 62000.00, 'jbarron2u@4shared.com', 60, '083238636581', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000972', '2017-01-28', '2017-01-28 12:59:00', 2, 62000.00, 'tdjurkovic5r@livejournal.com', 60, '083847277752', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000973', '2017-03-04', '2017-03-04 22:05:00', 2, 102000.00, 'omasham1z@meetup.com', 100, '083994974637', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000974', '2017-03-11', '2017-03-11 22:18:00', 2, 22000.00, 'amcatamney34@toplist.cz', 20, '084044664342', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000975', '2017-03-18', '2017-03-18 11:18:00', 1, 42000.00, 'jbarron2u@4shared.com', 40, '084515690614', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000976', '2017-03-26', '2017-03-26 14:23:00', 1, 102000.00, 'atatters31@marketwatch.com', 100, '088929444930', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000977', '2017-04-25', '2017-04-25 14:21:00', 2, 42000.00, 'bandryunin7p@cyberchimps.com', 40, '082021526697', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000978', '2017-03-09', '2017-03-09 10:15:00', 2, 62000.00, 'dmcauslene4z@amazon.com', 60, '084470120876', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000979', '2017-04-13', '2017-04-13 23:29:00', 1, 62000.00, 'dnottingam2t@marketwatch.com', 60, '081842091360', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000980', '2017-01-10', '2017-01-10 21:28:00', 2, 82000.00, 'vianni53@csmonitor.com', 80, '082315773127', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000981', '2017-04-12', '2017-04-12 19:15:00', 2, 22000.00, 'atatters31@marketwatch.com', 20, '081637888260', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000982', '2017-01-03', '2017-01-03 16:29:00', 1, 42000.00, 'bandryunin7p@cyberchimps.com', 40, '083283182859', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000983', '2017-04-05', '2017-04-05 21:42:00', 2, 42000.00, 'dmcauslene4z@amazon.com', 40, '089216397712', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000984', '2017-02-03', '2017-02-03 17:17:00', 2, 82000.00, 'dnottingam2t@marketwatch.com', 80, '088183419523', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000985', '2017-04-12', '2017-04-12 12:07:00', 2, 62000.00, 'vianni53@csmonitor.com', 60, '089030105966', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000986', '2017-03-18', '2017-03-18 13:47:00', 2, 82000.00, 'atrickeyv@yale.edu', 80, '083710822683', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000987', '2017-03-08', '2017-03-08 14:37:00', 2, 42000.00, 'sjurczak3j@moonfruit.com', 40, '086079345351', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000988', '2017-02-14', '2017-02-14 23:01:00', 2, 102000.00, 'rcrangle9p@cdc.gov', 100, '085445295296', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000989', '2017-01-01', '2017-01-01 12:59:00', 2, 102000.00, 'mhavercroft4j@redcross.org', 100, '081877562692', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000990', '2017-02-07', '2017-02-07 19:43:00', 2, 62000.00, 'bbilston60@wunderground.com', 60, '088384443767', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000991', '2017-04-18', '2017-04-18 12:35:00', 2, 102000.00, 'doveralln@biglobe.ne.jp', 100, '084080810738', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000992', '2017-02-28', '2017-02-28 15:18:00', 1, 42000.00, 'mpierson4h@goo.gl', 40, '087364098450', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000993', '2017-04-16', '2017-04-16 14:37:00', 1, 22000.00, 'amerrall3g@apple.com', 20, '082759748100', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000000994', '2017-01-06', '2017-01-06 17:32:00', 1, 82000.00, 'ghoonahan90@salon.com', 80, '083977495501', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000995', '2017-02-19', '2017-02-19 18:30:00', 2, 42000.00, 'ghooban2l@cisco.com', 40, '088401636682', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000000996', '2017-03-08', '2017-03-08 15:52:00', 1, 62000.00, 'jmustarde92@hp.com', 60, '088860517245', 'KLJ00256');
INSERT INTO transaksi_pulsa VALUES ('V000000997', '2017-01-03', '2017-01-03 21:24:00', 1, 82000.00, 'kparidge17@senate.gov', 80, '086154130068', 'KLJ00258');
INSERT INTO transaksi_pulsa VALUES ('V000000998', '2017-03-18', '2017-03-18 17:37:00', 2, 102000.00, 'wgent3n@pcworld.com', 100, '087980423853', 'KLJ00260');
INSERT INTO transaksi_pulsa VALUES ('V000000999', '2017-03-23', '2017-03-23 16:24:00', 2, 22000.00, 'amerrall3g@apple.com', 20, '088298460677', 'KLJ00252');
INSERT INTO transaksi_pulsa VALUES ('V000001000', '2017-03-31', '2017-03-31 11:02:00', 2, 42000.00, 'abramez@squidoo.com', 40, '083452142066', 'KLJ00254');
INSERT INTO transaksi_pulsa VALUES ('V000001001', '2017-05-20', '2017-05-20 23:23:00', 2, 11000.00, 'user@basdat.com', 10, '023123123', 'KLJ00254');


--
-- Data for Name: transaksi_shipped; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO transaksi_shipped VALUES ('V000000000', '2017-04-13', '2017-01-22 10:37:00', 3, 500.00, 'gkidwell3k@kickstarter.com', 'Ward Inc', '00 Sycamore Crossing', 3500.00, 'NR00000000000000', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000001', '2017-10-24', '2017-05-16 13:44:00', 3, 1000.00, 'doveralln@biglobe.ne.jp', 'Kreiger-Deckow and Paucek', '4 Mesta Drive', 4000.00, 'NR00000000000001', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000002', '2017-06-26', '2017-10-14 20:05:00', 1, 1500.00, 'ebromhead50@tinypic.com', 'Schulist and Sons', '35 Blaine Trail', 4500.00, 'NR00000000000002', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000003', '2017-04-07', '2017-08-06 11:09:00', 1, 2000.00, 'opetigrew6p@devhub.com', 'Grant Inc', '3401 Carberry Lane', 5000.00, 'NR00000000000003', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000004', '2017-11-06', '2017-03-08 03:21:00', 4, 2500.00, 'sklemke3t@lycos.com', 'Larson-Bode and Spencer', '53304 Hollow Ridge Park', 5500.00, 'NR00000000000004', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000005', '2017-11-19', '2017-03-01 00:28:00', 4, 3000.00, 'fsyratt8h@cpanel.net', 'Gusikowski LLC', '3706 Carpenter Plaza', 6000.00, 'NR00000000000005', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000006', '2017-05-23', '2017-08-11 19:37:00', 2, 3500.00, 'nleathers33@sbwire.com', 'Mitchell-Carroll and Von', '846 Debra Drive', 6500.00, 'NR00000000000006', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000007', '2017-02-19', '2017-01-03 16:36:00', 2, 4000.00, 'hflewitt9o@unicef.org', 'Gerhold-Brown', '4 Bluejay Avenue', 7000.00, 'NR00000000000007', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000008', '2017-02-02', '2017-02-27 20:03:00', 3, 4500.00, 'rpendergrast6z@hao123.com', 'Green-Ondricka and Kutch', '51 Barby Road', 7500.00, 'NR00000000000008', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000009', '2017-11-18', '2017-11-14 10:47:00', 4, 5000.00, 'lsparling73@fema.gov', 'Hickle Group', '8171 Jackson Way', 8000.00, 'NR00000000000009', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000010', '2017-04-05', '2017-06-07 09:30:00', 3, 5500.00, 'bde64@smugmug.com', 'Ondricka-Funk and Abernathy', '8 Mifflin Parkway', 8500.00, 'NR00000000000010', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000011', '2017-09-19', '2017-04-04 03:55:00', 3, 6000.00, 'dyankin59@quantcast.com', 'Leuschke-Pouros and Daugherty', '14630 Cottonwood Circle', 9000.00, 'NR00000000000011', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000012', '2017-10-27', '2017-04-16 04:48:00', 4, 6500.00, 'tbrettle52@wsj.com', 'Gaylord-Haley', '4428 Milwaukee Road', 9500.00, 'NR00000000000012', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000013', '2017-04-28', '2017-11-20 23:50:00', 3, 7000.00, 'cpeizer5e@vk.com', 'Cruickshank LLC', '83519 Dunning Center', 10000.00, 'NR00000000000013', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000014', '2017-05-10', '2017-01-28 11:33:00', 2, 7500.00, 'fwadeson6r@discuz.net', 'Wolf-Metz and Langosh', '1741 Buell Lane', 10500.00, 'NR00000000000014', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000015', '2017-01-23', '2017-01-24 03:23:00', 2, 8000.00, 'ctipper8o@unblog.fr', 'Hudson-Johnson', '160 4th Hill', 11000.00, 'NR00000000000015', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000016', '2017-08-28', '2017-02-22 20:17:00', 1, 8500.00, 'jbraikenridge1i@goo.gl', 'Schimmel-Nicolas', '657 Jana Terrace', 11500.00, 'NR00000000000016', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000017', '2017-07-07', '2017-04-18 03:39:00', 3, 9000.00, 'jdominici5c@wp.com', 'Senger-Nikolaus', '13 Morning Trail', 12000.00, 'NR00000000000017', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000018', '2017-01-30', '2017-05-12 22:17:00', 3, 9500.00, 'mromeoo@weather.com', 'Gulgowski-Hartmann', '63475 Shelley Junction', 12500.00, 'NR00000000000018', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000019', '2017-06-27', '2017-10-04 10:04:00', 1, 10000.00, 'smilbourne9c@comcast.net', 'Kessler-Fisher and Murphy', '4691 Moland Avenue', 13000.00, 'NR00000000000019', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000020', '2017-08-11', '2017-06-21 05:03:00', 1, 10500.00, 'cdoughty3o@i2i.jp', 'Cummings-Pollich and Ankunding', '91492 Anthes Avenue', 13500.00, 'NR00000000000020', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000021', '2017-04-03', '2017-01-17 18:42:00', 3, 11000.00, 'mramsdell78@paypal.com', 'Bashirian-Ratke and Schmitt', '52507 Kedzie Center', 14000.00, 'NR00000000000021', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000022', '2017-11-03', '2017-04-20 07:02:00', 4, 11500.00, 'sestcot7f@nbcnews.com', 'Kuhn-Wehner', '0958 Sunbrook Circle', 14500.00, 'NR00000000000022', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000023', '2017-03-15', '2017-03-13 19:28:00', 2, 12000.00, 'ghamberston55@foxnews.com', 'Wilkinson Inc', '134 Elka Parkway', 15000.00, 'NR00000000000023', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000024', '2017-08-25', '2017-03-01 18:06:00', 1, 12500.00, 'rjodrelle1c@topsy.com', 'Baumbach-Wiegand and Spencer', '20970 Westend Street', 15500.00, 'NR00000000000024', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000025', '2017-09-29', '2017-10-27 01:43:00', 2, 13000.00, 'dpartlett5f@wikia.com', 'Turner-Kuphal and Dooley', '1 Eliot Parkway', 16000.00, 'NR00000000000025', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000026', '2017-09-27', '2017-09-11 01:48:00', 1, 13500.00, 'mgallico88@zimbio.com', 'Hackett-Bogan and Price', '8454 Hagan Court', 16500.00, 'NR00000000000026', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000027', '2017-05-28', '2017-11-18 14:05:00', 1, 14000.00, 'adeg@facebook.com', 'Hansen-Schulist and Corkery', '99 Trailsway Terrace', 17000.00, 'NR00000000000027', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000028', '2017-05-11', '2017-09-08 20:35:00', 3, 14500.00, 'fsyratt8h@cpanel.net', 'Koelpin-Denesik', '9723 Hollow Ridge Avenue', 17500.00, 'NR00000000000028', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000029', '2017-04-05', '2017-10-29 13:04:00', 4, 15000.00, 'fsyratt8h@cpanel.net', 'Torphy-Zboncak and Upton', '742 Aberg Crossing', 18000.00, 'NR00000000000029', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000030', '2017-07-17', '2017-07-18 04:41:00', 3, 15500.00, 'vnewlove8g@yahoo.com', 'Boyle-Funk', '7 Bay Avenue', 18500.00, 'NR00000000000030', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000031', '2017-02-27', '2017-07-17 03:06:00', 3, 16000.00, 'kasprey6t@symantec.com', 'Gerhold Inc', '660 Waxwing Street', 19000.00, 'NR00000000000031', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000032', '2017-03-17', '2017-05-21 16:15:00', 3, 16500.00, 'ralders58@tripod.com', 'Heidenreich and Sons', '73962 Oriole Lane', 19500.00, 'NR00000000000032', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000033', '2017-07-21', '2017-08-25 05:30:00', 1, 17000.00, 'mjindrich7o@twitter.com', 'Schuster Group', '06273 Luster Plaza', 20000.00, 'NR00000000000033', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000034', '2017-09-29', '2017-02-25 12:49:00', 2, 17500.00, 'cpittford71@photobucket.com', 'Erdman-Bayer', '42 7th Place', 20500.00, 'NR00000000000034', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000035', '2017-08-05', '2017-02-13 23:16:00', 4, 18000.00, 'ppidgen2w@paginegialle.it', 'Friesen-Brakus', '9 Ilene Court', 21000.00, 'NR00000000000035', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000036', '2017-06-21', '2017-10-14 08:49:00', 4, 18500.00, 'yduffett4o@va.gov', 'Medhurst-Walsh', '04652 Steensland Place', 21500.00, 'NR00000000000036', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000037', '2017-05-29', '2017-04-15 01:06:00', 2, 19000.00, 'lstiggles4b@ucoz.com', 'Johnston LLC', '1 Carioca Court', 22000.00, 'NR00000000000037', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000038', '2017-05-13', '2017-03-17 20:48:00', 1, 19500.00, 'llawlings5l@china.com.cn', 'Runolfsson-O''Hara', '17 Spaight Parkway', 22500.00, 'NR00000000000038', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000039', '2017-08-12', '2017-02-14 09:49:00', 1, 20000.00, 'ppidgen2w@paginegialle.it', 'Hilll-Stanton', '89436 Dawn Way', 23000.00, 'NR00000000000039', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000040', '2017-07-26', '2017-05-16 08:52:00', 1, 20500.00, 'ctembey2s@nhs.uk', 'Mraz Inc', '37132 Twin Pines Way', 23500.00, 'NR00000000000040', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000041', '2017-02-04', '2017-04-23 14:14:00', 4, 21000.00, 'mtitherington10@amazon.co.jp', 'VonRueden-Pacocha and Dibbert', '66 Main Parkway', 24000.00, 'NR00000000000041', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000042', '2017-09-29', '2017-06-26 22:59:00', 1, 21500.00, 'tschimon5@rambler.ru', 'Bailey and Sons', '20887 Esch Road', 24500.00, 'NR00000000000042', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000043', '2017-11-05', '2017-07-24 21:43:00', 4, 22000.00, 'mcivitillob@google.ru', 'Lueilwitz-Bogan and Osinski', '1 Westend Hill', 25000.00, 'NR00000000000043', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000044', '2017-11-25', '2017-09-04 02:00:00', 1, 22500.00, 'eboddymead39@flavors.me', 'Dooley-Wisoky', '25250 Golf Center', 25500.00, 'NR00000000000044', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000045', '2017-05-23', '2017-09-19 02:36:00', 1, 23000.00, 'preddish7y@1und1.de', 'Simonis-Grimes and Turcotte', '780 Pawling Road', 26000.00, 'NR00000000000045', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000046', '2017-11-07', '2017-07-30 09:58:00', 4, 23500.00, 'gboschmann1w@themeforest.net', 'King-Spinka', '38339 Muir Avenue', 26500.00, 'NR00000000000046', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000047', '2017-03-14', '2017-07-24 10:19:00', 1, 24000.00, 'lgoggen4d@discovery.com', 'Carroll-Lubowitz', '4844 Eastlawn Park', 27000.00, 'NR00000000000047', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000048', '2017-02-04', '2017-05-27 04:35:00', 4, 24500.00, 'jluxford3x@statcounter.com', 'Parisian-Maggio and Bins', '6 Brown Street', 27500.00, 'NR00000000000048', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000049', '2017-01-27', '2017-08-24 17:15:00', 3, 25000.00, 'cmcgarrell6s@dropbox.com', 'Rowe-Dicki and Conroy', '08 Milwaukee Hill', 28000.00, 'NR00000000000049', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000050', '2017-02-03', '2017-10-15 22:03:00', 4, 25500.00, 'dcollinson43@usnews.com', 'Pfeffer-Rohan and Fadel', '24938 Warbler Court', 28500.00, 'NR00000000000050', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000051', '2017-03-13', '2017-07-01 12:36:00', 3, 26000.00, 'cdoughty3o@i2i.jp', 'Nienow and Sons', '08 Kim Drive', 29000.00, 'NR00000000000051', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000052', '2017-11-25', '2017-10-09 09:27:00', 4, 26500.00, 'gwhitworth30@slate.com', 'Ratke LLC', '3 Rockefeller Point', 29500.00, 'NR00000000000052', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000053', '2017-03-11', '2017-01-19 02:34:00', 4, 27000.00, 'rkinnin4r@odnoklassniki.ru', 'Yost Group', '92 Gerald Avenue', 30000.00, 'NR00000000000053', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000054', '2017-08-16', '2017-02-25 14:21:00', 3, 27500.00, 'dtredinnick6b@163.com', 'Kiehn-Steuber', '574 Spaight Road', 30500.00, 'NR00000000000054', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000055', '2017-05-24', '2017-09-08 03:18:00', 3, 28000.00, 'sgarric27@google.com', 'Kshlerin-Heaney and Mills', '5893 Roth Place', 31000.00, 'NR00000000000055', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000056', '2017-09-19', '2017-01-13 16:26:00', 4, 28500.00, 'lfeasey6i@godaddy.com', 'Bogisich and Sons', '89093 Graceland Street', 31500.00, 'NR00000000000056', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000057', '2017-07-12', '2017-10-22 17:45:00', 1, 29000.00, 'ekelleni@jugem.jp', 'Abshire-Veum and Stiedemann', '3395 Pearson Terrace', 32000.00, 'NR00000000000057', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000058', '2017-11-14', '2017-07-05 21:20:00', 3, 29500.00, 'vedgcumbe5h@prweb.com', 'Kris Group', '16 Hermina Pass', 32500.00, 'NR00000000000058', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000059', '2017-06-24', '2017-11-09 23:02:00', 3, 30000.00, 'akiltie81@edublogs.org', 'Konopelski-Lehner and Moore', '50213 Northridge Pass', 33000.00, 'NR00000000000059', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000060', '2017-08-02', '2017-11-24 03:16:00', 2, 30500.00, 'dcollister85@mashable.com', 'Vandervort LLC', '88194 Sachs Place', 33500.00, 'NR00000000000060', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000061', '2017-07-21', '2017-09-19 10:18:00', 1, 31000.00, 'mdyball1n@netlog.com', 'McGlynn-Aufderhar', '9 Stone Corner Hill', 34000.00, 'NR00000000000061', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000062', '2017-01-07', '2017-07-09 21:17:00', 3, 31500.00, 'rdiggins29@storify.com', 'Williamson-Harber and Russel', '7270 Lukken Avenue', 34500.00, 'NR00000000000062', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000063', '2017-04-09', '2017-03-06 12:08:00', 3, 32000.00, 'tbeecroft48@squarespace.com', 'Raynor Inc', '91 Carey Alley', 35000.00, 'NR00000000000063', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000064', '2017-08-16', '2017-04-07 12:56:00', 3, 32500.00, 'rmachen22@businessinsider.com', 'Gleichner Group', '3532 Anderson Road', 35500.00, 'NR00000000000064', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000065', '2017-09-19', '2017-11-26 04:40:00', 4, 33000.00, 'dterrey2x@bloglines.com', 'Steuber and Sons', '1 Anniversary Parkway', 36000.00, 'NR00000000000065', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000066', '2017-07-17', '2017-10-27 02:48:00', 3, 33500.00, 'ngagin3r@amazon.co.uk', 'Zulauf-Waelchi', '3 Esch Avenue', 36500.00, 'NR00000000000066', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000067', '2017-04-05', '2017-03-08 01:58:00', 2, 34000.00, 'cpittford71@photobucket.com', 'Ebert-Brekke and Romaguera', '44739 Forest Dale Way', 37000.00, 'NR00000000000067', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000068', '2017-02-19', '2017-08-04 12:49:00', 2, 34500.00, 'sbendik83@independent.co.uk', 'Zemlak Group', '6212 Bashford Crossing', 37500.00, 'NR00000000000068', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000069', '2017-08-14', '2017-04-20 13:54:00', 2, 35000.00, 'jbarron2u@4shared.com', 'Labadie-Ortiz and Bradtke', '8823 Kenwood Court', 38000.00, 'NR00000000000069', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000070', '2017-08-06', '2017-09-26 02:54:00', 4, 35500.00, 'hbatyw@dion.ne.jp', 'Baumbach-Koepp and Ritchie', '42 Oxford Crossing', 38500.00, 'NR00000000000070', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000071', '2017-09-25', '2017-03-06 17:56:00', 2, 36000.00, 'mtitherington10@amazon.co.jp', 'Rath Inc', '62056 Thackeray Place', 39000.00, 'NR00000000000071', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000072', '2017-06-26', '2017-07-01 00:49:00', 2, 36500.00, 'vedgcumbe5h@prweb.com', 'Dibbert-Batz and Fahey', '024 Roxbury Junction', 39500.00, 'NR00000000000072', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000073', '2017-02-19', '2017-11-10 01:15:00', 2, 37000.00, 'sklemke3t@lycos.com', 'Jacobson-Kunde', '4 Bellgrove Trail', 40000.00, 'NR00000000000073', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000074', '2017-01-04', '2017-01-20 12:29:00', 1, 37500.00, 'tbeecroft48@squarespace.com', 'Mertz LLC', '15851 Mcguire Court', 40500.00, 'NR00000000000074', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000075', '2017-02-26', '2017-06-12 23:55:00', 3, 38000.00, 'smilbourne9c@comcast.net', 'Gorczany-Hilll and Halvorson', '8870 Kipling Lane', 41000.00, 'NR00000000000075', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000076', '2017-11-04', '2017-07-18 01:15:00', 4, 38500.00, 'mtitherington10@amazon.co.jp', 'Kuphal-Bosco and Tremblay', '6 Mccormick Circle', 41500.00, 'NR00000000000076', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000077', '2017-02-01', '2017-07-25 20:25:00', 2, 39000.00, 'bstrafen8u@tinyurl.com', 'Kreiger-Leannon and Maggio', '219 Dovetail Pass', 42000.00, 'NR00000000000077', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000078', '2017-10-14', '2017-09-16 10:21:00', 4, 39500.00, 'ejochens2g@ihg.com', 'Keeling-Streich', '29780 Carberry Pass', 42500.00, 'NR00000000000078', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000079', '2017-09-19', '2017-09-09 03:13:00', 4, 40000.00, 'flapish4s@indiatimes.com', 'Emard Inc', '6 John Wall Crossing', 43000.00, 'NR00000000000079', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000080', '2017-06-17', '2017-09-16 15:11:00', 2, 40500.00, 'ejochens2g@ihg.com', 'Hagenes-Lubowitz', '1 Harbort Park', 43500.00, 'NR00000000000080', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000081', '2017-07-12', '2017-05-29 20:09:00', 4, 41000.00, 'jdwight8w@wikia.com', 'Greenholt-Willms and Stehr', '6 Mariners Cove Way', 44000.00, 'NR00000000000081', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000082', '2017-08-28', '2017-11-14 10:03:00', 2, 41500.00, 'jpawlata98@phoca.cz', 'Powlowski and Sons', '5444 Westport Court', 44500.00, 'NR00000000000082', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000083', '2017-08-07', '2017-05-12 18:17:00', 4, 42000.00, 'cgoldston8v@nature.com', 'Stamm Group', '89 Amoth Center', 45000.00, 'NR00000000000083', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000084', '2017-09-22', '2017-10-14 16:53:00', 4, 42500.00, 'ctipper8o@unblog.fr', 'Kreiger-Ward and D''Amore', '52 Stang Drive', 45500.00, 'NR00000000000084', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000085', '2017-04-08', '2017-06-07 05:31:00', 1, 43000.00, 'dizaks9e@qq.com', 'Johns-Ward and Veum', '7959 Thierer Crossing', 46000.00, 'NR00000000000085', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000086', '2017-01-11', '2017-04-07 22:22:00', 1, 43500.00, 'lbrewettc@prnewswire.com', 'Crona Inc', '950 Shasta Drive', 46500.00, 'NR00000000000086', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000087', '2017-02-06', '2017-01-19 13:40:00', 3, 44000.00, 'nbaiden3i@cam.ac.uk', 'Kreiger-Torp', '073 Gulseth Junction', 47000.00, 'NR00000000000087', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000088', '2017-05-29', '2017-06-19 19:38:00', 1, 44500.00, 'mromeoo@weather.com', 'Sipes LLC', '63 Swallow Road', 47500.00, 'NR00000000000088', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000089', '2017-05-27', '2017-03-04 23:26:00', 2, 45000.00, 'fwasson54@goo.ne.jp', 'Lindgren-Cartwright and Emard', '52 Russell Road', 48000.00, 'NR00000000000089', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000090', '2017-02-17', '2017-08-21 02:47:00', 3, 45500.00, 'pmease26@dell.com', 'Homenick-Treutel and Kuhlman', '5226 Waxwing Terrace', 48500.00, 'NR00000000000090', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000091', '2017-07-15', '2017-01-29 16:33:00', 3, 46000.00, 'dterrey2x@bloglines.com', 'Christiansen-Mitchell and Morissette', '80 Service Street', 49000.00, 'NR00000000000091', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000092', '2017-03-16', '2017-09-07 18:13:00', 4, 46500.00, 'hbatyw@dion.ne.jp', 'Nader-Pagac and Buckridge', '1007 Blue Bill Park Point', 49500.00, 'NR00000000000092', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000093', '2017-04-11', '2017-08-16 03:39:00', 4, 47000.00, 'otamblyn5b@arstechnica.com', 'Hansen-Mosciski and Swaniawski', '42 Schlimgen Plaza', 50000.00, 'NR00000000000093', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000094', '2017-01-09', '2017-10-07 15:31:00', 1, 47500.00, 'mhavercroft4j@redcross.org', 'Braun-Oberbrunner', '815 Manley Drive', 50500.00, 'NR00000000000094', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000095', '2017-07-03', '2017-03-11 11:57:00', 1, 48000.00, 'ngagin3r@amazon.co.uk', 'Abernathy-Grady', '315 Lakeland Terrace', 51000.00, 'NR00000000000095', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000096', '2017-05-03', '2017-10-15 01:54:00', 3, 48500.00, 'mgoodsal7l@virginia.edu', 'Lemke-Nienow and Stroman', '6 Westerfield Court', 51500.00, 'NR00000000000096', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000097', '2017-11-04', '2017-08-14 03:50:00', 1, 49000.00, 'efloodgate1r@stanford.edu', 'O''Kon Inc', '737 Sheridan Street', 52000.00, 'NR00000000000097', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000098', '2017-08-08', '2017-11-30 16:50:00', 3, 49500.00, 'mwadley1e@fema.gov', 'Tromp-Gleason', '2 Moose Street', 52500.00, 'NR00000000000098', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000099', '2017-11-17', '2017-07-05 11:20:00', 4, 50000.00, 'fwasson54@goo.ne.jp', 'McDermott-Berge', '143 Jackson Drive', 53000.00, 'NR00000000000099', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000100', '2017-04-13', '2017-01-22 10:37:00', 3, 50500.00, 'vianni53@csmonitor.com', 'McDermott-Berge', '1 Nevada Drive', 53500.00, 'NR00000000000100', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000101', '2017-10-24', '2017-05-16 13:44:00', 4, 51000.00, 'dmcauslene4z@amazon.com', 'Ward Inc', '1124 Forest Run Circle', 54000.00, 'NR00000000000101', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000102', '2017-06-26', '2017-10-14 20:05:00', 1, 51500.00, 'nhubbucks2q@census.gov', 'Kreiger-Deckow and Paucek', '2 Talisman Street', 54500.00, 'NR00000000000102', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000103', '2017-04-07', '2017-08-06 11:09:00', 4, 52000.00, 'hcaesar80@sina.com.cn', 'Schulist and Sons', '268 Eastlawn Alley', 55000.00, 'NR00000000000103', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000104', '2017-11-06', '2017-03-08 03:21:00', 2, 52500.00, 'ktonsley9b@nytimes.com', 'Grant Inc', '2340 Green Circle', 55500.00, 'NR00000000000104', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000105', '2017-11-19', '2017-03-01 00:28:00', 1, 53000.00, 'efloodgate1r@stanford.edu', 'Larson-Bode and Spencer', '9 Lakewood Gardens Hill', 56000.00, 'NR00000000000105', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000106', '2017-05-23', '2017-08-11 19:37:00', 1, 53500.00, 'tdjurkovic5r@livejournal.com', 'Gusikowski LLC', '8 Judy Court', 56500.00, 'NR00000000000106', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000107', '2017-02-19', '2017-01-03 16:36:00', 4, 54000.00, 'abury56@tmall.com', 'Mitchell-Carroll and Von', '02975 Meadow Vale Alley', 57000.00, 'NR00000000000107', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000108', '2017-02-02', '2017-02-27 20:03:00', 4, 54500.00, 'lgoggen4d@discovery.com', 'Gerhold-Brown', '2 Kipling Place', 57500.00, 'NR00000000000108', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000109', '2017-11-18', '2017-11-14 10:47:00', 3, 55000.00, 'zgellier8n@a8.net', 'Green-Ondricka and Kutch', '9 Buell Parkway', 58000.00, 'NR00000000000109', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000110', '2017-04-05', '2017-06-07 09:30:00', 4, 55500.00, 'amcatamney34@toplist.cz', 'Hickle Group', '778 Anhalt Road', 58500.00, 'NR00000000000110', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000111', '2017-09-19', '2017-04-04 03:55:00', 2, 56000.00, 'cschellig95@google.co.jp', 'Ondricka-Funk and Abernathy', '2917 Sunnyside Park', 59000.00, 'NR00000000000111', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000112', '2017-10-27', '2017-04-16 04:48:00', 2, 56500.00, 'rcullenp@amazon.co.uk', 'Leuschke-Pouros and Daugherty', '27369 5th Center', 59500.00, 'NR00000000000112', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000113', '2017-04-28', '2017-11-20 23:50:00', 4, 57000.00, 'mcivitillob@google.ru', 'Gaylord-Haley', '24406 Monument Drive', 60000.00, 'NR00000000000113', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000114', '2017-05-10', '2017-01-28 11:33:00', 1, 57500.00, 'gboschmann1w@themeforest.net', 'Cruickshank LLC', '49 Monument Plaza', 60500.00, 'NR00000000000114', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000115', '2017-01-23', '2017-01-24 03:23:00', 4, 58000.00, 'ppearmaina@nps.gov', 'Wolf-Metz and Langosh', '796 Mcguire Court', 61000.00, 'NR00000000000115', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000116', '2017-08-28', '2017-02-22 20:17:00', 4, 58500.00, 'ywestrip6h@pen.io', 'Hudson-Johnson', '7492 Kinsman Court', 61500.00, 'NR00000000000116', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000117', '2017-07-07', '2017-04-18 03:39:00', 4, 59000.00, 'mferrelli18@vkontakte.ru', 'Schimmel-Nicolas', '674 Northridge Court', 62000.00, 'NR00000000000117', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000118', '2017-01-30', '2017-05-12 22:17:00', 1, 59500.00, 'kmohammed42@plala.or.jp', 'Senger-Nikolaus', '903 Bunker Hill Street', 62500.00, 'NR00000000000118', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000119', '2017-06-27', '2017-10-04 10:04:00', 2, 60000.00, 'bstrafen8u@tinyurl.com', 'Gulgowski-Hartmann', '25 Leroy Street', 63000.00, 'NR00000000000119', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000120', '2017-08-11', '2017-06-21 05:03:00', 4, 60500.00, 'sbendik83@independent.co.uk', 'Kessler-Fisher and Murphy', '08 Gateway Avenue', 63500.00, 'NR00000000000120', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000121', '2017-04-03', '2017-01-17 18:42:00', 1, 61000.00, 'dspuner3w@nature.com', 'Cummings-Pollich and Ankunding', '5837 Kinsman Court', 64000.00, 'NR00000000000121', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000122', '2017-11-03', '2017-04-20 07:02:00', 4, 61500.00, 'dmcauslene4z@amazon.com', 'Bashirian-Ratke and Schmitt', '01001 American Lane', 64500.00, 'NR00000000000122', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000123', '2017-03-15', '2017-03-13 19:28:00', 1, 62000.00, 'enevek@devhub.com', 'Kuhn-Wehner', '800 Pawling Park', 65000.00, 'NR00000000000123', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000124', '2017-08-25', '2017-03-01 18:06:00', 4, 62500.00, 'mpumfretts@berkeley.edu', 'Wilkinson Inc', '16 Mesta Parkway', 65500.00, 'NR00000000000124', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000125', '2017-09-29', '2017-10-27 01:43:00', 1, 63000.00, 'agilhool6f@addtoany.com', 'Baumbach-Wiegand and Spencer', '78 Anthes Trail', 66000.00, 'NR00000000000125', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000126', '2017-09-27', '2017-09-11 01:48:00', 2, 63500.00, 'rliversage9f@icio.us', 'Turner-Kuphal and Dooley', '386 Acker Plaza', 66500.00, 'NR00000000000126', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000127', '2017-05-28', '2017-11-18 14:05:00', 1, 64000.00, 'dizaks9e@qq.com', 'Hackett-Bogan and Price', '2938 Westend Place', 67000.00, 'NR00000000000127', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000128', '2017-05-11', '2017-09-08 20:35:00', 3, 64500.00, 'mhache2j@typepad.com', 'Hansen-Schulist and Corkery', '532 Vidon Circle', 67500.00, 'NR00000000000128', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000129', '2017-04-05', '2017-10-29 13:04:00', 4, 65000.00, 'dollivierre4l@statcounter.com', 'Koelpin-Denesik', '3695 Gerald Center', 68000.00, 'NR00000000000129', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000130', '2017-07-17', '2017-07-18 04:41:00', 1, 65500.00, 'ncaro0@guardian.co.uk', 'Torphy-Zboncak and Upton', '632 Longview Avenue', 68500.00, 'NR00000000000130', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000131', '2017-02-27', '2017-07-17 03:06:00', 2, 66000.00, 'dpartlett5f@wikia.com', 'Boyle-Funk', '68 Tennyson Court', 69000.00, 'NR00000000000131', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000132', '2017-03-17', '2017-05-21 16:15:00', 3, 66500.00, 'ccallendar8m@xing.com', 'Gerhold Inc', '95339 Oakridge Place', 69500.00, 'NR00000000000132', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000133', '2017-07-21', '2017-08-25 05:30:00', 3, 67000.00, 'likringillh@wordpress.com', 'Heidenreich and Sons', '6536 Porter Junction', 70000.00, 'NR00000000000133', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000134', '2017-09-29', '2017-02-25 12:49:00', 3, 67500.00, 'dizaks9e@qq.com', 'Schuster Group', '3719 Crescent Oaks Parkway', 70500.00, 'NR00000000000134', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000135', '2017-08-05', '2017-02-13 23:16:00', 1, 68000.00, 'dollivierre4l@statcounter.com', 'Erdman-Bayer', '5 Green Ridge Pass', 71000.00, 'NR00000000000135', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000136', '2017-06-21', '2017-10-14 08:49:00', 3, 68500.00, 'tfulleylove7q@nps.gov', 'Friesen-Brakus', '14 Holy Cross Plaza', 71500.00, 'NR00000000000136', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000137', '2017-05-29', '2017-04-15 01:06:00', 4, 69000.00, 'ozettlerq@washingtonpost.com', 'Medhurst-Walsh', '3 Glacier Hill Plaza', 72000.00, 'NR00000000000137', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000138', '2017-05-13', '2017-03-17 20:48:00', 4, 69500.00, 'yelger5o@trellian.com', 'Johnston LLC', '2 West Trail', 72500.00, 'NR00000000000138', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000139', '2017-08-12', '2017-02-14 09:49:00', 4, 70000.00, 'hsiley4m@msu.edu', 'Runolfsson-O''Hara', '17 Anzinger Court', 73000.00, 'NR00000000000139', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000140', '2017-07-26', '2017-05-16 08:52:00', 1, 70500.00, 'nhubbucks2q@census.gov', 'Hilll-Stanton', '006 Elgar Lane', 73500.00, 'NR00000000000140', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000141', '2017-02-04', '2017-04-23 14:14:00', 1, 71000.00, 'gshilliday69@creativecommons.org', 'Mraz Inc', '74 Commercial Crossing', 74000.00, 'NR00000000000141', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000142', '2017-09-29', '2017-06-26 22:59:00', 1, 71500.00, 'tcolquete3c@goodreads.com', 'VonRueden-Pacocha and Dibbert', '7 Bayside Point', 74500.00, 'NR00000000000142', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000143', '2017-11-05', '2017-07-24 21:43:00', 2, 72000.00, 'jluxford3x@statcounter.com', 'Bailey and Sons', '0464 Tony Crossing', 75000.00, 'NR00000000000143', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000144', '2017-11-25', '2017-09-04 02:00:00', 4, 72500.00, 'rmaybey5m@pbs.org', 'Lueilwitz-Bogan and Osinski', '2212 Bunting Circle', 75500.00, 'NR00000000000144', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000145', '2017-05-23', '2017-09-19 02:36:00', 2, 73000.00, 'sestcot7f@nbcnews.com', 'Dooley-Wisoky', '79369 Clyde Gallagher Way', 76000.00, 'NR00000000000145', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000146', '2017-11-07', '2017-07-30 09:58:00', 1, 73500.00, 'atrickeyv@yale.edu', 'Simonis-Grimes and Turcotte', '30950 Mayfield Circle', 76500.00, 'NR00000000000146', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000147', '2017-03-14', '2017-07-24 10:19:00', 4, 74000.00, 'sjurczak3j@moonfruit.com', 'King-Spinka', '4 Buhler Park', 77000.00, 'NR00000000000147', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000148', '2017-02-04', '2017-05-27 04:35:00', 4, 74500.00, 'rcrangle9p@cdc.gov', 'Carroll-Lubowitz', '3 Weeping Birch Pass', 77500.00, 'NR00000000000148', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000149', '2017-01-27', '2017-08-24 17:15:00', 2, 75000.00, 'mhavercroft4j@redcross.org', 'Parisian-Maggio and Bins', '8293 Talisman Center', 78000.00, 'NR00000000000149', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000150', '2017-02-03', '2017-10-15 22:03:00', 1, 75500.00, 'bbilston60@wunderground.com', 'Ward Inc', '910 Sherman Plaza', 78500.00, 'NR00000000000150', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000151', '2017-03-13', '2017-07-01 12:36:00', 4, 76000.00, 'doveralln@biglobe.ne.jp', 'Kreiger-Deckow and Paucek', '16 Arapahoe Terrace', 79000.00, 'NR00000000000151', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000152', '2017-11-25', '2017-10-09 09:27:00', 3, 76500.00, 'mpierson4h@goo.gl', 'Schulist and Sons', '34710 Memorial Alley', 79500.00, 'NR00000000000152', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000153', '2017-03-11', '2017-01-19 02:34:00', 4, 77000.00, 'amerrall3g@apple.com', 'Grant Inc', '3 Ronald Regan Crossing', 80000.00, 'NR00000000000153', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000154', '2017-08-16', '2017-02-25 14:21:00', 4, 77500.00, 'ghoonahan90@salon.com', 'Larson-Bode and Spencer', '2485 Crest Line Avenue', 80500.00, 'NR00000000000154', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000155', '2017-05-24', '2017-09-08 03:18:00', 2, 78000.00, 'ghooban2l@cisco.com', 'Gusikowski LLC', '049 Arrowood Trail', 81000.00, 'NR00000000000155', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000156', '2017-09-19', '2017-01-13 16:26:00', 3, 78500.00, 'jmustarde92@hp.com', 'Mitchell-Carroll and Von', '328 Pond Trail', 81500.00, 'NR00000000000156', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000157', '2017-07-12', '2017-10-22 17:45:00', 4, 79000.00, 'kparidge17@senate.gov', 'Gerhold-Brown', '26638 Sherman Hill', 82000.00, 'NR00000000000157', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000158', '2017-11-14', '2017-07-05 21:20:00', 3, 79500.00, 'wgent3n@pcworld.com', 'Green-Ondricka and Kutch', '9 Banding Crossing', 82500.00, 'NR00000000000158', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000159', '2017-06-24', '2017-11-09 23:02:00', 1, 80000.00, 'amerrall3g@apple.com', 'Hickle Group', '17265 Dorton Parkway', 83000.00, 'NR00000000000159', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000160', '2017-08-02', '2017-11-24 03:16:00', 1, 80500.00, 'abramez@squidoo.com', 'Ondricka-Funk and Abernathy', '69 Barnett Place', 83500.00, 'NR00000000000160', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000161', '2017-07-21', '2017-09-19 10:18:00', 1, 81000.00, 'ilerego5p@github.io', 'Leuschke-Pouros and Daugherty', '3 Boyd Parkway', 84000.00, 'NR00000000000161', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000162', '2017-01-07', '2017-07-09 21:17:00', 1, 81500.00, 'ralders58@tripod.com', 'Gaylord-Haley', '18072 Westridge Point', 84500.00, 'NR00000000000162', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000163', '2017-04-09', '2017-03-06 12:08:00', 4, 82000.00, 'mhavercroft4j@redcross.org', 'Cruickshank LLC', '960 Rutledge Crossing', 85000.00, 'NR00000000000163', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000164', '2017-08-16', '2017-04-07 12:56:00', 4, 82500.00, 'enevek@devhub.com', 'Wolf-Metz and Langosh', '5 Grasskamp Hill', 85500.00, 'NR00000000000164', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000165', '2017-09-19', '2017-11-26 04:40:00', 2, 83000.00, 'amcatamney34@toplist.cz', 'Hudson-Johnson', '057 Sauthoff Drive', 86000.00, 'NR00000000000165', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000166', '2017-07-17', '2017-10-27 02:48:00', 4, 83500.00, 'cdoughty3o@i2i.jp', 'Schimmel-Nicolas', '9751 Mosinee Court', 86500.00, 'NR00000000000166', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000167', '2017-04-05', '2017-03-08 01:58:00', 4, 84000.00, 'cmalzard2f@acquirethisname.com', 'Senger-Nikolaus', '2561 3rd Place', 87000.00, 'NR00000000000167', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000168', '2017-02-19', '2017-08-04 12:49:00', 2, 84500.00, 'aginnaly4i@state.gov', 'Gulgowski-Hartmann', '178 Muir Circle', 87500.00, 'NR00000000000168', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000169', '2017-08-14', '2017-04-20 13:54:00', 3, 85000.00, 'rkinnin4r@odnoklassniki.ru', 'Kessler-Fisher and Murphy', '13 Old Shore Court', 88000.00, 'NR00000000000169', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000170', '2017-08-06', '2017-09-26 02:54:00', 2, 85500.00, 'bcourtois94@ucla.edu', 'Cummings-Pollich and Ankunding', '1 Amoth Crossing', 88500.00, 'NR00000000000170', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000171', '2017-09-25', '2017-03-06 17:56:00', 2, 86000.00, 'zgellier8n@a8.net', 'Bashirian-Ratke and Schmitt', '328 Forster Alley', 89000.00, 'NR00000000000171', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000172', '2017-06-26', '2017-07-01 00:49:00', 4, 86500.00, 'blampen4v@linkedin.com', 'Kuhn-Wehner', '46926 Stang Hill', 89500.00, 'NR00000000000172', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000173', '2017-02-19', '2017-11-10 01:15:00', 1, 87000.00, 'ngaudin5x@furl.net', 'Wilkinson Inc', '75 Namekagon Crossing', 90000.00, 'NR00000000000173', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000174', '2017-01-04', '2017-01-20 12:29:00', 4, 87500.00, 'sspohr35@symantec.com', 'Baumbach-Wiegand and Spencer', '015 Kings Lane', 90500.00, 'NR00000000000174', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000175', '2017-02-26', '2017-06-12 23:55:00', 2, 88000.00, 'singman1v@example.com', 'Turner-Kuphal and Dooley', '5651 Hudson Trail', 91000.00, 'NR00000000000175', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000176', '2017-11-04', '2017-07-18 01:15:00', 2, 88500.00, 'cjanaud1d@virginia.edu', 'Hackett-Bogan and Price', '32 Village Trail', 91500.00, 'NR00000000000176', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000177', '2017-02-01', '2017-07-25 20:25:00', 1, 89000.00, 'tbrettle52@wsj.com', 'Hansen-Schulist and Corkery', '4121 Ohio Junction', 92000.00, 'NR00000000000177', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000178', '2017-10-14', '2017-09-16 10:21:00', 3, 89500.00, 'bstrafen8u@tinyurl.com', 'Koelpin-Denesik', '4706 Kropf Street', 92500.00, 'NR00000000000178', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000179', '2017-09-19', '2017-09-09 03:13:00', 2, 90000.00, 'bandryunin7p@cyberchimps.com', 'Torphy-Zboncak and Upton', '142 Eliot Drive', 93000.00, 'NR00000000000179', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000180', '2017-06-17', '2017-09-16 15:11:00', 3, 90500.00, 'locannan2y@archive.org', 'Boyle-Funk', '59 Lighthouse Bay Drive', 93500.00, 'NR00000000000180', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000181', '2017-07-12', '2017-05-29 20:09:00', 3, 91000.00, 'hsiley4m@msu.edu', 'Gerhold Inc', '4 3rd Center', 94000.00, 'NR00000000000181', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000182', '2017-08-28', '2017-11-14 10:03:00', 1, 91500.00, 'ctrigg8q@sun.com', 'Heidenreich and Sons', '8982 Debra Junction', 94500.00, 'NR00000000000182', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000183', '2017-08-07', '2017-05-12 18:17:00', 1, 92000.00, 'acumberpatch7w@about.me', 'Schuster Group', '33 8th Plaza', 95000.00, 'NR00000000000183', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000184', '2017-09-22', '2017-10-14 16:53:00', 3, 92500.00, 'cround3b@kickstarter.com', 'Erdman-Bayer', '4 Trailsway Alley', 95500.00, 'NR00000000000184', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000185', '2017-04-08', '2017-06-07 05:31:00', 2, 93000.00, 'aginnaly4i@state.gov', 'Friesen-Brakus', '93830 Anniversary Point', 96000.00, 'NR00000000000185', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000186', '2017-01-11', '2017-04-07 22:22:00', 1, 93500.00, 'mgilleon8y@bing.com', 'Medhurst-Walsh', '82244 West Pass', 96500.00, 'NR00000000000186', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000187', '2017-02-06', '2017-01-19 13:40:00', 3, 94000.00, 'cgoldston8v@nature.com', 'Johnston LLC', '61100 Debra Plaza', 97000.00, 'NR00000000000187', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000188', '2017-05-29', '2017-06-19 19:38:00', 2, 94500.00, 'rjosselsohn3d@reverbnation.com', 'Runolfsson-O''Hara', '409 Coleman Road', 97500.00, 'NR00000000000188', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000189', '2017-05-27', '2017-03-04 23:26:00', 1, 95000.00, 'ttourmell2d@dailymail.co.uk', 'Hilll-Stanton', '0853 Autumn Leaf Court', 98000.00, 'NR00000000000189', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000190', '2017-02-17', '2017-08-21 02:47:00', 4, 95500.00, 'mferrelli18@vkontakte.ru', 'Mraz Inc', '80 Florence Park', 98500.00, 'NR00000000000190', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000191', '2017-07-15', '2017-01-29 16:33:00', 3, 96000.00, 'dnottingam2t@marketwatch.com', 'VonRueden-Pacocha and Dibbert', '65740 Killdeer Court', 99000.00, 'NR00000000000191', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000192', '2017-03-16', '2017-09-07 18:13:00', 1, 96500.00, 'mchillingworth7a@themeforest.net', 'Bailey and Sons', '8325 Hagan Parkway', 99500.00, 'NR00000000000192', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000193', '2017-04-11', '2017-08-16 03:39:00', 3, 97000.00, 'kmowsley2b@cyberchimps.com', 'Lueilwitz-Bogan and Osinski', '8 Dayton Hill', 100000.00, 'NR00000000000193', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000194', '2017-01-09', '2017-10-07 15:31:00', 1, 97500.00, 'nwagen8@dailymotion.com', 'Dooley-Wisoky', '38316 Thompson Way', 100500.00, 'NR00000000000194', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000195', '2017-07-03', '2017-03-11 11:57:00', 2, 98000.00, 'vgorham8i@wikipedia.org', 'Simonis-Grimes and Turcotte', '83 Anderson Trail', 101000.00, 'NR00000000000195', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000196', '2017-05-03', '2017-10-15 01:54:00', 2, 98500.00, 'kparidge17@senate.gov', 'King-Spinka', '8 Bay Court', 101500.00, 'NR00000000000196', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000197', '2017-11-04', '2017-08-14 03:50:00', 1, 99000.00, 'sestcot7f@nbcnews.com', 'Carroll-Lubowitz', '67 Sunbrook Court', 102000.00, 'NR00000000000197', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000198', '2017-08-08', '2017-11-30 16:50:00', 3, 99500.00, 'broskams9n@hud.gov', 'Parisian-Maggio and Bins', '8407 Maryland Place', 102500.00, 'NR00000000000198', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000199', '2017-11-17', '2017-07-05 11:20:00', 4, 100000.00, 'nrigmond3l@google.ca', 'Rowe-Dicki and Conroy', '770 Golf Course Park', 103000.00, 'NR00000000000199', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000200', '2017-04-13', '2017-01-22 10:37:00', 2, 100500.00, 'dspuner3w@nature.com', 'Pfeffer-Rohan and Fadel', '19 Thackeray Drive', 103500.00, 'NR00000000000200', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000201', '2017-10-24', '2017-05-16 13:44:00', 4, 101000.00, 'cschellig95@google.co.jp', 'Nienow and Sons', '1 Truax Hill', 104000.00, 'NR00000000000201', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000202', '2017-06-26', '2017-10-14 20:05:00', 4, 101500.00, 'slattos12@usnews.com', 'Ratke LLC', '6 Corry Place', 104500.00, 'NR00000000000202', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000203', '2017-04-07', '2017-08-06 11:09:00', 3, 102000.00, 'mde2p@census.gov', 'Yost Group', '246 Pierstorff Avenue', 105000.00, 'NR00000000000203', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000204', '2017-11-06', '2017-03-08 03:21:00', 1, 102500.00, 'stait9@goo.ne.jp', 'Kiehn-Steuber', '76665 Birchwood Crossing', 105500.00, 'NR00000000000204', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000205', '2017-11-19', '2017-03-01 00:28:00', 4, 103000.00, 'hcaistor91@mtv.com', 'Kshlerin-Heaney and Mills', '0 Debra Court', 106000.00, 'NR00000000000205', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000206', '2017-05-23', '2017-08-11 19:37:00', 4, 103500.00, 'scornelius9m@freewebs.com', 'Bogisich and Sons', '49 Lakeland Street', 106500.00, 'NR00000000000206', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000207', '2017-02-19', '2017-01-03 16:36:00', 1, 104000.00, 'amcgilvray5i@soup.io', 'Abshire-Veum and Stiedemann', '399 Granby Pass', 107000.00, 'NR00000000000207', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000208', '2017-02-02', '2017-02-27 20:03:00', 4, 104500.00, 'dwitt7x@forbes.com', 'Kris Group', '6105 Mesta Pass', 107500.00, 'NR00000000000208', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000209', '2017-11-18', '2017-11-14 10:47:00', 4, 105000.00, 'showes4c@opera.com', 'Konopelski-Lehner and Moore', '06 Carioca Alley', 108000.00, 'NR00000000000209', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000210', '2017-04-05', '2017-06-07 09:30:00', 4, 105500.00, 'apicopp4k@uol.com.br', 'Vandervort LLC', '6366 Lyons Drive', 108500.00, 'NR00000000000210', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000211', '2017-09-19', '2017-04-04 03:55:00', 4, 106000.00, 'aschmidt3u@wikia.com', 'McGlynn-Aufderhar', '9620 Forest Run Avenue', 109000.00, 'NR00000000000211', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000212', '2017-10-27', '2017-04-16 04:48:00', 4, 106500.00, 'cborborough7k@twitter.com', 'Williamson-Harber and Russel', '03607 Towne Avenue', 109500.00, 'NR00000000000212', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000213', '2017-04-28', '2017-11-20 23:50:00', 1, 107000.00, 'slattos12@usnews.com', 'Raynor Inc', '944 Corry Pass', 110000.00, 'NR00000000000213', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000214', '2017-05-10', '2017-01-28 11:33:00', 1, 107500.00, 'tlacroutz5n@icio.us', 'Gleichner Group', '8 Dennis Circle', 110500.00, 'NR00000000000214', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000215', '2017-01-23', '2017-01-24 03:23:00', 3, 108000.00, 'ktonsley9b@nytimes.com', 'Steuber and Sons', '12393 Parkside Street', 111000.00, 'NR00000000000215', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000216', '2017-08-28', '2017-02-22 20:17:00', 2, 108500.00, 'qstonestreet93@hatena.ne.jp', 'Zulauf-Waelchi', '58074 Mendota Parkway', 111500.00, 'NR00000000000216', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000217', '2017-07-07', '2017-04-18 03:39:00', 3, 109000.00, 'dgrenter1g@booking.com', 'Ebert-Brekke and Romaguera', '9 Cordelia Street', 112000.00, 'NR00000000000217', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000218', '2017-01-30', '2017-05-12 22:17:00', 4, 109500.00, 'iscrogges6y@samsung.com', 'Zemlak Group', '03362 Porter Road', 112500.00, 'NR00000000000218', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000219', '2017-06-27', '2017-10-04 10:04:00', 1, 110000.00, 'croston6c@amazon.de', 'Labadie-Ortiz and Bradtke', '9558 Debra Plaza', 113000.00, 'NR00000000000219', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000220', '2017-08-11', '2017-06-21 05:03:00', 1, 110500.00, 'jdwight8w@wikia.com', 'Baumbach-Koepp and Ritchie', '1 Autumn Leaf Plaza', 113500.00, 'NR00000000000220', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000221', '2017-04-03', '2017-01-17 18:42:00', 1, 111000.00, 'tdjurkovic5r@livejournal.com', 'Rath Inc', '02148 Columbus Terrace', 114000.00, 'NR00000000000221', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000222', '2017-11-03', '2017-04-20 07:02:00', 3, 111500.00, 'kmohammed42@plala.or.jp', 'Dibbert-Batz and Fahey', '57 Mitchell Park', 114500.00, 'NR00000000000222', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000223', '2017-03-15', '2017-03-13 19:28:00', 3, 112000.00, 'ishord7g@bloglines.com', 'Jacobson-Kunde', '3 Hanover Way', 115000.00, 'NR00000000000223', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000224', '2017-08-25', '2017-03-01 18:06:00', 2, 112500.00, 'singman1v@example.com', 'Mertz LLC', '8013 Magdeline Street', 115500.00, 'NR00000000000224', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000225', '2017-09-29', '2017-10-27 01:43:00', 1, 113000.00, 'troyal49@deliciousdays.com', 'Gorczany-Hilll and Halvorson', '5938 Village Center', 116000.00, 'NR00000000000225', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000226', '2017-09-27', '2017-09-11 01:48:00', 3, 113500.00, 'dpartlett5f@wikia.com', 'Kuphal-Bosco and Tremblay', '82 Dorton Place', 116500.00, 'NR00000000000226', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000227', '2017-05-28', '2017-11-18 14:05:00', 2, 114000.00, 'mhastewell5k@ask.com', 'Kreiger-Leannon and Maggio', '7790 Nelson Alley', 117000.00, 'NR00000000000227', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000228', '2017-05-11', '2017-09-08 20:35:00', 4, 114500.00, 'aluetkemeyers70@miibeian.gov.cn', 'Keeling-Streich', '08 Armistice Crossing', 117500.00, 'NR00000000000228', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000229', '2017-04-05', '2017-10-29 13:04:00', 4, 115000.00, 'acereceres4w@alexa.com', 'Emard Inc', '8857 Iowa Point', 118000.00, 'NR00000000000229', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000230', '2017-07-17', '2017-07-18 04:41:00', 1, 115500.00, 'yduffett4o@va.gov', 'Hagenes-Lubowitz', '6 Banding Avenue', 118500.00, 'NR00000000000230', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000231', '2017-02-27', '2017-07-17 03:06:00', 3, 116000.00, 'fwadeson6r@discuz.net', 'Greenholt-Willms and Stehr', '3620 Riverside Point', 119000.00, 'NR00000000000231', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000232', '2017-03-17', '2017-05-21 16:15:00', 3, 116500.00, 'sklemke3t@lycos.com', 'Powlowski and Sons', '63 Parkside Pass', 119500.00, 'NR00000000000232', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000233', '2017-07-21', '2017-08-25 05:30:00', 4, 117000.00, 'awalczak1f@mit.edu', 'Stamm Group', '228 Rieder Drive', 120000.00, 'NR00000000000233', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000234', '2017-09-29', '2017-02-25 12:49:00', 4, 117500.00, 'streasure7s@godaddy.com', 'Kreiger-Ward and D''Amore', '6 American Plaza', 120500.00, 'NR00000000000234', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000235', '2017-08-05', '2017-02-13 23:16:00', 3, 118000.00, 'kmowsley2b@cyberchimps.com', 'Johns-Ward and Veum', '1672 Hudson Circle', 121000.00, 'NR00000000000235', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000236', '2017-06-21', '2017-10-14 08:49:00', 1, 118500.00, 'mmotten8x@senate.gov', 'Crona Inc', '98602 Meadow Vale Center', 121500.00, 'NR00000000000236', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000237', '2017-05-29', '2017-04-15 01:06:00', 4, 119000.00, 'cjanaud1d@virginia.edu', 'Kreiger-Torp', '3427 Roxbury Road', 122000.00, 'NR00000000000237', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000238', '2017-05-13', '2017-03-17 20:48:00', 3, 119500.00, 'rjodrelle1c@topsy.com', 'Sipes LLC', '56 Debra Road', 122500.00, 'NR00000000000238', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000239', '2017-08-12', '2017-02-14 09:49:00', 3, 120000.00, 'dollivierre4l@statcounter.com', 'Lindgren-Cartwright and Emard', '24920 Main Road', 123000.00, 'NR00000000000239', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000240', '2017-07-26', '2017-05-16 08:52:00', 3, 120500.00, 'psummerlie8s@edublogs.org', 'Homenick-Treutel and Kuhlman', '8619 Upham Parkway', 123500.00, 'NR00000000000240', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000241', '2017-02-04', '2017-04-23 14:14:00', 1, 121000.00, 'pbittlestone5u@auda.org.au', 'Christiansen-Mitchell and Morissette', '8 Susan Pass', 124000.00, 'NR00000000000241', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000242', '2017-09-29', '2017-06-26 22:59:00', 1, 121500.00, 'obernaldez4e@mediafire.com', 'Nader-Pagac and Buckridge', '2 Buell Center', 124500.00, 'NR00000000000242', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000243', '2017-11-05', '2017-07-24 21:43:00', 3, 122000.00, 'sgarric27@google.com', 'Hansen-Mosciski and Swaniawski', '39887 Pawling Terrace', 125000.00, 'NR00000000000243', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000244', '2017-11-25', '2017-09-04 02:00:00', 1, 122500.00, 'rspeer63@topsy.com', 'Braun-Oberbrunner', '36 Mariners Cove Parkway', 125500.00, 'NR00000000000244', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000245', '2017-05-23', '2017-09-19 02:36:00', 1, 123000.00, 'htreagust4a@homestead.com', 'Abernathy-Grady', '182 Ilene Road', 126000.00, 'NR00000000000245', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000246', '2017-11-07', '2017-07-30 09:58:00', 3, 123500.00, 'nstenett1q@buzzfeed.com', 'Lemke-Nienow and Stroman', '519 Delladonna Way', 126500.00, 'NR00000000000246', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000247', '2017-03-14', '2017-07-24 10:19:00', 1, 124000.00, 'acumberpatch7w@about.me', 'O''Kon Inc', '233 Springs Place', 127000.00, 'NR00000000000247', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000248', '2017-02-04', '2017-05-27 04:35:00', 4, 124500.00, 'aorsd@cbc.ca', 'Tromp-Gleason', '65399 Fremont Point', 127500.00, 'NR00000000000248', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000249', '2017-01-27', '2017-08-24 17:15:00', 2, 125000.00, 'vedgcumbe5h@prweb.com', 'McDermott-Berge', '020 Monterey Crossing', 128000.00, 'NR00000000000249', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000250', '2017-02-03', '2017-10-15 22:03:00', 2, 125500.00, 'gkidwell3k@kickstarter.com', 'McDermott-Berge', '52669 Clove Lane', 128500.00, 'NR00000000000250', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000251', '2017-03-13', '2017-07-01 12:36:00', 1, 126000.00, 'doveralln@biglobe.ne.jp', 'Ward Inc', '70462 Brickson Park Circle', 129000.00, 'NR00000000000251', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000252', '2017-11-25', '2017-10-09 09:27:00', 1, 126500.00, 'ebromhead50@tinypic.com', 'Kreiger-Deckow and Paucek', '9 Maple Wood Parkway', 129500.00, 'NR00000000000252', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000253', '2017-03-11', '2017-01-19 02:34:00', 2, 127000.00, 'opetigrew6p@devhub.com', 'Schulist and Sons', '30 Crest Line Street', 130000.00, 'NR00000000000253', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000254', '2017-08-16', '2017-02-25 14:21:00', 3, 127500.00, 'sklemke3t@lycos.com', 'Grant Inc', '21 Loftsgordon Park', 130500.00, 'NR00000000000254', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000255', '2017-05-24', '2017-09-08 03:18:00', 1, 128000.00, 'fsyratt8h@cpanel.net', 'Larson-Bode and Spencer', '55065 Kings Place', 131000.00, 'NR00000000000255', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000256', '2017-09-19', '2017-01-13 16:26:00', 4, 128500.00, 'nleathers33@sbwire.com', 'Gusikowski LLC', '99 Packers Pass', 131500.00, 'NR00000000000256', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000257', '2017-07-12', '2017-10-22 17:45:00', 1, 129000.00, 'hflewitt9o@unicef.org', 'Mitchell-Carroll and Von', '206 Warbler Court', 132000.00, 'NR00000000000257', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000258', '2017-11-14', '2017-07-05 21:20:00', 3, 129500.00, 'rpendergrast6z@hao123.com', 'Gerhold-Brown', '77978 Derek Drive', 132500.00, 'NR00000000000258', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000259', '2017-06-24', '2017-11-09 23:02:00', 4, 130000.00, 'lsparling73@fema.gov', 'Green-Ondricka and Kutch', '79 Eastwood Avenue', 133000.00, 'NR00000000000259', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000260', '2017-08-02', '2017-11-24 03:16:00', 3, 130500.00, 'bde64@smugmug.com', 'Hickle Group', '1 Thompson Parkway', 133500.00, 'NR00000000000260', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000261', '2017-07-21', '2017-09-19 10:18:00', 3, 131000.00, 'dyankin59@quantcast.com', 'Ondricka-Funk and Abernathy', '71 Lien Alley', 134000.00, 'NR00000000000261', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000262', '2017-01-07', '2017-07-09 21:17:00', 3, 131500.00, 'tbrettle52@wsj.com', 'Leuschke-Pouros and Daugherty', '66 Dennis Alley', 134500.00, 'NR00000000000262', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000263', '2017-04-09', '2017-03-06 12:08:00', 2, 132000.00, 'cpeizer5e@vk.com', 'Gaylord-Haley', '52965 Moose Hill', 135000.00, 'NR00000000000263', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000264', '2017-08-16', '2017-04-07 12:56:00', 1, 132500.00, 'fwadeson6r@discuz.net', 'Cruickshank LLC', '6684 3rd Lane', 135500.00, 'NR00000000000264', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000265', '2017-09-19', '2017-11-26 04:40:00', 3, 133000.00, 'ctipper8o@unblog.fr', 'Wolf-Metz and Langosh', '440 Northport Lane', 136000.00, 'NR00000000000265', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000266', '2017-07-17', '2017-10-27 02:48:00', 4, 133500.00, 'jbraikenridge1i@goo.gl', 'Hudson-Johnson', '04 Dunning Lane', 136500.00, 'NR00000000000266', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000267', '2017-04-05', '2017-03-08 01:58:00', 4, 134000.00, 'jdominici5c@wp.com', 'Schimmel-Nicolas', '404 Dixon Way', 137000.00, 'NR00000000000267', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000268', '2017-02-19', '2017-08-04 12:49:00', 2, 134500.00, 'mromeoo@weather.com', 'Senger-Nikolaus', '9 Montana Circle', 137500.00, 'NR00000000000268', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000269', '2017-08-14', '2017-04-20 13:54:00', 1, 135000.00, 'smilbourne9c@comcast.net', 'Gulgowski-Hartmann', '05 Luster Road', 138000.00, 'NR00000000000269', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000270', '2017-08-06', '2017-09-26 02:54:00', 2, 135500.00, 'cdoughty3o@i2i.jp', 'Kessler-Fisher and Murphy', '83 Cody Circle', 138500.00, 'NR00000000000270', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000271', '2017-09-25', '2017-03-06 17:56:00', 1, 136000.00, 'mramsdell78@paypal.com', 'Cummings-Pollich and Ankunding', '9 Walton Place', 139000.00, 'NR00000000000271', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000272', '2017-06-26', '2017-07-01 00:49:00', 3, 136500.00, 'sestcot7f@nbcnews.com', 'Bashirian-Ratke and Schmitt', '64941 Lawn Crossing', 139500.00, 'NR00000000000272', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000273', '2017-02-19', '2017-11-10 01:15:00', 4, 137000.00, 'ghamberston55@foxnews.com', 'Kuhn-Wehner', '0035 Maryland Park', 140000.00, 'NR00000000000273', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000274', '2017-01-04', '2017-01-20 12:29:00', 3, 137500.00, 'rjodrelle1c@topsy.com', 'Wilkinson Inc', '61628 Fuller Road', 140500.00, 'NR00000000000274', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000275', '2017-02-26', '2017-06-12 23:55:00', 3, 138000.00, 'dpartlett5f@wikia.com', 'Baumbach-Wiegand and Spencer', '2 Village Parkway', 141000.00, 'NR00000000000275', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000276', '2017-11-04', '2017-07-18 01:15:00', 4, 138500.00, 'mgallico88@zimbio.com', 'Turner-Kuphal and Dooley', '040 Waubesa Hill', 141500.00, 'NR00000000000276', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000277', '2017-02-01', '2017-07-25 20:25:00', 1, 139000.00, 'adeg@facebook.com', 'Hackett-Bogan and Price', '94526 Fairview Terrace', 142000.00, 'NR00000000000277', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000278', '2017-10-14', '2017-09-16 10:21:00', 2, 139500.00, 'fsyratt8h@cpanel.net', 'Hansen-Schulist and Corkery', '89 Lighthouse Bay Trail', 142500.00, 'NR00000000000278', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000279', '2017-09-19', '2017-09-09 03:13:00', 3, 140000.00, 'fsyratt8h@cpanel.net', 'Koelpin-Denesik', '8344 Kennedy Road', 143000.00, 'NR00000000000279', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000280', '2017-06-17', '2017-09-16 15:11:00', 4, 140500.00, 'vnewlove8g@yahoo.com', 'Torphy-Zboncak and Upton', '44 Cascade Trail', 143500.00, 'NR00000000000280', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000281', '2017-07-12', '2017-05-29 20:09:00', 4, 141000.00, 'kasprey6t@symantec.com', 'Boyle-Funk', '62082 Drewry Lane', 144000.00, 'NR00000000000281', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000282', '2017-08-28', '2017-11-14 10:03:00', 3, 141500.00, 'ralders58@tripod.com', 'Gerhold Inc', '4991 Westend Drive', 144500.00, 'NR00000000000282', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000283', '2017-08-07', '2017-05-12 18:17:00', 4, 142000.00, 'mjindrich7o@twitter.com', 'Heidenreich and Sons', '2 Hoffman Terrace', 145000.00, 'NR00000000000283', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000284', '2017-09-22', '2017-10-14 16:53:00', 2, 142500.00, 'cpittford71@photobucket.com', 'Schuster Group', '690 Dovetail Court', 145500.00, 'NR00000000000284', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000285', '2017-04-08', '2017-06-07 05:31:00', 3, 143000.00, 'ppidgen2w@paginegialle.it', 'Erdman-Bayer', '037 Judy Court', 146000.00, 'NR00000000000285', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000286', '2017-01-11', '2017-04-07 22:22:00', 4, 143500.00, 'yduffett4o@va.gov', 'Friesen-Brakus', '082 Kedzie Street', 146500.00, 'NR00000000000286', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000287', '2017-02-06', '2017-01-19 13:40:00', 1, 144000.00, 'lstiggles4b@ucoz.com', 'Medhurst-Walsh', '8 Sugar Way', 147000.00, 'NR00000000000287', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000288', '2017-05-29', '2017-06-19 19:38:00', 1, 144500.00, 'llawlings5l@china.com.cn', 'Johnston LLC', '38 Lakewood Court', 147500.00, 'NR00000000000288', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000289', '2017-05-27', '2017-03-04 23:26:00', 2, 145000.00, 'ppidgen2w@paginegialle.it', 'Runolfsson-O''Hara', '41710 Crownhardt Street', 148000.00, 'NR00000000000289', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000290', '2017-02-17', '2017-08-21 02:47:00', 4, 145500.00, 'ctembey2s@nhs.uk', 'Hilll-Stanton', '745 Lien Drive', 148500.00, 'NR00000000000290', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000291', '2017-07-15', '2017-01-29 16:33:00', 1, 146000.00, 'mtitherington10@amazon.co.jp', 'Mraz Inc', '686 Heath Way', 149000.00, 'NR00000000000291', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000292', '2017-03-16', '2017-09-07 18:13:00', 4, 146500.00, 'tschimon5@rambler.ru', 'VonRueden-Pacocha and Dibbert', '06 Mesta Place', 149500.00, 'NR00000000000292', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000293', '2017-04-11', '2017-08-16 03:39:00', 4, 147000.00, 'mcivitillob@google.ru', 'Bailey and Sons', '49 Old Gate Park', 150000.00, 'NR00000000000293', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000294', '2017-01-09', '2017-10-07 15:31:00', 1, 147500.00, 'eboddymead39@flavors.me', 'Lueilwitz-Bogan and Osinski', '357 Oakridge Way', 150500.00, 'NR00000000000294', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000295', '2017-07-03', '2017-03-11 11:57:00', 2, 148000.00, 'preddish7y@1und1.de', 'Dooley-Wisoky', '526 Longview Junction', 151000.00, 'NR00000000000295', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000296', '2017-05-03', '2017-10-15 01:54:00', 4, 148500.00, 'gboschmann1w@themeforest.net', 'Simonis-Grimes and Turcotte', '391 Bultman Crossing', 151500.00, 'NR00000000000296', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000297', '2017-11-04', '2017-08-14 03:50:00', 1, 149000.00, 'lgoggen4d@discovery.com', 'King-Spinka', '5 East Lane', 152000.00, 'NR00000000000297', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000298', '2017-08-08', '2017-11-30 16:50:00', 3, 149500.00, 'jluxford3x@statcounter.com', 'Carroll-Lubowitz', '8670 Blue Bill Park Place', 152500.00, 'NR00000000000298', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000299', '2017-11-17', '2017-07-05 11:20:00', 1, 150000.00, 'cmcgarrell6s@dropbox.com', 'Parisian-Maggio and Bins', '565 Colorado Junction', 153000.00, 'NR00000000000299', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000300', '2017-04-13', '2017-01-22 10:37:00', 3, 150500.00, 'dcollinson43@usnews.com', 'Ward Inc', '24 Amoth Court', 153500.00, 'NR00000000000300', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000301', '2017-10-24', '2017-05-16 13:44:00', 3, 151000.00, 'cdoughty3o@i2i.jp', 'Kreiger-Deckow and Paucek', '29 Meadow Valley Alley', 154000.00, 'NR00000000000301', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000302', '2017-06-26', '2017-10-14 20:05:00', 3, 151500.00, 'gwhitworth30@slate.com', 'Schulist and Sons', '549 Rusk Junction', 154500.00, 'NR00000000000302', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000303', '2017-04-07', '2017-08-06 11:09:00', 2, 152000.00, 'rkinnin4r@odnoklassniki.ru', 'Grant Inc', '011 Susan Avenue', 155000.00, 'NR00000000000303', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000304', '2017-11-06', '2017-03-08 03:21:00', 1, 152500.00, 'dtredinnick6b@163.com', 'Larson-Bode and Spencer', '05729 Aberg Junction', 155500.00, 'NR00000000000304', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000305', '2017-11-19', '2017-03-01 00:28:00', 3, 153000.00, 'sgarric27@google.com', 'Gusikowski LLC', '73 Green Ridge Trail', 156000.00, 'NR00000000000305', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000306', '2017-05-23', '2017-08-11 19:37:00', 1, 153500.00, 'lfeasey6i@godaddy.com', 'Mitchell-Carroll and Von', '2 Springs Pass', 156500.00, 'NR00000000000306', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000307', '2017-02-19', '2017-01-03 16:36:00', 1, 154000.00, 'ekelleni@jugem.jp', 'Gerhold-Brown', '88 Blue Bill Park Junction', 157000.00, 'NR00000000000307', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000308', '2017-02-02', '2017-02-27 20:03:00', 4, 154500.00, 'vedgcumbe5h@prweb.com', 'Green-Ondricka and Kutch', '408 Cherokee Lane', 157500.00, 'NR00000000000308', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000309', '2017-11-18', '2017-11-14 10:47:00', 3, 155000.00, 'akiltie81@edublogs.org', 'Hickle Group', '7 Norway Maple Park', 158000.00, 'NR00000000000309', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000310', '2017-04-05', '2017-06-07 09:30:00', 2, 155500.00, 'dcollister85@mashable.com', 'Ondricka-Funk and Abernathy', '11912 Vera Alley', 158500.00, 'NR00000000000310', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000311', '2017-09-19', '2017-04-04 03:55:00', 3, 156000.00, 'mdyball1n@netlog.com', 'Leuschke-Pouros and Daugherty', '7 Springs Point', 159000.00, 'NR00000000000311', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000312', '2017-10-27', '2017-04-16 04:48:00', 2, 156500.00, 'rdiggins29@storify.com', 'Gaylord-Haley', '5 Laurel Terrace', 159500.00, 'NR00000000000312', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000313', '2017-04-28', '2017-11-20 23:50:00', 1, 157000.00, 'tbeecroft48@squarespace.com', 'Cruickshank LLC', '51 Kings Circle', 160000.00, 'NR00000000000313', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000314', '2017-05-10', '2017-01-28 11:33:00', 4, 157500.00, 'rmachen22@businessinsider.com', 'Wolf-Metz and Langosh', '275 Corscot Place', 160500.00, 'NR00000000000314', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000315', '2017-01-23', '2017-01-24 03:23:00', 4, 158000.00, 'dterrey2x@bloglines.com', 'Hudson-Johnson', '4 Tennessee Parkway', 161000.00, 'NR00000000000315', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000316', '2017-08-28', '2017-02-22 20:17:00', 1, 158500.00, 'ngagin3r@amazon.co.uk', 'Schimmel-Nicolas', '90 Mcbride Pass', 161500.00, 'NR00000000000316', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000317', '2017-07-07', '2017-04-18 03:39:00', 2, 159000.00, 'cpittford71@photobucket.com', 'Senger-Nikolaus', '24 High Crossing Junction', 162000.00, 'NR00000000000317', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000318', '2017-01-30', '2017-05-12 22:17:00', 2, 159500.00, 'sbendik83@independent.co.uk', 'Gulgowski-Hartmann', '4 Walton Pass', 162500.00, 'NR00000000000318', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000319', '2017-06-27', '2017-10-04 10:04:00', 3, 160000.00, 'jbarron2u@4shared.com', 'Kessler-Fisher and Murphy', '1560 Jackson Parkway', 163000.00, 'NR00000000000319', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000320', '2017-08-11', '2017-06-21 05:03:00', 1, 160500.00, 'hbatyw@dion.ne.jp', 'Cummings-Pollich and Ankunding', '2260 Graceland Lane', 163500.00, 'NR00000000000320', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000321', '2017-04-03', '2017-01-17 18:42:00', 4, 161000.00, 'mtitherington10@amazon.co.jp', 'Bashirian-Ratke and Schmitt', '50284 Lotheville Drive', 164000.00, 'NR00000000000321', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000322', '2017-11-03', '2017-04-20 07:02:00', 3, 161500.00, 'vedgcumbe5h@prweb.com', 'Kuhn-Wehner', '026 Anderson Circle', 164500.00, 'NR00000000000322', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000323', '2017-03-15', '2017-03-13 19:28:00', 1, 162000.00, 'sklemke3t@lycos.com', 'Wilkinson Inc', '750 Victoria Junction', 165000.00, 'NR00000000000323', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000324', '2017-08-25', '2017-03-01 18:06:00', 2, 162500.00, 'tbeecroft48@squarespace.com', 'Baumbach-Wiegand and Spencer', '49850 Corscot Drive', 165500.00, 'NR00000000000324', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000325', '2017-09-29', '2017-10-27 01:43:00', 2, 163000.00, 'smilbourne9c@comcast.net', 'Turner-Kuphal and Dooley', '66 Ramsey Trail', 166000.00, 'NR00000000000325', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000326', '2017-09-27', '2017-09-11 01:48:00', 2, 163500.00, 'mtitherington10@amazon.co.jp', 'Hackett-Bogan and Price', '11 Burrows Lane', 166500.00, 'NR00000000000326', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000327', '2017-05-28', '2017-11-18 14:05:00', 1, 164000.00, 'bstrafen8u@tinyurl.com', 'Hansen-Schulist and Corkery', '00713 Westport Junction', 167000.00, 'NR00000000000327', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000328', '2017-05-11', '2017-09-08 20:35:00', 3, 164500.00, 'ejochens2g@ihg.com', 'Koelpin-Denesik', '9 Monica Circle', 167500.00, 'NR00000000000328', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000329', '2017-04-05', '2017-10-29 13:04:00', 4, 165000.00, 'flapish4s@indiatimes.com', 'Torphy-Zboncak and Upton', '66274 Hansons Point', 168000.00, 'NR00000000000329', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000330', '2017-07-17', '2017-07-18 04:41:00', 4, 165500.00, 'ejochens2g@ihg.com', 'Boyle-Funk', '80497 Northview Plaza', 168500.00, 'NR00000000000330', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000331', '2017-02-27', '2017-07-17 03:06:00', 2, 166000.00, 'jdwight8w@wikia.com', 'Gerhold Inc', '53 Spohn Trail', 169000.00, 'NR00000000000331', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000332', '2017-03-17', '2017-05-21 16:15:00', 3, 166500.00, 'jpawlata98@phoca.cz', 'Heidenreich and Sons', '4652 Stone Corner Avenue', 169500.00, 'NR00000000000332', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000333', '2017-07-21', '2017-08-25 05:30:00', 1, 167000.00, 'cgoldston8v@nature.com', 'Schuster Group', '6392 Randy Crossing', 170000.00, 'NR00000000000333', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000334', '2017-09-29', '2017-02-25 12:49:00', 3, 167500.00, 'ctipper8o@unblog.fr', 'Erdman-Bayer', '69514 Forster Circle', 170500.00, 'NR00000000000334', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000335', '2017-08-05', '2017-02-13 23:16:00', 4, 168000.00, 'dizaks9e@qq.com', 'Friesen-Brakus', '1573 Briar Crest Parkway', 171000.00, 'NR00000000000335', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000336', '2017-06-21', '2017-10-14 08:49:00', 3, 168500.00, 'lbrewettc@prnewswire.com', 'Medhurst-Walsh', '82 Miller Street', 171500.00, 'NR00000000000336', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000337', '2017-05-29', '2017-04-15 01:06:00', 1, 169000.00, 'nbaiden3i@cam.ac.uk', 'Johnston LLC', '3743 Kipling Drive', 172000.00, 'NR00000000000337', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000338', '2017-05-13', '2017-03-17 20:48:00', 3, 169500.00, 'mromeoo@weather.com', 'Runolfsson-O''Hara', '8 Glacier Hill Junction', 172500.00, 'NR00000000000338', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000339', '2017-08-12', '2017-02-14 09:49:00', 3, 170000.00, 'fwasson54@goo.ne.jp', 'Hilll-Stanton', '78 Banding Circle', 173000.00, 'NR00000000000339', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000340', '2017-07-26', '2017-05-16 08:52:00', 4, 170500.00, 'pmease26@dell.com', 'Mraz Inc', '37147 Sundown Circle', 173500.00, 'NR00000000000340', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000341', '2017-02-04', '2017-04-23 14:14:00', 1, 171000.00, 'dterrey2x@bloglines.com', 'VonRueden-Pacocha and Dibbert', '54 Eastwood Parkway', 174000.00, 'NR00000000000341', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000342', '2017-09-29', '2017-06-26 22:59:00', 4, 171500.00, 'hbatyw@dion.ne.jp', 'Bailey and Sons', '756 Hanson Hill', 174500.00, 'NR00000000000342', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000343', '2017-11-05', '2017-07-24 21:43:00', 4, 172000.00, 'otamblyn5b@arstechnica.com', 'Lueilwitz-Bogan and Osinski', '2 Continental Trail', 175000.00, 'NR00000000000343', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000344', '2017-11-25', '2017-09-04 02:00:00', 1, 172500.00, 'mhavercroft4j@redcross.org', 'Dooley-Wisoky', '6 Lakeland Crossing', 175500.00, 'NR00000000000344', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000345', '2017-05-23', '2017-09-19 02:36:00', 4, 173000.00, 'ngagin3r@amazon.co.uk', 'Simonis-Grimes and Turcotte', '3 Dunning Place', 176000.00, 'NR00000000000345', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000346', '2017-11-07', '2017-07-30 09:58:00', 3, 173500.00, 'mgoodsal7l@virginia.edu', 'King-Spinka', '56 Chive Parkway', 176500.00, 'NR00000000000346', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000347', '2017-03-14', '2017-07-24 10:19:00', 4, 174000.00, 'efloodgate1r@stanford.edu', 'Carroll-Lubowitz', '5556 Golf View Center', 177000.00, 'NR00000000000347', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000348', '2017-02-04', '2017-05-27 04:35:00', 1, 174500.00, 'mwadley1e@fema.gov', 'Parisian-Maggio and Bins', '6 Menomonie Alley', 177500.00, 'NR00000000000348', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000349', '2017-01-27', '2017-08-24 17:15:00', 3, 175000.00, 'fwasson54@goo.ne.jp', 'Rowe-Dicki and Conroy', '46356 Summer Ridge Way', 178000.00, 'NR00000000000349', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000350', '2017-02-03', '2017-10-15 22:03:00', 1, 175500.00, 'vianni53@csmonitor.com', 'Pfeffer-Rohan and Fadel', '23 Dahle Pass', 178500.00, 'NR00000000000350', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000351', '2017-03-13', '2017-07-01 12:36:00', 4, 176000.00, 'dmcauslene4z@amazon.com', 'Nienow and Sons', '230 Farragut Avenue', 179000.00, 'NR00000000000351', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000352', '2017-11-25', '2017-10-09 09:27:00', 1, 176500.00, 'nhubbucks2q@census.gov', 'Ratke LLC', '3 Oneill Way', 179500.00, 'NR00000000000352', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000353', '2017-03-11', '2017-01-19 02:34:00', 3, 177000.00, 'hcaesar80@sina.com.cn', 'Yost Group', '57 Sage Park', 180000.00, 'NR00000000000353', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000354', '2017-08-16', '2017-02-25 14:21:00', 1, 177500.00, 'ktonsley9b@nytimes.com', 'Kiehn-Steuber', '16879 Clemons Parkway', 180500.00, 'NR00000000000354', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000355', '2017-05-24', '2017-09-08 03:18:00', 1, 178000.00, 'efloodgate1r@stanford.edu', 'Kshlerin-Heaney and Mills', '21894 Sunfield Place', 181000.00, 'NR00000000000355', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000356', '2017-09-19', '2017-01-13 16:26:00', 1, 178500.00, 'tdjurkovic5r@livejournal.com', 'Bogisich and Sons', '22367 Warner Parkway', 181500.00, 'NR00000000000356', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000357', '2017-07-12', '2017-10-22 17:45:00', 2, 179000.00, 'abury56@tmall.com', 'Abshire-Veum and Stiedemann', '6198 Maple Wood Avenue', 182000.00, 'NR00000000000357', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000358', '2017-11-14', '2017-07-05 21:20:00', 2, 179500.00, 'lgoggen4d@discovery.com', 'Kris Group', '00 Nevada Street', 182500.00, 'NR00000000000358', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000359', '2017-06-24', '2017-11-09 23:02:00', 2, 180000.00, 'zgellier8n@a8.net', 'Konopelski-Lehner and Moore', '0729 Myrtle Circle', 183000.00, 'NR00000000000359', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000360', '2017-08-02', '2017-11-24 03:16:00', 4, 180500.00, 'amcatamney34@toplist.cz', 'Vandervort LLC', '67 Eliot Plaza', 183500.00, 'NR00000000000360', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000361', '2017-07-21', '2017-09-19 10:18:00', 3, 181000.00, 'cschellig95@google.co.jp', 'McGlynn-Aufderhar', '05452 Toban Street', 184000.00, 'NR00000000000361', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000362', '2017-01-07', '2017-07-09 21:17:00', 3, 181500.00, 'rcullenp@amazon.co.uk', 'Williamson-Harber and Russel', '139 Montana Terrace', 184500.00, 'NR00000000000362', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000363', '2017-04-09', '2017-03-06 12:08:00', 2, 182000.00, 'mcivitillob@google.ru', 'Raynor Inc', '99239 Mccormick Terrace', 185000.00, 'NR00000000000363', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000364', '2017-08-16', '2017-04-07 12:56:00', 2, 182500.00, 'gboschmann1w@themeforest.net', 'Gleichner Group', '02 Manufacturers Terrace', 185500.00, 'NR00000000000364', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000365', '2017-09-19', '2017-11-26 04:40:00', 3, 183000.00, 'ppearmaina@nps.gov', 'Steuber and Sons', '9 Dottie Point', 186000.00, 'NR00000000000365', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000366', '2017-07-17', '2017-10-27 02:48:00', 4, 183500.00, 'ywestrip6h@pen.io', 'Zulauf-Waelchi', '70502 Dunning Point', 186500.00, 'NR00000000000366', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000367', '2017-04-05', '2017-03-08 01:58:00', 2, 184000.00, 'mferrelli18@vkontakte.ru', 'Ebert-Brekke and Romaguera', '749 Thierer Way', 187000.00, 'NR00000000000367', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000368', '2017-02-19', '2017-08-04 12:49:00', 4, 184500.00, 'kmohammed42@plala.or.jp', 'Zemlak Group', '0013 Daystar Park', 187500.00, 'NR00000000000368', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000369', '2017-08-14', '2017-04-20 13:54:00', 1, 185000.00, 'bstrafen8u@tinyurl.com', 'Labadie-Ortiz and Bradtke', '76450 Hintze Hill', 188000.00, 'NR00000000000369', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000370', '2017-08-06', '2017-09-26 02:54:00', 2, 185500.00, 'sbendik83@independent.co.uk', 'Baumbach-Koepp and Ritchie', '85487 Marcy Lane', 188500.00, 'NR00000000000370', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000371', '2017-09-25', '2017-03-06 17:56:00', 1, 186000.00, 'dspuner3w@nature.com', 'Rath Inc', '16 North Junction', 189000.00, 'NR00000000000371', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000372', '2017-06-26', '2017-07-01 00:49:00', 4, 186500.00, 'dmcauslene4z@amazon.com', 'Dibbert-Batz and Fahey', '9 Old Shore Road', 189500.00, 'NR00000000000372', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000373', '2017-02-19', '2017-11-10 01:15:00', 2, 187000.00, 'enevek@devhub.com', 'Jacobson-Kunde', '0 Springview Crossing', 190000.00, 'NR00000000000373', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000374', '2017-01-04', '2017-01-20 12:29:00', 1, 187500.00, 'mpumfretts@berkeley.edu', 'Mertz LLC', '216 Stone Corner Alley', 190500.00, 'NR00000000000374', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000375', '2017-02-26', '2017-06-12 23:55:00', 3, 188000.00, 'agilhool6f@addtoany.com', 'Gorczany-Hilll and Halvorson', '2704 Rigney Court', 191000.00, 'NR00000000000375', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000376', '2017-11-04', '2017-07-18 01:15:00', 2, 188500.00, 'rliversage9f@icio.us', 'Kuphal-Bosco and Tremblay', '310 Duke Street', 191500.00, 'NR00000000000376', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000377', '2017-02-01', '2017-07-25 20:25:00', 2, 189000.00, 'dizaks9e@qq.com', 'Kreiger-Leannon and Maggio', '1235 Shopko Junction', 192000.00, 'NR00000000000377', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000378', '2017-10-14', '2017-09-16 10:21:00', 3, 189500.00, 'mhache2j@typepad.com', 'Keeling-Streich', '59 Bluejay Center', 192500.00, 'NR00000000000378', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000379', '2017-09-19', '2017-09-09 03:13:00', 3, 190000.00, 'dollivierre4l@statcounter.com', 'Emard Inc', '97945 Dexter Center', 193000.00, 'NR00000000000379', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000380', '2017-06-17', '2017-09-16 15:11:00', 4, 190500.00, 'ncaro0@guardian.co.uk', 'Hagenes-Lubowitz', '7 Burrows Drive', 193500.00, 'NR00000000000380', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000381', '2017-07-12', '2017-05-29 20:09:00', 3, 191000.00, 'dpartlett5f@wikia.com', 'Greenholt-Willms and Stehr', '31202 Fordem Drive', 194000.00, 'NR00000000000381', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000382', '2017-08-28', '2017-11-14 10:03:00', 2, 191500.00, 'ccallendar8m@xing.com', 'Powlowski and Sons', '844 Myrtle Center', 194500.00, 'NR00000000000382', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000383', '2017-08-07', '2017-05-12 18:17:00', 3, 192000.00, 'likringillh@wordpress.com', 'Stamm Group', '405 Green Court', 195000.00, 'NR00000000000383', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000384', '2017-09-22', '2017-10-14 16:53:00', 1, 192500.00, 'dizaks9e@qq.com', 'Kreiger-Ward and D''Amore', '9 Moose Hill', 195500.00, 'NR00000000000384', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000385', '2017-04-08', '2017-06-07 05:31:00', 4, 193000.00, 'dollivierre4l@statcounter.com', 'Johns-Ward and Veum', '06216 Haas Alley', 196000.00, 'NR00000000000385', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000386', '2017-01-11', '2017-04-07 22:22:00', 3, 193500.00, 'tfulleylove7q@nps.gov', 'Crona Inc', '12413 Valley Edge Way', 196500.00, 'NR00000000000386', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000387', '2017-02-06', '2017-01-19 13:40:00', 1, 194000.00, 'ozettlerq@washingtonpost.com', 'Kreiger-Torp', '26876 New Castle Park', 197000.00, 'NR00000000000387', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000388', '2017-05-29', '2017-06-19 19:38:00', 2, 194500.00, 'yelger5o@trellian.com', 'Sipes LLC', '1 Fuller Drive', 197500.00, 'NR00000000000388', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000389', '2017-05-27', '2017-03-04 23:26:00', 1, 195000.00, 'hsiley4m@msu.edu', 'Lindgren-Cartwright and Emard', '79202 Maywood Place', 198000.00, 'NR00000000000389', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000390', '2017-02-17', '2017-08-21 02:47:00', 4, 195500.00, 'nhubbucks2q@census.gov', 'Homenick-Treutel and Kuhlman', '48 Pawling Point', 198500.00, 'NR00000000000390', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000391', '2017-07-15', '2017-01-29 16:33:00', 4, 196000.00, 'gshilliday69@creativecommons.org', 'Christiansen-Mitchell and Morissette', '52 Green Park', 199000.00, 'NR00000000000391', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000392', '2017-03-16', '2017-09-07 18:13:00', 4, 196500.00, 'tcolquete3c@goodreads.com', 'Nader-Pagac and Buckridge', '603 School Alley', 199500.00, 'NR00000000000392', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000393', '2017-04-11', '2017-08-16 03:39:00', 2, 197000.00, 'jluxford3x@statcounter.com', 'Hansen-Mosciski and Swaniawski', '44 Emmet Court', 200000.00, 'NR00000000000393', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000394', '2017-01-09', '2017-10-07 15:31:00', 4, 197500.00, 'rmaybey5m@pbs.org', 'Braun-Oberbrunner', '0 Waywood Pass', 200500.00, 'NR00000000000394', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000395', '2017-07-03', '2017-03-11 11:57:00', 3, 198000.00, 'sestcot7f@nbcnews.com', 'Abernathy-Grady', '5711 Messerschmidt Parkway', 201000.00, 'NR00000000000395', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000396', '2017-05-03', '2017-10-15 01:54:00', 3, 198500.00, 'atrickeyv@yale.edu', 'Lemke-Nienow and Stroman', '3595 Grasskamp Junction', 201500.00, 'NR00000000000396', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000397', '2017-11-04', '2017-08-14 03:50:00', 1, 199000.00, 'sjurczak3j@moonfruit.com', 'O''Kon Inc', '25422 Comanche Alley', 202000.00, 'NR00000000000397', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000398', '2017-08-08', '2017-11-30 16:50:00', 3, 199500.00, 'rcrangle9p@cdc.gov', 'Tromp-Gleason', '8854 Memorial Point', 202500.00, 'NR00000000000398', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000399', '2017-11-17', '2017-07-05 11:20:00', 1, 200000.00, 'mhavercroft4j@redcross.org', 'McDermott-Berge', '861 Hayes Center', 203000.00, 'NR00000000000399', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000400', '2017-04-13', '2017-01-22 10:37:00', 2, 200500.00, 'bbilston60@wunderground.com', 'McDermott-Berge', '410 Fallview Alley', 203500.00, 'NR00000000000400', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000401', '2017-10-24', '2017-05-16 13:44:00', 4, 201000.00, 'doveralln@biglobe.ne.jp', 'Ward Inc', '23 Loeprich Pass', 204000.00, 'NR00000000000401', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000402', '2017-06-26', '2017-10-14 20:05:00', 4, 201500.00, 'mpierson4h@goo.gl', 'Kreiger-Deckow and Paucek', '7 Farragut Junction', 204500.00, 'NR00000000000402', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000403', '2017-04-07', '2017-08-06 11:09:00', 4, 202000.00, 'amerrall3g@apple.com', 'Schulist and Sons', '3739 Hermina Place', 205000.00, 'NR00000000000403', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000404', '2017-11-06', '2017-03-08 03:21:00', 3, 202500.00, 'ghoonahan90@salon.com', 'Grant Inc', '38 Grasskamp Park', 205500.00, 'NR00000000000404', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000405', '2017-11-19', '2017-03-01 00:28:00', 2, 203000.00, 'ghooban2l@cisco.com', 'Larson-Bode and Spencer', '0192 Arapahoe Lane', 206000.00, 'NR00000000000405', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000406', '2017-05-23', '2017-08-11 19:37:00', 1, 203500.00, 'jmustarde92@hp.com', 'Gusikowski LLC', '806 International Pass', 206500.00, 'NR00000000000406', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000407', '2017-02-19', '2017-01-03 16:36:00', 1, 204000.00, 'kparidge17@senate.gov', 'Mitchell-Carroll and Von', '32 Dunning Court', 207000.00, 'NR00000000000407', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000408', '2017-02-02', '2017-02-27 20:03:00', 1, 204500.00, 'wgent3n@pcworld.com', 'Gerhold-Brown', '377 Thackeray Hill', 207500.00, 'NR00000000000408', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000409', '2017-11-18', '2017-11-14 10:47:00', 3, 205000.00, 'amerrall3g@apple.com', 'Green-Ondricka and Kutch', '7 Kedzie Road', 208000.00, 'NR00000000000409', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000410', '2017-04-05', '2017-06-07 09:30:00', 4, 205500.00, 'abramez@squidoo.com', 'Hickle Group', '97 Hanover Point', 208500.00, 'NR00000000000410', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000411', '2017-09-19', '2017-04-04 03:55:00', 1, 206000.00, 'ilerego5p@github.io', 'Ondricka-Funk and Abernathy', '24 Oxford Park', 209000.00, 'NR00000000000411', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000412', '2017-10-27', '2017-04-16 04:48:00', 2, 206500.00, 'ralders58@tripod.com', 'Leuschke-Pouros and Daugherty', '5862 Emmet Avenue', 209500.00, 'NR00000000000412', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000413', '2017-04-28', '2017-11-20 23:50:00', 1, 207000.00, 'mhavercroft4j@redcross.org', 'Gaylord-Haley', '2 Canary Trail', 210000.00, 'NR00000000000413', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000414', '2017-05-10', '2017-01-28 11:33:00', 4, 207500.00, 'enevek@devhub.com', 'Cruickshank LLC', '2248 Bowman Parkway', 210500.00, 'NR00000000000414', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000415', '2017-01-23', '2017-01-24 03:23:00', 3, 208000.00, 'amcatamney34@toplist.cz', 'Wolf-Metz and Langosh', '9 La Follette Plaza', 211000.00, 'NR00000000000415', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000416', '2017-08-28', '2017-02-22 20:17:00', 1, 208500.00, 'cdoughty3o@i2i.jp', 'Hudson-Johnson', '42181 Bartelt Court', 211500.00, 'NR00000000000416', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000417', '2017-07-07', '2017-04-18 03:39:00', 3, 209000.00, 'cmalzard2f@acquirethisname.com', 'Schimmel-Nicolas', '2280 Sullivan Terrace', 212000.00, 'NR00000000000417', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000418', '2017-01-30', '2017-05-12 22:17:00', 1, 209500.00, 'aginnaly4i@state.gov', 'Senger-Nikolaus', '56 Jay Place', 212500.00, 'NR00000000000418', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000419', '2017-06-27', '2017-10-04 10:04:00', 2, 210000.00, 'rkinnin4r@odnoklassniki.ru', 'Gulgowski-Hartmann', '01668 Eggendart Road', 213000.00, 'NR00000000000419', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000420', '2017-08-11', '2017-06-21 05:03:00', 4, 210500.00, 'bcourtois94@ucla.edu', 'Kessler-Fisher and Murphy', '71596 Crowley Terrace', 213500.00, 'NR00000000000420', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000421', '2017-04-03', '2017-01-17 18:42:00', 2, 211000.00, 'zgellier8n@a8.net', 'Cummings-Pollich and Ankunding', '4 Pond Circle', 214000.00, 'NR00000000000421', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000422', '2017-11-03', '2017-04-20 07:02:00', 3, 211500.00, 'blampen4v@linkedin.com', 'Bashirian-Ratke and Schmitt', '47 Nobel Place', 214500.00, 'NR00000000000422', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000423', '2017-03-15', '2017-03-13 19:28:00', 4, 212000.00, 'ngaudin5x@furl.net', 'Kuhn-Wehner', '48650 Hooker Terrace', 215000.00, 'NR00000000000423', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000424', '2017-08-25', '2017-03-01 18:06:00', 3, 212500.00, 'sspohr35@symantec.com', 'Wilkinson Inc', '97 Saint Paul Road', 215500.00, 'NR00000000000424', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000425', '2017-09-29', '2017-10-27 01:43:00', 4, 213000.00, 'singman1v@example.com', 'Baumbach-Wiegand and Spencer', '3 East Lane', 216000.00, 'NR00000000000425', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000426', '2017-09-27', '2017-09-11 01:48:00', 3, 213500.00, 'cjanaud1d@virginia.edu', 'Turner-Kuphal and Dooley', '31208 Farmco Place', 216500.00, 'NR00000000000426', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000427', '2017-05-28', '2017-11-18 14:05:00', 3, 214000.00, 'tbrettle52@wsj.com', 'Hackett-Bogan and Price', '1701 Independence Trail', 217000.00, 'NR00000000000427', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000428', '2017-05-11', '2017-09-08 20:35:00', 1, 214500.00, 'bstrafen8u@tinyurl.com', 'Hansen-Schulist and Corkery', '80 Moland Park', 217500.00, 'NR00000000000428', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000429', '2017-04-05', '2017-10-29 13:04:00', 3, 215000.00, 'bandryunin7p@cyberchimps.com', 'Koelpin-Denesik', '0 Thackeray Way', 218000.00, 'NR00000000000429', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000430', '2017-07-17', '2017-07-18 04:41:00', 3, 215500.00, 'locannan2y@archive.org', 'Torphy-Zboncak and Upton', '93 Tennyson Trail', 218500.00, 'NR00000000000430', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000431', '2017-02-27', '2017-07-17 03:06:00', 3, 216000.00, 'hsiley4m@msu.edu', 'Boyle-Funk', '05 Daystar Court', 219000.00, 'NR00000000000431', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000432', '2017-03-17', '2017-05-21 16:15:00', 2, 216500.00, 'ctrigg8q@sun.com', 'Gerhold Inc', '4 Village Green Alley', 219500.00, 'NR00000000000432', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000433', '2017-07-21', '2017-08-25 05:30:00', 2, 217000.00, 'acumberpatch7w@about.me', 'Heidenreich and Sons', '80344 Meadow Ridge Avenue', 220000.00, 'NR00000000000433', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000434', '2017-09-29', '2017-02-25 12:49:00', 4, 217500.00, 'cround3b@kickstarter.com', 'Schuster Group', '80 Bashford Crossing', 220500.00, 'NR00000000000434', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000435', '2017-08-05', '2017-02-13 23:16:00', 3, 218000.00, 'aginnaly4i@state.gov', 'Erdman-Bayer', '8812 Gerald Road', 221000.00, 'NR00000000000435', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000436', '2017-06-21', '2017-10-14 08:49:00', 3, 218500.00, 'mgilleon8y@bing.com', 'Friesen-Brakus', '14 Calypso Trail', 221500.00, 'NR00000000000436', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000437', '2017-05-29', '2017-04-15 01:06:00', 2, 219000.00, 'cgoldston8v@nature.com', 'Medhurst-Walsh', '5 Jana Court', 222000.00, 'NR00000000000437', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000438', '2017-05-13', '2017-03-17 20:48:00', 3, 219500.00, 'rjosselsohn3d@reverbnation.com', 'Johnston LLC', '3 Haas Road', 222500.00, 'NR00000000000438', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000439', '2017-08-12', '2017-02-14 09:49:00', 1, 220000.00, 'ttourmell2d@dailymail.co.uk', 'Runolfsson-O''Hara', '683 Doe Crossing Pass', 223000.00, 'NR00000000000439', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000440', '2017-07-26', '2017-05-16 08:52:00', 3, 220500.00, 'mferrelli18@vkontakte.ru', 'Hilll-Stanton', '05162 Stuart Parkway', 223500.00, 'NR00000000000440', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000441', '2017-02-04', '2017-04-23 14:14:00', 3, 221000.00, 'dnottingam2t@marketwatch.com', 'Mraz Inc', '26246 Scofield Center', 224000.00, 'NR00000000000441', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000442', '2017-09-29', '2017-06-26 22:59:00', 1, 221500.00, 'mchillingworth7a@themeforest.net', 'VonRueden-Pacocha and Dibbert', '33 Nevada Alley', 224500.00, 'NR00000000000442', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000443', '2017-11-05', '2017-07-24 21:43:00', 4, 222000.00, 'kmowsley2b@cyberchimps.com', 'Bailey and Sons', '65222 Veith Avenue', 225000.00, 'NR00000000000443', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000444', '2017-11-25', '2017-09-04 02:00:00', 3, 222500.00, 'nwagen8@dailymotion.com', 'Lueilwitz-Bogan and Osinski', '3 Trailsway Place', 225500.00, 'NR00000000000444', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000445', '2017-05-23', '2017-09-19 02:36:00', 2, 223000.00, 'vgorham8i@wikipedia.org', 'Dooley-Wisoky', '2340 Florence Court', 226000.00, 'NR00000000000445', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000446', '2017-11-07', '2017-07-30 09:58:00', 1, 223500.00, 'kparidge17@senate.gov', 'Simonis-Grimes and Turcotte', '64 Dottie Center', 226500.00, 'NR00000000000446', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000447', '2017-03-14', '2017-07-24 10:19:00', 3, 224000.00, 'sestcot7f@nbcnews.com', 'King-Spinka', '732 High Crossing Park', 227000.00, 'NR00000000000447', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000448', '2017-02-04', '2017-05-27 04:35:00', 2, 224500.00, 'broskams9n@hud.gov', 'Carroll-Lubowitz', '2731 Canary Road', 227500.00, 'NR00000000000448', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000449', '2017-01-27', '2017-08-24 17:15:00', 4, 225000.00, 'nrigmond3l@google.ca', 'Parisian-Maggio and Bins', '490 Stoughton Alley', 228000.00, 'NR00000000000449', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000450', '2017-02-03', '2017-10-15 22:03:00', 3, 225500.00, 'dspuner3w@nature.com', 'Ward Inc', '494 Logan Junction', 228500.00, 'NR00000000000450', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000451', '2017-03-13', '2017-07-01 12:36:00', 1, 226000.00, 'cschellig95@google.co.jp', 'Kreiger-Deckow and Paucek', '326 Bashford Pass', 229000.00, 'NR00000000000451', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000452', '2017-11-25', '2017-10-09 09:27:00', 3, 226500.00, 'slattos12@usnews.com', 'Schulist and Sons', '3810 Southridge Lane', 229500.00, 'NR00000000000452', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000453', '2017-03-11', '2017-01-19 02:34:00', 3, 227000.00, 'mde2p@census.gov', 'Grant Inc', '181 Springs Street', 230000.00, 'NR00000000000453', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000454', '2017-08-16', '2017-02-25 14:21:00', 4, 227500.00, 'stait9@goo.ne.jp', 'Larson-Bode and Spencer', '0 Kinsman Street', 230500.00, 'NR00000000000454', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000455', '2017-05-24', '2017-09-08 03:18:00', 2, 228000.00, 'hcaistor91@mtv.com', 'Gusikowski LLC', '553 Graceland Hill', 231000.00, 'NR00000000000455', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000456', '2017-09-19', '2017-01-13 16:26:00', 2, 228500.00, 'scornelius9m@freewebs.com', 'Mitchell-Carroll and Von', '2963 Loeprich Court', 231500.00, 'NR00000000000456', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000457', '2017-07-12', '2017-10-22 17:45:00', 1, 229000.00, 'amcgilvray5i@soup.io', 'Gerhold-Brown', '68326 Swallow Park', 232000.00, 'NR00000000000457', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000458', '2017-11-14', '2017-07-05 21:20:00', 1, 229500.00, 'dwitt7x@forbes.com', 'Green-Ondricka and Kutch', '93741 Pankratz Street', 232500.00, 'NR00000000000458', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000459', '2017-06-24', '2017-11-09 23:02:00', 1, 230000.00, 'showes4c@opera.com', 'Hickle Group', '28431 Magdeline Trail', 233000.00, 'NR00000000000459', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000460', '2017-08-02', '2017-11-24 03:16:00', 1, 230500.00, 'apicopp4k@uol.com.br', 'Ondricka-Funk and Abernathy', '33466 Reinke Hill', 233500.00, 'NR00000000000460', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000461', '2017-07-21', '2017-09-19 10:18:00', 3, 231000.00, 'aschmidt3u@wikia.com', 'Leuschke-Pouros and Daugherty', '58 Buena Vista Circle', 234000.00, 'NR00000000000461', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000462', '2017-01-07', '2017-07-09 21:17:00', 1, 231500.00, 'cborborough7k@twitter.com', 'Gaylord-Haley', '5368 Corscot Street', 234500.00, 'NR00000000000462', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000463', '2017-04-09', '2017-03-06 12:08:00', 2, 232000.00, 'slattos12@usnews.com', 'Cruickshank LLC', '3 Goodland Alley', 235000.00, 'NR00000000000463', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000464', '2017-08-16', '2017-04-07 12:56:00', 2, 232500.00, 'tlacroutz5n@icio.us', 'Wolf-Metz and Langosh', '00 Eggendart Lane', 235500.00, 'NR00000000000464', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000465', '2017-09-19', '2017-11-26 04:40:00', 3, 233000.00, 'ktonsley9b@nytimes.com', 'Hudson-Johnson', '3298 Longview Parkway', 236000.00, 'NR00000000000465', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000466', '2017-07-17', '2017-10-27 02:48:00', 3, 233500.00, 'qstonestreet93@hatena.ne.jp', 'Schimmel-Nicolas', '24285 Larry Court', 236500.00, 'NR00000000000466', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000467', '2017-04-05', '2017-03-08 01:58:00', 1, 234000.00, 'dgrenter1g@booking.com', 'Senger-Nikolaus', '8706 Cottonwood Hill', 237000.00, 'NR00000000000467', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000468', '2017-02-19', '2017-08-04 12:49:00', 4, 234500.00, 'iscrogges6y@samsung.com', 'Gulgowski-Hartmann', '71436 Clarendon Drive', 237500.00, 'NR00000000000468', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000469', '2017-08-14', '2017-04-20 13:54:00', 4, 235000.00, 'croston6c@amazon.de', 'Kessler-Fisher and Murphy', '7660 Sommers Pass', 238000.00, 'NR00000000000469', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000470', '2017-08-06', '2017-09-26 02:54:00', 1, 235500.00, 'jdwight8w@wikia.com', 'Cummings-Pollich and Ankunding', '7 Warbler Circle', 238500.00, 'NR00000000000470', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000471', '2017-09-25', '2017-03-06 17:56:00', 3, 236000.00, 'tdjurkovic5r@livejournal.com', 'Bashirian-Ratke and Schmitt', '6 Anniversary Center', 239000.00, 'NR00000000000471', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000472', '2017-06-26', '2017-07-01 00:49:00', 4, 236500.00, 'kmohammed42@plala.or.jp', 'Kuhn-Wehner', '8825 Merchant Circle', 239500.00, 'NR00000000000472', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000473', '2017-02-19', '2017-11-10 01:15:00', 3, 237000.00, 'ishord7g@bloglines.com', 'Wilkinson Inc', '144 Scofield Drive', 240000.00, 'NR00000000000473', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000474', '2017-01-04', '2017-01-20 12:29:00', 3, 237500.00, 'singman1v@example.com', 'Baumbach-Wiegand and Spencer', '30 Milwaukee Lane', 240500.00, 'NR00000000000474', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000475', '2017-02-26', '2017-06-12 23:55:00', 4, 238000.00, 'troyal49@deliciousdays.com', 'Turner-Kuphal and Dooley', '7296 Butternut Way', 241000.00, 'NR00000000000475', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000476', '2017-11-04', '2017-07-18 01:15:00', 3, 238500.00, 'dpartlett5f@wikia.com', 'Hackett-Bogan and Price', '39028 Beilfuss Center', 241500.00, 'NR00000000000476', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000477', '2017-02-01', '2017-07-25 20:25:00', 4, 239000.00, 'mhastewell5k@ask.com', 'Hansen-Schulist and Corkery', '8 Clyde Gallagher Avenue', 242000.00, 'NR00000000000477', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000478', '2017-10-14', '2017-09-16 10:21:00', 1, 239500.00, 'aluetkemeyers70@miibeian.gov.cn', 'Koelpin-Denesik', '43 Eastlawn Point', 242500.00, 'NR00000000000478', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000479', '2017-09-19', '2017-09-09 03:13:00', 2, 240000.00, 'acereceres4w@alexa.com', 'Torphy-Zboncak and Upton', '99032 Lotheville Junction', 243000.00, 'NR00000000000479', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000480', '2017-06-17', '2017-09-16 15:11:00', 4, 240500.00, 'yduffett4o@va.gov', 'Boyle-Funk', '81 Glendale Parkway', 243500.00, 'NR00000000000480', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000481', '2017-07-12', '2017-05-29 20:09:00', 2, 241000.00, 'fwadeson6r@discuz.net', 'Gerhold Inc', '3 Cody Center', 244000.00, 'NR00000000000481', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000482', '2017-08-28', '2017-11-14 10:03:00', 1, 241500.00, 'sklemke3t@lycos.com', 'Heidenreich and Sons', '1342 Park Meadow Avenue', 244500.00, 'NR00000000000482', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000483', '2017-08-07', '2017-05-12 18:17:00', 4, 242000.00, 'awalczak1f@mit.edu', 'Schuster Group', '5786 Hoard Street', 245000.00, 'NR00000000000483', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000484', '2017-09-22', '2017-10-14 16:53:00', 2, 242500.00, 'streasure7s@godaddy.com', 'Erdman-Bayer', '0 Welch Avenue', 245500.00, 'NR00000000000484', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000485', '2017-04-08', '2017-06-07 05:31:00', 1, 243000.00, 'kmowsley2b@cyberchimps.com', 'Friesen-Brakus', '275 Stuart Junction', 246000.00, 'NR00000000000485', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000486', '2017-01-11', '2017-04-07 22:22:00', 4, 243500.00, 'mmotten8x@senate.gov', 'Medhurst-Walsh', '67 Eggendart Pass', 246500.00, 'NR00000000000486', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000487', '2017-02-06', '2017-01-19 13:40:00', 4, 244000.00, 'cjanaud1d@virginia.edu', 'Johnston LLC', '3923 Kings Circle', 247000.00, 'NR00000000000487', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000488', '2017-05-29', '2017-06-19 19:38:00', 3, 244500.00, 'rjodrelle1c@topsy.com', 'Runolfsson-O''Hara', '366 Stuart Point', 247500.00, 'NR00000000000488', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000489', '2017-05-27', '2017-03-04 23:26:00', 2, 245000.00, 'dollivierre4l@statcounter.com', 'Hilll-Stanton', '4 Loeprich Plaza', 248000.00, 'NR00000000000489', 'WAHANA');
INSERT INTO transaksi_shipped VALUES ('V000000490', '2017-02-17', '2017-08-21 02:47:00', 4, 245500.00, 'psummerlie8s@edublogs.org', 'Mraz Inc', '480 Sloan Lane', 248500.00, 'NR00000000000490', 'J&T EXPRESS');
INSERT INTO transaksi_shipped VALUES ('V000000491', '2017-07-15', '2017-01-29 16:33:00', 4, 246000.00, 'pbittlestone5u@auda.org.au', 'VonRueden-Pacocha and Dibbert', '04 Rockefeller Park', 249000.00, 'NR00000000000491', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000492', '2017-03-16', '2017-09-07 18:13:00', 3, 246500.00, 'obernaldez4e@mediafire.com', 'Bailey and Sons', '09461 Memorial Plaza', 249500.00, 'NR00000000000492', 'LION PARCEL');
INSERT INTO transaksi_shipped VALUES ('V000000493', '2017-04-11', '2017-08-16 03:39:00', 2, 247000.00, 'sgarric27@google.com', 'Lueilwitz-Bogan and Osinski', '8 Porter Terrace', 250000.00, 'NR00000000000493', 'PAHALA');
INSERT INTO transaksi_shipped VALUES ('V000000494', '2017-01-09', '2017-10-07 15:31:00', 2, 247500.00, 'rspeer63@topsy.com', 'Dooley-Wisoky', '78397 Eagle Crest Drive', 250500.00, 'NR00000000000494', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000495', '2017-07-03', '2017-03-11 11:57:00', 3, 248000.00, 'htreagust4a@homestead.com', 'Simonis-Grimes and Turcotte', '28 Gateway Trail', 251000.00, 'NR00000000000495', 'JNE YES');
INSERT INTO transaksi_shipped VALUES ('V000000496', '2017-05-03', '2017-10-15 01:54:00', 4, 248500.00, 'nstenett1q@buzzfeed.com', 'King-Spinka', '79 Bobwhite Way', 251500.00, 'NR00000000000496', 'JNE OKE');
INSERT INTO transaksi_shipped VALUES ('V000000497', '2017-11-04', '2017-08-14 03:50:00', 4, 249000.00, 'acumberpatch7w@about.me', 'Carroll-Lubowitz', '3108 Vernon Point', 252000.00, 'NR00000000000497', 'TIKI REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000498', '2017-08-08', '2017-11-30 16:50:00', 2, 249500.00, 'aorsd@cbc.ca', 'Parisian-Maggio and Bins', '5 Golf Course Crossing', 252500.00, 'NR00000000000498', 'POS PAKET BIASA');
INSERT INTO transaksi_shipped VALUES ('V000000499', '2017-11-17', '2017-07-05 11:20:00', 2, 250000.00, 'vedgcumbe5h@prweb.com', 'Rowe-Dicki and Conroy', '57348 Westridge Terrace', 253000.00, 'NR00000000000499', 'POS PAKET KILAT');
INSERT INTO transaksi_shipped VALUES ('V000000500', '2017-05-20', '2017-05-20 22:51:00', 1, 10100.00, 'user@basdat.com', 'Ward Inc', 'mana aja boleh :3', 8000.00, 'NR00000000000501', 'JNE REGULER');
INSERT INTO transaksi_shipped VALUES ('V000000501', '2017-05-20', '2017-05-20 23:07:00', 1, 137000.00, 'user@basdat.com', 'Ward Inc', 'mana aja deh !', 5000.00, 'NR00000000000502', 'JNE OKE');


--
-- Data for Name: ulasan; Type: TABLE DATA; Schema: tokokeren; Owner: postgres
--

INSERT INTO ulasan VALUES ('gkidwell3k@kickstarter.com', 'KLJ00237', '2017-03-06', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('nleathers33@sbwire.com', 'KLJ00187', '2017-11-22', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('hflewitt9o@unicef.org', 'KLJ00188', '2017-07-29', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('rpendergrast6z@hao123.com', 'KLJ00037', '2017-02-08', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('dyankin59@quantcast.com', 'KLJ00055', '2017-08-22', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('cpeizer5e@vk.com', 'KLJ00149', '2017-02-04', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('adeg@facebook.com', 'KLJ00237', '2017-09-19', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('yduffett4o@va.gov', 'KLJ00225', '2017-09-06', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('mtitherington10@amazon.co.jp', 'KLJ00230', '2017-03-25', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('mcivitillob@google.ru', 'KLJ00053', '2017-06-28', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('eboddymead39@flavors.me', 'KLJ00063', '2017-03-23', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('preddish7y@1und1.de', 'KLJ00058', '2017-05-10', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('lgoggen4d@discovery.com', 'KLJ00059', '2017-09-19', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('jluxford3x@statcounter.com', 'KLJ00080', '2017-12-11', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('dcollinson43@usnews.com', 'KLJ00109', '2017-01-30', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('rkinnin4r@odnoklassniki.ru', 'KLJ00112', '2017-03-13', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('sgarric27@google.com', 'KLJ00092', '2017-01-29', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('lfeasey6i@godaddy.com', 'KLJ00246', '2017-02-19', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('rdiggins29@storify.com', 'KLJ00160', '2017-09-14', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('rmachen22@businessinsider.com', 'KLJ00021', '2017-09-21', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('dterrey2x@bloglines.com', 'KLJ00235', '2017-09-20', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('jbarron2u@4shared.com', 'KLJ00197', '2017-02-08', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('cgoldston8v@nature.com', 'KLJ00220', '2017-10-22', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('dterrey2x@bloglines.com', 'KLJ00231', '2017-10-06', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('hbatyw@dion.ne.jp', 'KLJ00220', '2017-06-28', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('mwadley1e@fema.gov', 'KLJ00137', '2017-06-14', 1, 'Kualitas sangat buruk');
INSERT INTO ulasan VALUES ('mromeoo@weather.com', 'KLJ00077', '2017-05-18', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('sestcot7f@nbcnews.com', 'KLJ00061', '2017-03-09', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('rjodrelle1c@topsy.com', 'KLJ00240', '2017-04-15', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('mgallico88@zimbio.com', 'KLJ00075', '2017-03-28', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('cpittford71@photobucket.com', 'KLJ00095', '2017-01-07', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('cmcgarrell6s@dropbox.com', 'KLJ00005', '2017-08-22', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('vedgcumbe5h@prweb.com', 'KLJ00071', '2017-07-05', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('mdyball1n@netlog.com', 'KLJ00054', '2017-01-02', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('hbatyw@dion.ne.jp', 'KLJ00049', '2017-12-05', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('vedgcumbe5h@prweb.com', 'KLJ00066', '2017-02-13', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('ejochens2g@ihg.com', 'KLJ00050', '2017-01-23', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('jdwight8w@wikia.com', 'KLJ00249', '2017-08-13', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('ctipper8o@unblog.fr', 'KLJ00032', '2017-12-06', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('mromeoo@weather.com', 'KLJ00193', '2017-05-23', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('efloodgate1r@stanford.edu', 'KLJ00026', '2017-11-22', 2, 'Kualitas buruk');
INSERT INTO ulasan VALUES ('doveralln@biglobe.ne.jp', 'KLJ00012', '2017-03-13', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('bde64@smugmug.com', 'KLJ00181', '2017-08-18', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('tbrettle52@wsj.com', 'KLJ00119', '2017-03-21', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('jdominici5c@wp.com', 'KLJ00181', '2017-01-23', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('ghamberston55@foxnews.com', 'KLJ00128', '2017-04-30', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('vnewlove8g@yahoo.com', 'KLJ00060', '2017-11-10', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('mjindrich7o@twitter.com', 'KLJ00059', '2017-09-27', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('ppidgen2w@paginegialle.it', 'KLJ00038', '2017-07-17', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('ctembey2s@nhs.uk', 'KLJ00045', '2017-02-03', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('gwhitworth30@slate.com', 'KLJ00217', '2017-11-25', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('dtredinnick6b@163.com', 'KLJ00036', '2017-05-01', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('akiltie81@edublogs.org', 'KLJ00170', '2017-05-21', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('tbeecroft48@squarespace.com', 'KLJ00245', '2017-10-30', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('sbendik83@independent.co.uk', 'KLJ00121', '2017-11-25', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('mtitherington10@amazon.co.jp', 'KLJ00173', '2017-11-02', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('sklemke3t@lycos.com', 'KLJ00017', '2017-05-28', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('tbeecroft48@squarespace.com', 'KLJ00054', '2017-04-13', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('smilbourne9c@comcast.net', 'KLJ00041', '2017-03-01', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('bstrafen8u@tinyurl.com', 'KLJ00230', '2017-11-22', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('dizaks9e@qq.com', 'KLJ00022', '2017-04-30', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('fwasson54@goo.ne.jp', 'KLJ00047', '2017-07-06', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('pmease26@dell.com', 'KLJ00246', '2017-04-17', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('otamblyn5b@arstechnica.com', 'KLJ00006', '2017-04-03', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('mhavercroft4j@redcross.org', 'KLJ00022', '2017-09-27', 3, 'Lumayan lahhh');
INSERT INTO ulasan VALUES ('sklemke3t@lycos.com', 'KLJ00066', '2017-08-14', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('lsparling73@fema.gov', 'KLJ00064', '2017-05-11', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('cdoughty3o@i2i.jp', 'KLJ00211', '2017-04-15', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('mramsdell78@paypal.com', 'KLJ00031', '2017-01-09', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('dpartlett5f@wikia.com', 'KLJ00177', '2017-10-15', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('fsyratt8h@cpanel.net', 'KLJ00181', '2017-04-15', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('fsyratt8h@cpanel.net', 'KLJ00082', '2017-08-22', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('lstiggles4b@ucoz.com', 'KLJ00231', '2017-01-29', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('llawlings5l@china.com.cn', 'KLJ00021', '2017-07-24', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('gboschmann1w@themeforest.net', 'KLJ00076', '2017-05-15', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('dcollister85@mashable.com', 'KLJ00082', '2017-09-06', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('ngagin3r@amazon.co.uk', 'KLJ00243', '2017-12-09', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('cpittford71@photobucket.com', 'KLJ00015', '2017-04-01', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('mtitherington10@amazon.co.jp', 'KLJ00164', '2017-09-06', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('flapish4s@indiatimes.com', 'KLJ00144', '2017-09-07', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('ngagin3r@amazon.co.uk', 'KLJ00239', '2017-07-09', 4, 'Barang oke, memuaskan');
INSERT INTO ulasan VALUES ('ebromhead50@tinypic.com', 'KLJ00157', '2017-09-16', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('opetigrew6p@devhub.com', 'KLJ00056', '2017-06-06', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('fsyratt8h@cpanel.net', 'KLJ00045', '2017-10-09', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('fwadeson6r@discuz.net', 'KLJ00220', '2017-07-19', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('ctipper8o@unblog.fr', 'KLJ00149', '2017-08-05', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('jbraikenridge1i@goo.gl', 'KLJ00069', '2017-04-25', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('smilbourne9c@comcast.net', 'KLJ00197', '2017-09-20', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('kasprey6t@symantec.com', 'KLJ00081', '2017-11-24', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('ralders58@tripod.com', 'KLJ00151', '2017-05-09', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('ppidgen2w@paginegialle.it', 'KLJ00093', '2017-06-02', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('tschimon5@rambler.ru', 'KLJ00049', '2017-06-28', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('cdoughty3o@i2i.jp', 'KLJ00012', '2017-09-18', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('ekelleni@jugem.jp', 'KLJ00049', '2017-06-16', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('ejochens2g@ihg.com', 'KLJ00178', '2017-11-29', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('jpawlata98@phoca.cz', 'KLJ00162', '2017-05-05', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('lbrewettc@prnewswire.com', 'KLJ00161', '2017-04-04', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('nbaiden3i@cam.ac.uk', 'KLJ00066', '2017-03-28', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('mgoodsal7l@virginia.edu', 'KLJ00085', '2017-09-19', 5, 'Barang sangat oke, sangat memuaskan');
INSERT INTO ulasan VALUES ('fwasson54@goo.ne.jp', 'KLJ00127', '2017-04-08', 5, 'Barang sangat oke, sangat memuaskan');


--
-- Name: jasa_kirim jasa_kirim_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY jasa_kirim
    ADD CONSTRAINT jasa_kirim_pkey PRIMARY KEY (nama);


--
-- Name: kategori_utama kategori_utama_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY kategori_utama
    ADD CONSTRAINT kategori_utama_pkey PRIMARY KEY (kode);


--
-- Name: keranjang_belanja keranjang_belanja_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY keranjang_belanja
    ADD CONSTRAINT keranjang_belanja_pkey PRIMARY KEY (pembeli, kode_produk);


--
-- Name: komentar_diskusi komentar_diskusi_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY komentar_diskusi
    ADD CONSTRAINT komentar_diskusi_pkey PRIMARY KEY (pengirim, penerima, waktu);


--
-- Name: list_item list_item_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY list_item
    ADD CONSTRAINT list_item_pkey PRIMARY KEY (no_invoice, kode_produk);


--
-- Name: pelanggan pelanggan_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY pelanggan
    ADD CONSTRAINT pelanggan_pkey PRIMARY KEY (email);


--
-- Name: pengguna pengguna_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY pengguna
    ADD CONSTRAINT pengguna_pkey PRIMARY KEY (email);


--
-- Name: produk produk_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY produk
    ADD CONSTRAINT produk_pkey PRIMARY KEY (kode_produk);


--
-- Name: produk_pulsa produk_pulsa_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY produk_pulsa
    ADD CONSTRAINT produk_pulsa_pkey PRIMARY KEY (kode_produk);


--
-- Name: promo promo_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY promo
    ADD CONSTRAINT promo_pkey PRIMARY KEY (id);


--
-- Name: promo_produk promo_produk_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY promo_produk
    ADD CONSTRAINT promo_produk_pkey PRIMARY KEY (id_promo, kode_produk);


--
-- Name: shipped_produk shipped_produk_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY shipped_produk
    ADD CONSTRAINT shipped_produk_pkey PRIMARY KEY (kode_produk);


--
-- Name: sub_kategori sub_kategori_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY sub_kategori
    ADD CONSTRAINT sub_kategori_pkey PRIMARY KEY (kode);


--
-- Name: toko_jasa_kirim toko_jasa_kirim_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY toko_jasa_kirim
    ADD CONSTRAINT toko_jasa_kirim_pkey PRIMARY KEY (nama_toko, jasa_kirim);


--
-- Name: toko toko_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY toko
    ADD CONSTRAINT toko_pkey PRIMARY KEY (nama);


--
-- Name: transaksi_pulsa transaksi_pulsa_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY transaksi_pulsa
    ADD CONSTRAINT transaksi_pulsa_pkey PRIMARY KEY (no_invoice);


--
-- Name: transaksi_shipped transaksi_shipped_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY transaksi_shipped
    ADD CONSTRAINT transaksi_shipped_pkey PRIMARY KEY (no_invoice);


--
-- Name: ulasan ulasan_pkey; Type: CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY ulasan
    ADD CONSTRAINT ulasan_pkey PRIMARY KEY (email_pembeli, kode_produk);


--
-- Name: keranjang_belanja keranjang_belanja_kode_produk_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY keranjang_belanja
    ADD CONSTRAINT keranjang_belanja_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES shipped_produk(kode_produk);


--
-- Name: keranjang_belanja keranjang_belanja_pembeli_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY keranjang_belanja
    ADD CONSTRAINT keranjang_belanja_pembeli_fkey FOREIGN KEY (pembeli) REFERENCES pelanggan(email);


--
-- Name: komentar_diskusi komentar_diskusi_penerima_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY komentar_diskusi
    ADD CONSTRAINT komentar_diskusi_penerima_fkey FOREIGN KEY (penerima) REFERENCES pelanggan(email);


--
-- Name: komentar_diskusi komentar_diskusi_pengirim_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY komentar_diskusi
    ADD CONSTRAINT komentar_diskusi_pengirim_fkey FOREIGN KEY (pengirim) REFERENCES pelanggan(email);


--
-- Name: list_item list_item_kode_produk_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY list_item
    ADD CONSTRAINT list_item_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES shipped_produk(kode_produk);


--
-- Name: list_item list_item_no_invoice_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY list_item
    ADD CONSTRAINT list_item_no_invoice_fkey FOREIGN KEY (no_invoice) REFERENCES transaksi_shipped(no_invoice);


--
-- Name: pelanggan pelanggan_email_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY pelanggan
    ADD CONSTRAINT pelanggan_email_fkey FOREIGN KEY (email) REFERENCES pengguna(email);


--
-- Name: produk_pulsa produk_pulsa_kode_produk_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY produk_pulsa
    ADD CONSTRAINT produk_pulsa_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES produk(kode_produk);


--
-- Name: promo_produk promo_produk_id_promo_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY promo_produk
    ADD CONSTRAINT promo_produk_id_promo_fkey FOREIGN KEY (id_promo) REFERENCES promo(id);


--
-- Name: promo_produk promo_produk_kode_produk_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY promo_produk
    ADD CONSTRAINT promo_produk_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES produk(kode_produk);


--
-- Name: shipped_produk shipped_produk_kategori_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY shipped_produk
    ADD CONSTRAINT shipped_produk_kategori_fkey FOREIGN KEY (kategori) REFERENCES sub_kategori(kode);


--
-- Name: shipped_produk shipped_produk_kode_produk_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY shipped_produk
    ADD CONSTRAINT shipped_produk_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES produk(kode_produk);


--
-- Name: shipped_produk shipped_produk_nama_toko_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY shipped_produk
    ADD CONSTRAINT shipped_produk_nama_toko_fkey FOREIGN KEY (nama_toko) REFERENCES toko(nama);


--
-- Name: sub_kategori sub_kategori_kode_kategori_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY sub_kategori
    ADD CONSTRAINT sub_kategori_kode_kategori_fkey FOREIGN KEY (kode_kategori) REFERENCES kategori_utama(kode);


--
-- Name: toko toko_email_penjual_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY toko
    ADD CONSTRAINT toko_email_penjual_fkey FOREIGN KEY (email_penjual) REFERENCES pelanggan(email);


--
-- Name: toko_jasa_kirim toko_jasa_kirim_jasa_kirim_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY toko_jasa_kirim
    ADD CONSTRAINT toko_jasa_kirim_jasa_kirim_fkey FOREIGN KEY (jasa_kirim) REFERENCES jasa_kirim(nama);


--
-- Name: toko_jasa_kirim toko_jasa_kirim_nama_toko_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY toko_jasa_kirim
    ADD CONSTRAINT toko_jasa_kirim_nama_toko_fkey FOREIGN KEY (nama_toko) REFERENCES toko(nama);


--
-- Name: transaksi_pulsa transaksi_pulsa_email_pembeli_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY transaksi_pulsa
    ADD CONSTRAINT transaksi_pulsa_email_pembeli_fkey FOREIGN KEY (email_pembeli) REFERENCES pelanggan(email);


--
-- Name: transaksi_pulsa transaksi_pulsa_kode_produk_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY transaksi_pulsa
    ADD CONSTRAINT transaksi_pulsa_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES produk_pulsa(kode_produk);


--
-- Name: transaksi_shipped transaksi_shipped_email_pembeli_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY transaksi_shipped
    ADD CONSTRAINT transaksi_shipped_email_pembeli_fkey FOREIGN KEY (email_pembeli) REFERENCES pelanggan(email);


--
-- Name: transaksi_shipped transaksi_shipped_nama_toko_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY transaksi_shipped
    ADD CONSTRAINT transaksi_shipped_nama_toko_fkey FOREIGN KEY (nama_toko, nama_jasa_kirim) REFERENCES toko_jasa_kirim(nama_toko, jasa_kirim);


--
-- Name: ulasan ulasan_email_pembeli_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY ulasan
    ADD CONSTRAINT ulasan_email_pembeli_fkey FOREIGN KEY (email_pembeli) REFERENCES pelanggan(email);


--
-- Name: ulasan ulasan_kode_produk_fkey; Type: FK CONSTRAINT; Schema: tokokeren; Owner: postgres
--

ALTER TABLE ONLY ulasan
    ADD CONSTRAINT ulasan_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES shipped_produk(kode_produk);


--
-- PostgreSQL database dump complete
--

