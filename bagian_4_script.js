function sendForm(){
	var form = $('#product_radio');
	var check = check_radio();
	form.submit(function (ev) {
		$.ajax({
	        type: form.attr('method'),
	        url: form.attr('action'),
	        data: form.serialize(),
	        success: function (data) {
	        	console.log(data);
	        	if(check == "pulsa"){
	       			product_pulsa(data,10,0); 	
	       		}
	      		else{
	      			product_barang(data);
	      		}
	        }
	    });
	    ev.preventDefault();
	});
}

function table_page_form_pulsa(limit,offset){
	$.ajax({
        url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"generate",product_type:"pulsa"},
        success: function (data) {
        	console.log(data);
       		product_pulsa(data,limit,offset); 	
        }
    });	
}

function product_barang(data){
	$(".box").empty();
	$(".box").append('<div class="header"><h1>FORM PILIH TOKO</h1></div>');
	$(".box").append('<div id="nama_toko"><select id="select_toko">');
	generate_toko_dropdown(data);
	$(".box").append('</select></div>');
	$(".box").append('<div id="submit_button"><button type="button" onclick="send_nama_toko()">Submit</button></div>');
}

function send_nama_toko(){
	var nama_toko = document.getElementById("select_toko").value;
	$(".box").empty();
	$(".box").append('<div class="header"><h1>DAFTAR SHIPPED PRODUK</h1></div>');
	$(".box").append('<div id="kategori">Kategori : <select id="select_kategori" onchange=\"generate_dropdown_sub_kategori()\">');
	generate_dropdown_kategori();
	$(".box").append('</select></div>');
	$(".box").append('<div id="sub_kategori">Sub Kategori : <select id="select_sub_kategori">');
	//generate_dropdown_sub_kategori()
	$(".box").append('</select></div>');
	$(".box").append('<div id="filter_button"><button type="button" id="'+nama_toko+'" onclick="filter(this.id)">Filter</button></div>');				
	generate_tabel_daftar_shipped_product(nama_toko);
}

function generate_tabel_daftar_shipped_product(nama_toko){
	var kat = document.getElementById("select_kategori").value;
	var sub_kat = document.getElementById("select_sub_kategori").value;
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"generate_tabel_daftar_shipped_product",kategori:kat,sub_kategori:sub_kat,toko:nama_toko},
	    success: function (data) {
	    	console.log(data);
	        $(".box").append('<div class="table-responsive"><table id="product_table" class="table table-bordered">');
	        var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];
			$("#product_table").append("<thead><tr id=\"0\">");
			var keys = [];
			for(var i = 0; i < Object.keys(header).length; i++){
				keys[i] = Object.keys(header)[i];
				$("#0").append("<th>"+header[Object.keys(header)[i]]+"</th>");
			}
			$("#0").append("<th>Beli</th>");
			$("#product_table").append("</tr></thead><tbody>");
			var harga = 0;
			if(parsed.length > 0){
				for(var i = 1; i < parsed.length;i++){
					var this_id = 0;
					var this_kode = "";
					var harga = 0;
					$("tbody").append("<tr id=\""+i+"\">");
					for(var j = 0; j < keys.length; j++){
						var key = header[keys[j]];
						var value = parsed[i][key];
						if(!isNaN(parseInt(value,10))){
							value = parseInt(value,10);
						}
						if(key == "Harga"){
							harga = value;
							$("#0").append("<input id=\""+"kode_"+this_kode+"\" type=\"hidden\" value=\""+harga+"\"/>");
						}
						if (j == 0) {
							this_kode = value;
						}
						if(value == "t"){
							value = "TRUE";
						}
						else if(value == "f"){
							value = "FALSE";
						}
						$("#"+i).append("<td>"+value+"</td>");
					}
					$("#"+i).append("<td><button id=\""+this_kode+"\" onclick=\"fill_weight_quantity(this.id)\">Beli</button></td>");
					$("tbody").append("</tr>");
					
				}
				$("#table").append("<input type=\"hidden\" id=\"total_row\" value=\""+(parsed.length-1)+"\">");
			}
			$("#product_table").append("</tbody>");
			$(".pagination").remove();
			generate_pagination_product(parsed.length-1);
	    }
	});
}

