<?php
	echo extension_loaded('pgsql') ? 'yes':'no';

	session_start();
	if($_SESSION['role'] != "admin"){
		header("Location:Home.php");
	}

	function logoutBtn(){
		if($_SESSION['role'] === "guest") {
		   echo 	'<form action="Home.php" method="post">
						<input type="hidden" id="update-command" name="command" value="start">
						<button id="logoutbtn" type="submit" class="btn">Login/SignUp</button></td></tr>
					</form>';
		} else {
			echo 	'<form action="Home.php" method="post">
						<input type="hidden" id="update-command" name="command" value="logout">
						<button id="logoutbtn" type="submit" class="btn">Log Out</button></td></tr>
					</form>';
		}
	}
 
	function kepala() {
		if($_SESSION['role'] === "admin") {
		   echo '<form action="Home.php" method="post">
					<input type="hidden" id="update-command" name="command" value="shoppingCart">
					<button type="submit" id="borrow" class="btn">Shopping Cart</button></td>
				</form>';
		} else if($_SESSION['role'] === "user") {
			echo '<form action="Home.php" method="post">
					<input type="hidden" id="update-command" name="command" value="shoppingCart">
					<button type="submit" class="btn">Shopping Cart</button></td>
				</form>';
		}
	}
 
	function logout() {
		unset($_SESSION['role']);
		header("location:Home.php");
	}
 
	function start() {
		unset($_SESSION['role']);
		header("location:Login.php");
	}
 
 	function insertPromo() {
 		$conn = pg_connect("dbname=haryoparigroho user=postgres password=satudua12 port=5432");
 		if (!$conn) {
		    die("Error in connection test: " . pg_last_error());
		} 

		$deskripsi_promo = $_POST['deskripsi_promo'];
		$periode_awal = $_POST['periode_awal'];
		$periode_akhir = $_POST['periode_akhir'];
		$kode_promo = $_POST['kode_promo'];
		$kategori = $_POST['kategori'];
		$sub_kategori = $_POST['sub_kategori'];

		$sql1 = "SELECT * fROM TOKOKEREN.PROMO ORDER BY ID DESC LIMIT 1";

		$last_record = pg_fetch_assoc(pg_query($conn, $sql1));

		$id_num = (int)substr($last_record["id"], 1) + 1;

		if ($id_num < 10) {
			$id = "R0000".(string)$id_num;
		} else if ($id_num < 100) {
			$id = "R000".(string)$id_num;
		} else if ($id_num < 1000) {
			$id = "R00".(string)$id_num;
		} else if ($id_num < 10000) {
			$id = "R0".(string)$id_num;
		} else {
			$id = "R".(string)$id_num;
		}

		if (strtotime($periode_akhir) > strtotime($periode_awal)) {

			$sql2 = "INSERT INTO TOKOKEREN.PROMO(id,deskripsi,periode_awal,periode_akhir,kode) VALUES ('$id','$deskripsi_promo','$periode_awal','$periode_akhir','$kode_promo')";
			$result = pg_query($conn, $sql2);

			$sql3 = "SELECT KODE_PRODUK FROM TOKOKEREN.SHIPPED_PRODUK WHERE KATEGORI = '$sub_kategori'";
			$result2 = pg_query($conn, $sql3);

			while ($row = pg_fetch_assoc($result2)) {
				$kode_produk = $row["kode_produk"];

				$sql4 = "INSERT INTO TOKOKEREN.PROMO_PRODUK(id_promo,kode_produk) VALUES ('$id','$kode_produk')";
				$result3 = pg_query($conn, $sql4);
			}
		}

		header("Location:Home.php");
		pg_close($conn);
 	}

 	function getAllKategori() {
 		$conn = pg_connect("dbname=haryoparigroho user=postgres password=satudua12 port=5432");
		if (!$conn) {
		    die("Error in connection test: " . pg_last_error());
		} 

 		$sql = "SELECT * FROM TOKOKEREN.KATEGORI_UTAMA";
 		$result = pg_query($conn, $sql);

 		if (!$result) {
		    die("Error in SQL query: " . pg_last_error());
		}

 		return $result;

 		pg_close($conn);
 	}
 
 	function getAllSubKategori() {
 		$conn = pg_connect("dbname=haryoparigroho user=postgres password=satudua12 port=5432");
		
		if (!$conn) {
		    die("Error in connection test: " . pg_last_error());
		} 

 		$sql = "SELECT * FROM TOKOKEREN.SUB_KATEGORI";
 		$result = pg_query($conn, $sql);

 		if (!$result) {
		    die("Error in SQL query: " . pg_last_error());
		}

 		return $result;

 		pg_close($conn);
 	}

	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if($_POST['command'] === 'logout') {
			logout();
		} else if($_POST['command'] === 'start') {
			start();
		} else if($_POST['command'] === 'shoppingCart') {
			header("location:ShoppingCart.php");
		} else if($_POST['command'] === 'insertPromo') {
			insertPromo();
		}
 	}
 
