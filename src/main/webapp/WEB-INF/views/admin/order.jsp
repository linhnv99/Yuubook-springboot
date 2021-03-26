<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="vn">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Đơn hàng</title>

    <c:import url="/WEB-INF/views/admin/layout/css.jsp"></c:import>
</head>
<style>
    select {
        border: 1px solid #ccc;
        color: #000;
        padding: 2px 6px;
    }

    .status {
        width: 125px;
        text-align: center;
        display: inline-block;
        padding: 0px 8px;
        color: #fff;
        border-radius: 5px;
        font-size: 13px;
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
        <div class="right_col" role="main">
            <div class="">
                <div class="page-title"></div>

                <div class="clearfix"></div>
                <style>
                    .box-filter{
                        width: 580px;
                    }
                    .box-filter input{
                        width: 220px;
                        margin-right: 8px;
                    }
                    .box-filter input[type="submit"]{
                        width: 45px;
                    }
                </style>
                <div class="row">
                    <div class="col-md-12 col-sm-12 ">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>
                                    <i class="fa fa-align-left"></i> Danh sách đơn hàng
                                </h2>
                                <div class="clearfix"></div>
                            </div>
                            <form:form action="/admin/order/filter" modelAttribute="orderFilter" method="post">
                                <div class="ml-3 mb-4 float-left row box-filter">
                                        <form:input class="form-control" type="datetime-local"
                                               id="fromDate"
                                         path="fromDate" />
                                        <form:input class="form-control" type="datetime-local"
                                               id="toDate"
                                        path="toDate"/>
                                        <button class="btn btn-primary"> Lọc </button>
                                </div>
                            </form:form>

                            <div class="x_content">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="card-box table-responsive">
                                            <table id="datatable-fixed-header" class="table table-hover"
                                                   style="width: 100%">
                                                <thead>
                                                <tr>
                                                    <th width="10%" class="no-sort">Mã HĐ</th>
                                                    <th width="20%" class="no-sort">Họ tên</th>
                                                    <th width="15%" class="no-sort">Tổng tiền</th>
                                                    <th width="15%" class="no-sort">Ngày tạo</th>
                                                    <th class="no-sort">Trạng thái</th>
                                                    <th class="no-sort">Act</th>
                                                    <th width="18%" class="no-sort">Thao tác</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${orders }" var="order">
                                                    <tr>
                                                        <td>HD${order.id }</td>
                                                        <td>${order.fullName }</td>
                                                        <td><fmt:formatNumber type="number"
                                                                              pattern="###,###,###"
                                                                              value="${order.totalPriceOrder }"></fmt:formatNumber>đ
                                                        </td>
                                                        <td>
                                                            <fmt:parseDate value="${order.buyDate }" type="both"
                                                                           pattern="yyyy-MM-dd'T'HH:mm:ss"
                                                                           var="myDate"></fmt:parseDate>
                                                            <fmt:formatDate value="${myDate }"
                                                                            pattern="dd-MM-yyyy HH:mm:ss"/>
                                                        </td>
                                                        <td>
                                                            <div class="box-status${order.id }">
                                                                <c:if test="${order.orderStatus == 1 }">
																			<span class="status"
                                                                                  style="background-color: #d35400 !important">
																				Đang xử lý</span>
                                                                </c:if>
                                                                <c:if test="${order.orderStatus == 2 }">
																			<span class="bg-info status"> Đang giao
																				hàng</span>
                                                                </c:if>
                                                                <c:if test="${order.orderStatus == 3 }">
																			<span class="bg-success status"> Hoàn
																				thành</span>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                        <td><select id="actOrder${order.id }"
                                                                    onchange="setStatus(${order.id },this.value)">
                                                            <option value="-1">-- Action --</option>
                                                            <option value="1">Đang xử lý</option>
                                                            <option value="2">Đang giao hàng</option>
                                                            <option value="3">Hoàn thành</option>
                                                        </select></td>
                                                        <td>
                                                            <div class="action">
                                                                <a href="" class="btn btn-info editAuthor custom"
                                                                   data-toggle="modal" data-target="#order${order.id }">
                                                                    <i class="fa fa-edit"></i>
                                                                </a> <a href="#" data-toggle="modal" data-target="#"
                                                                        class="btn btn-danger custom"><i
                                                                    class="fa fa-trash-o"></i></a>
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
                </div>
            </div>
        </div>
        <!-- /page content -->

        <!-- modal -->
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
                            <div class="row summary-cate">
                                <div class="col-7">
                                    <div class="sub-title">Thông tin giao hàng</div>
                                    <div class="box-confirm">
                                        <p>
                                            Người nhận : <span>${order.fullName }</span>
                                        </p>
                                        <p>
                                            SDT : <span>${order.phone }</span>
                                        </p>
                                        <p>
                                            Địa chỉ: <span style="width: 320px">${order.addressDetail },${order.wards } - ${order.district } - ${order.province }</span>
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
                                            Sản phẩm: <span>${order.orderDetails.size() } sản
													phẩm</span>
                                        </p>
                                        <p>
                                            Tổng tiền: <span> <fmt:formatNumber type="number"
                                                                                pattern="###,###,###"
                                                                                value="${order.totalPriceOrder }"></fmt:formatNumber>đ
												</span>
                                        </p>
                                        <p>
                                            Hình thức: <span>Thanh toán khi nhận hàng</span>
                                        </p>
                                        <p>
                                            Phí vận chuyển: <span>Miễn phí</span>
                                        </p>
                                        <p>
                                            Ngày tạo: <span><fmt:parseDate value="${order.buyDate }" type="both"
                                                                           pattern="yyyy-MM-dd'T'HH:mm:ss"
                                                                           var="myDate"></fmt:parseDate>
																	<fmt:formatDate value="${myDate }"
                                                                                    pattern="dd-MM-yyyy HH:mm:ss"/></span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                    data-dismiss="modal">Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- /modal -->

        <!-- footer content -->
        <c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
        <!-- /footer content -->
    </div>
</div>
<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
<
<script type="text/javascript">
    function setStatus(id, v) {
        var val = parseInt(v)
        if (val == -1) {
            return;
        }
        $.ajax({
            url: "/admin/order/" + id + "/status/" + val,
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.statusCode == 200) {
                    var html = "";
                    if (val == 1) {
                        html += "<span class='status' style='background-color: #d35400 !important'>Đang xử lý</span>";
                    } else if (val == 2) {
                        html += "<span class='status bg-info'>Đang giao hàng</span>";
                    } else {
                        html += "<span class='status bg-success'>Hoàn thành</span>";
                    }
                    $("#actOrder" + id).parent().parent().find(".box-status" + id).empty().append(html);
                }
            },
            error: function (err) {
                alert("Đã có lỗi xảy ra. Vui lòng thử lại.");
                console.log(err);
            }
        })
    }
</script>
</body>
</html>