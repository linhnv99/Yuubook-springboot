<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Liên hệ</title>
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
					<div class="page-title"></div>

					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										<i class="fa fa-align-left"></i> Danh sách liên hệ
									</h2>
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
															<th width="20%" class="no-sort">Tên</th>
															<th width="15%" class="no-sort">Số điện thoại</th>
															<th width="20%" class="no-sort">Tiêu đề</th>
															<th class="no-sort">Nội dung</th>
															<th width="15%" class="no-sort">Thao tác</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${contacts }" var="contact">
															<tr>
																<td>${contact.name }</td>
																<td>${contact.phone }</td>
																<td>${contact.subject }</td>
																<td><c:forTokens items="${contact.content }"
																		delims=" " var="myStr" begin="0" end="50"
																		varStatus="loop">
																	${myStr }
																	<c:if test="${loop.index > 49 }">...</c:if>
																	</c:forTokens></td>
																<td>
																	<div class="action">
																		<a href="#" class="btn btn-info editAuthor custom"
																			data-toggle="modal" data-target="#view${contact.id }">
																			<i class="fa fa-edit"></i>
																		</a> <a href="#" data-toggle="modal"
																			data-target="#delete${contact.id }"
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
			<!-- Modal -->
			<c:forEach items="${contacts }" var="contact">
				<div class="modal fade" id="view${contact.id }" tabindex="-1"
					role="dialog" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="category">Contact</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<div class="contact-view">
									<p>
										Name: <span>${contact.name }</span>
									</p>
									<p>
										Phone: <span>${contact.phone }</span>
									</p>
									<p>
										Subject: <span>${contact.subject } </span>
									</p>
									<p>Content:</p>
									<p>${contact.content }</p>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<!-- /modals -->

			<c:forEach items="${contacts }" var="contact">
				<div class="modal fade " id="delete${contact.id }" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content ">
							<div class="modal-body text-center" style="color: #212529">
								Bạn có chắc chắn muốn xóa liên hệ của
								<h6>${contact.name }?</h6>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Hủy</button>
								<a href="${path }/admin/contact/delete?id=${contact.id}"
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
</body>

</html>