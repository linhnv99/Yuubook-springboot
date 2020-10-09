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

<title>Người dùng</title>

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
						<div class="x_panel">
							<div class="x_title">
								<h2>
									<i class="fa fa-align-left"></i> Danh sách người dùng
								</h2>
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<div class="row">
									<div class="col-sm-12">
										<div class="card-box table-responsive table-load">
											<table id="datatable-fixed-header" 
											class="table table-hover" style="width: 100%">
												<thead>
													<tr>
														<th width="5%" class="no-sort">STT</th>
														<th width="10%" class="no-sort">Ảnh</th>
														<th width="20%"class="no-sort"> Họ Tên</th>
														<th class="no-sort">SDT</th>
														<th class="no-sort">Email</th>
														<th class="no-sort">Thời gian tạo</th>
														<th width="10%" class="no-sort">Vai trò</th>
														<th width="10%" class="no-sort">Thao tác</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${users }" var="user" varStatus="loop">
														<tr>
															<td>${loop.index + 1}</td>

															<td><c:choose>
																	<c:when test="${user.avatar != null}">
																		<img src="${path }/files/${user.avatar}"
																			class="img-fluid"
																			style="max-height: 80px; margin: auto; display: block" />
																	</c:when>
																	<c:otherwise>
																		<img src="${path }/files/user.png" class="img-fluid"
																			style="max-height: 80px; margin: auto; display: block" />
																	</c:otherwise>
																</c:choose></td>
															<td>${user.surname } ${user.name }</td>
															<td>${user.phone }</td>
															<td>${user.email }</td>
															<td>
																<fmt:parseDate value="${user.createdDate }" type="both" pattern="yyyy-MM-dd'T'HH:mm:ss" var="myDate"></fmt:parseDate>
																<fmt:formatDate value="${myDate }" pattern="dd-MM-yyyy HH:mm:ss"/>
															</td>
															<td>
															<c:forEach items="${user.roles }" var="role">
																	<c:choose>
																		<c:when test="${role.name == 'ROLE_ADMIN' }">
																			<span class="bg-success text-white py-1 px-2 rounded">Admin</span>
																		</c:when>
																		<c:otherwise>
																			<span style="background-color: #d35400"
																				class="text-white py-1 px-2 rounded">User</span>
																		</c:otherwise>
																	</c:choose></td>
															</c:forEach>
													<td>
														<div class="action">
															<a href="#" class="btn btn-danger custom"
																data-toggle="modal" data-target="#delete${user.id }"><i
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
			<!-- /page content -->
			<c:forEach items="${users }" var="user">
				<div class="modal fade " id="delete${user.id }" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content ">
							<c:forEach items="${user.roles }" var="role">
								<c:if test="${role.name == 'ROLE_USER' }">
									<div class="modal-body text-center" style="color: #212529">
										Bạn có chắc chắn muốn người dùng
										<h6>${user.name }?</h6>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Hủy</button>
										<a href="${path }/admin/user/delete?id=${user.id}"
											class="btn btn-danger">Xóa</a>
									</div>
								</c:if>
								<c:if test="${role.name == 'ROLE_ADMIN' }">
									<div class="modal-body text-center" style="color: #212529">
										<h5>KHÔNG THỂ XÓA TÀI KHOẢN QUẢN TRỊ.</h5	>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Hủy</button>
									</div>
								</c:if>
							</c:forEach>
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