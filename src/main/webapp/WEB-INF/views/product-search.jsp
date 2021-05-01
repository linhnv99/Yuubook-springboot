<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html lang="vn">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sản phẩm</title>
<jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>

<body>
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
												<img class="arrow" src="${path }/images/right-arrow.png"
													alt="">
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
	<!-- main -->
	<div class="main py-3">
		<div class="container-fluid">
			<div class="row">
				<!-- right -->
				<div class="col-12 bg-white">
					<div class="mainbox2-content" id="mainbox2-content">
						<div class=" mainbox2-title">
							<span>${books.size() } kết quả tìm kiếm cho từ khóa: <h2 style="display: inline;">`${keyword }`</h2></span>
						</div>
						<div class="mainbox-body">
							<div class="box-list-sanpham">
								<div class="row">
									<c:forEach items="${books }" var="book">
										<!-- one sanpham -->
										<c:if test="${book.status }">
											<div class="col-2">
											<div class="box-info-book" id="book-sanpham">
												<c:if test="${!book.act }">
													<span class="stop-sell">Tạm dừng bán</span>
												</c:if>
												<div class="book-img">
													<a href="${path }/san-pham/${book.slug}"> <img
														src="${path}/files/${book.avatar }" alt=""
														class="img-fluid" style="height: 235px">
													</a>
													<c:if test="${ book.discount > 0 }">
														<span class="discount"> ${book.discount }%</span>
													</c:if>
												</div>
												<div class="info-book-text">
													<div class="title">
														<a href="${path }/san-pham/${book.slug}"
															class="book-link h4x"> <c:set var="myStr"
																value="${fn:split(book.name, ' ') }"></c:set> <c:forEach
																items="${myStr }" var="str" begin="0" end="7"
																varStatus="loop">
																				${str }
																				<c:if test="${loop.index > 6 }">...</c:if>
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
										</c:if>
										<!-- end one sanpham -->
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
					<!-- end right -->
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- end main -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	<!-- end-wrapper -->
	<c:import url="/WEB-INF/views/layout/loader.jsp"></c:import>
	<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</body>
</html>