function fill_weight_quantity(id){
	var harga = document.getElementById("kode_" + id).value;
	$(".box").empty();
	$(".box").append('<div class="header"><h1>Masukkan berat dan kuantitas</h1></div>');
	$(".box").append('<form id="form_berat_kuantitas" action="bagian_4_service.php" method="post">');
	$("#form_berat_kuantitas").append("<div id=\"berat\">Berat : <input type=\"text\" name=\"berat\" id=\"isi_berat\"/></div>");
	$("#form_berat_kuantitas").append("<div id=\"kuantitas\">Kuantitas : <input type=\"text\" name=\"kuantitas\" id=\"isi_kuantitas\"/></div>");
	$("#form_berat_kuantitas").append('<input type="hidden" value="'+ id +'" id="id_barang" name="id_barang"/></form>');
	$("#form_berat_kuantitas").append('<input type="hidden" value="'+ harga +'" id="harga" name="harga"/></form>');
	$("#form_berat_kuantitas").append('<input type="hidden" value="insert_keranjang" name="command"/></form>');
	$("#form_berat_kuantitas").append('<input type="submit" value="Submit" onclick="calculate()"></form>');
}

function calculate(){
	var form = $('#form_berat_kuantitas');
	form.submit(function (ev) {
		$.ajax({
	        type: form.attr('method'),
	        url: form.attr('action'),
	        data: form.serialize(),
	        success: function (data) {
	        	console.log(data);
	        	$("#form_berat_kuantitas").empty();
				alert("data telah dimasukkan ke dalam keranjang belanja");
				//window.location.href="home.php";
	        }
	    });
	    ev.preventDefault();
	});
}

function filter(nama_toko){
	var kat = document.getElementById("select_kategori").value;
	var sub_kat = document.getElementById("select_sub_kategori").value;
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"generate_tabel_daftar_shipped_product",kategori:kat,sub_kategori:sub_kat,toko:nama_toko},
	    success: function (data) {
	    	console.log(data);
	        $("tbody").empty();
	        var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];
			var keys = [];
			for(var i = 0; i < Object.keys(header).length; i++){
				keys[i] = Object.keys(header)[i];
			}
			if(parsed.length > 0){
				for(var i = 1; i < parsed.length;i++){
					var this_id = 0;
					var this_kode = "";
					$("tbody").append("<tr id=\""+i+"\">");
					for(var j = 0; j < keys.length; j++){
						var key = header[keys[j]];
						var value = parsed[i][key];
						if(!isNaN(parseInt(value,10))){
							value = parseInt(value,10);
						}
						if (j == 0) {
							this_kode = value;
						}
						if(value == "t"){
							value = "TRUE";
						}
						else if(value == "f"){
							value = "FALSE";
						}
						$("#"+i).append("<td>"+value+"</td>");
					}
					$("#"+i).append("<td><button id=\""+this_kode+"\" onclick=\"buyProduk("+i+",this.id)\">Beli</button></td>");
					$("tbody").append("</tr>");
				}
				$("#table").append("<input type=\"hidden\" id=\"total_row\" value=\""+(parsed.length-1)+"\">");
			}
	    }
	});	
}

function generate_dropdown_kategori(){
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"generate_kategori"},
	    success: function (data) {
	        var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];

			var keys = [];
			for(var i = 0; i < Object.keys(header).length; i++){
				keys[i] = Object.keys(header)[i];
			}
			$("#select_kategori").append('<option value="'+ "null" + '" disabled selected>'+ "Pilih Kategori" +"</option>");
			$("#select_kategori").append('<option value="'+ "null" + '">'+ "Tanpa Kategori" +"</option>");
			if(parsed.length > 0){
				for(var i = 1; i < parsed.length;i++){
					for(var j = 0; j < keys.length; j++){
						var key = header[keys[j]];
						var value = parsed[i][key];

						$("#select_kategori").append('<option value="'+ value + '">'+ value +"</option>");
					}
				}
			}
	    }
	});
}

