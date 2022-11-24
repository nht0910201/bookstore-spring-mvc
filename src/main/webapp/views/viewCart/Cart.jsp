<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="orderItems" scope="request" type="java.util.List<com.hcmute.bookstore.models.OrderItem>"/>
<m1:Admin>
    <jsp:attribute name="js">
        <script>
            function updateCartItem(url){
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Không thể cập nhật!",
                            text: "Đã có lỗi xảy ra. Số lượng sản phẩm không đủ !",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else swal({
                        title: "Cập nhật thành công!",
                        text: "Số lượng sản phẩm đã được thay đổi",
                        icon: "success",
                        button: "OK!",
                        closeOnClickOutside: false,
                    }).then(function(){
                            location.reload();
                        }
                    );
                });
            }
            function removeCartItem(url){
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Không thể xoát!",
                            text: "Đã có lỗi xảy ra !",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else swal({
                        title: "Xoá thành công!",
                        text: "Sản phẩm đã được xoá khỏi giỏ hàng",
                        icon: "success",
                        button: "OK!",
                        closeOnClickOutside: false,
                    }).then(function(){
                            location.reload();
                        }
                    );
                });
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="container mt-4">
            <div class="d-flex justify-content-between">
                <h3>MY SHOPPING BAG</h3>
                <c:if test="${orderItems.size()>0}">
                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/order/makeOrder/${authUser.id}" role="button">
                        Make Order
                    </a>
                </c:if>
            </div>
            <c:if test="${hasError}">
                <div class="alert alert-danger alert-dismissible fade show w-100 mx-auto" role="alert">
                    <strong>Error: </strong> ${errorMessage}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>
            <div class="mt-2">
                <c:choose>
                    <c:when test="${orderItems.size()==0}">
                        <h4>Không có sản phẩm trong giỏ hàng</h4>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${orderItems}" var="orderItem">
                            <div class="media p-2 justify-content-around" style="border: 1px solid black">
                                <img src="${orderItem.image}" class="img-fluid w-25" alt="...">
                                <div class="media-body ml-3">
                                    <h4 class="mt-2">${orderItem.productName}</h4>
                                    <div class="d-flex mt-2">
                                        <button type="button" onclick="updateCartItem('${pageContext.request.contextPath}/cart/updateItem/${orderItem.id}?orderId=${orderItem.orderId}&quantity=${orderItem.quantity-1}')">-</button>
                                        <input readonly type="tel" value="${orderItem.quantity}">
                                        <button type="button" onclick="updateCartItem('${pageContext.request.contextPath}/cart/updateItem/${orderItem.id}?orderId=${orderItem.orderId}&quantity=${orderItem.quantity+1}')">+</button>
                                    </div>
                                    <h6 class="mt-3">Giảm giá: ${orderItem.discount}%</h6>
                                    <div class="d-flex align-items-center mt-3">
                                        <h6 >Giá gốc: </h6>
                                        <p class="mt-2 ml-1" style="text-decoration: line-through">${orderItem.price}</p>
                                    </div>
                                    <h6 class="text-primary mt-3">Giá khuyến mãi: ${orderItem.price - (orderItem.price * orderItem.discount/100)}</h6>
                                    <button onclick="removeCartItem('${pageContext.request.contextPath}/cart/deleteItem?proId=${orderItem.productId}&userId=${orderItem.userId}')" type="button" class="btn btn-outline-danger mt-2">
                                        Xoá sản phẩm
                                        <i class="fa fa-trash" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

    </jsp:body>
</m1:Admin>