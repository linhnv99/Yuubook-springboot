<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Sản phẩm</title>
<c:import url="/WEB-INF/views/admin/layout/css.jsp"></c:import>
</head>
<style>
	.status{font-size: 13px;}
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
							<div class="row">
								<div class="col-md-12 col-sm-12 ">
									<div class="x_panel">
										<div class="x_title">
											<h2>
												<i class="fa fa-align-left"></i> Danh sách sản phẩm
											</h2>
											<a href="${path}/admin/product/add" type="button"
												class="btn btn-success custom float-right" id="addProduct"><i
												class="fa fa-plus-circle"></i> Thêm mới </a>

											<div class="modal fade" id="addProductModal" tabindex="-1"
												role="dialog" aria-hidden="true">
												<div class="modal-dialog modal-lg">
													<div class="modal-content"></div>
												</div>
											</div>
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
																	<th width="1%" class="no-sort">ID</th>
																	<th class="no-sort">Tên</th>
																	<th width="10%" class="no-sort">Ảnh</th>
																	<th width="12%" class="no-sort">Giá</th>
																	<th width="18%" class="no-sort">Danh mục</th>
																	<th width="2%" class="no-sort">Hot</th>
																	<th width="12%" class="no-sort">Trạng thái</th>
																	<th width="15%" class="no-sort">Thao tác</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach items="${books }" var="book" varStatus="loop">
																	<c:if test="${book.status }">
																		<tr>
																			<td>${book.id }</td>
																			<td>${book.name }</td>
																			<td>
																				<img height="100" alt="avatar"
																				src="${path}/files/${book.avatar }">
																			</td>
																			<td>
																				<c:choose>
																					<c:when test="${book.discount!=0 && book.discount !=null }">
																						<p class="old-price mb-1  text-muted ">
																							<fmt:formatNumber type="number"
																							pattern="###,###,###" value="${book.price}" /> vnđ
																						</p>
																						<p class="new-price ">
																							<c:set value="${book.price - (book.price * book.discount)/100}" var="myPrice"></c:set>
																							<fmt:formatNumber type="number"
																							pattern="###,###,###" value="${myPrice }" /> vnđ
																						</p>
																					</c:when>
																					<c:otherwise>
																						<fmt:formatNumber type="number"
																							pattern="###,###,###" value="${book.price}" /> vnđ
																					</c:otherwise>
																				</c:choose>
																			</td>
																			<td><span>${book.category.name }</span></td>
																			<td>
																				<c:if test="${book.hot }">
																					<span class="bg-danger text-white p-1 rounded">hot</span>
																				</c:if>
																			</td>
																			<td>
																				<c:choose>
																					<c:when test="${book.act }">
																						<span class="bg-success text-white py-1 px-2 rounded status">Đang bán</span>
																					</c:when>
																					<c:otherwise>
																						<span style="background-color: #d35400" class="text-white py-1 px-2 rounded status">Tạm dừng</span>
																					</c:otherwise>
																				</c:choose>
																			</td>
																			<td>
																				<div class="action">
																					 <a
																						href="${path }/admin/product/edit?id=${book.id}"
																						class="btn btn-info custom editProduct"><i
																						class="fa fa-edit"></i></a>
																					<div class="modal fade" id="editProductModal"
																						tabindex="-1" role="dialog" aria-hidden="true">
																						<div class="modal-dialog modal-lg">
																							<div class="modal-content"></div>
																						</div>
																					</div>
																					<a href="#" class="btn btn-danger custom"
																						data-toggle="modal"
																						data-target="#delete${book.id }"><i
																						class="fa fa-trash-o"></i></a>
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
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row"> 
						<div class="col-12">
							<a href="${path }/admin/product-removed" class="text-primary"> Danh sách sản phẩm đã xóa</a>
						</div>
					</div>
					<!-- /page content -->
					<c:forEach items="${books }" var="book">
						<div class="modal fade " id="delete${book.id }" tabindex="-1">
							<div class="modal-dialog modal-sm">
								<div class="modal-content ">
									<div class="modal-body text-center" style="color: #212529">
										Bạn có chắc chắn muốn xóa sản phẩm
										<h6>${book.name }?</h6>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Hủy</button>
										<a href="${path }/admin/book/delete?id=${book.id}"
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
		</div>
	</div>
	<c:import url="/WEB-INF/views/admin/layout/js.jsp"></c:import>
  	
</body>
</html>