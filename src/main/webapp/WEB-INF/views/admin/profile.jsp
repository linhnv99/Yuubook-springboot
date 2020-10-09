<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="vn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Người dùng</title>

<c:import url="/WEB-INF/views/admin/layout/css.jsp"></c:import>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<!-- sidebar -->
			<c:import url="/WEB-INF/views/admin/layout/sidebar.jsp"></c:import>
			<!-- /sidebar -->
			<!--  top nav -->
			<c:import url="/WEB-INF/views/admin/layout/nav.jsp"></c:import>
			<!-- /top nav -->
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title"></div>

					<div class="clearfix"></div>

					<form:form action="/admin/profile/save-profile"
						modelAttribute="user" method="post" enctype="multipart/form-data">
						<div class="row">
							<div class="col-7">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											<i class="fa fa-align-left"></i> Thông tin cá nhân
										</h2>
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<form:hidden path="id" />
										<div class="form-group">
											<label for="surname">Họ đệm</label>
											<form:input type="text" path="surname" class="form-control" />
										</div>
										<div class="form-group">
											<label for="name">Tên</label>
											<form:input type="text" path="name" class="form-control" />
										</div>
										<div class="form-group">
											<label for="email">Email</label> <input type="email"
												disabled="disabled" value="${user.email }"
												class="form-control" />
											<form:hidden path="email" />
										</div>
										<div class="form-group">
											<label for="phone">Số điện thoại</label>
											<form:input type="text" path="phone" class="form-control" />
										</div>
										<div class="form-group">
											<label for="password">Mật khẩu mới</label> <input
												placeholder="******" type="password" name="password"
												class="form-control"> <small>Bỏ trống nếu
												không thay đổi mật khẩu.</small>
											<c:if test="${not empty error }">
												<small class="text-danger mt-2" style="font-size: 16px;">${error }</small>
											</c:if>
										</div>
										<button type="submit" class="btn btn-primary float-right">Lưu</button>
									</div>
								</div>
							</div>
							<!-- end col-6 -->
							<div class="col-5">
								<div class="bg-white x_panel text-center">
									<c:choose>
										<c:when test="${user.avatar == null }">
											<img src="${path }/images/user.png" alt=""
												style="max-height: 200px;">
										</c:when>
										<c:otherwise>
											<img src="${path }/files/${user.avatar }" alt=""
												style="max-height: 200px;">
										</c:otherwise>
									</c:choose>
									<div class="form-group">
										<label for="avatar"></label> <input type="file"
											class="form-control" name="uavatar" />
									</div>
								</div>
								<c:if test="${not empty success }">
									<div class="mb-0 alert alert-success" id="mess">${success }</div>
								</c:if>
								<script type="text/javascript">
									setTimeout(function() {
										$('#mess').fadeOut('low');
									}, 2000);
								</script>
							</div>
						</div>
					</form:form>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			<c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
			<!-- /footer content -->
		</div>
	</div>
	<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
</body>

</html>