function generate_dropdown_sub_kategori(){
	var kat = document.getElementById("select_kategori").value;
	$("#select_sub_kategori").empty();
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"generate_sub_kategori",kategori:kat},
	    success: function (data) {
	    	console.log(data);
	        var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];

			var keys = [];
			for(var i = 0; i < Object.keys(header).length; i++){
				keys[i] = Object.keys(header)[i];
			}
			$("#select_sub_kategori").append('<option value="'+ "null" + '" disabled selected>'+ "Pilih Sub Kategori" +"</option>");
			$("#select_sub_kategori").append('<option value="'+ "null" + '">'+ "Tanpa Sub Kategori" +"</option>");
					
			if(parsed.length > 0){
				for(var i = 1; i < parsed.length;i++){
					for(var j = 0; j < keys.length; j++){
						var key = header[keys[j]];
						var value = parsed[i][key];

						$("#select_sub_kategori").append('<option value="'+ value + '">'+ value +"</option>");
					}
				}
			}
	    }
	});
}

function generate_toko_dropdown(data){
	console.log(data);
	var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
	var header = parsed[0];
	var keys = [];
	for(var i = 0; i < Object.keys(header).length; i++){
		keys[i] = Object.keys(header)[i];
	}
	if(parsed.length > 0){
		for(var i = 1; i < parsed.length;i++){
			for(var j = 0; j < keys.length; j++){
				var key = header[keys[j]];
				var value = parsed[i][key];

				$("#select_toko").append('<option value="'+ value + '">'+ value +"</option>");
			}
		}
	}
}

function product_pulsa(data,limit,offset){
	$("#product_radio").empty();
	$("#product_radio").append("<h1>DAFTAR PRODUK PULSA</h1>");
	var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
	var header = parsed[0];
	$("#product_table").empty();
	$("#product_table").append("<thead><tr id=\"0\">");
	var keys = [];
	for(var i = 0; i < Object.keys(header).length; i++){
		keys[i] = Object.keys(header)[i];
		$("#0").append("<th>"+header[Object.keys(header)[i]]+"</th>");
	}
	$("#0").append("<th>Beli</th>");
	$("#product_table").append("</tr></thead><tbody>");
	var limiter = 0;
	if(parsed.length > limit+offset){
		limiter = limit+offset;
	}else{
		limiter = parsed.length; 
	}

	if(parsed.length > 0){
		for(var i = offset+1; i < limiter+1;i++){
			var this_id = 0;
			var this_kode = "";
			$("tbody").append("<tr id=\""+i+"\">");
			for(var j = 0; j < keys.length; j++){
				var key = header[keys[j]];
				var value = parsed[i][key];
				if (j == 0) {
					this_kode = value;
				}
				if(value == "t"){
					value = "TRUE";
				}
				else if(value == "f"){
					value = "FALSE";
				}
				$("#"+i).append("<td>"+value+"</td>");
			}
			$("#"+i).append("<td><button id=\""+this_kode+"\" onclick=\"buyPulsa("+i+",this.id)\">Beli</button></td>");
			$("tbody").append("</tr>");
		}
		$("#table").append("<input type=\"hidden\" id=\"total_row\" value=\""+(parsed.length-1)+"\">");
	}
	$("#product_table").append("</tbody>");
	$(".pagination").remove();
	generate_pagination_pulsa(parsed.length-1,"table_page_form_pulsa");
}

