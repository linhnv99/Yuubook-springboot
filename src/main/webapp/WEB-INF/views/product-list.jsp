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
</div>
<div class="list-category-throught">
    <div class="container-fluid">
        <ul>
            <li><a href="${path }/">Trang chủ</a></li>
            <li><img src="${path }/images/right-arrow.png"
                     class="img-fluid"><a
                    href="${path }/the-loai/${parentCateSelected.slug}">${parentCateSelected.name }</a></li>
            <c:if test="${not empty CATALOG_SELECTED }">
                <li><img src="${path }/images/right-arrow.png"
                         class="img-fluid"><a
                        href="${path }/the-loai/${CATALOG_SELECTED.slug}">${CATALOG_SELECTED.name }</a></li>
            </c:if>
        </ul>
    </div>
</div>
<!-- main -->
<div class="main py-3">
    <div class="container-fluid">
        <div class="row">
            <div class="col-3">
                <div class="mainbox-content">
                    <div class="mainbox-body" id="page-category">
                        <div class="page-category-content">
                            <span class="title">Danh Mục Sản Phẩm</span>
                            <ul>
                                <c:forEach items="${categories }" var="category">
                                    <c:if test="${category.id == parentCateSelected.id  }">
                                        <c:forEach items="${category.subCategories }" var="subCate">
                                            <c:if test="${subCate.status }">
                                                <li
                                                        class="${CATALOG_SELECTED.id == subCate.id ? 'active' : '' }"><a
                                                        href="${path }/the-loai/${subCate.slug}">${subCate.name }</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="page-category-content">
                            <span class="title">Tác giả</span>
                            <ul>
                                <c:forEach items="${author }" var="author">
                                    <li><a href="${path }/tac-gia/${author.slug}">${author.name }</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- right -->
            <div class="col-9 bg-white">
                <c:choose>
                    <c:when test="${not empty CATALOG_SELECTED }">
                        <div class="mainbox2-content" id="mainbox2-content">
                            <div class="mainbox2-title mt-0" id="mainbox2-title">
                                <span>${CATALOG_SELECTED.name }</span>
                            </div>
                            <c:if test="${books.size() > 0}">
                                <div class="box-sort">
                                    <div class="title">Sắp xếp</div>
                                    <div class="sort-by">
                                        <span class="selected-sort">${SORT }</span>
                                        <div class="sort-tmp">
                                            <a class="${SORT == 'newest' ? 'active' : '' }"
                                               href="${path }/the-loai/${CATALOG_SELECTED.slug}?sort=newest">Mới nhất</a>
                                            <a class="${SORT == 'az' ? 'active' : '' }"
                                               href="${path }/the-loai/${CATALOG_SELECTED.slug}?sort=az">A đến Z</a>
                                            <a class="${SORT == 'za' ? 'active' : '' }"
                                               href="${path }/the-loai/${CATALOG_SELECTED.slug}?sort=za">Z đến A</a>
                                            <a class="${SORT == 'minmax' ? 'active' : '' }"
                                               href="${path }/the-loai/${CATALOG_SELECTED.slug}?sort=minmax">Giá thấp
                                                nhất</a>
                                            <a class="${SORT == 'maxmin' ? 'active' : '' }"
                                               href="${path }/the-loai/${CATALOG_SELECTED.slug}?sort=maxmin">Giá cao
                                                nhất</a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <div class="clearfix"></div>
                            <div class="mainbox-body">
                                <div class="box-list-sanpham">
                                    <div class="row">
                                        <c:choose>
                                            <c:when test="${books.size() > 0 }">
                                                <c:forEach items="${books }" var="book">
                                                    <c:if test="${book.status }">
                                                        <!-- one sanpham -->
                                                        <div class="col-3">
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
                                                                                                         value="${fn:split(book.name, ' ') }"></c:set>
                                                                            <c:forEach
                                                                                    items="${myStr }" var="str"
                                                                                    begin="0" end="8"
                                                                                    varStatus="loop">
                                                                                ${str }
                                                                                <c:if test="${loop.index > 7 }">...</c:if>
                                                                            </c:forEach>
                                                                        </a> <span
                                                                            class="tacgia">${book.author.name }</span>
                                                                    </div>
                                                                </div>
                                                                <div class="box-info-book-price">
                                                                    <div class="box-price">
                                                                        <c:if
                                                                                test="${book.discount > 0 && book.discount != null }">
																			<span class="old-price"> <fmt:formatNumber
                                                                                    type="number" pattern="###,###,###"
                                                                                    value="${book.price}"/>
																			</span>
                                                                        </c:if>
                                                                        <span class="new-price"> <fmt:formatNumber
                                                                                type="number" pattern="###,###,###"
                                                                                value="${book.price - (book.price * book.discount)/100}"/>đ
																		</span>
                                                                    </div>
                                                                </div>

                                                                <div class="rate-now mb-2" id="rate-now">
                                                                    <c:set value="${book.starAvg + 1 }"
                                                                           var="starInt"></c:set>
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
                                                                            href="javascript:void(0)"></a> <span
                                                                            class="ml-2"
                                                                            style="font-size: 12px;">(
																			${book.comments.size() } đánh giá )</span>
																	</span>
                                                                </div>

                                                                <div class="group-btn-buy">
                                                                    <button class="add-heart" id="act${book.id }"
                                                                            onclick="toggleFavoriteBook(${book.id})"
                                                                            data-act="${bookFavorites.contains(book) ? 'remove' : 'add' }">
																		<span
                                                                                class="${bookFavorites.contains(book) ? 'heart-red' : 'heart-white' }"></span>
                                                                    </button>
                                                                    <button class="add-to-cart"
                                                                            style="${!book.act ? 'cursor: not-allowed' : ''}"
                                                                            onclick="addToCart(${book.id}, 1)">
																		<span class="cart"><i
                                                                                class="flaticon-shopping-cart"></i></span>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- end one sanpham -->
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center w-100 my-4">
                                                    <h4>Gian hàng đang được cập nhật</h4>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <c:set value="${ not empty param.sort ? 'sort='+=param.sort+='&'  :'' }"
                               var="sortParam"></c:set>
                        <div class="pagination">
                            <ul>
                                <c:if test="${currentPage > 1 }">
                                    <li><a
                                            href="${path }/the-loai/${CATALOG_SELECTED.slug}?${sortParam }page=${currentPage - 1}"><img
                                            src="${path}/images/left-arrow.png" alt=""></a></li>
                                </c:if>

                                <c:forEach var="i" begin="1" end="${totalPages }">
                                    <li><a
                                            href="${path }/the-loai/${CATALOG_SELECTED.slug}?${sortParam }page=${i}"
                                            class="${i == currentPage ? 'active' : ''}">${i }</a></li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages }">
                                    <li><a
                                            href="${path }/the-loai/${CATALOG_SELECTED.slug}?${sortParam }page=${currentPage + 1}"><img
                                            src="${path}/images/right-arrow.png" alt=""></a></li>
                                </c:if>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${subCategoriesWithProducts }"
                                   var="categoryDTO">
                            <c:if
                                    test="${categoryDTO.category.parentId.id == parentCateSelected.id }">
                                <div class="mainbox2-content" id="mainbox2-content">
                                    <div class="mainbox2-title mt-0" id="mainbox2-title">
											<span>${categoryDTO.category.name } <a
                                                    href="${path }/the-loai/${categoryDTO.category.slug}">
													Xem thêm</a></span>
                                    </div>
                                    <div class="mainbox-body">
                                        <div class="box-list-sanpham">
                                            <div class="row">
                                                <c:choose>
                                                    <c:when test="${categoryDTO.books.size() > 0 }">
                                                        <c:forEach items="${categoryDTO.books }" var="book">
                                                            <c:if test="${book.status }">
                                                                <!-- one sanpham -->
                                                                <div class="col-3">
                                                                    <div class="box-info-book" id="book-sanpham">
                                                                        <c:if test="${!book.act }">
                                                                            <span class="stop-sell">Tạm dừng bán</span>
                                                                        </c:if>
                                                                        <div class="book-img">
                                                                            <a href="${path }/san-pham/${book.slug}">
                                                                                <img
                                                                                        src="${path}/files/${book.avatar }"
                                                                                        alt=""
                                                                                        class="img-fluid"
                                                                                        style="height: 235px">
                                                                            </a>
                                                                            <c:if test="${ book.discount > 0 }">
                                                                                <span class="discount"> ${book.discount }%</span>
                                                                            </c:if>
                                                                        </div>
                                                                        <div class="info-book-text">
                                                                            <div class="title">
                                                                                <a href="${path }/san-pham/${book.slug} "
                                                                                   class="book-link h4x"> <c:set
                                                                                        var="myStr"
                                                                                        value="${fn:split(book.name, ' ') }"></c:set>
                                                                                    <c:forEach
                                                                                            items="${myStr }" var="str"
                                                                                            begin="0" end="8"
                                                                                            varStatus="loop">
                                                                                        ${str }
                                                                                        <c:if test="${loop.index > 7 }">...</c:if>
                                                                                    </c:forEach>
                                                                                </a> <span
                                                                                    class="tacgia">${book.author.name }</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="box-info-book-price">
                                                                            <div class="box-price">
                                                                                <c:if
                                                                                        test="${book.discount > 0 && book.discount != null }">
																					<span class="old-price"> <fmt:formatNumber
                                                                                            type="number"
                                                                                            pattern="###,###,###"
                                                                                            value="${book.price}"/>
																					</span>
                                                                                </c:if>
                                                                                <span class="new-price"> <fmt:formatNumber
                                                                                        type="number"
                                                                                        pattern="###,###,###"
                                                                                        value="${book.price - (book.price * book.discount)/100}"/>đ
																				</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="rate-now mb-2" id="rate-now">
                                                                            <c:set value="${book.starAvg + 1 }"
                                                                                   var="starInt"></c:set>
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
                                                                                    href="javascript:void(0)"></a> <span
                                                                                    class="ml-2"
                                                                                    style="font-size: 12px;">(
																					${book.comments.size() } đánh giá )</span>
																			</span>
                                                                        </div>
                                                                        <div class="group-btn-buy">
                                                                            <button class="add-heart"
                                                                                    id="act${book.id }"
                                                                                    onclick="toggleFavoriteBook(${book.id})"
                                                                                    data-act="${bookFavorites.contains(book) ? 'remove' : 'add' }">
																				<span
                                                                                        class="${bookFavorites.contains(book) ? 'heart-red' : 'heart-white' }"></span>
                                                                            </button>
                                                                            <button class="add-to-cart"
                                                                                    style="${!book.act ? 'cursor: not-allowed' : ''}"
                                                                                    onclick="addToCart(${book.id}, 1)">
																				<span class="cart"><i
                                                                                        class="flaticon-shopping-cart"></i></span>
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <!-- end one sanpham -->
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center w-100 my-4">
                                                            <h4>Gian hàng đang được cập nhật</h4>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                    </c:otherwise>
                </c:choose>
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