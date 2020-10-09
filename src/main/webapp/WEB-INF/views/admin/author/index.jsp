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

<title>Tác giả</title>

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

					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="x_panel" id="list-author">
								<div class="x_title">
									<h2>
										<i class="fa fa-align-left"></i> Danh sách tác giả
									</h2>
									<!-- modals -->
									<a href="${path }/admin/author/add"
										class=" addAuthor btn btn-success custom float-right"
										id="addAuthor"><i class="fa fa-plus-circle"></i> Thêm mới</a>

									<!-- Modal -->
									<div class="modal fade" id="addAuthorModal" tabindex="-1"
										role="dialog" aria-labelledby="author" aria-hidden="true">
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
											<div class="card-box table-responsive table-load">
												<table id=""
													class="table table-hover" style="width: 100%">
													<thead>
														<tr>
															<th>STT</th>
															<th>Tên</th>
															<th>Ảnh</th>
															<th>Mô tả</th>
															<th>Show</th>
															<th>Thao tác</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${authors }" var="author"
															varStatus="loop">
															<tr>
																<td>${loop.index + 1}</td>
																<td width="15%">${author.name }</td>
																<td width="20%"><c:choose>
																		<c:when test="${author.avatar != null}">
																			<img src="${path }/files/${author.avatar}"
																				class="img-fluid"
																				style="max-height: 150px; margin: auto; display: block" />
																		</c:when>
																		<c:otherwise>
																			<img src="${path }/files/user.png" class="img-fluid"
																				style="max-height: 150px; margin: auto; display: block" />
																		</c:otherwise>
																	</c:choose></td>

																<td width="40%"><c:forTokens
																		items="${author.desc }" delims=" " var="mySplit"
																		begin="0" end="50">
																		${mySplit}
																	</c:forTokens> ...</td>
																<td><input type="checkbox"
																	${author.showHome ? 'checked' : '' }
																	onclick="showHome(${author.id})" class="show-home" /></td>
																<td width="20%">
																	<div class="action">
																		<a href="${path }/admin/author/edit?id=${author.id}"
																			class="btn btn-info editAuthor custom"> <i
																			class="fa fa-edit"></i></a>
																		<div class="modal fade" id="editAuthorModal"
																			tabindex="-1" role="dialog" aria-labelledby="author"
																			aria-hidden="true">
																			<div class="modal-dialog">
																				<div class="modal-content"></div>
																			</div>
																		</div>
																		<a href="#" data-toggle="modal"
																			data-target="#delete${author.id }"
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
			<c:forEach items="${authors }" var="author">
				<div class="modal fade " id="delete${author.id }" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content ">
							<div class="modal-body text-center" style="color: #212529">
								Bạn có chắc chắn muốn xóa tác giả
								<h6>${author.name }?</h6>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Hủy</button>
								<a href="${path }/admin/author/delete?id=${author.id}"
									class="btn btn-danger">Xóa</a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

			<!-- /page content -->
			<c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
		</div>
	</div>
	<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
	<script type="text/javascript">
		function showHome(id){
			$.ajax({
				url: "/admin/author/show?id="+id,
				type: "PUT",
				success: function(data, status){
					if(status=="success"){
						console.log(data);
					}
				},
				error: function(err){
					console.log(err);
				}
			})
		}
		$(document).ready(function() {
			$(".editAuthor").on("click",function(e) {
				e.preventDefault();
				$(this).next().modal().find(
						".modal-content").load(
						$(this).attr("href"));
			})
			$("#addAuthor").on("click",function(e) {
				e.preventDefault();
				$("#addAuthorModal").find(".modal-content").load($(this).attr("href"));
				$("#addAuthorModal").modal();
			})
		})
	</script>
</body>
</html>