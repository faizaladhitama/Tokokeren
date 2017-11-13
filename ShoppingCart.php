<?php
	session_start();
	if($_SESSION['role'] === NULL){
		header("location:Home.php");
	}

	if($_SESSION['role'] === "admin") {

	} else if($_SESSION['role'] === "user") {

	} else {

	}

	

	function review($bookid) {
		echo
			'<form action="Home.php" method="post">
				<td><input type="hidden" id="update-bookid" name="bookid" value = "'.$bookid.'">
				<input type="hidden" id="update-command" name="command" value="seeMore">
				<button type="submit" class="btn">See More</button></td></tr>
			</form>';
	}

	
 
	function restoreReview($bookid) {
		echo'<form action="ShoppingCart.php" method="post">
				<td><input type="hidden" id="update-bookid" name="bookid" value = "'.$bookid.'">
				<input type="hidden" id="update-command" name="command" value="seeMore">
				<button type="submit" class="btn">Review</button></td>
			</form>
			<form action="ShoppingCart.php" method="post">
				<td><input type="hidden" id="update-bookid" name="bookid" value = "'.$bookid.'">
				<input type="hidden" id="update-command" name="command" value="kembalikan">
				<button type="submit" id="returnbtn" class="btn">Return</button></td></tr>
			</form>';
	}
 
	function tabelBuku() {
		if($_SESSION['role'] != NULL) {
			$books_dipinjam = bukuDipinjam();
			if($books_dipinjam == NULL){
				echo "<h2>Cart Empty</h2>";
			}
			foreach($books_dipinjam as $book) {
				$book_diprint = takeBook($book);
				while ($row = mysqli_fetch_row($book_diprint)) {
					echo "<tr>";
					$length = count($row);
					for ($i = 0; $i < $length; $i++) {
						if($i === 1) {
							echo "<td><img style='max-height:200px;' src='$row[$i]'></td>";
						} else if($i === 6){
								echo "Quantity left : "."$row[$i]</td>";
						}  else if($i === 0){       
							echo "";
						} else if($i === 5) { 
							echo "";
						} else if($i === 2) { 
							echo "<td class='judul'>$row[$i] <br>";
						} else if($i === 3) { 
							echo "Written by"."\t ".": "."$row[$i] <br>";
						} else if($i === 4) { 
							echo "Published by"."\t ".": "."$row[$i] <br>";
						}
					}
					restoreReview($row[0]);
				}
			}
		}
	}
 
	function kepala() {
		if($_SESSION['role'] != NULL) {
			echo '<form action="ShoppingCart.php" method="post">
					<input type="hidden" id="update-command" name="command" value="home">
					<button id="home" type="submit" class="btn">Home</button>
			     </form>';
		 } 
	}
 
	function home() {
		unset($_SESSION['book_id']);
		header("location:Home.php");
	}
 

	function logoutBtn(){
		if($_SESSION['role'] === "guest") {
		   echo '';
		} else {
			echo 	'<form action="Home.php" method="post">
						<input type="hidden" id="update-command" name="command" value="logout">
						<button id="logoutbtn" type="submit" class="btn">Log Out</button></td></tr>
					</form>';
		}
	}

	function logout() {
		unset($_SESSION['role']);
		header("location:Login.php");
	}
	
 
	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		if($_POST['command'] === 'insert') {
			insertReview();
		}  else if($_POST['command'] === 'kembalikan') {
			kembalikan($_POST['bookid']);
		} else if($_POST['command'] === 'home') {
			home();
		} else if($_POST['command'] === 'logout') {
			logout();
		} else if($_POST['command'] === 'seeMore') {
			$_SESSION['book_id'] = $_POST['bookid'];
			header("location:SeeMore.php");
		}
	}
?>
<!DOCTYPE html>
<html lang="en">
	<head>
	<title>Perpustakaan</title>
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
		          <a style="padding-top:6px" class="navbar-brand" href="Home.php"> <h4><img src = "assets/images/logo.png" style="max-height:17px"> MyLib</h4></a>
		    </div>
		    <div id="navbar" class="navbar-collapse collapse">
		    	<a class="navbar-brand navbar-right" href="Home.php">
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
		<div class="jumbotron" id="jumbo1">
		  <div class="container">
		    <h1>Welcome!</h1>
		    <p>to the best library online
		    </p>
		    <p style="max-width: 500px; font-size:14pt;">Easy and fast book rental for everyone</p>
		    <p><a id="up" class="btn btn-lg" href="Home.php" role="button">View Catalog &raquo;</a></p>
		  </div>
		</div>

		<div class="container" id="cons">
				<?php
					kepala();
				?>
			<br>
			<div class="table-responsive">
				<table class='table'>
					<tbody>
						<?php
							tabelBuku();
						?>
					</tbody>
				</table>
			</div>
		</div>
		<hr style="width: 80%; border-color:#EF0606">
		<footer>
		  <p class="text-center">Ari Tri Wibowo Yudasubrata - Faizal Adhitama Prabowo - Farizki Yazid - Haryo Parigroho</p>
		</footer>
	</body>
</html>


