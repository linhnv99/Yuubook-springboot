<!-- sử dụng tiếng việt -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- SPRING FORM -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="vn">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang chủ</title>

<jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>

<body>
	<div id="box-contact">
		<a href="${pageContext.request.contextPath }/contact">Liên hệ với
			chúng tôi</a>
	</div>
	<div class="wrapper">
		<!-- start header -->
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		<!-- end header -->
		<!-- start category-banner -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-3 pr-0">
					<div class="category">
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
													<li><a href="${path }/product/cate/${subCate.id}">${subCate.name }</a></li>
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
					<div id="slider">
						<div class="slides">
							<div class="slide">
								<a href="#"><img src="images/slider/slide_1.jpg" alt=""
									class="img-fluid"></a>
							</div>
							<div class="slide">
								<a href="#"><img src="images/slider/slide_2.png" alt=""
									class="img-fluid"></a>
							</div>
							<div class="slide">
								<a href="#"><img src="images/slider/slide_5.jpg" alt=""
									class="img-fluid"></a>
							</div>
							<div class="slide">
								<a href="#"><img src="images/slider/slide_4.jpg" alt=""
									class="img-fluid"></a>
							</div>
							<div class="slide">
								<a href="#"><img src="images/slider/slide_6.jpg" alt=""
									class="img-fluid"></a>
							</div>
							<div class="slide active">
								<a href="#"><img src="images/slider/slide_3.jpg" alt=""
									class="img-fluid"></a>
							</div>
							<div class="slide">
								<a href="#"><img src="images/slider/slide_7.png" alt=""
									class="img-fluid"></a>
							</div>
						</div>
						<div class="next">
							<img class="img-fluid" src="images/right-arrow.png" alt="">
						</div>
						<div class="prev">
							<img class="img-fluid" src="images/left-arrow.png" alt="">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- end category-banner -->
		<!-- start sale_banner -->
		<div class="sale_banner">
			<div class="container-fluid">
				<div class="row">
					<div class="col-3">
						<a href="#"> <img src="images/sale/sale_1.jpg" alt=""
							class="img-fluid">
						</a>
					</div>
					<div class="col-3">
						<a href="#"> <img src="images/sale/sale_2.jpg" alt=""
							class="img-fluid">
						</a>
					</div>
					<div class="col-3">
						<a href="#"> <img src="images/sale/sale_3.jpg" alt=""
							class="img-fluid">
						</a>
					</div>
					<div class="col-3">
						<a href="#"> <img src="images/sale/sale_4.png" alt=""
							class="img-fluid">
						</a>
					</div>
				</div>
			</div>
		</div>
		<!-- end sale_banner -->
		<!--start main-content -->
		<div class="main">
			<div class="container-fluid">
				<div class="row">
					<!-- main-left -->
					<div class="col-9">
						<!-- one-mainbox-content -->
						<div class="mainbox-content">
							<div class="mainbox-title">
								<span>Tác Giả Nổi Bật</span>
							</div>
							<c:forEach items="${authors }" var="authorDTO">
								<c:if test="${authorDTO.author.showHome }">
									<div class="mainbox-body bg-tacgia">
										<div class="box-tacgia">
											<c:choose>
												<c:when test="${authorDTO.author.avatar!=null }">
													<img style="max-height: 200px"
														src="${path }/files/${authorDTO.author.avatar}" alt="">
												</c:when>
												<c:otherwise>
													<img style="max-height: 200px"
														src="${path }/files/user.png" alt="">
												</c:otherwise>
											</c:choose>
											<div class="info-tacgia">
												<span><a
													href="${path }/author/${authorDTO.author.id}">${authorDTO.author.name }</a></span>
												<p>
													<c:forTokens items="${authorDTO.author.desc }" delims=" "
														var="mySplit" varStatus="loop" begin="0" end="80">
																		${mySplit}
																		<c:if test="${loop.index > 79}">...</c:if>
													</c:forTokens>
												</p>
												<a href="${path }/author/${authorDTO.author.id}">Xem
													thêm</a>
											</div>
										</div>
										<div class="box-book-tacgia">
											<div class="row">
												<c:forEach items="${authorDTO.books }" var="book">
													<c:if test="${book.status }">
														<div class="col-4">
															<div class="book-content">
																<a class="book-img"
																	href="${path }/product/detail/${book.id}"><img
																	style="max-width: 60px;"
																	src="${path }/files/${book.avatar}" alt=""
																	class="img-fluid"></a> <a class="book-link"
																	href="${path }/product/detail/${book.id}"> <c:forTokens
																		items="${book.name }" delims=" " var="mySplit"
																		varStatus="loop" begin="0" end="9">
																		${mySplit}
																		<c:if test="${loop.index > 8}">...</c:if>
																	</c:forTokens>
																</a>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<!-- end one-mainbox-content -->

						<c:forEach items="${parentCateShowHome }" var="categoryDTO"
							varStatus="loop" begin="0" end="2">
							<c:if test="${categoryDTO.category.showHome }">
								<!-- one-mainbox-content -->
								<div class="mainbox-content">
									<div class="mainbox-title">
										<span>${ categoryDTO.category.name} <a
											href="${path }/product/cate/${categoryDTO.category.id}">
												Xem thêm <img src="${path }images/right-arrow.png" alt=""
												srcset="" class="img-fluid">
										</a>
										</span>
									</div>
									<div class="mainbox-body">
										<div class="row">
											<c:forEach items="${categoryDTO.books }" var="book">
												<c:if test="${book.status && book.act}">
													<!-- one-book -->
													<div class="col-4">
														<div class="box-info-book">
															<div class="info-book">
																<div class="book-img">
																	<a href="${path }/product/detail/${book.id}"> <img
																		src="${path }/files/${book.avatar}" alt=""
																		style="height: 155px" class=" img-fluid">
																	</a>
																</div>
																<div class="info-book-text">
																	<div class="title">
																		<a href="${path }/product/detail/${book.id}"
																			class="book-link"> ${fn:substring(book.name,0,14) }
																			<c:if test="${fn:length(book.name) > 14 }">...</c:if>
																		</a> <span class="tacgia">${book.author.name }</span>
																	</div>
																	<a href="${path }/product/detail/${book.id}"
																		class="text-book-nd"> <c:forTokens
																			items="${book.desc }" delims=" " var="mySplit"
																			varStatus="loop" begin="0" end="12">
																		${mySplit}
																		<c:if test="${loop.index > 11}">...</c:if>
																		</c:forTokens>
																	</a>
																</div>
																<div class="clearfix"></div>
															</div>
															<div class="box-info-book-price">
																<c:if
																	test="${book.discount!=null && book.discount > 0 }">
																	<span class="discount">${book.discount }%</span>
																</c:if>
																<div class="box-price">
																	<span class="old-price"> <fmt:formatNumber
																			type="number" pattern="###,###,###"
																			value="${book.price}" />
																	</span> <span class="new-price"> <fmt:formatNumber
																			type="number" pattern="###,###,###"
																			value="${book.price - (book.price * book.discount)/100}" />đ
																	</span>
																</div>
															</div>
														</div>
													</div>
													<!-- end-one-book -->
												</c:if>
											</c:forEach>

										</div>
									</div>
								</div>
								<!-- end one-mainbox-content -->
							</c:if>
						</c:forEach>

						<!-- one-mainbox-content -->
						<div class="mainbox-content">
							<div class="mainbox-title">
								<span>Clip Giới Thiệu Sách</span>
							</div>
							<div class="mainbox-body bg-gioithieu-sach">
								<div class="row">
									<div class="col-6">
										<div class="box-clip">
											<iframe
												src="//www.youtube.com/embed/MNm77lvTfi4?enablejsapi=1"
												allow="autoplay; encrypted-media" allowfullscreen=""
												width="100%" height="330" frameborder="0"
												data-gtm-yt-inspected-10569849_161="true" id="817909017"></iframe>
										</div>
									</div>
									<div class="col-6">
										<div class="box-info-book bg-book-clip">
											<div class="box-info-clip">
												<div class="title">
													<a class="book-title" href="">Mắt Biếc (Phiên Bản Phim)</a>
													<span class="info-tacgia">Nguyễn Nhật Ánh</span>
												</div>
												<div class="info-book-text">Mắt biếc là một tác phẩm
													được nhiều người bình chọn là hay nhất của nhà văn Nguyễn
													Nhật Ánh. Sách Mắt biếc đã được dựng thành phim điện ảnh,
													đạo diễn bởi đạo diễn nổi tiếng với rất nhiều phim ăn khách
													là Victor Vũ, sản xuất và phân phối bởi Galaxy Cinema – một
													trong những cụm rạp hàng đầu Việt Nam.</div>
											</div>
											<div class="box-info-book-price pt-3">
												<a href="#"><span class="discount">Mua Ngay</span></a>
												<div class="box-price">
													<span class="old-price"> 95.000 đ </span> <span
														class="new-price"> 79.000đ </span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- end one-mainbox-content -->
					
					<c:forEach items="${parentCateShowHome }" var="categoryDTO"
							varStatus="loop" begin="3" end="${parentCateShowHome.size() -1 }">
							<c:if test="${categoryDTO.category.showHome }">
								<!-- one-mainbox-content -->
								<div class="mainbox-content">
									<div class="mainbox-title">
										<span>${ categoryDTO.category.name} <a
											href="${path }/product/cate/${categoryDTO.category.id}">
												Xem thêm <img src="${path }images/right-arrow.png" alt=""
												srcset="" class="img-fluid">
										</a>
										</span>
									</div>
									<div class="mainbox-body">
										<div class="row">
											<c:forEach items="${categoryDTO.books }" var="book">
												<c:if test="${book.status && book.act}">
													<!-- one-book -->
													<div class="col-4">
														<div class="box-info-book">
															<div class="info-book">
																<div class="book-img">
																	<a href="${path }/product/detail/${book.id}"> <img
																		src="${path }/files/${book.avatar}" alt=""
																		style="height: 155px" class=" img-fluid">
																	</a>
																</div>
																<div class="info-book-text">
																	<div class="title">
																		<a href="${path }/product/detail/${book.id}"
																			class="book-link"> ${fn:substring(book.name,0,14) }
																			<c:if test="${fn:length(book.name) > 14 }">...</c:if>
																		</a> <span class="tacgia">${book.author.name }</span>
																	</div>
																	<a href="${path }/product/detail/${book.id}"
																		class="text-book-nd"> <c:forTokens
																			items="${book.desc }" delims=" " var="mySplit"
																			varStatus="loop" begin="0" end="12">
																		${mySplit}
																		<c:if test="${loop.index > 11}">...</c:if>
																		</c:forTokens>
																	</a>
																</div>
																<div class="clearfix"></div>
															</div>
															<div class="box-info-book-price">
																<c:if
																	test="${book.discount!=null && book.discount > 0 }">
																	<span class="discount">${book.discount }%</span>
																</c:if>
																<div class="box-price">
																	<span class="old-price"> <fmt:formatNumber
																			type="number" pattern="###,###,###"
																			value="${book.price}" />
																	</span> <span class="new-price"> <fmt:formatNumber
																			type="number" pattern="###,###,###"
																			value="${book.price - (book.price * book.discount)/100}" />đ
																	</span>
																</div>
															</div>
														</div>
													</div>
													<!-- end-one-book -->
												</c:if>
											</c:forEach>

										</div>
									</div>
								</div>
								<!-- end one-mainbox-content -->
							</c:if>
						</c:forEach>
					
					</div>
					<!-- end main-left -->


					<!-- main-right -->
					<div class="col-3">
						<!-- one  main-content-right -->
						<div class="mainbox-content-right">
							<div class="mainbox-title">
								<span>Sách hot</span>
							</div>
							<div class="mainbox-body">
								<ul>
									<c:forEach items="${bookHot }" var="book">
										<c:if test="${book.status && book.act}">
											<li>
												<div class="box-info-book-right">
													<div class="book-img">
														<a href="${path }/product/detail/${book.id}"> <img
															src="${path }/files/${book.avatar}"
															style="height: 74px; min-width: 50px; max-width: 50px"
															class="img-fluid">
														</a>
													</div>
													<div class="info-book-text">
														<a href="${path }/product/detail/${book.id}"
															class="book-link"> ${book.name }</a> <span
															class="info-tacgia">${book.author.name }</span>
														<div class="box-info-book-price">
															<!-- <span class="old-price">168.000 đ</span> <span
															class="new-price">120.000 đ</span>  -->
															<span class="new-price"> <fmt:formatNumber
																	type="number" pattern="###,###,###"
																	value="${book.price - (book.price * book.discount)/100}" />đ
															</span> <span class="old-price"> <fmt:formatNumber
																	type="number" pattern="###,###,###"
																	value="${book.price}" />
															</span>
														</div>
													</div>
												</div>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
						<!-- end one main-content-right -->
						<c:forEach items="${subCateShowHome }" var="categoryDTO">
							<c:if test="${categoryDTO.category.showHome }">
								<!-- one  main-content-right -->
								<div class="mainbox-content-right">
									<div class="mainbox-title">
										<span>${categoryDTO.category.name }</span>
									</div>
									<div class="mainbox-body">
										<ul>
											<c:forEach items="${categoryDTO.books }" var="book">
												<c:if test="${book.status && book.act}">
													<li>
														<div class="box-info-book-right">
															<div class="book-img">
																<a href="${path }/product/detail/${book.id}"> <img
																	src="${path }/files/${book.avatar}"
																	style="height: 74px; min-width: 50px; max-width: 50px"
																	class="img-fluid">
																</a>
															</div>
															<div class="info-book-text">
																<a href="${path }/product/detail/${book.id}"
																	class="book-link"> ${book.name }</a> <span
																	class="info-tacgia">${book.author.name }</span>
																<div class="box-info-book-price">
																	<!-- <span class="old-price">168.000 đ</span> <span
															class="new-price">120.000 đ</span>  -->
																	<span class="new-price"> <fmt:formatNumber
																			type="number" pattern="###,###,###"
																			value="${book.price - (book.price * book.discount)/100}" />đ
																	</span> <span class="old-price"> <fmt:formatNumber
																			type="number" pattern="###,###,###"
																			value="${book.price}" />
																	</span>
																</div>
															</div>
														</div>
													</li>
												</c:if>
											</c:forEach>


										</ul>
									</div>
								</div>
								<!-- end one main-content-right -->
							</c:if>
						</c:forEach>
					</div>
					<!-- end main-right -->
				</div>
			</div>
		</div>
		<!--end main-content -->
		<!--footer  -->
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		<!--end footer  -->
	</div>
	<!-- end-wrapper -->
	<!-- model login -->
	<jsp:include page="/WEB-INF/views/layout/login.jsp"></jsp:include>
	<!-- end model login -->
</body>
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
</html>