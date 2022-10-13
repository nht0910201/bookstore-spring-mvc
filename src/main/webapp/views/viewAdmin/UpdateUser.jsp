<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:useBean id="user" scope="request" type="com.hcmute.bookstore.models.User"/>
<m1:Admin>
    <jsp:attribute name="js">
        <script>
            $('#frmUpdateUser').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#frmUpdateUser',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#txtName', 'Please fill your user name'),
                        // Validator.isRequired('#txtEmail', 'Please fill your user email'),
                        Validator.isEmail('#txtEmail','Please fill correct email'),
                        Validator.isRequired('#txtPhone', 'Please fill your user phone'),
                    ],
                });
                $('#frmUpdateUser').off('submit').submit();
            })
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="col-sm-12 mt-1 p-0">
            <div class="card-body w-50 mx-auto" style="background-color: white">
                <h3 class="text-center">EDIT USER</h3>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-100 mx-auto" role="alert">
                        <strong>Update User Fail: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <c:if test="${hasNotify}">
                    <div class="alert alert-success alert-dismissible fade show w-100 mx-auto" role="alert">
                        <strong>Completed: </strong> ${successMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <form id="frmUpdateUser" method="post" action="/admin/update_user/${user.id}">
                    <div class="form-group">
                        <label for="txtName" style="font-weight: bold">Name</label>
                        <input type="text" class="form-control" name="name" id="txtName" value="${user.name}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail" style="font-weight: bold">Email</label>
                        <input type="email" class="form-control" name="email" id="txtEmail" value="${user.email}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtPhone" style="font-weight: bold">Phone</label>
                        <input type="tel" class="form-control" name="phone" id="txtPhone" value="${user.phone}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="role" style="font-weight: bold">Role</label>
                        <select name="role" class="form-control" id="role">
                            <c:if test="${user.role=='CUSTOMER'}">
                                <option value="ADMIN">ADMIN</option>
                                <option selected value="CUSTOMER">CUSTOMER</option>
                            </c:if>
                            <c:if test="${user.role=='ADMIN'}">
                                <option value="CUSTOMER">CUSTOMER</option>
                                <option selected value="ADMIN">ADMIN</option>
                            </c:if>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="state" style="font-weight: bold">State</label>
                        <select name="state" class="form-control" id="state">
                            <c:if test="${user.state=='ACTIVE'}">
                                <option value="NOT_ACTIVE">NOT_ACTIVE</option>
                                <option selected value="ACTIVE">ACTIVE</option>
                            </c:if>
                            <c:if test="${user.state=='NOT_ACTIVE'}">
                                <option value="ACTIVE">ACTIVE</option>
                                <option selected value="NOT_ACTIVE">NOT_ACTIVE</option>
                            </c:if>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="form-control btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </jsp:body>
</m1:Admin>