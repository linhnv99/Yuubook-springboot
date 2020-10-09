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
<title>Giỏ hàng</title>
<jsp:include page="/WEB-INF/views/layout/css.jsp"></jsp:include>
</head>

<body>
	<div class="wrapper" id="bg-white">
		<!-- start header -->
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		<!-- end header -->
		<!-- mainbox-content-cart -->
		<div class="mainbox-content" id="mainbox-content-cart">
			<div class="container-fluid">
				<div class="mainbox-body bg-cart">
					<c:if test="${isSuccess }">
						<div class="box-info-cart">
							<div class="title">
								HOÀN THÀNH<a href="${path}/" class="mua-tiep float-right">Tiếp
									tục mua hàng</a>
							</div>
							<h5 class="my-3">Chúc mừng bạn đã đặt hàng thành công. Vui
								lòng chờ xác nhận của cửa hàng! Cảm ơn.</h5>
							<div style="text-align: center;">
								<img src="${path }/images/congrats.jpg">
							</div>
						</div>
					</c:if>
					<c:if test="${!isSuccess }">
						<div class="title">
								CHÚ Ý<a href="${path}/" class="mua-tiep float-right">Tiếp
									tục mua hàng</a>
							</div>
							<h5 class="my-3">Không thể gửi yêu cầu.</h5>
					</c:if>
				</div>
			</div>
			<!-- end mainbox-content-cart -->
			<!--footer  -->
			<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
			<!--end footer  -->
		</div>
		<!-- end-wrapper -->
	</div>
</body>
<jsp:include page="/WEB-INF/views/layout/js.jsp"></jsp:include>

</html>