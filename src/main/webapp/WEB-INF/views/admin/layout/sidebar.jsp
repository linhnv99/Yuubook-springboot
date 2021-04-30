<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<div class="col-md-3 left_col menu_fixed">
    <div class="left_col scroll-view">

        <div class="clearfix"></div>
        <sec:authentication property="principal" var="adminLogin"/>
        <!-- menu profile quick info -->
        <div class="profile clearfix">
            <div class="profile_pic">
                <c:choose>
                    <c:when test="${adminLogin.avatar != null }">
                        <img src="${adminLogin.avatar}" alt="" height="56" width="56"
                             class="img-circle profile_img">
                    </c:when>
                    <c:otherwise>
                        <img src="${path}/images/user.png" alt=""
                             class="img-circle profile_img">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="profile_info">
                <span>Welcome,</span>
                <h2>${adminLogin.surname } ${adminLogin.name }</h2>
            </div>
        </div>
        <!-- /menu profile quick info -->

        <br/>

        <!-- sidebar menu -->
        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
            <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                    <li><a href="${path }/admin/dashboard"><i class="fa fa-home"></i> Trang chủ</a></li>
                    <li><a><i class="fa fa-comments"></i> Liên hệ <span
                            class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu">
                            <li><a href="${path }/admin/contact">Góp ý</a></li>
                            <li><a href="${path }/admin/comment">Đánh giá</a></li>
                        </ul>
                    </li>
                    <li><a><i class="fa fa-edit"></i> Sản phẩm <span
                            class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu">
                            <li><a href="${path }/admin/category">Danh mục sản phẩm</a></li>
                            <li><a href="${path }/admin/product">Danh sách sản phẩm</a></li>
                            <li><a href="${path }/admin/publisher">Nhà xuất bản</a></li>
                            <li><a href="${path }/admin/author">Tác giả</a></li>
                        </ul>
                    </li>
                    <li><a href="${path }/admin/user"><i class="fa fa-users"></i>Người
                        dùng</a></li>
                    <li><a href="${path }/admin/order"><i
                            class="fa fa-building"></i>Đơn hàng</a></li>

                    <li>
                        <a><i class="fa fa-comments"></i>Khác <span
                                class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu">
                            <li><a href="${path }/admin/notifications">Notification</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!-- /sidebar menu -->

        <!-- /menu footer buttons -->
        <div class="sidebar-footer hidden-small"></div>
        <!-- /menu footer buttons -->
    </div>
</div>