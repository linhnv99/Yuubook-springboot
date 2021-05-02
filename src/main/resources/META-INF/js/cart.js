function addToCart(id) {
	$(".preloader").show();
	var data = {
		"bookId" : id,
		"quantity" : 1
	}
	setTimeout(function(){
		$.ajax({
			url : "/add-to-cart",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				if(data.statusCode == 400){
					alert(data.obj);
					$(".preloader").hide();
				}
				if (data.statusCode == 200) {
					$.each(data.obj.cartItems, function(k, v){
						if(v.bookId == id){
							$(".wp-box").show();
							$("#p-img").attr("src", window.location.origin + "/files/"+ v.avatar);
							$("#p-name").attr("href", window.location.origin + "/san-pham/"+ v.slug);
							$("#p-name").html(v.bookName.substring(0,30));
							$("#js-cartNumber").html(data.obj.cartItems.length);
						}
					})
				}
			},
			error : function(err) {
				$(".preloader").hide();
				alert("Có lỗi xảy ra! Vui lòng thử lại sau.");
			}
		})
	}, 1200);
}

function removeCart(id) {
	$(".cube-overlay").show();
	setTimeout(function(){
		$.ajax({
			url : "/remove-cart/"+id,
			type : "post",
			dataType : "json",
			success : function(data) {
				if(data.statusCode == 400){
					alert(data.obj);
					return;
				}
				if (data.statusCode == 200) {
					$("#js-cartNumber").html(data.obj.cartItems.length);
					window.location.reload();
				}
			},
			error : function(err) {
				console.log(err);
				alert("Có lỗi xảy ra! Vui lòng thử lại sau.");
				$(".cube-overlay").hide();
			}
		})
	}, 1200);
}


$("#mua-tiep").on("click", function(e){
	e.preventDefault();
	$(".wp-box").hide();
	$(".preloader").hide();
})

function buyNow(id){
	var qty = $(".quantity input.number").val();
	if(!qty){
		qty = 1;
	}
	var data = {
			"bookId" : id,
			"quantity" : qty
		}
	$.ajax({
		url : "/add-to-cart",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data, status) {
			if (status == "success") {
				window.location.href = "/cart";
			}
		},
		error : function(err) {
			alert("Có lỗi xảy ra! Vui lòng thử lại sau.");
		}
	})
}
function updateCart(id, num){
	$(".cube-overlay").show();
	var data = {
			"bookId" : id,
			"quantity" : num
		}
	setTimeout(function(){
		$.ajax({
			url : "/add-to-cart",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data, status) {
				if (status == "success") {
					window.location.reload();
				}
			},
			error : function(err) {
				alert("Có lỗi xảy ra! Vui lòng thử lại sau.");
			}
		})
	},1500);
}


function getDistrict(p_id,d_id){
	$("#wards").attr("disabled", true);
	$("#wards").empty().append("<option value='-1'>-- Chọn phường xã --</option>");
	var districtSelected;
	if(p_id == null || p_id == ''){
		return;
	}
	$.ajax({
		url: "/district/"+p_id,
		type: "post",
		dataType: "json",
		success: function(data){
			if(data.statusCode == 200){
				$("#district").empty().append("<option value='-1'>-- Chọn quận huyện --</option>");
				$(data.obj).each(function(k, v){
					var html = "";
					if(d_id != '' && parseInt(d_id) ==  v.id)
						html += "<option value='"+v.id+"' selected>"+v.name+"</option>";
					else
						html += "<option value='"+v.id+"'>"+v.name+"</option>";
					
					$("#district").append(html);
				})
				$("#district").attr("disabled", false);
			}
		},
		error: function(err){
			console.log(err);
		}
	})
}

