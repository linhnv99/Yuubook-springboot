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
										href="${pageContext.request.contextPath }/product/cate/${category.id}">${category.name }
											<c:if test="${category.subCategories.size() > 0 }">
												<img class="arrow" src="images/right-arrow.png" alt="">
											</c:if>
									</a> <c:if test="${category.subCategories.size() > 0 }">
											<ul class="submenu">
												<span>${category.name }</span>
												<c:forEach items="${category.subCategories }" var="subCate">
													<c:if test="${subCate.status }">
														<li><a href="${path }/product/cate/${subCate.id}">${subCate.name }</a></li>
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
							<div class="title">Sách yêu thích của tôi</div>
							<div class="box-list-sanpham">
								<div class="row">
									<c:choose>
										<c:when test="${bookFavorites.size() > 0 }">
											<c:forEach items="${bookFavorites }" var="book">
												<!-- one sanpham -->
												<div class="col-3">
													<div class="box-info-book" id="book-sanpham">
														<c:if test="${!book.act }">
															<span class="stop-sell">Tạm dừng bán</span>
														</c:if>
														<div class="book-img">
															<a href="${path }/product/detail/${book.id}"> <img
																src="${path}/files/${book.avatar }" alt=""
																class="img-fluid" style="height: 235px">
															</a>
															<c:if test="${ book.discount > 0 }">
																<span class="discount"> ${book.discount }%</span>
															</c:if>
														</div>
														<div class="info-book-text">
															<div class="title">
																<a href="${path }/product/detail/${book.id}"
																	class="book-link h4x"> <c:set var="myStr"
																		value="${fn:split(book.name, ' ') }"></c:set> <c:forEach
																		items="${myStr }" var="str" begin="0" end="8"
																		varStatus="loop">
																				${str }
																				<c:if test="${loop.index > 7 }">...</c:if>
																	</c:forEach>
																</a> <span class="tacgia">${book.author.name }</span>
															</div>
														</div>
														<div class="box-info-book-price">
															<div class="box-price">
																<c:if
																	test="${book.discount > 0 && book.discount != null }">
																	<span class="old-price"> <fmt:formatNumber
																			type="number" pattern="###,###,###"
																			value="${book.price}" />
																	</span>
																</c:if>
																</span> <span class="new-price"> <fmt:formatNumber
																		type="number" pattern="###,###,###"
																		value="${book.price - (book.price * book.discount)/100}" />đ
																</span>
															</div>
														</div>
													</div>
												</div>
												<!-- end one sanpham -->
											</c:forEach>
										</c:when>
										<c:otherwise>
											<div class="col-12"><p class="text-center mt-4">Bạn chưa có cuốn sách yêu thích nào.</p></div>
										</c:otherwise>
									</c:choose>
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
	<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</body>

</html>