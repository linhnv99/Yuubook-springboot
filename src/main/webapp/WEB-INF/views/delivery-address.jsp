<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="vn">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Giỏ hàng</title>
<jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>
<style>
select:disabled, input:disabled {
	background-color: #f2f2f2;
}

#saveProfile, #saveAddress {
	color: #fff !important;
	font-family: montserrat-medium;
}

textarea {
	padding: 5px;
	font-size: 14px;
	font-family: montserrat-medium;
	font-size: 14px;
	opacity: 0.9
}
small{
	    display: block;
    margin-top: 5px;
    margin-left: 169px;
    font-weight: 600;
    color: #ff0000;
    display: none;
}
</style>
<c:set value="${DIA_CHI_KHACH_HANG }" var="customerAddress"></c:set>
<body
	onload="getDistrict(${customerAddress!=null ? customerAddress.provinceId : 'null'}, 
							${customerAddress!=null ? customerAddress.districtId : 'null'}),
							getWards(${customerAddress!=null ? customerAddress.districtId : 'null' },
							${customerAddress!=null ? customerAddress.wardsId : 'null'})">
	<div class="wrapper" id="bg-white">
		<!-- start header -->
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		<!-- end header -->
		<div class="mainbox-content">
			<div class="container-fluid">
				<div class="box-process">
					<div class="timeline-process-cart">
						<div class="step step1 active">
							<span class="title">Kiểm tra giỏ hàng</span> <span class=>1</span>
						</div>
						<div class="step step2 active">
							<span class="title">Địa chỉ giao hàng</span> <span>2</span>
						</div>
						<div class="step step3 ">
							<span class="title">Xác nhận đặt hàng </span> <span>3</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- end timeline-process-cart -->
		<!-- mainbox-content-cart -->
		<div class="mainbox-content" id="mainbox-content-cart">
			<div class="container-fluid">
				<div class="mainbox-body bg-cart">
					<!-- box-info-cart -->
					<div class="box-info-cart">
						<div class="title">Địa chỉ giao hàng</div>
						<div class="form-group" id="form-group">
							<form action="">
								<div class="input-group">
									<label for="name">Họ tên: <span class="req">*</span></label> <input
										type="text" id="fullname" value="${customerAddress!=null ? customerAddress.fullname : '' }">
									<small id="errName"></small>
								</div>
								<div class="input-group">
									<label for="phone">Số điện thoại: <span class="req">*</span></label>
									<input type="text" id="phone" value="${customerAddress!=null ? customerAddress.phone : '' }">
									<small id="errPhone"></small>
								</div>
								<div class="input-group">
									<label for="province">Tỉnh thành: <span class="req">*</span></label>
									<select id="province" onchange="getDistrict(this.value, '')">
										<option value="-1">-- Chọn tỉnh, thành phố --</option>
										<c:forEach items="${province }" var="p">
											<c:choose>
												<c:when
													test="${customerAddress!=null && customerAddress.provinceId == p.id }">
													<option value="${p.id }" selected="selected">${p.name }</option>
												</c:when>
												<c:otherwise>
													<option value="${p.id }">${p.name }</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
									<small id="errProvince"></small>
								</div>
								<div class="input-group">
									<label for="district">Quận huyện: <span class="req">*</span></label>
									<select id="district" disabled="disabled"
										onchange="getWards(this.value, '')">
										<option>-- Chọn quận huyện --</option>
									</select>
									<small id="errDistrict"></small>
								</div>
								<div class="input-group">
									<label for="wards">Phường xã: <span class="req">*</span></label>
									<select id="wards" disabled="disabled">
										<option>-- Chọn phường xã --</option>
									</select>
									<small id="errWards"></small>
								</div>
								<div class="input-group">
									<label for="">Địa chỉ chi tiết: <span class="req">*</span></label>
									<input type="text" id="addressDetail" value="${customerAddress!=null ? customerAddress.addressDetail : '' }" />
									<small id="errAddressDetail"></small>
								</div>
								<div class="input-group">
									<label for="note">Ghi chú giao hàng:</label> <input type="text"
										value="${customerAddress!=null ? customerAddress.note : '' }"
										id="note">
								</div>
								<div class="input-group">
									<a href="" id="saveCusomerAddress"
										style="background-color: #087b39; margin-left: 169px; margin-top: 15px;">Lưu & tiếp tục</a>
									<a href="${path }/cart">Quay lại</a>
								</div>
							</form>

						</div>
<%-- 						<a href="${path }/cart/cart-payment" class="next-checkout mr-5">Tiếp
							tục</a>
 --%>						<div class="clearfix"></div>
					</div>
					<!-- end box-info-cart -->
				</div>
			</div>
		</div>
		<!-- end mainbox-content-cart -->
		<!--footer  -->
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		<!--end footer  -->
	</div>
	<!-- end-wrapper -->

	<!-- model login -->
	<jsp:include page="/WEB-INF/views/layout/login.jsp"></jsp:include>
	<!-- end model login -->
</body>
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</html>