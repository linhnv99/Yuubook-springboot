<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- spring taglibs -->
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<div class="bg-top">
    <div class="container-fluid">
        <div class="header-top">
            <ul>
                <li><i class="flaticon-shipped"></i> Miễn phí giao hàng</li>
                <li><i class="flaticon-books-group"></i> 60.000 tựa sách</li>
            </ul>
            <div class=fb-share>
                <span><i class="flaticon-like"></i> Thích 6.4k </span>
            </div>
        </div>
    </div>
</div>
<div class="header-bottom">
    <div class="container-fluid">
        <div class="row">
            <a href="${path }/" class="brand col-3"> <span>YuuBook</span> <span>.com</span>
            </a>
            <div class="col-6 ">
                <form action="/search" class="box-search" id="topSearch">
                    <input type="text" placeholder="Nhập tên sách, tác giả ..." name="q" id="keySearch"
                           autocomplete="off">
                    <i class="flaticon-search"></i> <input type="submit"
                                                           value="Tìm sách">
                    <ul class="box-result-search">

                    </ul>
                </form>
            </div>
            <div class="col-3">
                <div class="box-cart">
                    <a href="${path}/cart" class="cart"> <span
                            id="js-cartNumber">${GIO_HANG.cartItems.size() > 0 && GIO_HANG.cartItems!=null ? GIO_HANG.cartItems.size() : 0 }
                    </span> <i class="flaticon-shopping-cart"></i>
                    </a>

                    <ul>
                        <sec:authorize access="!isAuthenticated()">
                            <li><a href="${path }/login">Đăng nhập</a></li>
                            <li><a href="${path }/register">Đăng ký</a></li>
                        </sec:authorize>

                        <sec:authorize access="isAuthenticated()">
                            <li>
                                <c:choose>
                                    <c:when test="${userLogin.avatar != null}">
                                        <img src="${userLogin.avatar }" alt="" width="52"
                                             style="border-radius: 50%; border: 1px solid #ccc;
                                              padding: 3px; cursor: pointer;height: 52px;width: 52px;">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${path }/images/user.png" alt="" width="50"
                                             style="border-radius: 50%; border: 1px solid #ccc;
                                             padding: 3px; cursor: pointer;height: 52px; width: 52px;">
                                    </c:otherwise>
                                </c:choose>
                                <ul class="sub-menu">
                                    <li><a href="${path }/profile">Bảng điều khiển</a></li>

                                    <sec:authorize access="hasAuthority('ROLE_ADMIN')">
                                        <li><a href="${path}/admin/dashboard">Trang quản trị</a></li>
                                    </sec:authorize>

                                    <li><a href="${path}/logout">Đăng xuất</a></li>
                                </ul>
                            </li>

                            <li><a href="#"> Xin chào, <span id="userLogin"> ${userLogin.name } </span></a>
                            </li>
                        </sec:authorize>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>