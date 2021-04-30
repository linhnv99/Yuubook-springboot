<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>

<style>
    #box-register-notify {
        background: #087b39;
        color: #fff;
        padding: 15px 0;
        margin: 20px 0 45px 0;
        font-family: montserrat-medium;
    }

    #box-register-notify form {
        display: flex;
        align-items: center;
    }

    #box-register-notify form input[type="text"], #box-register-notify form select {
        margin: 10px 5px;
        padding: 8px;
        border-radius: 5px;
        background: #fff;
        border: 1px solid #fff;
        width: 30%;
        height: 42px;
        font-size: 14px;
        outline: none;
    }

    #box-register-notify form input[type="text"]:nth-child(1) {
        width: 40%;
    }
    #box-register-notify form select#category {
        width: 30%;
    }
    #box-register-notify form input[type="button"] {
        border: 1px solid #fff;
        border-radius: 5px;
        width: 160px;
        height: 42px;
        margin-left: 15px;
        padding: 0 10px;
        color: #0b2e13;
    }
</style>

<div id="box-register-notify">
    <div class="container-fluid">
        <div class="row">
            <div class="col-4">
                <h5>ĐĂNG KÝ EMAIL</h5>
                <span>Đăng ký ngay để nhận những thông tin sách mới nào!</span>
            </div>
            <div class="col-8 info">
                <form action="">
                    <input type="text" id="noti-email" placeholder="Nhập email của bạn">

                    <select name="category" id="category">
                        <option value="0" selected>Tất cả thể loại</option>

                        <c:forEach items="${categories }" var="category">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>

                    <input type="button" id="register-notify" value="ĐĂNG KÝ">
                </form>
            </div>
        </div>
    </div>
</div>
<footer>
    <%--	<div class="line"></div>--%>
    <div class="container-fluid">
        <div class="row">
            <div class="col-2">
                <div class="col-footer">
                    <span class="title">Hỗ Trợ Khách Hàng</span>
                    <ul>
                        <li><a href="contact.html">Liên hệ với chúng tôi</a></li>
                        <li><a href="#">Câu hỏi thường gặp</a></li>
                        <li><a href="#">Hướng dẫn đặt hàng</a></li>
                        <li><a href="#">Hướng dẫn thanh toán</a></li>
                        <li><a href="#">Hướng dẫn hủy đơn hàng</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-2">
                <div class="col-footer">
                    <span class="title">Dịch Vụ</span>
                    <ul>
                        <li><a href="#">Chính sách đổi - trả - hoàn tiền</a></li>
                        <li><a href="#">Chính sách khách sỉ</a></li>
                        <li><a href="#">Phương thức vận chuyển</a></li>
                        <li><a href="#">Phương thức thanh toán</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-2">
                <div class="col-footer">
                    <span class="title">Tài Khoản Của Tôi</span>
                    <ul>
                        <li><a href="#">Đăng nhập/Tạo mới tài khoản</a></li>
                        <li><a href="#">Thay đổi địa chỉ khách hàng</a></li>
                        <li><a href="#">Chi tiết tài khoản</a></li>
                        <li><a href="#">Lịch sử mua hàng</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-3">
                <div class="register-book">
                    <span class="title"> Xác Nhận Của Bộ Công Thương</span>
                    <%--                    <form action="">--%>
                    <%--                        <input type="text" placeholder="Nhập email của bạn"> <input--%>
                    <%--                            type="submit" value="Đăng Kí">--%>
                    <%--                    </form>--%>
                    <div class="mt-4">
                        <img src="${path }/images/bo_cong_thuong.png" width="200" alt="" class="img-fluid">
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="register-book">
                    <span class="title"> Các Đối Tác Tin Tưởng</span>
                    <div class="mt-1">
                        <img src="${path }/images/giaonhanh.png" width="120" alt="" class="img-fluid">
                        <img src="${path }/images/lazada.jpg" width="120" alt="" class="img-fluid">
                        <img src="${path }/images/shopee.jpg" width="120" alt="" class="img-fluid">
                        <img src="${path }/images/vn-post.jpg" width="120" alt="" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bot">Copyright 2020 by Linh Nguyen</div>
    </div>
</footer>
<div id="gototop">
    <img src="${path }/images/up-arrow.png" alt="" class="img-fluid">
</div>
