<?php
	session_start();
	if($_SESSION['role'] == "user"){
		header("location:user.php");
	}elseif($_SESSION['role'] != "admin"){
		header("location:Home.php");
	}

	function logoutBtn(){
		if($_SESSION['role'] === "guest") {
		   echo '<form action="admin.php" method="post">
						<input type="hidden" id="update-command" name="command" value="start">
						<button id="logoutbtn" type="submit" class="btn">Login/SignUp</button></td></tr>
					</form>';
		} else {
			echo 	'<form action="admin.php" method="post">
						<input type="hidden" id="update-command" name="command" value="logout">
						<button id="logoutbtn" type="submit" class="btn">Log Out</button></td></tr>
					</form>';
		}
	}

	function newCate(){
		$conn = pg_connect("dbname=haryoparigroho user=postgres password=satudua12 port=5432");
 		if (!$conn) {
		    die("Error in connection test: " . pg_last_error());
		}

		$kode = $_POST['kode'];
		$nama = $_POST['nama'];
		$jumlah = $_POST['jumlah'];

		$sql1 = "INSERT INTO TOKOKEREN.KATEGORI_UTAMA (kode, nama) values('$kode','$nama')";
		$result1 = pg_query($conn, $sql1);

		if (!$result1) { 
				echo "An error occurred. "; 
				exit(); 
			}

		for($x = 1; $x <= $jumlah; $x++){
			$kode_subkategori = $_POST['kodesubkategori'. $x];
			$subkategori = $_POST['subkategori'. $x];

			$sql2 = "INSERT INTO TOKOKEREN.SUB_KATEGORI (kode, kode_kategori, nama) values('$kode_subkategori', '$kode', '$subkategori')";
			$result2 = pg_query($conn, $sql2);
			if (!$result1) { 
				echo "An error occurred in subcategory. "; 
				exit(); 
			}
		}
		pg_close($conn);
	}
 
	function logout() {
		unset($_SESSION['role']);
		unset($_SESSION['id']);	
		unset($_SESSION['email_pembeli']);	
		header("location:Home.php");
	}
 
	function start() {
		unset($_SESSION['role']);
		header("location:Login.php");
	}
 
 
	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if($_POST['command'] === 'insert') {
			newCate();
		} else if($_POST['command'] === 'logout') {
			logout();
		} else if($_POST['command'] === 'start') {
			start();
		} else if($_POST['command'] === 'jasakirimbaru') {
			header("location:create_jasa_kirim.php");
		} else if($_POST['command'] === 'promobaru') {
			header("location:create_promo.php");
		} else if($_POST['command'] === 'newprod') {
			header("location:menambah_produk_pulsa.php");
		} 
	}
 
?>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
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
		      		echo"Logged in as ".$_SESSION['role'];
		      	?>
		      	</a>	
		    	<?php
		    		logoutBtn();
		    	?>
		    </div><!--/.navbar-collapse -->
		  </div>
		</nav>
		<br> <br> <br>
		<h1 style="text-align : center; font-size:40pt">Add a new Category</h1>
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
					<h4 class="modal-title" id="insertModalLabel">Add Category</h4>
				</div>
				<div class="modal-body">
					<form id="tambah" action="category.php" method="post">
						<div id="containerTambah">
							<div class="form-group">
								<label for="title">Kode kategori</label>
								<input type="text" class="form-control" id="insert-kode" name="kode" placeholder="Kode Kategori" required>
							</div>
							<div class="form-group">
									<label for="author">Nama kategori</label>
									<input type="text" class="form-control" id="insert-nama" name="nama" placeholder="nama" required>
							</div>
							<script>
								function report(period) {
									if (period=="") return; // please select - possibly you want something else here
									$("#subkat").html("");
									var old = "";
									var n = 0;
									for (var i = period - 1; i >= 0; i--) {
										n++;
										old = $("#subkat").html();
								  		$("#subkat").html(old + "<div class='form-group'><label for='author'>Nama subkategori "+n+"</label><input type='text' class='form-control' id='insert-subkategori"+n+"' name='subkategori"+n+"' placeholder='Nama Subkategori' required></div><div class='form-group'><label for='author'>Kode subkategori "+n+"</label><input type='text' class='form-control' id='insert-kodesubkategori"+n+"' name='kodesubkategori"+n+"' placeholder='Kode Kategori' required></div>");
									};
								} 
							</script>
							<div class="form-group">
								<label for="password">Jumlah subkategori</label>
								<select class="form-control" id="insert-jumlah" name="jumlah" onchange="report(this.value)"> 
								  <option value="">Please select</option>
								  <option value=1>1</option>
								  <option value=2>2</option>
								  <option value=3>3</option>
								  <option value=4>4</option>
								  <option value=5>5</option>
								  <option value=6>6</option>
								  <option value=7>7</option>
								  <option value=8>8</option>
								  <option value=9>9</option>
								  <option value=10>10</option>
								</select>
								<div id="subkat">
								</div>	
							</div>
						</div>
						<input type="hidden" id="insert-command" name="command" value="insert">
						<button id="submit" type="submit" class="btn">Submit</button>
					</form>
				</div>
			</div>
		</div>
		<div class="table-responsive">
			<table class='table'>
				<br>
				<tbody>
					
				</tbody>
			</table>
		</div>
		<hr style="width: 80%; border-color:#EF0606">
		<footer>
		  <p class="text-center">Ari Tri Wibowo Yudasubrata - Faizal Adhitama Prabowo - Farizki Yazid - Haryo Parigroho</p>
		</footer>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</body>
</html>