<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="orders" scope="request" type="java.util.List<com.hcmute.bookstore.models.Order>"/>
<m1:SubLayout>
    <jsp:attribute name="js">
        <script>
            function doneOrder(url) {
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Error!",
                            text: "Đã xảy ra lỗi",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else {
                        swal({
                            title: "Successfully",
                            text: "Hoàn thành đơn hàng",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        })
                            .then(function () {
                                    location.reload();
                                }
                            );
                    }
                });
            }
            function cancelOrder(url) {
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Error!",
                            text: "Đã xảy ra lỗi",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else {
                        swal({
                            title: "Successfully",
                            text: "Huỷ đơn hàng thành công",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        })
                            .then(function () {
                                    location.reload();
                                }
                            );
                    }
                });
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="container mt-4">
            <div class="d-flex justify-content-center">
                <h3>MY ORDER</h3>
            </div>
            <div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">No.</th>
                            <th scope="col">Order By</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Email</th>
                            <th scope="col">Address</th>
                            <th scope="col">TotalPrice</th>
                            <th scope="col">State</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${orders.size()<=0}">
                            <h5>No information</h5>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${orders}" var="order" varStatus="loop">
                                <tr>
                                    <td>${loop.index +1}</td>
                                    <td>${authUser.name}</td>
                                    <td>${authUser.phone}</td>
                                    <td>${authUser.email}</td>
                                    <td>${order.address}</td>
                                    <td>${order.totalPrice}</td>
                                    <td class="text-danger">${order.state}</td>
                                    <td>
                                        <a class="btn btn-light" href="${pageContext.request.contextPath}/order/${order.id}" role="button">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                        </a>
                                        <c:if test="${order.state=='DELIVERY'}">
                                            <button onclick="doneOrder('${pageContext.request.contextPath}/order/done/${order.id}')" type="button" class="btn btn-outline-success">
                                                <i class="fa fa-check" aria-hidden="true"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${order.state == 'ORDERED' || order.state == 'ACCEPTED'}">
                                            <button onclick="cancelOrder('${pageContext.request.contextPath}/order/cancel/${order.id}')" type="button" class="btn btn-outline-danger">
                                                <i class="fa fa-times" aria-hidden="true"></i>
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </jsp:body>
</m1:SubLayout>