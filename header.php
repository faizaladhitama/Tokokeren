<?php
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
		header("location:Home.php");
	}
 
	function start() {
		unset($_SESSION['role']);
		header("location:Login.php");
	} 
?>


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