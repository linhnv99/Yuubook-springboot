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
<title>Giỏ hàng</title>
<link rel="shortcut icon" href="${path }/images/logo.png">
<jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>

<body>
	<div class="wrapper" id="bg-white">
		<!-- start header -->
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		<!-- end header -->
		<div class="mainbox-content">
			<div class="container-fluid">
				<div class="box-process">
					<div class="timeline-process-cart">
						<div class="step step1 active">
							<span class="title">Kiểm tra giỏ hàng</span> <span class=>1</span>
						</div>
						<div class="step step2 active">
							<span class="title">Địa chỉ giao hàng</span> <span>2</span>
						</div>
						<div class="step step3 active">
							<span class="title">Xác nhận đặt hàng </span> <span>3</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- end timeline-process-cart -->
		<!-- mainbox-content-cart -->
		<div class="mainbox-content" id="mainbox-content-cart">
			<div class="container-fluid">
				<div class="mainbox-body bg-cart">
					<div class="box-info-cart">
						<div class="title">XÁC NHẬN ĐẶT HÀNG</div>
						<c:choose>
							<c:when test="${GIO_HANG.cartItems!=null && GIO_HANG.cartItems.size() > 0}">
								<table>
									<thead>
										<th>Sản phẩm</th>
										<th>Số lượng</th>
										<th>Đơn giá</th>
										<th>Thành tiền</th>
										</head>
									<tbody>
										<c:forEach items="${GIO_HANG.cartItems }" var="book">
											<tr>
												<td width="45%" class="pr-2"><a
													href="${path }/san-pham/${book.slug}"> <img
														style="max-height: 100px"
														src="${path}/files/${book.avatar}" class="img-fluid">
												</a> <a href="${path }/san-pham/${book.slug}"
													class="book-link">${book.bookName }</a></td>
												<td width="25%">
													<div class="quantity" id="q-cart">
														<c:choose>
															<c:when test="${book.quantity > 1 }">
																<input class="qtyminus" value="-" type="button"
																	onclick="updateCart(${book.bookId}, -1)">
															</c:when>
															<c:otherwise>
																<input class="qtyminus" value="-" type="button"
																	disabled="disabled">
															</c:otherwise>
														</c:choose>
														<input class="number" min="1" max="99" id="qty"
															value="${book.quantity }" type="number"
															disabled="disabled">
														<c:choose>
															<c:when test="${book.quantity < 99 }">
																<input class="qtyplus" value="+" type="button"
																	onclick="updateCart(${book.bookId}, 1)" />
															</c:when>
															<c:otherwise>
																<input class="qtyplus" value="+" type="button"
																	disabled="disabled" />
															</c:otherwise>
														</c:choose>
													</div>
												</td>
												<td width="20%"><span class="new-price"> <fmt:formatNumber
															type="number" pattern="###,###,###"
															value="${book.price }"></fmt:formatNumber>đ
												</span> <c:if test="${book.discount!=null}">
														<div>
															<span class="old-price"> <fmt:formatNumber
																	type="number" pattern="###,###,###"
																	value="${book.originPrice }"></fmt:formatNumber>đ
															</span> <small class="discount">${book.discount }%</small>
														</div>
													</c:if></td>

												<td width="10%"><span class="total-book"> <fmt:formatNumber
															type="number" pattern="###,###,###"
															value="${book.price * book.quantity }"></fmt:formatNumber>đ
												</span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:when>
							<c:otherwise>
								<h3 class="text-center my-5">Chưa có sản phẩm nào trong giỏ</h3>
								<a href="${path}/" class="mua-tiep">Tiếp tục mua hàng</a>
							</c:otherwise>
						</c:choose>

					</div>
					<c:if test="${GIO_HANG.cartItems != null && GIO_HANG.cartItems.size() > 0}">
						<div class="row mt-5 mb-5">
							<div class="col-7">
								<div class="sub-title">Thông tin giao hàng 
									<a href="/cart/delivery-address" style="font-size: 12px;color: #28a745!important; ">(Sửa)</a>
								</div>
								<div class="box-confirm" style="width: 600px">
									<c:set value="${DIA_CHI_KHACH_HANG }" var="customer"></c:set>
									<p>
										Người nhận : <span>${customer.fullname }</span>
									</p>
									<p>
										SDT : <span>${customer.phone }</span>
									</p>
									<p>
										Địa chỉ: <span>${customer.addressDetail },
											${customer.wards } - ${customer.district } -
											${customer.province }</span>
									</p>
									<p>
										Ghi chú: <span>${customer.note != '' ? customer.note : 'không có' }</span>
									</p>
								</div>
							</div>
							<div class="col-5">
								<div class="sub-title">Tóm tắt đơn hàng</div>
								<div class="summary2-cart">
									<p>
										Sản phẩm: <span>${GIO_HANG.cartItems != null ? GIO_HANG.cartItems.size() : 0 }
											sản phẩm</span>
									</p>
									<p>
										Tổng tiền: <span><fmt:formatNumber type="number"
												pattern="###,###,###" value="${GIO_HANG.totalPriceCart }"></fmt:formatNumber>đ</span>
									</p>
									<p>
										Hình thức: <span>Giao hàng thu tận nơi </span>
									</p>
									<p>
										Phí vận chuyển: <span>Miễn phí</span>
									</p>
								</div>
							</div>
						</div>
					</c:if>
					<a href="${path}/cart/delivery-address"
						class="prev-checkout mr-5">Quay lại</a> 
					<a href="${path }/order-confirm"
						class="next-checkout mr-5">Xác nhận</a>
					<div class="clearfix"></div>

				</div>
			</div>
		</div>
		<!-- end mainbox-content-cart -->
		<!--footer  -->
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		<!--end footer  -->

		<div class="cube-overlay">
			<div id="loader-cube">
				<div class="thecube">
					<div class="cube c1"></div>
					<div class="cube c2"></div>
					<div class="cube c4"></div>
					<div class="cube c3"></div>
				</div>

				<div class="textedit">
					<h4>Đang cập nhật giỏ hàng</h4>
				</div>
			</div>
		</div>

	</div>
	<!-- end-wrapper -->
</body>
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>

</html>