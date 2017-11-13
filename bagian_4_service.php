<?php
	session_start();
	header("Content-Type: text/html; charset=ISO-8859-1");
	$command = "";
	if(isset($_POST['command'])){
		$command = $_POST['command'];

	}
	else if(isset($_GET['command'])){
		$command = $_GET['command'];
	}

	if($_SERVER['PHP_SELF'] == "/bagian_4/bagian_4_service.php"){
		if($_SERVER['REQUEST_METHOD'] == "POST" || ($_SERVER['REQUEST_METHOD'] =="GET" && count($_GET) > 0))
		{
		}
		else{
			header('HTTP/1.0 404 Not Found');
	    	echo "<h1>Error 404 Not Found</h1>";
	    	echo "The page that you have requested could not be found.";
			exit();
		}
	}
	switch ($command) {
		case 'check_ulas':
			$conn = connect_to_postgres();

			$kode_produk = $_POST["kode_produk"];
			$query = "SELECT COUNT(*) FROM tokokeren.ulasan where kode_produk='$kode_produk'";
			query_to_json($conn,$query,$query);

			break;
		case 'transaksi_daftar_produk':
			$conn = connect_to_postgres();

			$no_invoice = $_POST["no_invoice"];
			$query = "SELECT LI.kode_produk, nama AS \"Nama produk\", berat AS \"Berat\", kuantitas AS \"Kuantitas\", LI.harga AS \"Harga\", sub_total AS \"Sub total\" FROM tokokeren.list_item AS LI, tokokeren.produk AS P  WHERE LI.no_invoice = '$no_invoice' AND LI.kode_produk = P.kode_produk";
			
			$count_query = "SELECT COUNT(*) FROM tokokeren.list_item AS LI, tokokeren.produk AS P  WHERE LI.no_invoice = '$no_invoice' AND LI.kode_produk = P.kode_produk";
			
			query_to_json($conn, $query,$count_query);
			break;
		case 'checkout':
			$conn = connect_to_postgres();

			$email_pembeli = $_SESSION["email_pembeli"];
			$toko = $_SESSION["toko"];
			$query = "SELECT count(distinct no_resi) from tokokeren.transaksi_shipped";
			$result = pg_fetch_assoc(pg_query($conn, $query));
			$next_number = $result['count'];
			$no_resi = "NR00000000000" . ($next_number+1);
			$query = "SELECT count(distinct no_invoice) from tokokeren.list_item";
			$result = pg_fetch_assoc(pg_query($conn, $query));
			$next_number = $result['count'];
			$no_invoice = "V000000" . $next_number;
			$email_pembeli = $_SESSION['email_pembeli'];
			$query = "SELECT * from tokokeren.keranjang_belanja WHERE pembeli = '$email_pembeli'";
			$result = pg_query($conn, $query);
			if (!$result) {
			  echo "An error occurred.\n";
			  exit;
			}
			$condition = false;
			while($row = pg_fetch_row($result)){
				$kode_produk = $row[1];
				$berat = $row[2];
				$kuantitas = $row[3];
				$harga = $row[4];
				$sub_total = $row[5];
				$jasa_kirim = $_POST['jasa_kirim'];
				$alamat  = $_POST['alamat'];
				$query = "SELECT tarif from tokokeren.jasa_kirim WHERE nama = '$jasa_kirim'";
				$result = pg_query($conn, $query);
				$r = pg_fetch_row($result);
				$tarif = $r[0];
				$biaya_kirim = $berat*$tarif;
				$total_bayar = $sub_total+$biaya_kirim;
				$current_datetime = $_POST['datetime'];
				$current_date = $_POST['date'];
				
				$query = "INSERT INTO tokokeren.TRANSAKSI_SHIPPED (no_invoice,tanggal,waktu_bayar,status,total_bayar,email_pembeli,nama_toko,alamat_kirim,biaya_kirim,no_resi,nama_jasa_kirim) VALUES ('$no_invoice','$current_date','$current_datetime',1,$total_bayar,'$email_pembeli','$toko','$alamat',$tarif,'$no_resi','$jasa_kirim')";
				$result = pg_query($conn, $query);
				if (!$result) {
			  		echo "An error occurred.\n";
			  		exit;
				}

				$query = "INSERT INTO tokokeren.LIST_ITEM (no_invoice,kode_produk,berat,kuantitas,harga,sub_total) VALUES ('$no_invoice','$kode_produk',$berat,$kuantitas,$harga,$sub_total)";
				$result = pg_query($conn, $query);
				if (!$result) {
			  		echo "An error occurred.\n";
			  		exit;
				}
				$condition = true;
			}
			if($condition == true){
				$query = "DELETE FROM tokokeren.keranjang_belanja WHERE pembeli = '$email_pembeli' ";
				$result = pg_query($conn, $query);
			}
			break;
		case 'generate_transaction':
			$email_pembeli = $_SESSION['email_pembeli'];
			$conn = connect_to_postgres();

			if($_POST["product_type"] == "pulsa"){
				$query = "SELECT no_invoice AS \"No Invoice\", nama AS \"Nama Produk\", tanggal AS \"Tanggal\", status AS \"Status\", total_bayar AS \"Total Bayar\", nominal AS \"Nominal\", nomor AS \"Nomor\" FROM TOKOKEREN.TRANSAKSI_PULSA AS TP, TOKOKEREN.PRODUK AS P WHERE email_pembeli = '$email_pembeli' AND TP.kode_produk = P.kode_produk AND TP.total_bayar = P.harga";

				$count_query = "SELECT COUNT(*) FROM TOKOKEREN.TRANSAKSI_PULSA AS TP, TOKOKEREN.PRODUK AS P WHERE email_pembeli = '$email_pembeli' AND TP.kode_produk = P.kode_produk AND TP.total_bayar = P.harga";

				query_to_json($conn,$query,$count_query);
				break;
			}
			else if($_POST["product_type"] == "barang"){
				$query = "SELECT no_invoice AS \"No Invoice\", nama_toko AS \"Nama Toko\", tanggal AS \"Tanggal\", status AS \"Status\", total_bayar AS \"Total Bayar\", alamat_kirim AS \"Alamat Kirim\", biaya_kirim AS \"Biaya Kirim\", no_resi AS \"Nomor Resi\", nama_jasa_kirim AS \"Jasa Kirim\" FROM TOKOKEREN.TRANSAKSI_SHIPPED WHERE email_pembeli = '$email_pembeli'";

				$count_query = "SELECT COUNT(*) FROM TOKOKEREN.TRANSAKSI_SHIPPED WHERE email_pembeli = '$email_pembeli'";

				query_to_json($conn,$query,$count_query);
				break;
			}
		case 'generate_jasa_kirim_toko':
			$conn = connect_to_postgres();

			$toko = $_SESSION["toko"];
			$query = "SELECT jasa_kirim FROM tokokeren.toko_jasa_kirim WHERE nama_toko = '$toko'";

			$count_query = "SELECT COUNT(*) FROM tokokeren.toko_jasa_kirim WHERE nama_toko = '$toko'";

			query_to_json($conn,$query,$count_query);
			break;
		case 'generate_keranjang_belanja':
			$conn = connect_to_postgres();

			$email_pembeli = $_SESSION['email_pembeli'];
			$query = "SELECT KB.kode_produk AS \"Kode Produk\",P.nama AS \"Nama Produk\",berat AS \"Berat\",kuantitas AS \"Kuantitas\",P.harga AS \"Harga\",sub_total AS \"Sub total\" FROM tokokeren.KERANJANG_BELANJA AS KB, tokokeren.PRODUK AS P WHERE pembeli = '$email_pembeli' AND KB.kode_produk = P.kode_produk";

			$count_query = "SELECT COUNT(*) FROM tokokeren.KERANJANG_BELANJA AS KB, tokokeren.PRODUK AS P WHERE pembeli = '$email_pembeli' AND KB.kode_produk = P.kode_produk";
			
			query_to_json($conn,$query,$count_query);
			break;
		case 'insert_keranjang' :
			$conn = connect_to_postgres();

			$berat = $_POST['berat'];
			$kuantitas = $_POST['kuantitas'];
			$id_barang = $_POST['id_barang'];
			$harga = $_POST['harga'];
			$sub_total = $kuantitas*$harga;
			$email_pembeli = $_SESSION['email_pembeli'];

			$query = "INSERT INTO tokokeren.KERANJANG_BELANJA (pembeli,kode_produk,berat,kuantitas,harga,sub_total) VALUES ('$email_pembeli','$id_barang',$berat,$kuantitas,$harga,$sub_total)";

			$result = pg_query($conn, $query);
			break;
		case 'generate_tabel_daftar_shipped_product' :
			$conn = connect_to_postgres();

			$kategori = $_POST["kategori"];
			$toko = $_POST["toko"];
			$_SESSION["toko"] = $toko;
			$sub_kategori = $_POST["sub_kategori"];
			if($_POST["kategori"] != "null" && $_POST["sub_kategori"] == "null"){
				$query = "SELECT DISTINCT SP.kode_produk AS \"Kode produk\", P.nama AS \"Nama produk\",P.harga AS \"Harga\", P.deskripsi AS \"Deskripsi\", SP.is_asuransi AS \"Is_asuransi\", SP.stok AS \"Stok\", is_baru AS \"Is baru\", harga_grosir AS \"Harga grosir\" from tokokeren.shipped_produk AS SP, tokokeren.produk AS P, tokokeren.kategori_utama AS K, tokokeren.sub_kategori AS SK WHERE SP.kategori = SK.kode AND SP.kode_produk = P.kode_produk AND '$kategori' = K.nama AND SK.kode_kategori = K.kode AND SP.nama_toko = '$toko'";

				$count_query = "SELECT distinct COUNT(*) from tokokeren.shipped_produk AS SP, tokokeren.produk AS P, tokokeren.kategori_utama AS K, tokokeren.sub_kategori AS SK WHERE SP.kategori = SK.kode AND SP.kode_produk = P.kode_produk AND '$kategori' = K.nama AND SK.kode_kategori = K.kode AND SP.nama_toko = '$toko'";

				query_to_json($conn,$query,$count_query);
				break;
			}
			else if($_POST["sub_kategori"] != "null" && $_POST["kategori"] == "null"){
				$query = "SELECT SP.kode_produk AS \"Kode produk\", P.nama AS \"Nama produk\", P.harga AS \"Harga\", P.deskripsi AS \"Deskripsi\", SP.is_asuransi AS \"Is_asuransi\", SP.stok AS \"Stok\", SP.is_baru AS \"Is baru\", SP.harga_grosir AS \"Harga grosir\" from tokokeren.shipped_produk AS SP ,tokokeren.produk AS P, tokokeren.kategori_utama AS K, tokokeren.sub_kategori AS SK WHERE SP.kode_produk = P.kode_produk AND '$sub_kategori' = SK.nama AND SP.kategori = SK.kode AND SK.kode_kategori = K.kode AND SP.nama_toko = '$toko'";

				$count_query = "SELECT COUNT(*) from tokokeren.shipped_produk AS SP ,tokokeren.produk AS P, tokokeren.kategori_utama AS K, tokokeren.sub_kategori AS SK WHERE SP.kode_produk = P.kode_produk AND '$sub_kategori' = SK.nama AND SP.kategori = SK.kode AND SK.kode_kategori = K.kode AND SP.nama_toko = '$toko'";
				
				query_to_json($conn,$query,$count_query);
				break;
			}
			else if(($_POST["sub_kategori"] == "null" && $_POST["kategori"] == "null") || ($_POST["sub_kategori"] == "" && $_POST["kategori"] == "")){
				$query = "SELECT SP.kode_produk AS \"Kode produk\",nama AS \"Nama produk\",harga AS \"Harga\", deskripsi AS \"Deskripsi\", is_asuransi AS \"Is_asuransi\", stok AS \"Stok\", is_baru AS \"Is baru\", harga_grosir AS \"Harga grosir\" from tokokeren.shipped_produk AS SP ,tokokeren.produk AS P WHERE SP.kode_produk = P.kode_produk AND SP.nama_toko = '$toko'";

				$count_query = "SELECT COUNT(*) from tokokeren.shipped_produk AS SP ,tokokeren.produk AS P WHERE SP.kode_produk = P.kode_produk AND SP.nama_toko = '$toko'";

				query_to_json($conn,$query,$count_query);
				
				break;	
			}
			else{
				$query = "SELECT SP.kode_produk AS \"Kode produk\",P.nama AS \"Nama produk\",P.harga AS \"Harga\", P.deskripsi AS \"Deskripsi\", SP.is_asuransi AS \"Is_asuransi\", SP.stok AS \"Stok\", SP.is_baru AS \"Is baru\", SP.harga_grosir AS \"Harga grosir\" from tokokeren.shipped_produk AS SP ,tokokeren.produk AS P, tokokeren.kategori_utama AS K, tokokeren.sub_kategori AS SK WHERE SP.kode_produk = P.kode_produk AND '$sub_kategori' = SK.nama AND SK.kode_kategori = K.kode AND K.nama = '$kategori' AND SP.nama_toko = '$toko' AND SP.kategori = SK.kode";

				$count_query = "SELECT COUNT(*) from tokokeren.shipped_produk AS SP ,tokokeren.produk AS P, tokokeren.kategori_utama AS K, tokokeren.sub_kategori AS SK WHERE SP.kode_produk = P.kode_produk AND '$sub_kategori' = SK.nama AND SK.kode_kategori = K.kode AND K.nama = '$kategori' AND SP.nama_toko = '$toko' AND SP.kategori = SK.kode";

				query_to_json($conn,$query,$count_query);
				break;
			}
		case 'generate_sub_kategori' :
			$conn = connect_to_postgres();

			$kategori = $_POST['kategori'];

			$query = "SELECT SK.nama from tokokeren.sub_kategori AS SK,tokokeren.kategori_utama AS KU WHERE KU.nama = '$kategori' AND KU.kode =SK.kode_kategori";

			$count_query = "SELECT COUNT(*) from tokokeren.sub_kategori";

			query_to_json($conn,$query,$count_query);
			break;
		case 'generate_kategori' :
			$conn = connect_to_postgres();

			$query = "SELECT nama from tokokeren.kategori_utama";

			$count_query = "SELECT COUNT(*) from tokokeren.kategori_utama";
			
			query_to_json($conn,$query,$count_query);
			break;
		case 'buy_pulsa' :
			$conn = connect_to_postgres();
			
			$query = "Select count(*) from tokokeren.transaksi_pulsa";
			$result = pg_fetch_assoc(pg_query($conn, $query));
			$next_number = $result['count']+1;
			$no_invoice = "V00000" . $next_number;

			$current_date = $_POST['date'];
			$current_datetime = $_POST['datetime'];
			$status = $_POST['status'];
			$harga = $_POST['harga'];
			$nominal = $_POST['nominal'];
			$nomor = $_POST['nomor'];
			$kode_produk = $_POST['kode_produk'];
			$email_pembeli = $_SESSION['email_pembeli'];

			$query = "SELECT PP.kode_produk, harga, nominal FROM tokokeren.produk_pulsa AS PP, tokokeren.produk AS P WHERE PP.kode_produk = P.kode_produk AND PP.kode_produk = '$kode_produk'";
			$result = pg_fetch_assoc(pg_query($conn, $query));
			$harga = intval($result['harga']);
			$nominal = intval($result['nominal']);

			$query = "INSERT INTO tokokeren.TRANSAKSI_PULSA (no_invoice,tanggal,waktu_bayar,status,total_bayar,email_pembeli,nominal,nomor,kode_produk) VALUES ('$no_invoice','$current_date','$current_datetime',$status,$harga,'$email_pembeli',$nominal,'$nomor','$kode_produk')";

			$result = pg_query($conn, $query);
			break;
		case 'generate' :
			$conn = connect_to_postgres();
			if($_POST["product_type"] == "pulsa"){
				$query = "SELECT PP.kode_produk AS \"Kode produk\",nama AS \"Nama produk\",harga AS \"Harga\", deskripsi AS \"Deskripsi\", nominal AS \"Nominal\" from tokokeren.produk_pulsa AS PP ,tokokeren.produk AS P WHERE PP.kode_produk = P.kode_produk";

				$count_query = "SELECT COUNT(*) from tokokeren.produk_pulsa AS PP ,tokokeren.produk AS P WHERE PP.kode_produk = P.kode_produk";

				query_to_json($conn,$query,$count_query);
				break;
			}
			else if($_POST["product_type"] == "barang"){
				$query = "SELECT nama from tokokeren.toko";
				$count_query = "SELECT count(nama) from tokokeren.toko";

				query_to_json($conn,$query,$count_query);
				break;
			}
		default:
			break;
	}

	function connect_to_postgres(){
		$conn = pg_connect("host=localhost port=5432 dbname=faizaladhitama user=postgres password=root");
		if(!$conn){
			echo "An error occured.\n";
			exit;
		}
		return $conn;
	}

	function query_to_json($conn,$query,$count_query){
		$result = pg_query($conn, $query);
		if (!$result) {
		  echo "An error occurred.\n";
		  exit;
		}
		$temp = array();
		$key = [];
		$i = 0;
		$x = pg_fetch_assoc($result);

		$res = pg_query($conn,$count_query);
		$assoc_array = pg_fetch_row($res);

		while ($i < pg_num_fields($result))
		{
			$key[] = pg_field_name($result, $i);
			$i = $i + 1;
		}
		$array_temp = array();
		for($i = 0; $i < count($key);$i++){
			$array_temp["key_$i"] = $key[$i];
		}
		$temp[] = $array_temp;
		if($assoc_array[0] > 0){
			$temp[] = $x;	
		}
		while($row = pg_fetch_assoc($result)){
			$temp[] = $row;
		} 
		echo json_encode($temp);
	}
?>