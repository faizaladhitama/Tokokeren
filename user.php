<?php
	session_start();
	if($_SESSION['role'] != "user"){
		header("location:Home.php");
	}


	function logoutBtn(){
		if($_SESSION['role'] === "guest") {
		   echo '<form action="user.php" method="post">
						<input type="hidden" id="update-command" name="command" value="start">
						<button id="logoutbtn" type="submit" class="btn">Login/SignUp</button></td></tr>
					</form>';
		} else {
			echo 	'<form action="user.php" method="post">
						<input type="hidden" id="update-command" name="command" value="logout">
						<button id="logoutbtn" type="submit" class="btn">Log Out</button></td></tr>
					</form>';
		}
	}
 
	function logout() {
		unset($_SESSION['role']);
		unset($_SESSION['id']);
		header("location:Home.php");
	}
 
	function start() {
		unset($_SESSION['role']);
		header("location:Login.php");
	}
 
 
	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if($_POST['command'] === 'insert') {
			insertItem();
		} else if($_POST['command'] === 'logout') {
			logout();
		} else if($_POST['command'] === 'start') {
			start();
		} else if($_POST['command'] === 'beliprod') {
			header("location:Buy_product.php");
		} else if($_POST['command'] === 'view') {
			header("location:See_transaction.php");
		} else if($_POST['command'] === 'open') {
			header("location:membuat_toko.php");
		} else if($_POST['command'] === 'addprod') {
			header("location:menambah_shipped_produk.php");
		} else if($_POST['command'] === 'belipuls') {
			header("location:Buy_product_pulsa.php");
		} else if($_POST['command'] === 'cart') {
			header("location:Keranjang_belanja.php");
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
		<div class="jumbotron" id="jumbo1">
		  <div class="container">
		    <h1>Welcome User</h1>
		    <p>Users's Dashboard
		    </p>
		    <p style="max-width: 500px; font-size:14pt;">Easy and fast electronics solution for you</p>
		    <p><a id="up" class="btn btn-lg" href="Home.php" role="button">View Catalog &raquo;</a></p>
		  </div>
		</div>
		<div class="container" id="cons">
			<h1>Dashboard</h1>
			<form action="user.php" method="post">
				<input type="hidden" id="update-command" name="command" value="beliprod">
				<button type="submit" id="borrow" class="btn">Buy Products</button></td>
			</form>
			<form action="user.php" method="post">
				<input type="hidden" id="update-command" name="command" value="cart">
				<button type="submit" id="borrow" class="btn">Shopping Cart</button></td>
			</form>
			<form action="user.php" method="post">
				<input type="hidden" id="update-command" name="command" value="view">
				<button type="submit" id="borrow" class="btn">View Transaction</button></td>
			</form>
			<form action="user.php" method="post">
				<input type="hidden" id="update-command" name="command" value="open">
				<button type="submit" id="borrow" class="btn">Open Store</button></td>
			</form>
			<form action="user.php" method="post">
				<input type="hidden" id="update-command" name="command" value="addprod">
				<button type="submit" id="borrow" class="btn">Add Product</button></td>
			</form>
			<div class="table-responsive">
				<table class='table'>
					<br>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<hr style="width: 80%; border-color:#EF0606">
		<footer>
		  <p class="text-center">Ari Tri Wibowo Yudasubrata - Faizal Adhitama Prabowo - Farizki Yazid - Haryo Parigroho</p>
		</footer>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</body>
</html>