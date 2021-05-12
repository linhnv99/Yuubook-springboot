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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Đánh giá</title>

<c:import url="/WEB-INF/views/admin/layout/css.jsp"></c:import>
<link href="${path}/css/style.css" rel="stylesheet">
</head>

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
					<div class="page-title">
						<div id="box-notification">
							<c:if test="${not empty success }">
								<div class="mb-0 alert alert-success" id="mess">${success }</div>
							</c:if>
							<c:if test="${not empty error }">
								<div class="mb-0 alert alert-warning" id="mess">${error }</div>
							</c:if>
							<script type="text/javascript">
								setTimeout(function() {
									$('#mess').fadeOut('low');
								}, 2000);
							</script>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="x_panel" id="list-author">
								<div class="x_title">
									<h2>
										<i class="fa fa-align-left"></i> Danh sách đánh giá
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="row">
										<div class="col-sm-12">
											<div class="card-box table-responsive table-load">
												<table id="" class="table table-hover" style="width: 100%">
													<thead>
														<tr>
															<th>STT</th>
															<th>Sách</th>
															<th>Đánh giá</th>
															<th>Tiêu đề</th>
															<th>Thời gian</th>
															<th>Thao tác</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${comments }" var="comment"
															varStatus="loop">
															<tr>
																<td>${loop.index + 1}</td>
																<td width="30%">${comment.book.name }</td>
																<td width="15%">
																	<div class="rate-now mb-2" id="rate-now">
																		<c:set value="${comment.star + 1 }" var="starInt"></c:set>
																		<span class="ml-0 mt-1 d-inline"> <a
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
																</td>

																<td>${comment.title }</td>
																<td>
<%--																	<fmt:parseDate value="${comment.date }"--%>
<%--																		type="both" pattern="yyyy-MM-dd'T'HH:mm"--%>
<%--																		var="myDate"></fmt:parseDate> <fmt:formatDate--%>
<%--																		value="${myDate }" pattern="dd-MM-yyyy HH:mm" />--%>
																	${comment.date }
																</td>
																<td width="20%">
																	<div class="action">
																		<a href="${path }/san-pham/${comment.book.slug}"
																			class="btn btn-info editAuthor custom"> <i
																			class="fa fa-edit"></i></a> <a href="#"
																			data-toggle="modal"
																			data-target="#delete${comment.id }"
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
			<c:forEach items="${comments }" var="comment">
				<div class="modal fade " id="delete${comment.id }" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content ">
							<div class="modal-body text-center" style="color: #212529">
								Bạn có chắc chắn muốn xóa đánh giá này?</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Hủy</button>
								<a href="${path }/admin/comment/delete?id=${comment.id}"
									class="btn btn-danger">Xóa</a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
		</div>
	</div>
	<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
</body>
</html>