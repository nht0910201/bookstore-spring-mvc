<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${role == 0}">
    <div class="tab-pane fade" id="list-users" role="tabpanel" aria-labelledby="list-users-list">
        <div class="card mx-auto justify-content-center d-flex"  id="accordionUser">
            <div class="text-center mt-3">
                <h3 class="text-primary">Quản lý người dùng</h3>
            </div>
            <c:forEach items="${users}" var="user">
                <form method="post"  action="/Admin/UserManage/${user.id}/Update" >
                    <div class="card">
                        <div class="card-header" id="headingUsers">
                            <h2 class="mb-0">
                                <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse"
                                        data-target="#<c:out value="collapse${user.id}"/>" aria-expanded="true" aria-controls="<c:out value="collapse${user.id}"/>">
                                    <b>${user.email}</b>
                                </button>
                            </h2>
                        </div>
                        <div id="<c:out value="collapse${user.id}"/>" class="collapse" aria-labelledby="headingUsers" data-parent="#accordionUser">
                            <table class="list-group list-group-flush">
                                <tr>
                                    <td class="list-group-item"><b>Họ và tên:</b></td>
                                    <td><input class="w-100" value="${user.name}" name="name" disabled></td>
                                </tr>
                                <tr>
                                    <td class="list-group-item"><b>Địa chỉ:</b></td>
                                    <td class="w-75"><input class="w-100" type="text" value="${user.address}" name="address" disabled></td>
                                </tr>
                                <tr>
                                    <td class="list-group-item"><b>Số điện thoại:</b></td>
                                    <td><input type="number" class="w-100" value="${user.phone_number}" name="phone_number" disabled></td>
                                </tr>
                            </table>
                            <div class="card-body justify-content-center d-flex">
                                <button type="button" id="<c:out value="btnEditUser${user.id}"/>"
                                        class=" btn btn-outline-primary mr-1"
                                        onclick="edit('User', ${user.id})">
                                    Chỉnh sửa thông tin
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </button>
                                <button type="submit" id="<c:out value="btnSaveUser${user.id}"/>"
                                        hidden class=" btn btn-outline-primary mr-1 w-25">
                                    Lưu
                                </button>
                                <button type="button" id="<c:out value="btnCancelUser${user.id}"/>"
                                        hidden class=" btn btn-outline-primary mr-1 w-25"
                                        onclick="cancel('User', ${user.id})">
                                    Hủy
                                </button>
                                <button type="submit" class=" btn btn-outline-danger mr-1"
                                        formaction="/Admin/UserManage/${user.id}/Delete">
                                    Xóa
                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </c:forEach>
        </div>
    </div>
</c:if>