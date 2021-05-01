<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form action="/admin/author/save" enctype="multipart/form-data"
	modelAttribute="author" method="post">
	<div class="modal-header">
		<h5 class="modal-title" id="author">${isAdd ? 'Thêm' : 'Sửa' }
			tác giả</h5>
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body">
		<c:if test="${!isAdd }">
			<form:hidden path="id" />
		</c:if>
		<div class="form-group">
			<label for="authorName">Tên tác giả</label>
			<form:input path="name" type="text" class="form-control"
				id="authorName" />
		</div>
		<div class="form-group">
			<label for="authorImage">Ảnh</label> <input type="file"
				class="form-control" name="authorImage">
		</div>

		<c:if test="${!isAdd }">
			<div class="form-group">
				<img
					src="${path }/files/${author.avatar}"
					class="img-fluid" style="max-height: 100px">
			</div>
		</c:if>

		<div class="form-group">
			<label for="authorDesc">Mô tả</label>
			<form:textarea path="desc" id="editor" class="summernote"
				rows="8" />
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<button type="submit" class="btn btn-primary">${isAdd ? 'Add' : 'Save' }</button>
	</div>
</form:form>
<script src="${path }/admin/vendors/ckeditor/ckeditor.js"></script>
<script>
	CKEDITOR.replace('editor');
	/* $(document).ready(function(){
		$('.summernote').summernote({
			height:250
		});
	})  */
</script>