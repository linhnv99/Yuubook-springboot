<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html lang="vn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Nhà xuất bản</title>

<c:import url="/WEB-INF/views/admin/layout/css.jsp"></c:import>
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

					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										<i class="fa fa-align-left"></i> Danh sách nhà xuất bản
									</h2>
									<!-- modals -->
									<a href="${path }/admin/publisher/add" id="addPubliser"
										class="btn btn-success  float-right custom"><i class="fa fa-plus-circle"></i> Thêm mới</a>

									<!-- Modal -->
									<div class="modal fade" id="addPubliserModal" tabindex="-1"
										role="dialog" aria-labelledby="publisher" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content"></div>
										</div>
									</div>
									<!-- /modals -->
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="row">
										<div class="col-sm-12">
											<div class="card-box table-responsive">
												<table id="datatable-fixed-header"
													class="table table-hover"
													style="width: 100%">
													<thead>
														<tr>
															<th class="no-sort">STT</th>
															<th width="25%" class="no-sort">Tên</th>
															<th class="no-sort">Mô tả</th>
															<th width="20%" class="no-sort">Thao tác</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${publishers }" var="publisher" varStatus="loop">
															<tr>
																<td>${loop.index + 1}</td>
																<td>${publisher.name }</td>
																<td><c:forTokens items="${publisher.desc }"
																		delims=" " var="mySplit" begin="0" end="50">
																		${mySplit}
																	</c:forTokens>
																...
																</td>
																<td>
																	<div class="action">
																		 <a
																			href="${path }/admin/publisher/edit?id=${publisher.id}"
																			class="btn btn-info custom editPublisher"> <i
																			class="fa fa-edit"></i></a>
																		<div class="modal fade" id="editPubliserModal"
																			tabindex="-1" role="dialog"
																			aria-labelledby="publisher" aria-hidden="true">
																			<div class="modal-dialog">
																				<div class="modal-content"></div>
																			</div>
																		</div>
																		<a
																			href="#"
																			data-toggle="modal"
																			data-target="#delete${publisher.id }"
																			class="btn btn-danger custom"><i class="fa fa-trash-o"></i></a>
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
			<c:forEach items="${publishers }" var="publisher">
				<div class="modal fade " id="delete${publisher.id }" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content ">
							<div class="modal-body text-center" style="color: #212529">
								Bạn có chắc chắn muốn xóa nhà xuất bản
								<h6>${publisher.name }?</h6>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Hủy</button>
								<a href="${path }/admin/publisher/delete?id=${publisher.id}"
									class="btn btn-danger">Xóa</a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<!-- footer content -->
			<c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
			<!-- /footer content -->
		</div>
	</div>
	<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
	<script type="text/javascript">
		$(document).ready(function() {
					$(".editPublisher").on("click",function(e) {
						e.preventDefault();
						$(this).next().modal("show").find(".modal-content").load($(this).attr("href"));
					})
					$("#addPubliser").on("click",function(e) {
						e.preventDefault();
						$(this).next().modal("show").find(".modal-content").load($(this).attr("href"));
					})
					
				})
	</script>
</body>
</html>