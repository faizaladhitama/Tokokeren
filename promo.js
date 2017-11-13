$(document).ready(function() {
    $("#sub_kategori").children().hide();

    $("#kategori").change(function() {
        var selected = $(this).val();
        $("#sub_kategori").children().hide().filter('.' + selected).show();
    });

    $("#awal").change(function() {
    	var minValue = $("#awal").val();
    	$("#akhir").attr("min", minValue);
    });

});