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
<title>Đăng kí</title>
<jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>

<body cz-shortcut-listen="true">
	<div class="wrapper" id="bg-white">
		<!-- start header -->
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		<!-- end header -->
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
													<li><a href="${path }/the-loai/${subCate.slug}">${subCate.name }</a></li>
												</c:forEach>
											</ul></li>
								</c:if>
								</c:if>
							</c:forEach>
							<li><a href="${path }/product/hot">Kho sách hot</a></li>

						</ul>
					</div>
				</div>
				<div class="col-9 pl-0"></div>
			</div>
		</div>
		<!-- end category-banner -->
		<div class="list-category-throught">
			<div class="container-fluid">
				<ul>
					<li><a href="${path }/">Trang chủ</a> <img
						src="images/right-arrow.png" alt="" class="img-fluid"></li>
					<li><a href="#">Tạo tài khoản mới</a></li>
				</ul>
			</div>
		</div>
		<div class="mainbox2-content">
			<div class="container-fluid">
				<div class="mainbox2-title">
					<span>Chưa có tài khoản? Đăng ký ngay</span>
				</div>
				<div class="mainbox2-body">
					<div class="row">
						<div class="col-7 px-5 py-2">
							<div class="title">ĐĂNG KÝ TÀI KHOẢN</div>
							<div class="form-group">
								<form action="" method="POST" id="formValid">
									<div class="input-group">
										<label for="name">Họ đệm <span class="req">*</span></label> <input
											type="text" id="re-surname"> <small id="errSurname"></small>
									</div>
									<div class="input-group">
										<label for="name">Tên <span class="req">*</span></label> <input
											type="text" id="re-name"> <small id="errName"></small>
									</div>
									<div class="input-group">
										<label for="email">Email <span class="req">*</span></label> <input
											type="email" id="re-email"> <small id="errEmail"></small>
									</div>
									<div class="input-group">
										<label for="pass"> Mật khẩu <span class="req">*</span></label>
										<input type="password" id="re-password"> <small
											id="errPassword"></small>
									</div>
									<div class="input-group">
										<label for="confirmPass">Xác nhận mật khẩu <span
											class="req">*</span></label> <input type="password"
											id="re-confirmPassword"> <small
											id="errConfirmPassword"></small>
									</div>
									<div class="input-group">
										<input type="submit" id="btnRegister" value="Đăng Ký">
									</div>
								</form>
							</div>
						</div>
						<div class="col-5">
							<div class="box-login-social">
								<span class="title">Đăng nhập bằng tài khoản khác</span>
								<%--								<a href="#"> <img src="images/fb.png" alt="" width="220"--%>
								<%--												  class="img-fluid fb">--%>
								<%--								</a>--%>
								<a
										href="${path}/oauth2/authorization/google">
									<img src="images/google.png" alt="" width="280"
										 class="img-fluid gg">
								</a>

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

</html>