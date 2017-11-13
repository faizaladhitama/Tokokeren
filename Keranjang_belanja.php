<?php session_start(); ?>

<!DOCTYPE html>
<html>
	<head>
		<title>Buy Product</title>
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
		<?php include 'header.php'; ?>
		<div class="container">
			<div class="user_box">
				<div class="box">
					<div class="header">
						<h1>DAFTAR SHIPPED PRODUK</h1>
					</div>
					<div class="table-responsive">
						<table id="product_table" class="table table-bordered">

						</table>
					</div>
					<div id="kirim">
						<div>Alamat kirim : <input type="text" id="alamat"></div>
						<div>Jasa kirim : 
							<select id="select_jasa_kirim">
								<script type="text/javascript">generate_jasa_kirim();</script>
							</select>
						</div>
					</div>
					<div id="checkout_button">

					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			generate_keranjang_belanja();
		</script>
	</body>
</html>