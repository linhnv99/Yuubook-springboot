<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vn">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin tài khoản</title>
    <jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>
<style>
    .box-info {
        border-bottom: 1px solid #f7f7f7;
    }

    .box-address {
        margin-top: 20px;
    }

    .box-info, .box-address {
        font-family: montserrat-medium;
        font-size: 14px;
    }

    .box-info > p > span {
        font-size: 16px;
        margin-left: 12px;
    }

    .box-address > p {
        font-size: 15px;
    }

    .box-address > h6 > a {
        font-size: 13px;
        color: #087b39 !important;
    }

    .avatar-wrapper {
        position: relative;
        height: 200px;
        width: 200px;
        margin: 5px 10px 20px 30px;
        border-radius: 50%;
        overflow: hidden;
        box-shadow: 0 3px 10px -5px #000;
        transition: all .3s ease;
        cursor: pointer;
    }

    .avatar-wrapper:hover {
        transform: scale(1.01);
        cursor: pointer;
    }

    .avatar-wrapper:hover .profile-pic {
        opacity: .5;
    }

    .profile-pic {
        height: 100%;
        width: 100%;
        transition: all .3s ease;
    }

    .profile-pic:after {
        font-family: FontAwesome;
        content: "\f007";
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        position: absolute;
        font-size: 190px;
        background: #ecf0f1;
        color: #34495e;
        text-align: center;
    }

    .upload-button {
        position: absolute;
        top: 0;
        left: 0;
        height: 100%;
        width: 100%;
    }

    .upload-button .fa-arrow-circle-up {
        position: absolute;
        font-size: 234px;
        top: -17px;
        left: 0;
        text-align: center;
        opacity: 0;
        transition: all .3s ease;
        color: #34495e;
    }

    .upload-button:hover .fa-arrow-circle-up {
        opacity: .9;
    }

</style>
<body>
<div class="wrapper">
    <!-- start header -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    <!-- end header -->
    <!-- start category-banner -->
    <div class="container-fluid">
        <div class="row">
            <div class="col-3 pr-0">
                <div class="category" id="category-hover">
                    <span> Danh mục sản phẩm</span>
                    <ul>
                        <c:forEach items="${categories }" var="category">
                            <c:if test="${category.parentId == null  && category.status}">
                                <li><a
                                href="${path }/the-loai/${category.slug}">${category.name }
                                <c:if test="${category.subCategories.size() > 0 }">
                                    <img class="arrow" src="images/right-arrow.png" alt="">
                                </c:if>
                                </a> <c:if test="${category.subCategories.size() > 0 }">
                                <ul class="submenu">
                                    <span>${category.name }</span>
                                    <c:forEach items="${category.subCategories }" var="subCate">
                                        <c:if test="${subCate.status }">
                                            <li><a href="${path }/the-loai/${subCate.slug}">${subCate.name }</a></li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                                </li>
                            </c:if>
                            </c:if>
                        </c:forEach>
                        <li><a href="${path }/product/hot">Kho sách hot</a></li>

                    </ul>
                </div>
            </div>
            <div class="col-9">
                <div id="bg-cate"></div>
            </div>
        </div>
    </div>
    <!-- end category-banner -->
    <div class="mainbox2-content">
        <div class="container-fluid" id="control-panel">
            <div class="row">
                <div class="col-3 pr-0">
                    <div class="mainbox2-body panel">
                        <c:import url="/WEB-INF/views/layout/user-dashboard.jsp"></c:import>
                    </div>
                </div>
                <div class="col-9 pl-4">
                    <div class="mainbox2-body py-2 px-3">
                        <div class="title">Bảng điều khiển của người dùng</div>
                        <div class="row">
                            <div class="col-8">
                                <div class="box-info pl-3 pt-3 ">
                                    <p>Họ tên: <span> ${user.surname } ${user.name }</span></p>
                                    <p>Email: <span> ${user.email } </span></p>
                                    <p>Số điện thoại:
                                        <span> ${user.phone != '' && user.phone!=null ? user.phone : 'không xác định' } </span>
                                    </p>
                                </div>
                                <div class="box-address pl-3 pb-4">
                                    <h6>ĐỊA CHỈ GIAO HÀNG MẶC ĐỊNH <a href="${path }/profile/address">(Sửa)</a></h6>
                                    <c:if test="${userAddress.id !=null }">
                                        <p>${userAddress.addressDetail }, ${userAddress.wards }
                                            - ${userAddress.district } - ${userAddress.province }</p>
                                    </c:if>
                                    <c:if test="${userAddress.id == null }">
                                        <p>Không xác định</p>
                                    </c:if>
                                </div>
                            </div>
                            <div clas="col-4">
                                <form method="post" enctype="multipart/form-data" id="upload-file-form">
                                    <div class="avatar-wrapper">
                                        <c:choose>
                                            <c:when test="${user.avatar != null}">
                                                <img class="profile-pic" src="${user.avatar}" alt=""/>
                                            </c:when>
                                            <c:otherwise>
                                                <img class="profile-pic" src="${path }/images/user.png" alt=""/>

                                            </c:otherwise>
                                        </c:choose>
                                        <div class="upload-button">
                                            <i class="fa fa-arrow-circle-up" aria-hidden="true"></i>
                                        </div>
                                        <input class="file-upload" type="file" name="file" accept="*"/>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div style="margin-bottom: 60px;"></div>
        </div>
    </div>
    <!--footer  -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    <!--end footer  -->

</div>
<!-- end-wrapper -->

<!-- model login -->
<jsp:include page="/WEB-INF/views/layout/login.jsp"></jsp:include>
<!-- end model login -->
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</body>
<script>

    $(document).ready(function() {
        var readURL = function(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('.profile-pic').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $(".file-upload").on('change', function(){
            readURL(this);

            $.ajax({
                url: "/profile/upload",
                type: "POST",
                data: new FormData($("#upload-file-form")[0]),
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: function (data) {
                    if (data.statusCode == 200)
                        console.log("SUCCESS")
                    else
                        console.log("ERROR")
                },
                error: function () {
                    console.log("ERROR")
                }
            });
        });

        $(".upload-button").on('click', function() {
            $(".file-upload").click();
        });
    });
</script>
</html>