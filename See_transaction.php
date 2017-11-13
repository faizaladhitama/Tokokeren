<?php
	session_start();
?>
<html>
	<head>
		<title>View Transaction</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="bagian_4_script.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  		<link rel="stylesheet" href="assets/css/home-css.css">
  		<link rel="stylesheet" href="bagian_4_css.css">
	</head>
	<body>
		<div class="container">
			<div class="user_box">
				<div class="box">
					<form id="product_radio" action="bagian_4_service.php" method="POST">
						<input type="radio" name="product_type" value="barang"/> Barang<br>
			  			<input type="radio" name="product_type" value="pulsa"/> Pulsa<br>
			  			<input type="hidden" name="command" value="generate_transaction"/>
			  			<input type="submit" value="Submit" onclick="sendFormTransaction()"/>
					</form>
					<div id="table" class="table-responsive">
						<table id="product_table" class="table table-bordered">
							
						</table>
					</div>
				</div>
			</div>
		</div>
		<?php include 'header.php' ;?>
		<hr style="width: 80%; border-color:#EF0606">
		<footer>
		  <p class="text-center">Ari Tri Wibowo Yudasubrata - Faizal Adhitama Prabowo - Farizki Yazid - Haryo Parigroho</p>
		</footer>
	</body>
</html>