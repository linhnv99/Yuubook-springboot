<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en-vn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />

<title>Trang chủ</title>

<c:import url="/WEB-INF/views/admin/layout/css.jsp"></c:import>
</head>
<style>
.box-widget {
	overflow: hidden;
	border-radius: 4px;
	box-shadow: 0 3px 5px #c4c4c4;
}

.box-widget>div {
	height: 90px;
	width: 100%;
	font-family: Verdana, Geneva, Tahoma, sans-serif;
}

.box-widget>div p {
	margin-bottom: 5px;
	font-size: 12px;
}

.box-widget>div span {
	font-size: 18px;
}

.box-widget>div a {
	font-size: 12px;
	margin-left: 4px;
}

.box-widget>div.left {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 40%;
	float: left;
}

.box-widget>div.right {
	padding: 10px;
	background-color: #fff;
	width: 60%;
	float: left;
}

.box-widget>div>i {
	font-size: 45px;
	color: #fff
}

.box-widget .user {
	background-color: #3498db;
}

.box-widget .product {
	background-color: #05c46b;
}

.box-widget .order {
	background-color: #e74c3c;
}

.box-widget .money {
	background-color: #e67e22;
}

select {
	border: 1px solid #ccc;
	color: #000;
	padding: 2px 6px;
}
</style>
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
			<div class="right_col" role="main" style="color: rgba(0, 0, 0, 0.9)">
				<div>
					<div class="title">
						<h6 class=" mb-4">Bảng điều khiển</h6>
					</div>
					<div class="row mt-3">
						<div class="col-3">
							<div class="box-widget">
								<div class="order left">
									<i class="fa fa-shopping-cart"></i>
								</div>
								<div class="right">
									<p>ĐƠN HÀNG</p>
									<span>${totalNumberOfOrders }</span><a
										href="${path }/admin/order">(Chi tiết)</a>
								</div>
							</div>
						</div>
						<div class="col-3">
							<div class="box-widget">
								<div class="user left">
									<i class="fa fa-users"></i>
								</div>
								<div class="right">
									<p>THÀNH VIÊN</p>
									<span>${totalNumberOfUsers }</span><a
										href="${path }/admin/user">(Chi tiết)</a>
								</div>
							</div>
						</div>
						<div class="col-3">
							<div class="box-widget">
								<div class="product left">
									<i class="fa fa-book"></i>
								</div>
								<div class="right">
									<p>SẢN PHẨM</p>
									<span>${totalNumberOfProducts }</span><a
										href="${path }/admin/product">(Chi tiết)</a>
								</div>
							</div>
						</div>
						<div class="col-3">
							<div class="box-widget">
								<div class="money left">
									<i class="fa fa-dollar"></i>
								</div>
								<div class="right">
									<p>TỔNG DOANH THU</p>
									<span><fmt:formatNumber type="number"
											pattern="###,###,###" value="${totalSales}"></fmt:formatNumber>đ</span>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row mt-5">
					<div class="x_panel">
						<div class="x_title">
							<h2>Đơn hàng chờ xác nhận</h2>
							<div class="clearfix"></div>
						</div>

						<div class="x_content">
							<div class="row">
								<div class="col-sm-12">
									<div class="card-box table-responsive">
										<table id="" class="table-hover" style="width: 100%">
											<thead>
												<tr style="font-weight: bold">
													<th width="10%">Mã HĐ</th>
													<th width="20%">Người nhận</th>
													<th width="15%">Tổng tiền</th>
													<th width="15%">Ngày tạo</th>
													<th width="18%">Trạng thái</th>
													<th width="15%">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${orders }" var="order">
													<tr>
														<td>HD${order.id }</td>
														<td>${order.fullName }</td>
														<td><fmt:formatNumber type="number"
																pattern="###,###,###" value="${order.totalPriceOrder }"></fmt:formatNumber>đ</td>
														<td>${order.buyDate }</td>
														<td><span
															class="bg-secondary text-white py-1 px-2 rounded">Chờ
																xác nhận</span></td>
														<td>
															<div class="action">
																<a href="" class="btn btn-info editAuthor custom"
																	data-toggle="modal" data-target="#order${order.id }">
																	<i class="fa fa-edit"></i>
																</a> <a href="${path }/admin/order/confirm?id=${order.id}"
																	class="btn btn-success bg-success custom">Xác nhận</a>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>





				<div class="row mt-5">
					<div class="x_panel">
						<div class="x_title">
							<h2>Top 10 sản phẩm được mua nhiều nhất</h2>
							<div class="clearfix"></div>
						</div>

						<div class="x_content">
							<div class="row">
								<div class="col-sm-12">
									<div class="card-box table-responsive">
										<table id="" class="table-hover" style="width: 100%">
											<thead>
											<tr style="font-weight: bold">
												<th width="10%">STT</th>
												<th width="10%">Ảnh</th>
												<th width="20%">Tên sản phẩm</th>
												<th width="20%">Danh mục</th>
												<th width="10%">Lượt mua</th>
											</tr>
											</thead>
											<tbody>
											<c:forEach items="${books }" var="book" varStatus="loop">
												<tr>
													<td>${loop.count}</td>
													<td>
														<img height="55" alt="avatar"
															 src="${path}/files/${book.avatar }">
													</td>
													<td><a href="${path}/san-pham/${book.slug}" style="color: #000!important">${book.name}</a></td>
													<td><span>${book.category.name }</span></td>
													<td>${book.buyCount}</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /page content -->
		<c:forEach items="${orders }" var="order">
			<div class="modal fade " tabindex="-1" id="order${order.id }"
				role="dialog" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h6 class="modal-title" id="myModalLabel">Mã HĐ:
								DH${order.id }</h6>
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<h4 class="text-center my-4" style="color: #000">Danh sách
								sản phẩm</h4>
							<div class="row">
								<div class="col-12">
									<table class="table table-bordered ">
										<thead>
											<tr>
												<th width="40%">Sản phẩm</th>
												<th width="15%">Ảnh</th>
												<th width="12%">Số lượng</th>
												<th>Đơn giá</th>
												<th>Thành tiền</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${order.orderDetails }" var="orderDetail">
												<tr>
													<td>${orderDetail.book.name }</td>
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
							<div class="row summary-cate">
								<div class="col-7">
									<div class="sub-title">Thông tin giao hàng</div>
									<div class="box-confirm">
										<p>
											Người nhận : <span>${order.fullName }</span>
										</p>
										<p>
											SDT : <span>0986613124</span>
										</p>
										<p>
											Địa chỉ: <span style="width: 350px">${order.addressDetail },
												${order.wards } - ${order.district } - ${order.province }</span>
										</p>
										<p>
											Ghi chú: <span>${order.note != '' ? order.note : 'không có' }</span>
										</p>
									</div>
								</div>
								<div class="col-5">
									<div class="sub-title">Tóm tắt đơn hàng</div>
									<div class="box-confirm">
										<p>
											Sản phẩm: <span>${order.orderDetails.size() } sản phẩm</span>
										</p>
										<p>
											Tổng tiền: <span> <fmt:formatNumber type="number"
													pattern="###,###,###" value="${order.totalPriceOrder }"></fmt:formatNumber>đ
											</span>
										</p>
										<p>
											Hình thức: <span>Thanh toán khi nhận hàng</span>
										</p>
										<p>
											Phí vận chuyển: <span>Miễn phí</span>
										</p>
										<p>
											Ngày tạo: <span>${order.buyDate }</span>
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
		<!-- footer content -->
		<c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
		<!-- /footer content -->
	</div>
	<!--  top nav -->
	<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
	<!-- /top nav -->
</body>
</html>
