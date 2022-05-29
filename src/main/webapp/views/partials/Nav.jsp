<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="suppliers" scope="request" type="java.util.List<com.hcmute.mobilestore.models.Supplier>"/>
<div class="header">
    <nav class="navbar navbar-expand-lg navbar-light " style="background-image: linear-gradient(#ea8215, #eca45d)">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-lg-between"  id="navbarSupportedContent">
            <a href="${pageContext.request.contextPath}/Home"><img src="https://sp-ao.shortpixel.ai/client/q_glossy,ret_img/https://lambanner.com/wp-content/uploads/2020/04/MNT-DESIGN-10-MEO-THIET-KE-LOGO-1130x570.jpg" class="img-fluid rounded-top"
                                                                   alt="No Loading" style=" width:140px ;height: 70px"></a>
            <nav class="navbar navbar-light d-inline">
                <div class="form-inline">
                    <input id="search" class="form-control mr-sm-3" onkeydown = "if (event.keyCode == 13)
                        document.getElementById('btnSearch').click()" name="search"  type="search" placeholder="Search" aria-label="Search" style="width: 500px">
                    <button id="btnSearch" class="btn btn-danger text-light my-2 my-sm-0 " type="button" onclick="Found('${pageContext.request.contextPath}')" >
                        <i class="fa fa-search"></i>
                        Search
                    </button>
                </div>
            </nav>
            <ul class="navbar-nav">
                <li class="nav-item active mr-4 ">
                    <a href="${pageContext.request.contextPath}/Cart?acc_id=${authUser.id}"  id="watchlist" class="text-light " style="font-weight: bold" >
                    <i class="fa fa-heart text-danger" aria-hidden="true"></i>
                    Shopping Cart
                </a>
                </li>
                <li class="nav-item active mr-4 dropdown">
                    <c:choose>
                        <c:when test="${auth}">
                            <form id="frmLogout" method="post" action="${pageContext.request.contextPath}/Account/Logout"></form>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light " style="font-weight: bold">
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                <c:set var="nameParts" value="${fn:split(authUser.name, ' ')}"/>
                                Hi, <b>${nameParts[0]}!</b>
                                <c:choose>
                                    <c:when test="${role == 0}">(Quản lý)</c:when>
                                    <c:when test="${role == 1}">(Nhân viên)</c:when>
                                    <c:otherwise>(Khách hàng)</c:otherwise>
                                </c:choose>
                            </a>
                            <ul class="dropdown-menu mt-0 dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                                <c:choose>
                                    <c:when test="${role != 2}"><li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile/${authUser.id}">
                                        <i class="fa fa-user" aria-hidden="true"></i> Trang cá nhân
                                    </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Admin/Manage">
                                            <i class="fa fa-cog" aria-hidden="true"></i>
                                            Quản lý
                                        </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile/${authUser.id}">
                                            <i class="fa fa-user" aria-hidden="true"></i> Trang cá nhân
                                        </a></li>
                                    </c:otherwise>
                                </c:choose>

<%--                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/YourProduct?uid=${authUser.id}">--%>
<%--                                    <i class="fa fa-product-hunt" aria-hidden="true"></i> Đơn hàng của bạn--%>
<%--                                </a></li>--%>
                                <li><a class="dropdown-item" href="javascript: $('#frmLogout').submit()">
                                    <i class="fa fa-sign-out" aria-hidden="true"></i> Đăng xuất
                                </a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light " style="font-weight: bold">
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                Đăng nhập/Đăng ký
                            </a>
                            <ul class="dropdown-menu mt-0 dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Login">
                                    <i class="fa fa-sign-in mr-1" aria-hidden="true"></i> Đăng nhập
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Register">
                                    <i class="fa fa-user-plus mr-1" aria-hidden="true"></i> Đăng ký
                                </a></li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </nav>
    <!-- Nav Bar -->
    <nav class="navbar navbar-expand-lg navbar-light nav-fix " style="background-color: #F5F5F5">
        <div class="collapse navbar-collapse justify-content-center" id="navbarNavDropdown">
            <ul class="navbar-nav">
                <c:forEach items="${suppliers}" var="supplier">
                    <li class="nav-item active mr-1">
                        <a class="mr-2" href="${pageContext.request.contextPath}/Product/ListProduct?sup_id=${supplier.id}">
                                ${supplier.name}
                                    <i class="fa fa-caret-down" aria-hidden="true"></i>
                        </a>
<%--                        <div class="dropdown">--%>
<%--                            <a class="btn btn-light dropdown-toggle" href="${pageContext.request.contextPath}/Product/ListProduct?sup_id=${supplier.id}" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-expanded="false">--%>
<%--                                    ${supplier.name}--%>
<%--                            </a>--%>
<%--                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">--%>
<%--                                <a class="dropdown-item" href="#">Action</a>--%>
<%--                                <a class="dropdown-item" href="#">Another action</a>--%>
<%--                                <a class="dropdown-item" href="#">Something else here</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </nav>
</div>