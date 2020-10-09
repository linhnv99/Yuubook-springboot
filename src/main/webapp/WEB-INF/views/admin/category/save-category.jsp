<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<form:form action="/admin/category/save" method="POST"
	modelAttribute="category">
	<div class="modal-header">
		<h5 class="modal-title" id="categoryModal">${isAdd ? 'Thêm' : 'Sửa'} danh mục</h5>
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body">
		<c:if test="${!isAdd }">
			<form:hidden path="id"/>
		</c:if>
		<div class="form-group">
			<label for="">Tên danh mục</label>
			<form:input path="name" type="text" class="form-control" />
		</div>
		<div class="form-group">
			<label for="">Mô tả</label>
			<form:textarea path="desc" class="form-control" rows="5" />
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<button type="submit" class="btn btn-primary">${isAdd ? 'Add' : 'Save'}</button>
		</div>
	</div>
</form:form>