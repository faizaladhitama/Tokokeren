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
 
	function logout() {
		unset($_SESSION['role']);
		header("location:Home.php");
	}
 
	function start() {
		unset($_SESSION['role']);
		header("location:Login.php");
	}
 
	function insertJasaKirim() {
		$conn = pg_connect("dbname=haryoparigroho user=postgres password=satudua12 port=5432");
		if (!$conn) {
		    die("Error in connection test: " . pg_last_error());
		} 

		$nama_jasa_kirim = $_POST['nama_jasa_kirim'];
		$lama_kirim = $_POST['lama_kirim'];
		$tarif_kirim = $_POST['tarif_kirim'];

		$sql = "INSERT INTO TOKOKEREN.JASA_KIRIM (nama,lama_kirim,tarif) VALUES ('$nama_jasa_kirim','$lama_kirim','$tarif_kirim')";

		if($result = pg_query($conn, $sql)) {
			$_SESSION['createServiceMessage'] = 'Delivery Service is successfully created';
		}

		pg_close($conn);
	}	

	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if($_POST['command'] === 'logout') {
			logout();
		} else if($_POST['command'] === 'start') {
			start();
		} else if($_POST['command'] === 'shoppingCart') {
			header("location:ShoppingCart.php");
		} else if($_POST['command'] === 'insertJasaKirim') {
			insertJasaKirim();
		}
	}
 
?>

<!DOCTYPE html>
<html>
<head>
	<title>Membuat Jasa Kirim</title>

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
		<h1 class="text-center">Membuat Jasa Kirim</h1>

		<form class="form-horizontal" method="POST" action="create_jasa_kirim.php">
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="nama">Nama:</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="nama" placeholder="Masukan nama jasa kirim" name="nama_jasa_kirim" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="lama_kirim">Lama Kirim:</label>
		    <div class="col-sm-10"> 
		      <input type="number" class="form-control" id="lama_kirim" placeholder="Masukan lama waktu pengiriman" name="lama_kirim" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="tarif">Tarif:</label>
		    <div class="col-sm-10"> 
		      <input type="number" class="form-control" id="tarif" placeholder="Masukan tarif pengiriman" name="tarif_kirim" required>
		    </div>
		  </div>		
		  <div class="form-group"> 
		    <div class="col-sm-offset-2 col-sm-10">
		      <input type="hidden" id="insert-jasakirim-command" name="command" value="insertJasaKirim">
			  <button type="submit" class="btn">Submit</button>
		    </div>
		  </div>
		</form>

		<?php
		if(isset($_SESSION["createServiceMessage"])){
			echo '
				<div class="alert alert-success">
				  <strong>Success!</strong>' . $_SESSION["createServiceMessage"] . '
				</div>
			';


			unset($_SESSION["createServiceMessage"]);
		}
		?>

	</div>

	<hr style="width: 80%; border-color:#EF0606">
	<footer>
	  <p class="text-center">Ari Tri Wibowo Yudasubrata - Faizal Adhitama Prabowo - Farizki Yazid - Haryo Parigroho</p>
	</footer>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>