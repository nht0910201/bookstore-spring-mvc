<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="carts" scope="request" type="java.util.List<com.hcmute.mobilestore.models.Cart>"/>
<m1:MainLayout>
    <jsp:attribute name="js">
        <script>
            function remove (url) {
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Không thành công!",
                            text: "Xoá sản phẩm không thành công",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else {
                        swal({
                            title: "Xoá thành công",
                            text: "Xoá sản phẩm thành công",
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
        <div class="col-2">

        </div>
        <div class="col-8 d-flex flex-wrap">
            <c:forEach items="${carts}" var="cart">
                <div class="card mt-1 mr-1" style="width: 18rem;">
                    <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${cart.pro_id}">
                        <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${cart.pro_id}">
                                ${cart.pro_name}
                        </a>
<%--                        <h5 class="card-title">${cart.pro_name}</h5>--%>
<%--                        <p class="card-text">${cart.}</p>--%>
                    </div>
                    <ul class="list-group list-group-flush">
<%--                        <li class="list-group-item">Tồn kho: ${quantities.quantity}</li>--%>
                        <li class="list-group-item">Giá bán: ${cart.price}(1 sản phẩm)</li>
                        <li class="list-group-item">
                            <label for="quantity">Số lượng mua:</label>
                            <input style="width: 100%" type="number" value="${cart.quantity}" id="quantity" name="quantity" min="1" max="5">
                        </li>
                    </ul>
                    <div class="card-body mx-auto">
                        <button class="btn btn-outline-danger" onclick="remove('${pageContext.request.contextPath}/Cart/DeleteCart?pro_id=${cart.pro_id}&acc_id=${cart.account_id}')" role="button">
                            <i class="fa fa-trash" aria-hidden="true"></i>
<%--                            pro_name=${cart.pro_name}&price=${cart.price}&quantity=${cart.quantity}&--%>
                            Delete
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="col-2">

        </div>
    </jsp:body>
</m1:MainLayout>