<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
        padding: 2px 15px;
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

    td {
        /*display: flex;*/
        /*align-items: center;*/
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

                <div class="row">
                    <div class="col-md-12 col-sm-12 ">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>
                                    <i class="fa fa-align-left"></i> Danh sách email đăng ký nhận thông báo
                                </h2>
                                <button type="button" onclick="sendNotification()"
                                        class="btn btn-success custom float-right"><i
                                        class="fa fa-plus-circle"></i> Send
                                </button>

                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="card-box table-responsive">
                                            <table id="datatable-fixed-header" class="table table-hover"
                                                   style="width: 100%">
                                                <thead>
                                                <tr>
                                                    <th width="10%" class="no-sort">STT</th>
                                                    <th width="20%" class="no-sort">Email</th>
                                                    <th width="20%" class="no-sort">Thể loại</th>
                                                    <th width="12%" class="no-sort">Trạng thái</th>
                                                    <th width="10%" class="no-sort">Act</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${notifications }" var="notify" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.count}</td>
                                                        <td>${notify.email }</td>
                                                        <td>
                                                            <ul style="list-style: none; padding: 0">
                                                                <c:forEach items="${notify.genres}" var="genre">
                                                                    <li>- ${genre.name} </li>
                                                                </c:forEach>
                                                            </ul>
                                                        </td>
                                                        <td>
                                                            <div class="box-status${notify.id }">
                                                                <c:choose>
                                                                    <c:when test="${notify.status}">
                                                                        <span class="bg-success status"> Active</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="bg-danger status"> Inactive </span>
                                                                    </c:otherwise>
                                                                </c:choose>


                                                            </div>
                                                        </td>
                                                        <td>
                                                            <select id="actNotify${notify.id }"
                                                                    onchange="setStatus(${notify.id },this.value)">
                                                                <option value="-1">-- Action --</option>
                                                                <option value="1">Active</option>
                                                                <option value="0">Inactive</option>
                                                            </select>
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

        <!-- footer content -->
        <c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
        <!-- /footer content -->
    </div>
</div>
<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
</body>
<script type="text/javascript">

    function sendNotification() {
        alert("Gửi thành công!");
        $.ajax({
            url: "/admin/notifications/sends",
            type: "post",
            dataType: "json",
            success: function (data) {
            }
        })
    }


    function setStatus(id, v) {
        var val = parseInt(v)
        if (val == -1) {
            return;
        }
        $.ajax({
            url: "/admin/notifications/statuses/" + id + "/changers",
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.statusCode == 200) {
                    var html = "";
                    if (val == 1) {
                        html += "<span class='bg-success status'>Active</span>";
                    } else {
                        html += "<span class='status bg-danger'>Inactive</span>";
                    }
                    $("#actNotify" + id).parent().parent().find(".box-status" + id).empty().append(html);
                }
                if (data.statusCode == 400) {
                    alert("Đã có lỗi xảy ra. Vui lòng thử lại.");
                }
            },
            error: function (err) {
                alert("Đã có lỗi xảy ra. Vui lòng thử lại.");
                console.log(err);
            }
        })
    }
</script>
</html>