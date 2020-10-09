<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<form:form action="/admin/product/save" enctype="multipart/form-data"
	modelAttribute="book" method="POST">
	<div class="modal-header">
		<h4 class="modal-title" id="myModalLabel">${isAdd ? 'Thêm' : 'Sửa'  }
			sản phẩm</h4>
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">×</span>
		</button>
	</div>
	<div class="modal-body">
		<c:if test="${!isAdd }">
			<form:hidden path="id"/>
		</c:if>
		<div class="form-group">
			<label for="name">Tên sản phẩm</label>
			<form:input path="name" type="text" class="form-control" id="name" />
		</div>
		<div class="form-group">
			<label for="category">Danh mục cha</label>
			<form:select id="category" path="category" class="form-control">
				<form:option value="-1">- Chọn danh mục -</form:option>
				<c:forEach items="${parentCategories }" var="parentCate">
					<form:option value="${parentCate.id }">${parentCate.name }</form:option>
				</c:forEach>
			</form:select>
			<c:if test="${!isAdd }">
				<p class="text-muted mb-2">Old category: ${book.category.parentId.name }</<p>
			</c:if>
		</div>

		<div class="form-group">
			<label for="subCategory">Danh mục con</label> <select
				id="subCategory" name="subCategory" class="form-control">
				<option value="-1" selected>- Chọn danh mục con -</option>
			</select>
			<c:if test="${!isAdd }">
				<p class="text-muted mb-2">Old Subcategory: ${book.category.name }</<p>
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
				class="form-control" name="extraAvatar" multiple="multiple" />
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
			<form:input path="discount" type="number" class="form-control"
				id="discount" min="0" />
		</div>
		<div class="form-group">
			<label for="dimension">Kích thước</label>
			<form:input path="dimension" type="text" class="form-control"
				id="dimension" />
		</div>
		<div class="form-group">
			<label for="format">Định dạng</label>
			<form:input path="format" type="text" class="form-control"
				id="format" />
		</div>
		<div class="form-group">
			<label for="language">Ngôn ngữ</label>
			<form:input path="language" type="text" class="form-control"
				id="language" />
		</div>
		<div class="form-group">
			<label for="totalPage">Số trang</label>
			<form:input path="totalPage" type="number" class="form-control"
				id="totalPage" min="0" />
		</div>
		<div class="form-group">
			<label for="author">Tác giả</label>
			<form:select path="author" id="author" class="form-control">
				<form:options items="${authors }" itemLabel="name" itemValue="id" />
			</form:select>
		</div>
		<div class="form-group">
			<label for="publisher">Nhà xuất bản</label>
			<form:select path="publisher" id="publisher" class="form-control">
				<form:options items="${publishers }" itemLabel="name" itemValue="id" />
			</form:select>
		</div>
		<div class="form-group">
			<label for="publicationDate">Năm xuất bản</label>
			<form:input class="form-control" type="datetime-local"
				id="publicationDate" name="publicationDate" path="publicationDate" />
		</div>
		<div class="form-group">
			<label for="hot">Hot</label>
			<form:checkbox path="hot" class="ml-3"/>
		</div>
		
		<div class="form-group">
			<label for="act">Trạng thái</label>
			<select name="act" class="form-control">
				<c:choose>
					<c:when test="${isAdd }">
						<option value="1">Đang bán</option>	
						<option value="0" >Tạm dừng</option>
					</c:when>
					<c:otherwise>
						<option value="1" ${book.act ? 'selected' : '' }>Đang bán</option>
						<option value="0" ${!book.act ? 'selected' : '' }>Tạm dừng</option>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
		
		<div class="form-group">
			<label for="">Mô tả</label>
			<form:textarea path="desc" name="des" rows="3" class="summernote" />
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<button type="submit" class="btn btn-primary">${isAdd ? 'Add' : 'Save' }</button>
	</div>
</form:form>
<script>
	$(document)
			.ready(
					function() {
						$('.summernote').summernote();
						$("#subCategory").attr("disabled", "disabled");
						$("#category")
								.on(
										"change",
										function() {
											$
													.ajax({
														url : "/admin/api/getSub/"
																+ $(this).val(),
														type : "GET",
														dataType : "json",
														success : function(
																data, status) {
															if (status == "success") {
																var option = "";
																$(
																		"#subCategory")
																		.empty();
																for (var i = 0; i < data.length; i++) {
																	option = option
																			+ "<option value='"+data[i].id + "'>"
																			+ data[i].name
																			+ "</option>";
																}
																if (data.length == 0) {
																	$(
																			"#subCategory")
																			.append(
																					"<option value='0'>- Chọn danh mục con -</option>");
																}
																$(
																		"#subCategory")
																		.append(
																				option);
																$(
																		"#subCategory")
																		.removeAttr(
																				"disabled");
															}
														},
														error : function(err) {
															console.log(err);
														}
													})
										})

					})
</script>