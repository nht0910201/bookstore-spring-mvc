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
            <div class="card">
                <ul class="list-group list-group-flush">
                    <button class="list-group-item btn-outline-secondary active text-left">
                        Trang cá nhân</button>
                    <button class="list-group-item btn-outline-secondary text-left">
                        Đơn hàng đã đặt</button>
                    <button class="list-group-item btn-outline-secondary text-left">
                        Quay lại </button>
                </ul>
            </div>
        </div>
        <div class="col-sm-9">
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
    </jsp:body>
</t:account>