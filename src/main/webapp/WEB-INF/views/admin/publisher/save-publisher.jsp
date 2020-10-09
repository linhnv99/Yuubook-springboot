<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form action="/admin/publisher/save"
	modelAttribute="publisher" method="post">
	<div class="modal-header">
		<h5 class="modal-title" id="author">${(isAdd) ? 'Thêm' : 'Sửa' }
			nhà xuất bản</h5>
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
			<label for="publisherName">Tên nhà xuất bản</label>
			<form:input path="name" type="text" class="form-control" id="publisherName" />
		</div>
		<div class="form-group">
			<label for="publisherDesc">Mô tả</label>
			<form:textarea path="desc" id="publisherDesc" class="form-control" rows="8" />
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<button type="submit" class="btn btn-primary">${(isAdd) ? 'Add' : 'Save' }</button>
	</div>
</form:form>