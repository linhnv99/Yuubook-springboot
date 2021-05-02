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
<style>
th {
	font-weight: bold;
}

th, td, .order-deleted {
	font-size: 14px;
	font-family: montserrat-medium;
	padding: 8px;
}

.order-deleted:hover {
	text-decoration: underline !important
}

.action>a {
	font-size: 12px;
	font-weight: bold;
	color: #fff !important;
	padding: 4px 6px;
	cursor: pointer;
}

.status {
	width: 125px;
	text-align: center;
	display: inline-block;
	padding: 4px 8px;
	color: #fff;
	border-radius: 5px;
	font-size: 13px;
}

.order-detail {
	font-family: montserrat-medium;
}

.order-detail p {
	font-size: 14px;
	margin-bottom: 4px;;
	display: flex;
	justify-content: space-between;
}

.order-detail h6 {
	font-weight: bold;
}

#rate-now span {
	display: inline
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
							<div class="title">Đánh giá của tôi</div>
							<div class="box-order">
								<c:choose>
									<c:when test="${comments.size() > 0 }">
										<table width="100%">
											<thead>
												<tr>
													<th>STT</th>
													<th width="25%">Time</th>
													<th width="30%">Sách</th>
													<th>Đánh giá</th>
													<th>Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${comments }" var="comment"
													varStatus="loop">
													<tr>
														<td>${loop.index + 1 }</td>
														<td>
															<fmt:parseDate value="${comment.date }" type="both" pattern="yyyy-MM-dd'T'HH:mm:ss" var="myDate"></fmt:parseDate>
															<fmt:formatDate value="${myDate }" pattern="dd-MM-yyyy HH:mm:ss"/>
														</td>
														<td>${comment.book.name }</td>
														<td>
															<div class="rate-now mb-2" id="rate-now">
																<c:set value="${comment.star + 1 }" var="starInt"></c:set>
																<span class="ml-0 mt-1"> <a
																	class="star ${starInt > 1 ? 'active' : '' }"
																	href="javascript:void(0)"></a> <a
																	class="star ${starInt > 2 ? 'active' : '' }"
																	href="javascript:void(0)"></a> <a
																	class="star ${starInt > 3 ? 'active' : '' }"
																	href="javascript:void(0)"></a> <a
																	class="star ${starInt > 4 ? 'active' : '' }"
																	href="javascript:void(0)"></a> <a
																	class="star ${starInt > 5 ? 'active' : '' }"
																	href="javascript:void(0)"></a>
																</span>
															</div>
														</td>
														<td>
															<div class="action">
																<a class="btn btn-info"
																	href="${path }/san-pham/${comment.book.slug}">Xem</a>
																<a class="delete-comment btn btn-danger"
																	data-id="${comment.id }">Xóa</a>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<p class="text-center my-4">Bạn chưa có đánh giá nào.</p>
									</c:otherwise>
								</c:choose>
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
	<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</body>

</html>