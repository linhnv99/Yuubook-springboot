<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<div class="top_nav">
	<div class="nav_menu">
		<div class="nav toggle">
			<a id="menu_toggle"><i class="fa fa-bars"></i></a>
		</div>
		<nav class="nav navbar-nav">
			<ul class=" navbar-right">
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="adminLogin"/>
				</sec:authorize>
				<li class="nav-item dropdown open" style="padding-left: 15px;">
					<a href="javascript:;" class="user-profile dropdown-toggle"
					aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown"
					aria-expanded="false"> 
					<c:choose>
						<c:when test="${adminLogin.avatar != null }">
							<img src="${adminLogin.avatar}" alt="">
						</c:when>
						<c:otherwise>
							<img src="${path}/images/user.png" alt="">
						</c:otherwise>
					</c:choose>
					
					${adminLogin.surname } ${adminLogin.name }				</a> 
						<div class="dropdown-menu dropdown-usermenu pull-right"
							aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="${path }/admin/profile">
								Profile</a> <a class="dropdown-item" href="${path }/logout"><i
								class="fa fa-sign-out pull-right"></i> Log Out</a>
						</div>
				</li>
			</ul>
		</nav>
	</div>
</div>