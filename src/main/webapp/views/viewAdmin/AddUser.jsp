<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<m1:Admin>
    <jsp:attribute name="js">
        <script>
            $('#frmAddUser').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#frmAddUser',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#txtName', 'Please fill your user name'),
                        // Validator.isRequired('#txtEmail', 'Please fill your user email'),
                        Validator.isEmail('#txtEmail','Please fill correct email'),
                        Validator.isRequired('#txtPhone', 'Please fill your user phone'),
                    ],
                });
                    $('#frmAddUser').off('submit').submit();
            })
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="col-sm-12 mt-1 p-0">
            <div class="card-body w-50 mx-auto" style="background-color: white">
                <h3 class="text-center">ADD NEW USER</h3>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-100 mx-auto" role="alert">
                        <strong>Add User Fail: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <form id="frmAddUser" method="post" action="/admin/add_user">
                    <div class="form-group">
                        <label for="txtName" style="font-weight: bold">Name</label>
                        <input type="text" class="form-control" name="name" id="txtName"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail" style="font-weight: bold">Email</label>
                        <input type="email" class="form-control" name="email" id="txtEmail"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtPhone" style="font-weight: bold">Phone</label>
                        <input type="text" class="form-control" name="phone" id="txtPhone"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="role" style="font-weight: bold">ROLE</label>
                        <select name="role" class="form-control" id="role">
                            <option value="CUSTOMER">CUSTOMER</option>
                            <option value="ADMIN">ADMIN</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="form-control btn btn-primary">Add</button>
                    </div>
                </form>
            </div>
        </div>
    </jsp:body>
</m1:Admin>