<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html lang="vn">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm</title>
    <jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>
<style>
    .cate-desc {
        color: #007bff !important;
        font-family: montserrat-medium;
        font-size: 15px;
    }

    .cate-desc:hover {
        text-decoration: underline !important;
    }

    .add-heart {
        margin-left:
    }

    .blike a {
        cursor: pointer;
    }
</style>

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
                                href="${path}/the-loai/${category.slug}">${category.name }
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
                                </ul>
                                </li>

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
    <!--  end category-banner -->
    <div class="list-category-throught">
        <div class="container-fluid">
            <ul>
                <li><a href="${path }/">Trang chủ</a> <img
                        src="${path }/images/right-arrow.png"></li>
                <c:choose>
                    <c:when test="${book.category.parentId != null }">
                        <li><a
                                href="${path }/the-loai/${book.category.parentId.slug}">${book.category.parentId.name }</a>
                            <img src="${path }/images/right-arrow.png"></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${path }/the-loai/${book.category.slug}">${book.category.name }</a></li>
                    </c:otherwise>
                </c:choose>
                <li><a href="${path }/san-pham/${book.slug}">${book.name }</a>
                </li>
            </ul>
            <div class="line-gray"></div>
        </div>
    </div>
    <div class="mainbox-content">
        <div class="container-fluid">
            <div class="mainbox-body">
                <!-- info-book -->
                <c:if test="${not empty book }">
                    <div class="box-info-book" id="box-info-book">
                        <div class="row">
                            <div class="col-6">
                                <div class="box-img-book">
                                    <ul class="slide-img-detail">
                                        <c:forEach items="${book.bookImages }" var="bookImg"
                                                   varStatus="loop">
                                            <li><img src="${path }/files/${bookImg.path}" alt=""
                                                     class="img-fluid"></li>
                                        </c:forEach>
                                    </ul>
                                    <div class="book-img">
                                        <img src="${path }/files/${book.bookImages[0].path }" alt=""
                                             class="img-fluid">
                                        <div class="group-btn-buy text-center mt-4">
                                            <button class="add-heart" id="act${book.id }"
                                                    onclick="toggleFavoriteBook(${book.id})"
                                                    data-act="${bookFavorites.contains(book) ? 'remove' : 'add' }">
													<span
                                                            class="${bookFavorites.contains(book) ? 'heart-red' : 'heart-white' }"></span>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-6">
                                <div class="info-book-text">
                                    <div class="title">
                                        <h1>${book.name }</h1>
                                        <div class="rate-now mb-2" id="rate-now" style="width: 200px">
                                            <c:set value="${book.starAvg + 1 }" var="starInt"></c:set>
                                            <span class="ml-0"> <a
                                                    class="star ${starInt > 1 ? 'active' : '' }"
                                                    href="javascript:void(0)"></a> <a
                                                    class="star ${starInt > 2 ? 'active' : '' }"
                                                    href="javascript:void(0)"></a> <a
                                                    class="star ${starInt > 3 ? 'active' : '' }"
                                                    href="javascript:void(0)"></a> <a
                                                    class="star ${starInt > 4 ? 'active' : '' }"
                                                    href="javascript:void(0)"></a> <a
                                                    class="star ${starInt > 5 ? 'active' : '' }"
                                                    href="javascript:void(0)"></a> <span
                                                    class="text-primary ml-2" style="font-size: 12px;">(
														${book.comments.size() } đánh giá )</span>
												</span>

                                        </div>
                                    </div>

                                    <div class="box-tacgia">
                                        <div class="row">
                                            <div class="col-6">
                                                <span>Tác giả: <a href="#">${book.author.name }</a></span>
                                                <span>Nhà xuất bản: ${book.publisher.name }</span>
                                            </div>
                                            <div class="col-6">
                                                <span>Ngôn ngữ: ${book.language }</a></span> <span>Hình
														thức: ${book.format }</span>
                                            </div>
                                        </div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${!book.act }">
                                            <h4 class="my-3 text-danger font-weight-bold">Sản phẩm
                                                đã tạm dừng bán</h4>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="box-price mb-4">
													<span class="new-price"> <fmt:formatNumber
                                                            type="number" pattern="###,###,###"
                                                            value="${book.price - (book.price * book.discount)/100}"/>đ
													</span>
                                                <c:if
                                                        test="${book.discount != null && book.discount > 0  }">
														<span class="old-price"> <fmt:formatNumber
                                                                type="number" pattern="###,###,###"
                                                                value="${book.price}"/>
														</span>
                                                </c:if>
                                                <c:if test="${book.discount != null && book.discount > 0 }">
                                                    <span class="sale">${book.discount }%</span>
                                                </c:if>
                                            </div>
                                            <div class="quantity mb-3">
                                                <input class="qtyminus" value="-" type="button"> <input
                                                    class="number" min="1" max="99" id="qty" value="1"
                                                    type="number"> <input class="qtyplus" value="+"
                                                                          type="button"/>
                                            </div>
                                            <div class="box-btn-group">
                                                <button onclick="buyNow(${book.id})" class="buy-now">Mua
                                                    ngay
                                                </button>
                                                <button class="add-to-cart" onclick="addToCart(${book.id})">Thêm
                                                    vào giỏ
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="box-more-info-book">
                                    <div class="title">Thông tin kèm theo</div>
                                    <p>
                                        <i class="flaticon-shipped"></i> Miễn phí giao hàng toàn quốc
                                        cho Đơn hàng từ 250.000đ (Áp dụng từ 1/7/2020 đến hết
                                        30/2/2021).
                                    </p>
                                    <p>
                                        <i class="flaticon-call"></i> <span class="contact">Hotline:
												0986.613.124</span>
                                    </p>
                                    <p>
                                        <i class="flaticon-chat"></i> <span class="contact">Email:
												yuubook@gmail.com</span>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <!--end info-book -->
                    </div>
                </c:if>

                <!-- main-content -->
                <div class="mainbox2-content">
                    <div class="mainbox2-body" id="about-book">
                        <div class="title">Giới thiệu sách</div>
                        <div class="box-subinfo-book">
                            <div class="row">
                                <div class="col-9">
                                    <div class="sub-title">${book.name }</div>
                                    <div class="text-book">
                                        ${book.desc }
                                        <p>Mời bạn đón đọc.</p>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="box-info-tacgia">
                                        <div class="title">Thông tin tác giả</div>
                                        <div class="tacgia">
                                            <a href="#">${book.author.name }</a>
                                        </div>
                                        <div class="info-tacgia">
                                            <c:choose>
                                                <c:when test="${book.author.avatar != null}">
														<span class="box-img-tacgia"> <img
                                                                src="${path }/files/${book.author.avatar}"
                                                                class="img-fluid">
														</span>
                                                </c:when>
                                                <c:otherwise>
														<span class="box-img-tacgia"> <img
                                                                style="height: 200px" src="${path }/images/user.png"
                                                                class="img-fluid">
														</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if
                                                    test="${book.author.desc!=null && book.author.desc != ''}">
                                                <c:forTokens items="${book.author.desc }" delims=" "
                                                             var="mySplit" begin="0" end="60">
                                                    ${mySplit}
                                                </c:forTokens>
                                                ...
                                            </c:if>
                                            <a href="${path }/tac-gia/${book.author.slug}"
                                               class="more-info-tacgia">Xem tất cả sách của tác giả</a> <a
                                                href="${path }/tac-gia/${book.author.slug}"
                                                class="more-info-tacgia">Xem thêm</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end main-content -->
                <!-- main-content -->
                <div class="mainbox2-content">
                    <div class="mainbox2-body" id="about-book">
                        <div class="box-subinfo-book">
                            <div class="sub-title" style="font-size: 18px;">Thông tin
                                chi tiết
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div class="box-info-nxb">
                                        <ul>
                                            <li><span>Tác giả: </span><span>${book.author.name }</span></li>
                                            <li><span>Nhà xuất bản: </span><span>${book.publisher.name }</span></li>
                                            <li><span>Định dạng: </span><span>${book.format }
                                            </span></li>
                                            <li><span>Năm xuất bản: </span><span> <fmt:parseDate
                                                    value="${book.publicationDate }" type="date"
                                                    pattern="yyyy-MM-dd" var="myDate"></fmt:parseDate> <fmt:formatDate
                                                    value="${myDate }" pattern="yyyy"/>
												</span></li>
                                            <li><span>Thể loại: </span><a class="cate-desc"
                                                                          href="${path }/the-loai/${book.category.slug}">
                                                ${book.category.name }</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="box-info-nxb">
                                        <ul>
                                            <li><span>Mã sản phẩm: </span><span>S${book.id }</span></li>
                                            <li><span>Ngôn ngữ: </span><span>${book.language }</span></li>
                                            <li><span>Kích thước: </span><span>${book.dimension }
                                            </span></li>
                                            <li><span>Số trang: </span><span>${book.totalPage }</span></li>
                                            <li><span>Tuyển tập: </span><span>không xác định</span></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end main-content -->
            </div>
        </div>
    </div>
    <!-- reviews -->
    <div class="container-fluid">
        <div class="mainbox2-content">
            <div class="mainbox2-body" id="reviews-book">
                <div class="title">Đánh giá sách</div>
                <div class="row px-2 py-3">
                    <div class="col-12">
                        <form action="" class="rate-form">
                            <input type="hidden" value="${book!=null ?  book.id : ''}"
                                   id="rate-bookId"/>
                            <div class="rate-now">
                                1. Đánh giá: <span> <a class="star active"
                                                       href="javascript:void(0)" data-star="1"></a> <a
                                    class="star active" href="javascript:void(0)" data-star="2"></a>
										<a class="star active" href="javascript:void(0)" data-star="3"></a>
										<a class="star active" href="javascript:void(0)" data-star="4"></a>
										<a class="star active selected" href="javascript:void(0)"
                                           data-star="5"></a>
									</span>
                            </div>
                            <div class="form-group">
                                <label for="">2. Tiêu đề</label> <input type="text"
                                                                        id="rate-title">
                            </div>
                            <div class="form-group">
                                <label for="">3. Nội dung</label>
                                <textarea id="rate-content" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <button class="send-rate">Gửi đánh giá</button>
                            </div>
                            <div class="clearfix"></div>
                        </form>

                        <div class="list-rate">
                            <c:if test="${book!=null }">
                                <c:forEach items="${book.comments }" var="comment">
                                    <div class="box-content"
                                         style="overflow: hidden; margin-bottom: 55px">
                                        <div class="left">
                                            <c:choose>
												<c:when test="${comment.user.avatar != null}">
													<img src="${comment.user.avatar}" alt=""
														 class="round-circle">
												</c:when>
												<c:otherwise>
													<img src="${path }/images/user.png" alt=""
														 class="round-circle">
												</c:otherwise>
											</c:choose>


											<b>${comment.user.surname } ${comment.user.name }</b>
                                        </div>
                                        <div class="right">
                                            <div class="rate-now mb-2">
                                                <c:set value="${comment.star + 1 }" var="starInt"></c:set>
                                                <span class="ml-0"> <a
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
                                            <div class="time-rate">
