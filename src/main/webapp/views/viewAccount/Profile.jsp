<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<t:account>
    <jsp:attribute name="js">
        <script>
            $( "#btnEditUser" ).click(function() {
                $("td input").removeAttr('disabled');
                $("#btnEditUser").attr('hidden', true);
                $("#btnSave").removeAttr('hidden');
                $("#btnCancel").removeAttr('hidden');
            });
            $( "#btnCancel" ).click(function() {
                $("td input").attr('disabled', true);
                $("#btnEditUser").attr('hidden', false);
                $("#btnSave").attr('hidden', true);
                $("#btnCancel").attr('hidden', true);
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="col-sm-3">
            <div class="list-group" id="list-tab" role="tablist">
                <a class="list-group-item list-group-item-action active" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">
                    Trang cá nhân</a>
                <a class="list-group-item list-group-item-action" id="list-orders-list" data-toggle="list" href="#list-orders" role="tab" aria-controls="orders">
                    Đơn hàng của tôi
                </a>
            </div>
        </div>
        <div class="col-sm-9">
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
                    <form method="post" id="formEditUser" action="/Account/Profile/${authUser.id}/Update" >
                        <div class="card mx-auto justify-content-center d-flex" >
                            <div class="text-center mt-3">
                                <h3 class="text-primary">Trang cá nhân</h3>
                            </div>
                            <i class="fa fa-user-circle fa-3x mx-auto" aria-hidden="true"></i>
                            <div class="card-body justify-content-center d-flex">
                                <h5 class="card-title"><b>${authUser.email}</b> </h5>
                            </div>
                            <table class="list-group list-group-flush">
                                <tr>
                                    <td class="list-group-item"><b>Họ và Tên:</b></td>
                                    <td><input class="w-100" value="${authUser.name}" name="name" disabled></td>
                                </tr>
                                <tr>
                                    <td class="list-group-item"><b>Địa chỉ:</b></td>
                                    <td class="w-75"><input class="w-100" value="${authUser.address}" name="address" disabled></td>
                                </tr>
                                <tr>
                                    <td class="list-group-item"><b>Số điện thoại:</b></td>
                                    <td><input type="number" class="w-100" value="${authUser.phone_number}" name="phone_number" disabled></td>
                                </tr>
                            </table>
                            <div class="card-body justify-content-center d-flex">
                                <button type="button" id="btnEditUser" class=" btn btn-outline-primary mr-1">
                                    Chỉnh sửa thông tin
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </button>
                                <button type="submit" id="btnSave" hidden class=" btn btn-outline-primary mr-1 w-25">
                                    Lưu
                                </button>
                                <button type="button" id="btnCancel" hidden class=" btn btn-outline-primary mr-1 w-25">
                                    Hủy
                                </button>
                                    <%--<a href="${pageContext.request.contextPath}/Account/ChangePwd" class="btn btn-outline-primary ml-1">--%>
                                    <%--    Đổi mật khẩu--%>
                                    <%--    <i class="fa fa-key" aria-hidden="true"></i>--%>
                                    <%--</a>--%>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="tab-pane fade" id="list-orders" role="tabpanel" aria-labelledby="list-orders-list">
                    <div class="accordion" id="accordionExample">
                        <c:forEach items="${list_Order}" var="orderItem">
                        <div class="card">
                            <div class="card-header" id="headingOne">
                                <h2 class="mb-0">
                                    <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne${orderItem.id}" aria-expanded="true" aria-controls="collapseOne${orderItem.id}">
                                        ${orderItem.id}
                                    </button>
                                </h2>
                            </div>
                            <c:forEach items="${cart_item}" var="item">
                                <c:if test = "${orderItem.id == item.order_id}">
                                    <div id="collapseOne${orderItem.id}" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                        <div class="card-body">
                                               Tên sản phẩm: ${item.pro_name} <span class="text-primary" > Giá: ${item.price}</span>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        </c:forEach>

                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:account>