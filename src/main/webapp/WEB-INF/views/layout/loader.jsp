<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="quantity" value="${GIO_HANG.cartItems.size()}"></c:set>
<div class="preloader">
    <div class="loader">Loading...</div>
</div>
<div class="wp-box">
    <p class="mess">Sản phẩm đã được thêm thành công vào giỏ hàng</p>
    <div class="box-sp">
        <img src="" class="img-fluid" id="p-img">
        <a href="#"
           id="p-name">Thả thính chân kinh</a>
    </div>
    <div class="box-btn mt-1">
        <a href="#" id="mua-tiep">Mua tiếp</a> <a href="${path }/cart">Thanh toán</a>
    </div>
</div>
