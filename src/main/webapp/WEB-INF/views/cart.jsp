<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="totalPrice" value="${0 }"></c:set>
<!DOCTYPE html>
<html lang="vn">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Giỏ hàng</title>
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
				<div class="col-9 pl-0"></div>
			</div>
		</div>
	</div>
	<div class="mainbox-content">
		<div class="container-fluid">
			<div class="box-process">
				<div class="timeline-process-cart">
					<div class="step step1 active">
						<span class="title">Kiểm tra giỏ hàng</span> <span class=>1</span>
					</div>
					<div class="step step2 ">
						<span class="title">Địa chỉ giao hàng</span> <span>2</span>
					</div>
					<div class="step step3 ">
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
			<div class="mainbox-body bg-cart" id="list-cart">
				<div class="box-info-cart">
					<div class="title">
						Giỏ hàng <small>(${GIO_HANG.cartItems != null ? GIO_HANG.cartItems.size() : 0 }
							sản phẩm)</small>
					</div>
					<c:choose>
						<c:when test="${GIO_HANG.cartItems!=null && GIO_HANG.cartItems.size() > 0}">
							<table>
								<thead>
									<th>Sản phẩm</th>
									<th>Số lượng</th>
									<th>Đơn giá</th>
									<th>Thành tiền</th>
									<th>Thao tác</th>
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
											<td width="15%">
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
											<td width="15%"><span class="new-price"> <fmt:formatNumber
														type="number" pattern="###,###,###" value="${book.price }"></fmt:formatNumber>đ
											</span> <c:if test="${book.discount!=null}">
													<div>
														<span class="old-price"> <fmt:formatNumber
																type="number" pattern="###,###,###"
																value="${book.originPrice }"></fmt:formatNumber>đ
														</span> <small class="discount">${book.discount }%</small>
													</div>
												</c:if></td>

											<td width="15%"><span class="total-book"> <fmt:formatNumber
														type="number" pattern="###,###,###"
														value="${book.price * book.quantity }"></fmt:formatNumber>đ
											</span></td>
											<td width="10%"><a class="delete-link" style="cursor: pointer;"
												onclick="removeCart(${book.bookId })"> Xóa </a></td>
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
				<!-- end box-info-cart -->
				<c:if test="${GIO_HANG.cartItems != null && GIO_HANG.cartItems.size() > 0}">
					<div class="box-summary-cart mt-5">
						<div class="title">Tóm tắt đơn hàng</div>
						<div class="summary-cart">
							<div class="left">
								<span>Tổng sản phẩm: </span> <span>${GIO_HANG.cartItems.size() }
									sản phẩm</span>
							</div>
							<div class="right">
								<p>
									Tổng tiền: <span> <fmt:formatNumber type="number"
											pattern="###,###,###" value="${GIO_HANG.totalPriceCart }"></fmt:formatNumber>đ
									</span>
								</p>
								<p>
									Phí vận chuyển: <span>Miễn phí</span>
								</p>
								<a class="next-checkout" href="${path }/cart/delivery-address">Tiếp
									tục</a>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<!--footer  -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	<!--end footer  -->
	</div>
	<!-- end-wrapper -->
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
	<jsp:include page="/WEB-INF/views/layout/login.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</body>
</html>