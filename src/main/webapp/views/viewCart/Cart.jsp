<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="carts" scope="request" type="java.util.List<com.hcmute.mobilestore.models.Cart_Item>"/>
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
        <div class="col-8 d-flex flex-wrap ">
            <ul class="list-unstyled">
            <c:forEach items="${carts}" var="cartItem">
                    <li class="media mt-2 border-bottom" >
                        <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top w-25" alt="...">
                        <div class="media-body">
                            <h5 class="mt-0 mb-1">
                                <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${cartItem.pro_id}">
                                                ${cartItem.pro_name}
                                </a>
                            </h5>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">Giá bán: <fmt:formatNumber value="${cartItem.price}" type="number" />(1 sản phẩm)</li>
                                <li class="list-group-item totalPrice">
                                    <label>Số lượng mua:</label>
                                    <input class="quantity" style="width: 25%" type="number" value="${cartItem.quantity}"  name="quantity" min="1" max="5">
                                    <input type="hidden" value="${cartItem.price}"> <br>
                                    Thành tiền: <span> <fmt:formatNumber value="${cartItem.price}" type="number" /></span>
                                    <input type="hidden" value="${cartItem.id}">
                                </li>
                            </ul>
                            <button class="btn btn-outline-danger float-right mr-3" onclick="remove('${pageContext.request.contextPath}/Cart/DeleteCart?pro_id=${cartItem.pro_id}&acc_id=${cartItem.account_id}')" role="button">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                                Delete
                            </button>
                        </div>
                    </li>
            </c:forEach>
            </ul>
        </div>





        <div class="col-2">
            <button type="button" class="btn btn-outline-success float-right mt-3" href="/Cart/Order" role="button"  data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
                <i class="fa fa-check" aria-hidden="true"></i>
                Đặt hàng
            </button>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Thông tin đơn hàng</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="/Cart/ProcessCart">
                            <div class="d-inline-block">
                                <ul class="list-unstyled">
                                    <c:forEach items="${carts}" var="cartItem">
                                        <li class="media mt-2 border-bottom" >
                                            <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top w-25" alt="...">
                                            <div class="media-body">
                                                <h5 class="mt-0 mb-1">
                                                    <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${cartItem.pro_id}">
                                                            ${cartItem.pro_name}
                                                    </a>
                                                </h5>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">Giá bán: <fmt:formatNumber value="${cartItem.price}" type="number" /> (1 sản phẩm)</li>
                                                    <li class="list-group-item ">
                                                        <label>Số lượng mua:</label>
                                                        <span class="quantity" style="width: 25%"  name="quantity">
                                                                ${cartItem.quantity}</span>
                                                        <input type="hidden" value="${cartItem.price}"> <br>
                                                        Thành tiền:  <fmt:formatNumber value="${cartItem.price}" type="number" />
                                                        <input type="hidden" value="${cartItem.id}" id="${cartItem.id}">
                                                        <input type="hidden" value="${cartItem.order_id}" name="orderid">

                                                    </li>
                                                </ul>

                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="form-group">
                                <label for="name" class="col-form-label">Tên</label>
                                <input type="text" class="form-control" id="name" value="${authUser.name}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="address" class="col-form-label">Địa Chỉ</label>
                                <input class="form-control" id="address" value="${authUser.address}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="phone" class="col-form-label">Số điện thoại</label>
                                <input type="text" class="form-control" id="phone" value="${authUser.phone_number}" readonly>
                            </div>
                            <input type="hidden" value="${carts}" name="userid">
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">Đặt hàng</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </jsp:body>
</m1:MainLayout>