<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="vn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Danh mục sản phẩm</title>

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
						<div class="col-12">
							<div class="x_content">
								<div class="d-flex	justify-content-between align-items-center">
									<a href="${path }/admin/category" style="font-size: 16px">
										<i class="fa fa-angle-double-left"></i> Quay lại
									</a>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="col-md-12 col-sm-6  ">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											<small>Danh mục cha: </small>${parentCate.name }</h2>
										<a
											href="${path }/admin/category/sub-category/add?pid=${parentCate.id}"
											id="addSubCategory"
											class="btn btn-success float-right custom"> <i
											class="fa fa-plus-circle"></i> Thêm mới
										</a>
										<!-- Modal -->
										<div class="modal fade" id="addSubCategoryModal">
											<div class="modal-dialog">
												<div class="modal-content"></div>
											</div>
										</div>
										<!-- /Modals -->
										<div class="clearfix"></div>
									</div>
									<div class="x_content">

										<div class="card-box table-responsive">
											<table id="datatable-fixed-header"  
											class="table table-hover"
												style="width: 100%">
												<thead>
													<tr>
														<th width="8%" class="no-sort">STT</th>
														<th class="no-sort">Tên</th>
														<th width="15%" class="no-sort">Show Home</th>
														<th width="30%" class="no-sort">Thao tác</th>
													</tr>
												</thead>
												<tbody>

													<c:forEach items="${subCategories }" var="subCate"
														varStatus="loop">
														<c:if test="${subCate.status }">
															<tr>
																<td>${loop.index+1 }</td>
																<td><h5>${subCate.name }</h5></td>
																<td><input type="checkbox"
																	onclick="showHome(${subCate.id})"
																	${subCate.showHome ? 'checked' : '' } /></td>
																<td>
																	<div class="action">
																		<a
																			href="${path }/admin/category/sub-category/edit?sid=${subCate.id}"
																			class="editCategory btn btn-info"><i
																			class="fa fa-pencil"></i> </a>
																		<div class="modal fade" id="editCategoryModal">
																			<div class="modal-dialog">
																				<div class="modal-content"></div>
																			</div>
																		</div>
																		<a href="#" data-toggle="modal"
																			data-target="#delete${subCate.id }"
																			class="btn btn-danger"><i class="fa fa-trash-o"></i></a>
																	</div>
																</td>
															</tr>
														</c:if>
													</c:forEach>

												</tbody>
											</table>
										</div>

									</div>
								</div>
							</div>
							<!-- end col-6 -->

						</div>
					</div>
				</div>
			</div>
			<!-- /page content -->

			<c:forEach items="${subCategories }" var="subCate">
				<c:if test="${subCate.status }">
					<div class="modal fade " id="delete${subCate.id }" tabindex="-1">
						<div class="modal-dialog modal-sm">
							<div class="modal-content ">
								<div class="modal-body text-center" style="color: #212529">
									Bạn có chắc chắn muốn xóa danh mục
									<h6>${subCate.name }?</h6>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Hủy</button>
									<a href="${path }/admin/category/delete?id=${subCate.id}"
										class="btn btn-danger">Xóa</a>
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>



			<!-- footer content -->
			<c:import url="/WEB-INF/views/admin/layout/footer.jsp"></c:import>
			<!-- /footer content -->
		</div>
	</div>
	<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
	<script type="text/javascript">
		function showHome(id){
			$.ajax({
				url: "/admin/category/show?id="+id,
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
			$(".editCategory").on("click",function(e) {
				e.preventDefault();
				$(this).next().modal().find(
						".modal-content").load(
						$(this).attr("href"));
			})
			
			$("#addSubCategory").on("click",function(e) {
				e.preventDefault();
				$("#addSubCategoryModal").find(".modal-content").load($(this).attr("href"));
				$("#addSubCategoryModal").modal();
			})
		})
	</script>
</body>
</html>