function buyPulsa(id,kode){
	var string = String(id);
	var children = document.getElementById(string).children;
	var val = [];
	for(var i=0;i < children.length-1;i++){
		val[i] = children[i].innerHTML;	
	}
	console.log(val);
	var harga = parseInt(val[2]);
	var nominal = parseInt(val[4]);
	var current_date = new Date().toLocaleDateString();
	var current_time = new Date().toLocaleTimeString('en-US', { hour12: false,hour: "numeric",minute: "numeric"});
	var current_datetime = current_date + " " + current_time;
	var status = 2;
	var total_row = document.getElementById("total_row").value;
	$("#table").remove();
	$(".box").append("<form id=\"box\" action=\"bagian_4_service.php\" method=\"POST\">");
	$("#box").append("<div id=\"kode_produk_div\"> Kode produk : "+kode+"</div>");	
	$("#box").append("<div id=\"nomor\">Nomor HP / Token Listrik: <input type=\"text\" name=\"nomor\" id=\"isi_nomor\"/></div>");
	$("#box").append("<input type=\"hidden\" name=\"date\" value=\""+current_date+"\">");
	$("#box").append("<input type=\"hidden\" name=\"datetime\" value=\""+current_datetime+"\">");
	$("#box").append("<input type=\"hidden\" name=\"status\" value=\""+status+"\">");
	$("#box").append("<input type=\"hidden\" name=\"kode_produk\" value=\""+kode+"\">");
	$("#box").append("<input type=\"hidden\" name=\"harga\" value=\""+harga+"\">");
	$("#box").append("<input type=\"hidden\" name=\"nominal\" value=\""+nominal+"\">");
	$("#box").append("<input type=\"hidden\" name=\"command\" value=\"buy_pulsa\"/>");
	$("#box").append("<div id=\"submit_button\"><input type=\"submit\" onclick=\"saveToDatabase()\" value=\"Submit\"/></div>");
	$(".user_box").append("</form>");
	var nomor = $("#isi_nomor").val();
}

function saveToDatabase(){
	var form = $('#box');
	form.submit(function (ev) {
		$("#box").hide();
	    $.ajax({
	        type: form.attr('method'),
	        url: form.attr('action'),
	        data: form.serialize(),
	        success: function (data) {
	        	console.log(data);
	        	alert("data telah berhasil dimasukkan");
	        }
	    });
	    ev.preventDefault();
	});
	window.location.href = "home.php";
}

function check_radio(){
	var radios = document.getElementsByName('product_type');
	for (var i = 0, length = radios.length; i < length; i++) {
		if (radios[i].checked) {
			return radios[i].value;
		}
	}
}

function generate_keranjang_belanja(){
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"generate_keranjang_belanja"},
	    success: function (data) {
	    	console.log(data);
	        var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];
			$("#product_table").append("<thead><tr id=\"0\">");
			var keys = [];
			for(var i = 0; i < Object.keys(header).length; i++){
				keys[i] = Object.keys(header)[i];
				$("#0").append("<th>"+header[Object.keys(header)[i]]+"</th>");
			}
			$("#product_table").append("</tr></thead><tbody>");
			if(parsed.length > 0){
				for(var i = 1; i < parsed.length;i++){
					var this_id = 0;
					var this_kode = "";
					$("tbody").append("<tr id=\""+i+"\">");
					for(var j = 0; j < keys.length; j++){
						var key = header[keys[j]];
						var value = parsed[i][key];
						if(!isNaN(parseInt(value,10))){
							value = parseInt(value,10);
						}
						if (j == 0) {
							this_kode = value;
						}
						if(value == "t"){
							value = "TRUE";
						}
						else if(value == "f"){
							value = "FALSE";
						}
						$("#"+i).append("<td>"+value+"</td>");
					}
					$("tbody").append("</tr>");
				}
				$("#table").append("<input type=\"hidden\" id=\"total_row\" value=\""+(parsed.length-1)+"\">");
			}
			$("#product_table").append("</tbody>");
	    	if(parsed.length-1 > 0){
				$("#checkout_button").append('<button type="button" onclick="checkout()">Checkout Button</button>');
			}
			else{
				$("#checkout_button").append('<button type="button" onclick="checkout()" disabled>Checkout Button</button>');
			}
			generate_pagination_product(parsed.length-1);
	    }
	});	
}

function generate_jasa_kirim(){
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"generate_jasa_kirim_toko"},
	    success: function (data) {
	    	console.log(data);
	    	var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];
			var keys = [];
			for(var i = 0; i < Object.keys(header).length; i++){
				keys[i] = Object.keys(header)[i];
			}
			$("#select_jasa_kirim").append('<option value="'+ "null" + '" disabled selected>'+ "Pilih Jasa Kirim" +"</option>");					
			if(parsed.length > 0){
				for(var i = 1; i < parsed.length;i++){
					for(var j = 0; j < keys.length; j++){
						var key = header[keys[j]];
						var value = parsed[i][key];

						$("#select_jasa_kirim").append('<option value="'+ value + '">'+ value +"</option>");
					}
				}
			}
	    }
	});	
}

