<?php
	session_start();
	
	function login() {
		$email = $_POST['email'];
		$password = $_POST['password'];

		if($email == "admin" && $password == "admin"){
			$_SESSION['id'] = $email;
			$_SESSION['role'] = $email;
			header("location:Home.php");
		}

		$conn = pg_connect("dbname=haryoparigroho user=postgres password=satudua12 port=5432");
 		if (!$conn) {
		    die("Error in connection test: " . pg_last_error());
		}

		$checkAdmin = "SELECT email FROM TOKOKEREN.PENGGUNA where email NOT IN(select email from TOKOKEREN.PELANGGAN where email = '$email') AND password = '$password'";
		$result = pg_query($conn, $checkAdmin);
		
		if(pg_num_rows($result) == 1) {
		    $arr = pg_fetch_array($result);
			$_SESSION['id'] = $email;
			$_SESSION['role'] = "admin";
			header("location:Home.php");
		}

		$check = "SELECT email FROM TOKOKEREN.PENGGUNA where email IN(select email from TOKOKEREN.PELANGGAN where email = '$email') AND password = '$password'";
		$result = pg_query($conn, $check);
		
		if(pg_num_rows($result) != 1) {
		    echo "Wrong email or Password";
		} else {
		    $arr = pg_fetch_array($result);
			$_SESSION['id'] = $email;
			$_SESSION['email_pembeli'] = $email;
			$_SESSION['role'] = "user";
			header("location:Home.php");
		}

		pg_close($conn);

	}


	function insertUser(){
		$conn = pg_connect("dbname=haryoparigroho user=postgres password=satudua12 port=5432");
 		if (!$conn) {
		    die("Error in connection test: " . pg_last_error());
		}

		$fullname = $_POST['fullname'];
		$username = $_POST['username'];
		$password = $_POST['password'];
		$password2 = $_POST['password2'];
		$telp = $_POST['telp'];
		$alamat = $_POST['alamat'];
		$tgllahir = $_POST['tgllahir'];
		$jenis_kelamin = $_POST['jk'];
		$sql = "INSERT INTO TOKOKEREN.PENGGUNA (email, password, nama, jenis_kelamin, tgl_lahir, no_telp, alamat) values('$username','$password','$fullname', '$jenis_kelamin', '$tgllahir', '$telp', '$alamat')";

		if($fullname == NULL){
			echo "Fill in your data";
		}elseif($username == NULL){
			echo "Fill in your data";
		}elseif($password == NULL){
			echo "Fill in your data";
		}elseif($password2 == NULL){
			echo "Fill in your data";
		}elseif($telp == NULL){
			echo "Fill in your data";
		}elseif($alamat == NULL){
			echo "Fill in your data";
		}
		elseif($password != $password2){
			echo "Confirm password does not match";
		}else {
			$result = pg_query($conn, $sql);
			if (!$result) { 
				$errormessage = pg_last_error(); 
				echo "An error occurred. " . $errormessage; 
				exit(); 
			}

			$sql2 = "INSERT INTO TOKOKEREN.PELANGGAN (email, is_penjual, nilai_reputasi) values('$username',FALSE,NULL)";
			$result = pg_query($conn, $sql2);
			$_SESSION['id'] = $username;
			$_SESSION['role'] = "user";
			if (!$result) {
			  echo "An error occurred.\n";
			  exit;
			}
			$_SESSION['email_pembeli'] = $username;
			header("location:Home.php");
		}
		pg_close($conn);
	}
	
	function start() {
		$_SESSION['role'] = "guest";
		header("Location: Home.php");
		die();
	}
	
	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if(isset($_POST['login'])) {
			login();
		} else if(isset($_POST['start'])) {
			start();
		} else if($_POST['command'] === 'insert') {
	        insertUser();
	   	}
	}
	
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="assets/css/login-css.css">
	</head>
	<body>
		<div id="background">
			<br>
			<div class="container" id="borderLogin">
				<img src="assets/images/t.svg" style="max-height:70px; margin-right:60px; margin-bottom:5px">
				<h3 id="atas">Welcome to TokoKeren,</h3>
				<h3 id="tengah">the world's coolest</h3>
				<h3 id="bawah">online store</h3>
				<div id="signin">
					<form action="Login.php" method="post">
						<input type="text" id="email" name="email" placeholder="Email" required/>
						<input type="password" id="password" name="password" placeholder="Password" required/>
						<input type="submit" id="tombol" name="login" class="btn btn-default"  value="Log In"/>
					</form>
					<form action="Login.php" method="post">
						<input type="submit" class="btn btn-default" name="start" value="View As Guest"/>
					</form>
					<button type="button" id="btnAdd" class="btn" data-toggle="modal" data-target="#insertModal">
						Sign Up
					</button>
					<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
									<h4 class="modal-title" id="insertModalLabel">Add User</h4>
								</div>
								<div class="modal-body">
									<form action="login.php" method="post">

										<div class="form-group">
											<label for="fullname">Full Name</label>
											<input type="text" class="form-control" id="insert-fullname" name="fullname" placeholder="Full Name" required/>
										</div>

										<div class="form-group" style="margin: 10px; margin-left: 20px; min-width: 300px;">
											<label for="jk">Gender</label>
											<select class="form-control" id="insert-jk" name="jk" required>
												<option value="L">Male</option>
												<option value="P">Female</option>
											</select>
											<br>
										</div>

										<div class="form-group">
											<label for="username">Email</label>
											<input type="email" class="form-control" id="insert-username" name="username" placeholder="username" required/>
										</div>

										<div class="form-group">
											<label for="tgllahir">Tanggal Lahir</label>
											<input type="text" class="form-control" id="insert-tgllahir" name="tgllahir" placeholder="Tanggal Lahir [dd/mm/yyyy]" required/>
										</div>

										<div class="form-group">
											<label for="password">Password</label>
											<input type="password" class="form-control" id="insert-password" name="password" placeholder="********" required/>
										</div>
										<div class="form-group">
											<label for="password2">Confirm Password</label>
											<input type="password" class="form-control" id="insert-password2" name="password2" placeholder="********" required/>
										</div>
										<div class="form-group">
											<label for="telp">Phone</label>
											<input type="text" class="form-control" id="insert-telp" name="telp" placeholder="08..." required/>
										</div>
										<div class="form-group">
											<label for="alamat">Address</label>
											<input type="text" class="form-control" id="insert-alamat" name="alamat" placeholder="address" required/>
										</div>
										<input type="hidden" id="insert-command" name="command" value="insert">
										<button type="submit" class="btn btn-danger	">Submit</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
