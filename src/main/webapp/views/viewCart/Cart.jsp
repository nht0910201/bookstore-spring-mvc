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
            $(".quantity").each(function() {
                let quantity = parseInt($(this).val(), 10);
                let price = parseFloat($(this).next().val());
                $(this).next().next().next().text(quantity*price)
            });
            $(".totalPrice :input").bind('keyup mouseup', function () {

                $(".quantity").each(function() {
                    let quantity = parseInt($(this).val(), 10);
                    let price = parseFloat($(this).next().val());
                    $(this).next().next().next().text(quantity*price);

                });
            });

        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="col-2">

        </div>
        <div class="col-8 d-flex flex-wrap">
            <ul class="list-unstyled">
            <c:forEach items="${carts}" var="cart">
<%--                <div class="card mt-1 mr-1" style="width: 18rem;">--%>
<%--                    <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${cart.pro_id}">--%>
<%--                        <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top" alt="...">--%>
<%--                    </a>--%>
<%--                    <div class="card-body">--%>
<%--                        <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${cart.pro_id}">--%>
<%--                                ${cart.pro_name}--%>
<%--                        </a>--%>
<%--&lt;%&ndash;                        <h5 class="card-title">${cart.pro_name}</h5>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <p class="card-text">${cart.}</p>&ndash;%&gt;--%>
<%--                    </div>--%>
<%--                    <ul class="list-group list-group-flush">--%>
<%--&lt;%&ndash;                        <li class="list-group-item">Tồn kho: ${quantities.quantity}</li>&ndash;%&gt;--%>
<%--                        <li class="list-group-item">Giá bán: ${cart.price}(1 sản phẩm)</li>--%>
<%--                        <li class="list-group-item">--%>
<%--                            <label for="quantity">Số lượng mua:</label>--%>
<%--                            <input style="width: 100%" type="number" value="${cart.quantity}" id="quantity" name="quantity" min="1" max="5">--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                    <div class="card-body mx-auto">--%>
<%--                        <button class="btn btn-outline-danger" onclick="remove('${pageContext.request.contextPath}/Cart/DeleteCart?pro_id=${cart.pro_id}&acc_id=${cart.account_id}')" role="button">--%>
<%--                            <i class="fa fa-trash" aria-hidden="true"></i>--%>
<%--&lt;%&ndash;                            pro_name=${cart.pro_name}&price=${cart.price}&quantity=${cart.quantity}&&ndash;%&gt;--%>
<%--                            Delete--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                </div>--%>


                    <li class="media mt-2 border-bottom" >
                        <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top w-25" alt="...">
                        <div class="media-body">
                            <h5 class="mt-0 mb-1">
                                <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${cart.pro_id}">
                                                ${cart.pro_name}
                                </a>
                            </h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">Giá bán: ${cart.price}(1 sản phẩm)</li>
                                <li class="list-group-item totalPrice">
                                    <label>Số lượng mua:</label>
                                    <input class="quantity" style="width: 25%" type="number" value="${cart.quantity}"  name="quantity" min="1" max="5">
                                    <input type="hidden" value="${cart.price}"> <br>
                                    Thành tiền: <span></span>
                                    <input type="hidden" value="${cart.id}">
                                </li>
                            </ul>
                            <button class="btn btn-outline-danger float-right mr-3" onclick="remove('${pageContext.request.contextPath}/Cart/DeleteCart?pro_id=${cart.pro_id}&acc_id=${cart.account_id}')" role="button">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                                Delete
                            </button>
                        </div>
                    </li>
            </c:forEach>
            </ul>
        </div>
        <div class="col-2">
            <a class="btn btn-outline-success float-right mt-3" href="/Cart/Order" role="button">
                <i class="fa fa-check" aria-hidden="true"></i>
                Đặt hàng
            </a>
        </div>
    </jsp:body>
</m1:MainLayout>