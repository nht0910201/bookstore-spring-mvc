<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="orderItems" scope="request" type="java.util.List<com.hcmute.bookstore.models.OrderItem>"/>
<jsp:useBean id="totalPrice" scope="request" type="java.lang.Double"/>
<m1:SubLayout>
    <jsp:attribute name="js">

    </jsp:attribute>
    <jsp:body>
        <div class="container mt-4">
            <div class="d-flex justify-content-center">
                <h3>ORDER DETAIL</h3>
            </div>
            <div>
                <c:forEach items="${orderItems}" var="orderItem">
                    <div class="media p-2 justify-content-around" style="border: 1px solid black">
                        <img src="${orderItem.image}" class="img-fluid w-25" alt="...">
                        <div class="media-body ml-3">
                            <h4 class="mt-2">${orderItem.productName}</h4>
                            <div class="d-flex mt-1">
                                Số lượng: <input readonly type="tel" value="${orderItem.quantity}">
                            </div>
                            <h6 class="mt-1">Giảm giá: ${orderItem.discount}%</h6>
                            <div class="d-flex align-items-center mt-1">
                                <h6>Giá gốc: </h6>
                                <p class="mt-1 ml-1" style="text-decoration: line-through">${orderItem.price}</p>
                            </div>
                            <h6 class="text-primary mt-1">Giá khuyến
                                mãi: ${orderItem.price - (orderItem.price * orderItem.discount/100)}</h6>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="d-flex justify-content-end mt-2">
                <h3>Total: ${totalPrice}</h3>
            </div>
        </div>
    </jsp:body>
</m1:SubLayout>