function checkout(){
	var almt = document.getElementById("alamat").value;
	var jasa = document.getElementById("select_jasa_kirim").value;
	var current_date = new Date().toLocaleDateString();
	var current_time = new Date().toLocaleTimeString('en-US', { hour12: false,hour: "numeric",minute: "numeric"});
	var current_datetime = current_date + " " + current_time;
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"checkout",alamat:almt,jasa_kirim:jasa,date:current_date,datetime:current_datetime},
	    success: function (data) {
	    	console.log(data);
	    	alert("Anda telah berhasil melakukan checkout");
	    	window.location.href="home.php";
	    }
	});	
}

function sendFormTransaction(){
	var form = $('#product_radio');
	var check = check_radio();
	form.submit(function (ev) {
		$.ajax({
	        type: form.attr('method'),
	        url: form.attr('action'),
	        data: form.serialize(),
	        success: function (data) {
	        	console.log(data);
	        	if(check == "pulsa"){
	       			transaction_pulsa(data); 	
	       		}
	      		else{
	      			transaction_barang(data);
	      		}
	        }
	    });
	    ev.preventDefault();
	});
}

function transaction_pulsa(data) {
	$("#product_radio").empty();
	$("#product_radio").append("<h1>DAFTAR PRODUK PULSA</h1>");
	var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
	var header = parsed[0];
	$("#product_table").append("<thead><tr id=\"0\">");
	var keys = [];
	for(var i = 0; i < Object.keys(header).length; i++){
		keys[i] = Object.keys(header)[i];
		$("#0").append("<th>"+header[Object.keys(header)[i]]+"</th>");
	}
	$("#product_table").append("</tr></thead><tbody>");
	if(parsed.length > 0){
		for(var i = 1; i < parsed.length;i++){
			var this_id = 0;
			var this_kode = "";
			$("tbody").append("<tr id=\""+i+"\">");
			for(var j = 0; j < keys.length; j++){

				var key = header[keys[j]];
				var value = parsed[i][key];
				if (j == 0) {
					this_kode = value;
				}
				if(value == "t"){
					value = "TRUE";
				}
				else if(value == "f"){
					value = "FALSE";
				}
				if(value == "1"){
					value = "BELUM DIBAYAR";
				}
				else if(value == "2"){
					value = "SUDAH DIBAYAR";
				}
				$("#"+i).append("<td>"+value+"</td>");
			}
			$("tbody").append("</tr>");
		}
		$("#table").append("<input type=\"hidden\" id=\"total_row\" value=\""+(parsed.length-1)+"\">");
	}
	$("#product_table").append("</tbody>");
	generate_pagination_pulsa(parsed.length-1);
}

function transaction_barang(data) {
	$("#product_radio").empty();
	$("#product_radio").append("<h1>DAFTAR TRANSAKSI SHIPPED</h1>");
	var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
	var header = parsed[0];
	$("#product_table").append("<thead><tr id=\"0\">");
	var keys = [];
	for(var i = 0; i < Object.keys(header).length; i++){
		keys[i] = Object.keys(header)[i];
		$("#0").append("<th>"+header[Object.keys(header)[i]]+"</th>");
	}
	$("#0").append("<th>ULASAN</th>");
	$("#product_table").append("</tr></thead><tbody>");
	if(parsed.length > 0){
		for(var i = 1; i < parsed.length;i++){
			var this_id = 0;
			var this_kode = "";
			$("tbody").append("<tr id=\""+i+"\">");
			for(var j = 0; j < keys.length; j++){
				var key = header[keys[j]];
				var value = parsed[i][key];
				if (j == 0) {
					this_kode = value;
				}
				if(value == "t"){
					value = "TRUE";
				}
				else if(value == "f"){
					value = "FALSE";
				}
				if(value == "1"){
					value = "BELUM DIBAYAR";
				}
				else if(value == "2"){
					value = "SUDAH DIBAYAR";
				}
				$("#"+i).append("<td>"+value+"</td>");
			}
			$("#"+i).append("<td><button id=\""+this_kode+"\" onclick=\"daftar_produk(this.id)\">DAFTAR PRODUK</button></td>");
			$("tbody").append("</tr>");
		}
		$("#table").append("<input type=\"hidden\" id=\"total_row\" value=\""+(parsed.length-1)+"\">");
	}
	$("#product_table").append("</tbody>");
	generate_pagination_product(parsed.length-1);
}

