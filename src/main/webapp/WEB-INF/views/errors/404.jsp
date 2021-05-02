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
    <title>Tác giả</title>
    <jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>

<body>
<div class="wrapper" id="bg-white">
    <!-- start header -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
    <!-- end header -->
    <div class="container-fluid">
        <div class="my-5">
            <h5 style="font-weight: bold"> Không tìm thấy trang. Vui lòng thử lại</h5>
        </div>
    </div>
    <!--footer  -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    <!--end footer  -->
</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>