?>

<!DOCTYPE html>
<html>
<head>
	<title>Membuat Promo</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
 	
	<!-- css -->
 	<link rel="stylesheet" href="assets/css/home-css.css">
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top">
	  <div class="container">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	        <span class="sr-only">Toggle navigation</span>
	          <span class="icon-bar"></span>
	          <span class="icon-bar"></span>
	          <span class="icon-bar"></span>
	          </button>
	          <a style="padding-top:5px" class="navbar-brand" href="Home.php"> 
	          	<h5 id="logo">
	          		<img src = "assets/images/t.svg" style="max-height:17px"> 
	          		TokoKeren
	          	</h5>
	          </a>
	    </div>
	    <div id="navbar" class="navbar-collapse collapse">
	    	<a class="navbar-brand navbar-right" href="admin.php">
	      	<?php
	      		echo $_SESSION['id']." logged in as ".$_SESSION['role'];
	      	?>
	      	</a>	
	    	<?php
	    		logoutBtn();
	    	?>
	    </div><!--/.navbar-collapse -->
	  </div>
	</nav>
	<div class="container">
		<br> <br> <br>
		<h1 class="text-center">Membuat Promo</h1>

		<form class="form-horizontal" method="POST" action="create_promo.php">
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="deskripsi_promo">Deskripsi:</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="deskripsi_promo" placeholder="Masukan deskripsi promo" name="deskripsi_promo" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="awal">Periode Awal:</label>
		    <div class="col-sm-10"> 
		      <input type="date" class="form-control" id="awal" name="periode_awal" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="akhir">Periode Akhir:</label>
		    <div class="col-sm-10"> 
		      <input type="date" class="form-control" id="akhir" min="" name="periode_akhir" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="kode_promo">Kode Promo:</label>
		    <div class="col-sm-10"> 
		      <input type="text" class="form-control" id="kode_promo" placeholder="Masukan kode promo" name="kode_promo" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="kategori">Kategori:</label>
		    <div class="col-sm-10">
			  <select size="1" id="kategori" title="" name="kategori" class="form-control">
				    <option value="">-Pilih Kategori-</option>
				   
				    <?php
				    	$kategori = getAllKategori();
				    	while ($row = pg_fetch_assoc($kategori)) {
				    		echo '
				    			<option value="'.$row["kode"].'">'.$row["nama"].'</option>
				    		';
				    	}
				    ?>

			  </select>
		    </div>
		  </div>	
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="sub_kategori">Sub Kategori:</label>
		    <div class="sub col-sm-10">
			    <select size="1" id="sub_kategori" title="" name="sub_kategori" class="form-control">
			    	<option value="">-Pilih Sub Kategori-</option>
			    <?php
			    	$sub_kategori = getAllSubKategori();
			    	while ($row = pg_fetch_assoc($sub_kategori)) {
			    		echo '
			    			<option class="'.$row["kode_kategori"].'" value="'.$row["kode"].'">'.$row["nama"].'</option>
			    		';
			    	}
			    ?>
			    </select>

		    </div>
		  </div>  		
		  <div class="form-group"> 
		    <div class="col-sm-offset-2 col-sm-10">
		      <input type="hidden" id="insert-promo-command" name="command" value="insertPromo">
			  <button type="submit" class="btn">Submit</button>
		    </div>
		  </div>
		</form>

	</div>

	<hr style="width: 80%; border-color:#EF0606">
	<footer>
	  <p class="text-center">Ari Tri Wibowo Yudasubrata - Faizal Adhitama Prabowo - Farizki Yazid - Haryo Parigroho</p>
	</footer>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

	<script type="text/javascript" src="promo.js"></script>
</body>
</html>