<?php
	session_start();
	if($_SESSION['role'] == NULL){
		$_SESSION['role'] = "guest";
	}
 

	function logoutBtn(){
		if($_SESSION['role'] === "guest") {
		   echo '<form action="Home.php" method="post">
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
			insertItem();
		} else if($_POST['command'] === 'logout') {
			logout();
		} else if($_POST['command'] === 'start') {
			start();
		} else if($_POST['command'] === 'shoppingCart') {
			header("location:ShoppingCart.php");
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
		      		if($_SESSION['role'] != 'guest'){
		      			echo $_SESSION['id']." logged in as ".$_SESSION['role'];
		      		}
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
		    <h1>Welcome!</h1>
		    <p>to the coolest online store
		    </p>
		    <p style="max-width: 500px; font-size:14pt;">Easy and fast electronics solution for you</p>
		    <p><a id="up" class="btn btn-lg" href="Home.php" role="button">View Catalog &raquo;</a></p>
		  </div>
		</div>
		<div class="container" id="cons">
			<?php
				kepala();
			?>
			<br>
			<div class="row">
			  <div class="col-md-4">
			    <div class="thumbnail">
			      <a href="assets/images/hp.png">
			        <img src="assets/images/hp.png" alt="Lights" style="width:200px; height:auto">
			        <div class="caption">
			          <p>Iphone 10</p>
			        </div>
			      </a>
			    </div>
			  </div>
			  <div class="col-md-4">
			    <div class="thumbnail">
			      <a href="assets/images/ps.png">
			        <img src="assets/images/ps.png" alt="Nature" style="width:200px; height:auto">
			        <div class="caption">
			          <p>PS 2+2</p>
			        </div>
			      </a>
			    </div>
			  </div>
			  <div class="col-md-4">
			    <div class="thumbnail">
			      <a href="assets/images/baju.jpg">
			        <img src="assets/images/baju.jpg" alt="Fjords" style="width:200px; height:auto">
			        <div class="caption">
			          <p>Baju</p>
			        </div>
			      </a>
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
		</div>
		<hr style="width: 80%; border-color:#EF0606">
		<footer>
		  <p class="text-center">Ari Tri Wibowo Yudasubrata - Faizal Adhitama Prabowo - Farizki Yazid - Haryo Parigroho</p>
		</footer>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</body>
</html>