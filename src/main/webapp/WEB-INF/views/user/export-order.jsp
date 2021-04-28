<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vn">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa đơn </title>
    <jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
    <script src="${path }/lib/html2pdf.bundle.js"></script>
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

    .action > a {
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
        padding: 0 15px;
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

    .wrapper {
        padding: 40px 0;
        background: #1b1e21;
    }

    .top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 15px;
    }
</style>
<body>
<div class="wrapper">
    <!-- Modal -->
    <div style="max-width: 800px; margin: 0 auto">
        <button id="download" class="btn btn-primary float-right mb-3">Download</button>
    </div>
    <c:if test="${order != null}">
        <div class="order" id="order${order.id }" tabindex="-1"
             aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-body" id="invoice">
                        <div class="top">
                            <div class="left">
                                <span style="font-size: 12px; ">Mã HĐ: HĐ15${order.id}</span>
                                <p style="font-size: 12px; ">Ngày tạo: ${order.createdDate}</p>
                            </div>
                            <div class="text-center">
                                <img src="${path }/images/yuubook.png" alt="" class="img-fluid">
                            </div>
                        </div>
                        <div class="order-detail">
                            <div class="mainbox2-body pt-4"
                                 style="border: none; margin-bottom: 60px;">
                                <h6 class="text-center mt-2 mb-5">HÓA ĐƠN BÁN HÀNG</h6>
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
                                                        href="${path }/product/detail/${orderDetail.book.id}">${orderDetail.book.name }</a>
                                                </td>
                                                <td><img
                                                        src="${path }/files/${orderDetail.book.avatar}"
                                                        class="img-fluid" style="max-height: 90px"></td>
                                                <td>${orderDetail.quantity }</td>
                                                <td><fmt:formatNumber type="number"
                                                                      pattern="###,###,###"
                                                                      value="${orderDetail.unitPrice}"></fmt:formatNumber>đ
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
                            <div class="row pb-4">
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
                                                                          pattern="###,###,###"
                                                                          value="${order.totalPriceOrder }"></fmt:formatNumber>đ</span>
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
                </div>
            </div>
        </div>
    </c:if>
</div>
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>
<script>
    window.onload = function () {
        document.getElementById("download").addEventListener("click", () => {
            const invoice = this.document.getElementById("invoice");
            console.log(invoice)
            html2pdf().from(invoice).save();
        })
    }
</script>

</body>
</html>