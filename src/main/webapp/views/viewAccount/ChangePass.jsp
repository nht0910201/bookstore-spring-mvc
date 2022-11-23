<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--<jsp:useBean id="user" scope="request" type="com.hcmute.bookstore.models.User"/>--%>
<m1:Auth>
    <jsp:attribute name="js">
        <script>
            Validator({
                form: '#frmChangePass',
                formGroupSelector: '.form-group',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#oldPass', 'Vui lòng nhập mật khẩu cũ'),
                    Validator.minLength('#newPass', 6),
                    Validator.isConfirmed('#confirmPass', function () {
                        return document.querySelector('#frmChangePass #newPass').value;
                    }, 'Vui lòng nhập mật khẩu chính xác')
                ],
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="mx-auto col-lg-5 mt-lg-5">
            <form class="p-5 mx-auto border rounded-lg shadow bg-light" id="frmChangePass" method="post"
                  action="/user/changePass/${authUser.id}">
                <h4 class="text-center">CHANGE PASSWORD</h4>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                        <strong>Error: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <div class="form-group">
                    <input id="oldPass" name="oldPass" type="password" class="form-control" placeholder="Password">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <input id="newPass" name="newPass" type="password" class="form-control" placeholder="New Password">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <input id="confirmPass" name="confirmPass" type="password" class="form-control"
                           placeholder="Confirm Password">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group d-flex justify-content-around">
                    <a class="bform-control btn btn-outline-success"
                       href="${pageContext.request.contextPath}/user/profile" role="button">
                        <i class="fa fa-arrow-left" aria-hidden="true"></i>
                        Back
                    </a>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </jsp:body>
</m1:Auth>