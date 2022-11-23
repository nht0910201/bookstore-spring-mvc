<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<m1:Auth>
    <jsp:attribute name="js">
        <script>
            Validator({
                form: '#formLogin',
                formGroupSelector: '.form-group',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#loginEmail', 'Vui lòng nhập email tài khoản của bạn'),
                ],
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="mx-auto col-lg-5 mt-lg-5" >
            <form class="p-5 mx-auto border rounded-lg shadow bg-light" id="formLogin" method="post" action="/auth/updatePass">
                <div class="text-center mb-3">
                    <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">RESET PASSWORD</h3>
                    <i class="fa fa-unlock-alt" aria-hidden="true"></i>
                </div>
                    <%--Alert--%>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                        <strong>Reset Fail: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <c:if test="${hasNotify}">
                    <div class="alert alert-success alert-dismissible fade show w-100 mx-auto" role="alert">
                        <strong>Reset Password Successfully: </strong> ${successMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <div class="form-group">
                    <input type="email" name="email" placeholder="Email" autofocus class="form-control" id="loginEmail" aria-describedby="emailHelp">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary w-100" id="btnLogIn">UNCLOCK</button>
<%--                    <a id="btnLogIn" class="btn btn-primary w-100" href="${pageContext.request.contextPath}/auth/updatePass?email" role="button">UNCLOCK</a>--%>
                </div>
                <div class="text-center mt-3">
                    <a  class="btn btn-outline-success" role="button" href="${pageContext.request.contextPath}/auth/login">LOG IN</a>
                </div>
            </form>
        </div>
    </jsp:body>
</m1:Auth>