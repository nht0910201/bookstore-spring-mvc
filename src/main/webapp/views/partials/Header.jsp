<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<nav id="top" class="navbar navbar-expand-lg navbar-light bg-dark shadow-sm">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse " id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown ">
                <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-bars fa-2x" aria-hidden="true"></i>
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item " href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                </div>
            </li>
        </ul>
        <div clas="w-25">
            <a href="${pageContext.request.contextPath}/Home">
                <img class="w-25" src="https://www.tiendauroi.com/wp-content/uploads/2020/02/bhd-star-cinema.png" alt="">
            </a>
        </div>
        <div class="flex justify-content-around">
            <a class="btn btn-primary" href="#" role="button">
                <i class="fa fa-facebook-official" aria-hidden="true"></i>
            </a>
            <a  class="btn btn-primary" href="#" role="button">
                <i class="fa fa-instagram" aria-hidden="true"></i>
            </a>
            <a  class="btn btn-primary" href="#" role="button">
                <i class="fa fa-youtube" aria-hidden="true"></i>
            </a>
            <a  class="btn btn-primary" href="#" role="button">
                <i class="fa fa-envelope" aria-hidden="true"></i>
            </a>
            <a class="btn btn-outline-success text-white ml-2" href="#" role="button">
                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
            </a>
        </div>
        <div class="text-white">
            <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                <i class="fa fa-user-circle" aria-hidden="true"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <c:choose>
                    <c:when test="${auth}">
                        <form id="frmLogout" class="hide" method="post" action="${pageContext.request.contextPath}/auth/logout"></form>
                        <c:choose>
                            <c:when test="${role == 'CUSTOMER'}">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                    <i class="fa fa-user" aria-hidden="true"></i> Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fa fa-first-order" aria-hidden="true"></i>
                                    My Order
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="dropdown-item" href="#">
                                    <i class="fa fa-cog" aria-hidden="true"></i>
                                    Manage
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <a class="dropdown-item" href="javascript: $('#frmLogout').submit()">
                            <i class="fa fa-sign-out" aria-hidden="true"></i> Log out
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/auth/login">
                            <i class="fa fa-sign-in" aria-hidden="true"></i>
                            Login
                        </a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/auth/register">
                            <i class="fa fa-user-plus" aria-hidden="true"></i>
                            Register
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>