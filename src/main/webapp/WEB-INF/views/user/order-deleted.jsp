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
							<div class="title">Danh sách đơn hàng đã hủy</div>
							<div class="box-order">
								<c:choose>
									<c:when test="${orders.size() > 0 }">
										<table width="100%">
											<thead>
												<tr>
													<th>Mã HĐ</th>
													<th>Người nhận</th>
													<th>Thành tiền</th>
													<th>Thời gian mua</th>
													<th>Trạng thái</th>
													<th>Thao tác</th>
												</tr>
												</head>
											<tbody>
												<c:forEach items="${orders }" var="order">
													<tr>
														<td>HD${order.id }</td>
														<td>${order.fullName }</td>
														<td><fmt:formatNumber type="number"
																pattern="###,###,###" value="${order.totalPriceOrder }"></fmt:formatNumber>đ</td>
														<td>
<%--															<fmt:parseDate value="${order.buyDate }" type="both" pattern="yyyy-MM-dd'T'HH:mm" var="myDate"></fmt:parseDate>--%>
<%--															<fmt:formatDate value="${myDate }" pattern="dd-MM-yyyy HH:mm"/>--%>
															${order.buyDate }
														</td>
														<td><c:if test="${!order.status}">
																<span class="bg-secondary status"> Đã hủy</span>
															</c:if>
														<td>
															<div class="action">
																<a data-toggle="modal" data-target="#order${order.id }"
																	class="btn btn-info">Xem</a>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<p class="text-center mt-4">Bạn chưa có đơn hàng nào</p>
									</c:otherwise>
								</c:choose>
								<div class="text-right mt-3 mb-2">
									<a href="${path }/profile/order" class="order-deleted">Quay Lại</a>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div style="margin-bottom: 60px;"></div>
			</div>
		</div>

		<!-- Modal -->
		<c:forEach items="${orders }" var="order">
			<div class="modal fade" id="order${order.id }" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-body">
							<div class="order-detail">
								<div class="mainbox2-body"
									style="border: none; margin-bottom: 60px;">
									<h6 class="text-center mt-5 mb-4">DANH SÁCH SẢN PHẨM</h6>
									<div class="box-order">
										<table width="100%" class="table-bordered">
											<thead>
												<tr>
													<th>Sản phẩm</th>
													<th>Ảnh</th>
													<th>Số lượng</th>
													<th>Đơn giá</th>
													<th>Thành tiền</th>
												</tr>
												</head>
											<tbody>
												<c:forEach items="${order.orderDetails }" var="orderDetail">
													<tr>
														<td><a
															href="${path }/san-pham/${orderDetail.book.slug}">${orderDetail.book.name }</a></td>
														<td><img
															src="${path }/files/${orderDetail.book.avatar}"
															class="img-fluid" style="max-height: 90px"></td>
														<td>${orderDetail.quantity }</td>
														<td><fmt:formatNumber type="number"
																pattern="###,###,###" value="${orderDetail.unitPrice}"></fmt:formatNumber>đ
														</td>
														<td><fmt:formatNumber type="number"
																pattern="###,###,###"
																value="${orderDetail.quantity *  orderDetail.unitPrice}"></fmt:formatNumber>đ
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<h6>Địa chỉ giao hàng</h6>
										<p>${order.fullName }</p>
										<p>${order.addressDetail },${order.wards }-
											${order.district } - ${order.province }</p>
										<p>${order.phone }</p>
										<div class="my-4"></div>
										<h6>Địa chỉ thanh toán</h6>
										<p>${order.fullName }</p>
										<p>${order.addressDetail },${order.wards }-
											${order.district } - ${order.province }</p>
										<p>${order.phone }</p>
									</div>
									<div class="col-6">
										<h6>Tổng cộng</h6>
										<p>
											Tạm tính: <span><fmt:formatNumber type="number"
													pattern="###,###,###" value="${order.totalPriceOrder }"></fmt:formatNumber>đ</span>
										</p>
										<p>
											Phí vận chuyển: <span>Miễn phí</span>
										</p>
										<p>
											Hình Thức: <span>Thanh toán khi nhận hàng</span>
										</p>
										<hr>
										<p>
											Tổng cộng(Bao gồm VAT): <b style="font-size: 16px;"><fmt:formatNumber
													type="number" pattern="###,###,###"
													value="${order.totalPriceOrder }"></fmt:formatNumber>đ</b>
										</p>
									</div>
								</div>

							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>

		<!--footer  -->
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		<!--end footer  -->


	</div>
	<!-- end-wrapper -->
	<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</body>

</html>