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
<title>Thông tin tài khoản</title>
<jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>

<body
	onload="getDistrict(${userAddress!=null ? userAddress.provinceId : 'null'}, ${userAddress!=null ? userAddress.districtId : 'null'}),
							getWards(${userAddress!=null ? userAddress.districtId : 'null' },
							${userAddress!=null ? userAddress.wardsId : 'null'})">
	<div class="wrapper" >
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
										href="${path}/the-loai/${category.slug}">${category.name }
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
											</ul></li>
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
							<div class="title">
								Địa chỉ giao hàng <small style="font-family: arial">(mặc
									định)</small>
							</div>

							<div class="form-group d-flex justify-content-center">
								<form action="/save-address" method="POST">
									<input type="hidden"
										value="${userAddress!= null ? userAddress.id : '' }" id="aid" />

									<div class="input-group">
										<label for="province">Tỉnh thành:</label> <select
											id="province" onchange="getDistrict(this.value, '')">
											<option value="-1">-- Chọn tỉnh, thành phố --</option>
											<c:forEach items="${province }" var="p">
												<c:choose>
													<c:when test="${userAddress.provinceId == p.id }">
														<option value="${p.id }" selected="selected">
															${p.name }</option>
													</c:when>
													<c:otherwise>
														<option value="${p.id }">${p.name }</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
									<div class="input-group">
										<label for="district">Quận huyện:</label> <select
											id="district" disabled="disabled"
											onchange="getWards(this.value, '')">
											<option>-- Chọn quận huyện --</option>
										</select>
									</div>
									<div class="input-group">
										<label for="wards">Phường xã:</label> <select id="wards"
											disabled="disabled">
											<option>-- Chọn phường xã --</option>
										</select>
									</div>
									<div class="input-group">
										<label for="">Địa chỉ chi tiết:</label>
										<textarea rows="5" cols="35" id="addressDetail">${userAddress!=null ? userAddress.addressDetail : '' }</textarea>
									</div>
									<a href="#" class="btn btn-success px-5 my-3" id="saveAddress">Cập
										nhật</a>
								</form>
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