<%--                                                <fmt:parseDate value="${comment.date }" type="both"--%>
<%--                                                               pattern="yyyy-MM-dd'T'HH:mm"--%>
<%--                                                               var="myDate"></fmt:parseDate>--%>
<%--                                                <fmt:formatDate value="${myDate }"--%>
<%--                                                                pattern="dd-MM-yyyy HH:mm"/>--%>
                                                ${comment.date }
                                                <div class="content">
                                                    <div class="tit">${comment.title }</div>
                                                        ${comment.content }
                                                </div>
                                                <div class="like-comment mt-3 ">
                                                    <span class="cmt-number${comment.id }">${comment.likeComment  }</span>
                                                    lượt thích <span class="blike box-like${comment.id }">
															<c:set value="${0 }" var="check"></c:set> <c:forEach
                                                        items="${comment.userLikedComments }" var="userLiked">
                                                    <c:if test="${userLiked.userId == userLogin.id }">
                                                        <c:set value="${1 }" var="check"></c:set>
                                                    </c:if>
                                                </c:forEach> <c:choose>
                                                    <c:when test="${check != 1 }">
																	<a onclick="likeComment(${comment.id})"> <i
                                                                            class="ml-3 glyph-icon flaticon-like"></i> Thích
																	</a>
                                                    </c:when>
                                                    <c:otherwise>
																	<a class="ml-2 text-primary"
                                                                       onclick="dislikeComment(${comment.id})"> Bỏ Thích
																	</a>
                                                    </c:otherwise>
                                                </c:choose>
														</span>

                                                    <c:if test="${userLogin.id == comment.user.id }">
                                                        <a href="#" class="delete-comment text-danger"
                                                           data-id=${comment.id }> Xóa</a>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!--footer  -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    <!--end footer  -->
</div>
<!-- end-wrapper -->
<c:import url="/WEB-INF/views/layout/loader.jsp"></c:import>
<jsp:include page="/WEB-INF/views/layout/login.jsp"></jsp:include>
</body>
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>

</html>