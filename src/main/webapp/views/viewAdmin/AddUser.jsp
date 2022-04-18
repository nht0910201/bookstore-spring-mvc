<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${role == 0}">
    <div class="tab-pane fade" id="list-adduser" role="tabpanel" aria-labelledby="list-adduser-list">
        <div class="card-body mx-auto">
            <form method="post" id="frmAddUser"
                  action="/Admin/UserManage/Add">
                <div class="form-group">
                    <label for="txtName" style="font-weight: bold">Họ và tên:</label>
                    <input type="text" class="form-control" name="name" id="txtName">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtEmail" style="font-weight: bold">Email:</label>
                    <input type="text" class="form-control " name="email" id="txtEmail">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtAddress" style="font-weight: bold">Địa chỉ: </label>
                    <input type="text" class="form-control" name="address" id="txtAddress">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtPhoneNumber" style="font-weight: bold">Số điện thoại:</label>
                    <input type="number" class="form-control" name="phone_number" id="txtPhoneNumber">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtPass" style="font-weight: bold">Mật khẩu:</label>
                    <input type="password" class="form-control" name="pass" id="txtPass">
                    <span class="form-message" ></span>
                </div>
                <button type="submit" class="btn w-100 text-light" style="background-color: darkblue">Thêm người dùng</button>
            </form>
        </div>
    </div>
</c:if>