function getWards(d_id, w_id){
	if(d_id == null || d_id == ''){
		return;
	}
	$.ajax({
		url: "/wards/"+d_id,
		type: "post",
		dataType: "json",
		success: function(data){
			if(data.statusCode == 200){
				$("#wards").empty().append("<option value='-1'>-- Chọn phường xã --</option>");
				$(data.obj).each(function(k, v){
					var html = "";
					if(w_id != '' && parseInt(w_id) ==  v.id)
						html += "<option value='"+v.id+"' selected>"+v.name+"</option>";
					else
						html += "<option value='"+v.id+"'>"+v.name+"</option>";
					
					$("#wards").append(html);
				})
				$("#wards").attr("disabled", false);
			}
		},
		error: function(err){
			console.log(err); 
		}
	})
}

function validatePhone(phone){
	var pattern = /^(84|0[3|5|7|8|9])+([0-9]{8})\b$/;
	if(pattern.test(phone))
		return true;
	return false;
}

$("#saveCusomerAddress").on("click", function(e){
	e.preventDefault();
	var fullname = $("#fullname").val().trim();
	var phone = $("#phone").val().trim();
	var addressDetail = $("#addressDetail").val().trim();
	var provinceId = $("#province").val();
	var districtId = $("#district").val();
	var wardsId = $("#wards").val();
	var note = $("#note").val().trim();
	var data = {
			"fullname": fullname,
			"phone": phone,
			"province": $("#province option:selected").text(),
			"district": $("#district option:selected").text(),
			"wards": $("#wards option:selected").text(),
			"addressDetail": addressDetail,
			"note": $("#note").val().trim(),
			"provinceId": provinceId,
			"districtId": districtId,
			"wardsId": wardsId
	}
	if(fullname == ''){
		$("#errName").show().html("Họ tên không được để trống.");
		return false;
	}else $("#errName").hide().html("");
	
	if(phone == ''){
		$("#errPhone").show().html("Số điện thoại không được để trống.");
		return false;
	}else $("#errPhone").hide().html("");

	if(!validatePhone(phone) && phone != ''){
		$("#errPhone").show().html("Số điện thoại không hợp lệ !");
		return;
	}else $("#errPhone").hide().html("");
	if(provinceId == '-1'){
		$("#errProvince").show().html("Vui lòng chọn tỉnh thành phố.");
		return false;
	}else $("#errProvince").hide().html("");
	
	if(districtId == '-1'){
		$("#errDistrict").show().html("Vui lòng chọn quận huyện.");
		return false;
	}else $("#errDistrict").hide().html("");
	
	if(wardsId == '-1'){
		$("#errWards").show().html("Vui lòng chọn xã phường.");
		return false;
	}else $("#errWards").hide().html("");
	if(addressDetail == ''){
		$("#errAddressDetail").show().html("Địa chỉ không được để trống.");
		return false;
	}else $("#errAddressDetail").hide().html("");
	
	$.ajax({
		url: "/save-customer-address",
		type: "post",
		dataType: "json",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(data){
			console.log(data.obj);
			window.location.href = "/cart/cart-payment";
		},
		error: function(err){
			console.log(err);
		}
	})
})

function deleteOrder(id){
	var $confirm = confirm("Bạn có chắc chắn muốn hủy đơn hàng?");
	if($confirm){
		$.ajax({
			url: "/profile/order/delete/"+id,
			type: "post",
			dataType: "json",
			success: function(data){
				if(data.statusCode == 400){
					alert(data.obj);
					return;
				}
				if(data.statusCode == 200){
					alert(data.obj);
					window.location.href = "/profile/order";
				}
			},
			error: function(err){
				console.log(err);
			}
		})
	}
}

function toggleFavoriteBook(id){
	var $act = $("#act"+id);
	var action = $act.attr("data-act");
	$.ajax({
		url: "/favorite-book/"+action+"/"+id,
		type: "post",
		dataType: "json",
		success: function(data){
			if(data.statusCode == 400){
				alert(data.obj);
			}
			if(data.statusCode == 200){
				if(action == "add"){
					$act.attr("data-act", "remove");
					$act.find("span").removeClass("heart-white").addClass("heart-red");
				}else {
					$act.attr("data-act", "add");
					$act.find("span").removeClass("heart-red").addClass("heart-white");
				}
			}
		},
		error: function(err){
			console.log(err);
		}
	})
}

