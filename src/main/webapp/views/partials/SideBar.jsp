<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="categoriesParent" scope="request" type="java.util.List<com.hcmute.bookstore.models.Category>"/>
<jsp:useBean id="categoriesChild" scope="request" type="java.util.List<com.hcmute.bookstore.models.Category>"/>
<div class="list-group mt-2">
<%--    <c:forEach items="${categoriesParent}" var="category1">--%>
<%--        <div class="dropright">--%>
<%--            <a class="list-group-item list-group-item-action dropdown-toggle" href="${pageContext.request.contextPath}/product/category/${category1.id}" role="button"--%>
<%--               data-toggle="dropdown" aria-expanded="false">--%>
<%--                    ${category1.name}--%>
<%--            </a>--%>
<%--            <div class="dropdown-menu">--%>
<%--                <c:forEach items="${categoriesChild}" var="category2">--%>
<%--                    <c:if test="${category2.parent_id==category1.id}">--%>
<%--                        <a class="dropdown-item" href="${pageContext.request.contextPath}/product/category/${category2.id}">${category2.name}</a>--%>
<%--                    </c:if>--%>
<%--                </c:forEach>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </c:forEach>--%>
    <div class="list-group list-group-flush">
        <c:forEach items="${categoriesParent}" var="c1">
            <div class="dropright">
                <a href="${pageContext.request.contextPath}/product/category/${c1.id}" class="list-group-item list-group-item-action  " aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-caret-right mr-3" aria-hidden="true"></i>
                        ${c1.name}
                </a>
                <ul class="dropdown-menu ml-0">
                    <c:forEach items="${categoriesChild}" var="c2">
                        <c:if test="${c2.parent_id==c1.id}">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product/category/${c2.id}">${c2.name}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>
    </div>
</div>