function daftar_produk(invoice) {
	$.ajax({
        type: "POST",
        url: "bagian_4_service.php",
        data: {command:"transaksi_daftar_produk",no_invoice:invoice},
        success: function (data) {
        	console.log(data);
        	$("#product_radio").empty();
			$("#product_radio").append("<h1>DAFTAR TRANSAKSI SHIPPED</h1>");
			var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];
			$("#product_table").empty();
			$("#table").prepend('<div id="no_invoice">No Invoice: '+invoice+'</div>');
			$("#product_table").append("<thead><tr id=\"0\">");
			var keys = [];
			for(var i = 1; i < Object.keys(header).length; i++){
				keys[i] = Object.keys(header)[i];
				$("#0").append("<th>"+header[Object.keys(header)[i]]+"</th>");
			}
			$("#0").append("<th>ULASAN</th>");
			$("#product_table").append("</tr></thead><tbody>");

			var key_kode_produk = header[Object.keys(header)[0]];
			if(parsed.length > 0){
				for(var i = 1; i < parsed.length;i++){
					var this_id = 0;
					var this_kode = "";
					$("tbody").append("<tr id=\""+i+"\">");
					for(var j = 1; j < keys.length; j++){
						var key = header[keys[j]];
						var value = parsed[i][key];
						if(value == "t"){
							value = "TRUE";
						}
						else if(value == "f"){
							value = "FALSE";
						}
						if(value == "1"){
							value = "BELUM DIBAYAR";
						}
						else if(value == "2"){
							value = "SUDAH DIBAYAR";
						}
						$("#"+i).append("<td>"+value+"</td>");
					}
					var kode_produk = parsed[i][key_kode_produk];
					isSudahDiUlas(kode_produk,i);
					$("tbody").append("</tr>");
				}
				$("#table").append("<input type=\"hidden\" id=\"total_row\" value=\""+(parsed.length-1)+"\">");
			}
			$("#product_table").append("</tbody>");
			generate_pagination_product(parsed.length-1);
        }
    });
}

function isSudahDiUlas(kode,m){
	$.ajax({
	    url: 'bagian_4_service.php',
	    type: "POST",
	    data: {command:"check_ulas",kode_produk:kode},
	    success: function (data) {
	    	var parsed = JSON.parse(data.replace(/&#34;/g,'"'));
			var header = parsed[0];
			if(parsed.length-1 > 0){
				$("#"+m).append("<td><button id=\""+kode+"\" onclick=\"create_ulasan(this.id)\" disabled>ULASAN</button></td>");
			}
			else{
				$("#"+m).append("<td><button id=\""+kode+"\" onclick=\"create_ulasan(this.id)\">ULASAN</button></td>");
			}
		}
	});	
}

function create_ulasan(kode){
	var kode_produk = kode;

	window.location.href="create_ulasan.php?kode_produk="+kode_produk;	
}

function generate_pagination_pulsa(total_row,method_name){
	if(total_row > 10){
		$("#table").append('<ul class="pagination">');
		for(var i = 0; i < Math.ceil(total_row/10);i++){
			var offset = i*10;
			var method = method_name+"(10,"+offset+")";
			$(".pagination").append('<li><button onclick='+method+'><a href="#">'+(i+1)+'</a></button></li>');
		}
		$("#table").append('</ul>');
	}
}

function generate_pagination_product(total_row){
	if(total_row > 10){
		$(".table-responsive").append('<ul class="pagination">');
		for(var i = 0; i < Math.ceil(total_row/10);i++){
			var offset = i*10;
			var method = method_name+"(10,"+offset+")";
			$(".pagination").append('<li><button onclick='+method+'"><a href="#">'+(i+1)+'</a></button></li>');
		}
		$("#table").append('</ul>');	
	}
}