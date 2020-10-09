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

<title>Thêm sản phẩm</title>

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
					</div>

					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12 ">
							<div class="col-md-12 col-sm-12  ">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											<i class="fa fa-align-left"></i> Thêm sản phẩm
										</h2>
										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<form:form action="/admin/product/save"
											enctype="multipart/form-data" modelAttribute="book"
											method="POST">
											<div class="modal-body">
												<c:if test="${!isAdd }">
													<form:hidden path="id" />
												</c:if>
												<div class="form-group">
													<label for="name">Tên sản phẩm</label>
													<form:input path="name" type="text" class="form-control"
														id="name" />
												</div>
												<div class="form-group">
													<label for="category">Danh mục cha</label>
													<form:select id="category" path="category"
														class="form-control">
														<form:option value="-1">- Chọn danh mục -</form:option>
														<c:forEach items="${parentCategories }" var="parentCate">
															<form:option value="${parentCate.id }">${parentCate.name }</form:option>
														</c:forEach>
													</form:select>
													<c:if test="${!isAdd }">
														<p class="text-muted mb-2">Old category:
															${book.category.parentId.name }</
														<p>
													</c:if>
												</div>

												<div class="form-group">
													<label for="subCategory">Danh mục con</label> <select
														id="subCategory" name="subCategory" class="form-control">
														<option value="-1" selected>- Chọn danh mục con -</option>
													</select>
													<c:if test="${!isAdd }">
														<p class="text-muted mb-2">Old Subcategory:
															${book.category.name }</
														<p>
													</c:if>
												</div>
												<div class="form-group">
													<label for="avatar">Main Avatar</label> <input type="file"
														class="form-control" name="mainAvatar" />
												</div>
												<c:if test="${!isAdd }">
													<div class="form-group">
														<!-- <p class="text-muted mb-2">Old MainAvatar</p> -->
														<img style="max-height: 120px" alt="avatar"
															src="${path }/files/${book.avatar}">
													</div>
												</c:if>
												<div class="form-group">
													<label for="avatar">Extra Avatar</label> <input type="file"
														class="form-control" name="extraAvatar"
														multiple="multiple" />
												</div>
												<c:if test="${!isAdd }">
													<div class="form-group">
														<!-- <p class="text-muted mb-2">Old ExtraAvatar</p> -->
														<c:forEach items="${book.bookImages }" var="bookImage">
															<img style="max-height: 120px" alt="avatar" class="mr-2"
																src="${path }/files/${bookImage.path}">
														</c:forEach>
													</div>
												</c:if>
												<div class="form-group">
													<label for="price">Giá bán</label>
													<form:input path="price" type="number" class="form-control"
														id="price" min="0" />
												</div>
												<div class="form-group">
													<label for="discount">Giảm giá</label>
													<form:input path="discount" type="number"
														class="form-control" id="discount" min="0"  />
												</div>
												<div class="form-group">
													<label for="dimension">Kích thước</label>
													<form:input path="dimension" type="text"
														class="form-control" id="dimension" />
												</div>
												<div class="form-group">
													<label for="format">Định dạng</label>
													<form:input path="format" type="text" class="form-control"
														id="format" />
												</div>
												<div class="form-group">
													<label for="language">Ngôn ngữ</label>
													<form:input path="language" type="text"
														class="form-control" id="language" />
												</div>
												<div class="form-group">
													<label for="totalPage">Số trang</label>
													<form:input path="totalPage" type="number"
														class="form-control" id="totalPage" min="0" />
												</div>
												<div class="form-group">
													<label for="author">Tác giả</label>
													<form:select path="author" id="author" class="form-control">
														<form:options items="${authors }" itemLabel="name"
															itemValue="id" />
													</form:select>
												</div>
												<div class="form-group">
													<label for="publisher">Nhà xuất bản</label>
													<form:select path="publisher" id="publisher"
														class="form-control">
														<form:options items="${publishers }" itemLabel="name"
															itemValue="id" />
													</form:select>
												</div>
												<div class="form-group">
													<label for="publicationDate">Năm xuất bản</label>
													<form:input class="form-control" type="datetime-local"
														id="publicationDate" name="publicationDate"
														path="publicationDate" />
												</div>
												<div class="form-group">
													<label for="hot">Hot</label>
													<form:checkbox path="hot" class="ml-3" />
												</div>

												<div class="form-group">
													<label for="act">Trạng thái</label> <select name="act"
														class="form-control">
														<c:choose>
															<c:when test="${isAdd }">
																<option value="1">Đang bán</option>
																<option value="0">Tạm dừng</option>
															</c:when>
															<c:otherwise>
																<option value="1" ${book.act ? 'selected' : '' }>Đang
																	bán</option>
																<option value="0" ${!book.act ? 'selected' : '' }>Tạm
																	dừng</option>
															</c:otherwise>
														</c:choose>
													</select>
												</div>

												<div class="form-group">
													<label for="">Mô tả</label>
													<form:textarea path="desc" name="des" rows="5"
														 id="editor"/>
												</div>
											</div>
											<div class="modal-footer">
												<a href="${path }/admin/product" class="btn btn-secondary"
													>Back</a>
												<button type="submit" class="btn btn-primary">${isAdd ? 'Add' : 'Save' }</button>
											</div>
										</form:form>
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
	<script src="${path }/admin/vendors/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
	CKEDITOR.replace('editor');
	$(document).ready(
		     function () {	
		          /* $('.summernote').summernote({
		        	  height: 300
		          }); */
		          $("#subCategory").attr("disabled", "disabled");
		          $("#category").on("change",function () {
		               $.ajax({
		                    url: "/admin/api/getSub/"
		                         + $(this).val(),
		                    type: "GET",
		                    dataType: "json",
		                    success: function (data, status) {
		                         if (status == "success") {
		                              var option = "";
		                              $("#subCategory").empty();
		                              for (var i = 0; i < data.length; i++) {
		                                   option = option
		                                        + "<option value='" + data[i].id + "'>"
		                                        + data[i].name
		                                        + "</option>";
		                              }
		                              if (data.length == 0) {
		                                   $("#subCategory").append("<option value='0'>- Chọn danh mục con -</option>");
		                              }
		                              $("#subCategory").append(option);
		                              $("#subCategory").removeAttr("disabled");
		                         }
		                    },
		                    error: function (err) {
		                         console.log(err);
		                    }
		               })
		          })
		     }
		)
	</script>
</body>
</html>