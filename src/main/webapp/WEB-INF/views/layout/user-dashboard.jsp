<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
select:disabled, input:disabled {
	background-color: #f2f2f2;
}

#saveProfile, #saveAddress {
	color: #fff !important;
	font-family: montserrat-medium;
	margin-left: 169px
}

textarea {
	padding: 5px;
	font-size: 14px;
	font-family: montserrat-medium;
	font-size: 14px;
	opacity: 0.9
}

#control-panel .mainbox2-body {
	border-radius: 0;
	background-color: #fff;
}

#control-panel .panel p {
	font-size: 20px;
	font-weight: bolder;
	border-bottom: 1px solid #ccc;
	margin: 0;
	color: #087b39;
}

#control-panel .panel ul li a {
	display: inline-block;
	width: 100%;
	padding: 10px 20px;
	font-weight: bold;
	border-bottom: 1px solid #f9f9f9;
}

#control-panel .panel ul li a:hover {
	color: #087b39 !important;
}
p.dashboard{padding: 10px 20px;}
</style>
<p class="dashboard">BẢNG ĐIỀU KHIỂN</p>
<ul>
	<li><a href="${path }/profile">Bảng điều khiển</a></li>
	<li><a href="${path }/profile/personal/info">Thông tin tài khoản</a></li>
	<li><a href="${path }/profile/address">Địa chỉ giao hàng</a></li>
	<li><a href="${path }/profile/order">Đơn hàng của tôi</a></li>
	<li><a href="${path }/profile/book/favorite">Sách yêu thích của tôi</a></li>
	<li><a href="${path }/profile/reviews">Đánh giá của tôi</a></li>
</ul>