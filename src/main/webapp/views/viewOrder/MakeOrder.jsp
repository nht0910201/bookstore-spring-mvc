<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="orderItems" scope="request" type="java.util.List<com.hcmute.bookstore.models.OrderItem>"/>
<jsp:useBean id="totalPrice" scope="request" type="java.lang.Double"/>
<m1:Admin>
    <jsp:attribute name="js">
        <script>
            Validator({
                form: '#frmOrder',
                formGroupSelector: '.form-group',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#address', 'Vui lòng nhập địa chỉ của bạn'),
                ],
            });
            function order(url){
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Error",
                            text: "Make an Order fail!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else swal({
                        title: "Successfully",
                        text: "Make an Order complete",
                        icon: "success",
                        button: "OK!",
                        closeOnClickOutside: false,
                    }).then(function(){
                            location.href = '/Home';
                        }
                    );
                });
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="container mt-4">
            <div class="mt-2 row">
                <div class="col-sm-8">
                    <c:if test="${hasNotify}">
                        <div class="alert alert-success alert-dismissible fade show w-75 mx-auto" role="alert">
                            <strong>Completed: </strong> ${successMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <c:if test="${hasError}">
                        <div class="alert alert-danger alert-dismissible fade show w-100 mx-auto" role="alert">
                            <strong>Error: </strong> ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <div class="d-flex justify-content-between">
                        <h3>ORDER</h3>
                        <h4>Total: ${totalPrice}</h4>
                    </div>
                    <c:forEach items="${orderItems}" var="orderItem">
                        <div class="media p-2 justify-content-around" style="border: 1px solid black">
                            <img src="${orderItem.image}" class="img-fluid w-25" alt="...">
                            <div class="media-body">
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
                <div class="col-sm-4">
                    <div class="d-flex justify-content-between">
                        <h3>DELIVERY INFORMATION</h3>
                    </div>
                    <form id="frmOrder" method="post" action="/order/completeOrder/${orderItems.get(0).orderId}">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input class="form-control" id="name" readonly type="text" value="${authUser.name}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input class="form-control" id="email" readonly type="text" value="${authUser.email}">
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input class="form-control" id="phone" readonly type="text" value="${authUser.phone}">
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <textarea class="form-control" name="address" id="address" cols="30" rows="5" placeholder="Nhập địa chỉ"></textarea>
                            <span class="form-message text-danger"></span>
                        </div>
                        <button type="submit" class="form-control btn btn-outline-danger">
                            Confirm
                        </button>
                    </form>

                </div>
            </div>
        </div>

    </jsp:body>
</m1:Admin>