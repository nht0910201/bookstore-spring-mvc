<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<nav id="top" class="navbar navbar-expand-lg navbar-light bg-light shadow sticky-top">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">
        <div class="w-25 d-flex">
            <a href="${pageContext.request.contextPath}/Home">
                <img style="width: 120px" src="https://seeklogo.com/images/E/ebook-logo-70316FE30A-seeklogo.com.png"
                     alt="">
            </a>
        </div>

        <div class="d-flex align-items-center">
            <div class=" d-flex">
                <input type="search" id="txtSearch" placeholder="Search" class="form-control mr-1">
                <button type="button" class="btn btn-success"><i class="fa fa-search" aria-hidden="true"></i></button>
            </div>
            <div class="d-flex align-items-center">
                <a class="btn btn-danger ml-2" href="#" role="button">
                    <i class="fa fa-shopping-bag text-white" aria-hidden="true"></i>
                </a>
                <div>
                    <a class="nav-link dropdown-toggle text-dark" href="#" role="button" data-toggle="dropdown"
                       aria-expanded="false">
                        <i class="fa fa-user-circle" aria-hidden="true"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <c:choose>
                            <c:when test="${auth}">
                                <form id="frmLogout" class="hide" method="post"
                                      action="${pageContext.request.contextPath}/auth/logout"></form>
                                <c:choose>
                                    <c:when test="${role == 'CUSTOMER'}">
                                        <a class="dropdown-item d-flex justify-content-between align-items-center" href="${pageContext.request.contextPath}/user/profile">
                                            PROFILE
                                            <i class="fa fa-user" aria-hidden="true"></i>
                                        </a>
                                        <a class="dropdown-item d-flex justify-content-between align-items-center" href="#">
                                            MY ORDER
                                            <i class="fa fa-history" aria-hidden="true"></i>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="dropdown-item d-flex justify-content-between align-items-center" href="${pageContext.request.contextPath}/user/profile">
                                            PROFILE
                                            <i class="fa fa-user" aria-hidden="true"></i>
                                        </a>
                                        <a class="dropdown-item d-flex justify-content-between align-items-center" href="#">
                                            MY ORDER
                                            <i class="fa fa-history" aria-hidden="true"></i>
                                        </a>
                                        <a class="dropdown-item d-flex justify-content-between align-items-center" href="${pageContext.request.contextPath}/admin/manage">
                                            MANAGE
                                            <i class="fa fa-history" aria-hidden="true"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <a class="dropdown-item d-flex justify-content-between align-items-center" href="javascript: $('#frmLogout').submit()">
                                    LOG OUT
                                    <i class="fa fa-sign-out" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="dropdown-item d-flex justify-content-between align-items-center" href="${pageContext.request.contextPath}/auth/login">
                                    LOGIN
                                    <i class="fa fa-sign-in" aria-hidden="true"></i>
                                </a>
                                <a class="dropdown-item d-flex justify-content-between align-items-center" href="${pageContext.request.contextPath}/auth/register">
                                    REGISTER
                                    <i class="fa fa-user-plus" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

    </div>
</nav>