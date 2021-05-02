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
		<div class="list-category-throught">
			<div class="container-fluid">
				<ul>
					<li><a href="index.html">Trang chủ</a> <img
						src="images/right-arrow.png" alt="" srcset="" class="img-fluid"></li>
					<li><a href="#">Liên hệ</a></li>
				</ul>
			</div>
		</div>
		<div class="mainbox2-content">
			<div class="container-fluid">
				<div class="mainbox2-title">
					<span>Liên hệ với chúng tôi!</span>
				</div>
				<div class="mainbox2-body">
					<div class="row">
						<div class="col-7 px-5 py-2">
							<div class="title">Liên Hệ</div>
							<div class="form-group">
								<form method="post" action="/save-contact">
									<div class="input-group">
										<label for="name">Họ tên: </label> <input type="text"
											id="name" />
									</div>
									<div class="input-group">
										<label for="phone">Số điện thoại:</label> <input type="text"
											id="phone" />
									</div>
									<div class="input-group">
										<label for="subject">Tiêu đề:</label> <input type="text"
											id="subject" />
									</div>
									<div class="input-group">
										<label for="content">Nội dung:</label>
										<textarea name="content" id="content" cols="50" rows="4"></textarea>
									</div>

									<div class="input-group">
										<input type="submit" id="submit-contact" value="Gửi">
										<span class="contact-loader" style="margin-left: 35px;
    margin-top: 15px!important;"></span>
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