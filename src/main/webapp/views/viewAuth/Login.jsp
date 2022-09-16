<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<m1:Auth>
    <jsp:attribute name="js">
        <script>
            // Log in form
            Validator({
                form: '#formLogin',
                formGroupSelector: '.form-group',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#loginEmail', 'Vui lòng nhập tài khoản của bạn'),
                    Validator.isRequired('#loginPassword', 'Vui lòng nhập mật khẩu của bạn'),
                ],
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="mx-auto col-lg-5 mt-lg-5" >
            <form class="p-5 mx-auto border rounded-lg shadow bg-light" id="formLogin" method="post">
                <div class="text-center mb-3">
                    <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">Sign In</h3>
                    <i class="fa fa-user-circle fa-3x mx-auto" aria-hidden="true"></i>
                </div>
                    <%--Alert--%>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                        <strong>Login Fail: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <div class="form-group">
                    <input type="email" name="email" placeholder="Email" autofocus class="form-control" id="loginEmail" aria-describedby="emailHelp">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" class="form-control" id="loginPassword">
                    <span class="form-message mx-auto text-danger"></span>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary w-100" id="btnLogIn">LOG IN</button>
                </div>
                <div class="text-center mt-2">
                    <a class="text-primary" href="#">
                        Forgot Password ?
                    </a>
                </div>

                <hr class="w-75 mx-auto bg-primary">
                <!-- Đăng nhập với Google -->
                <div class="text-center">
                        <%--Sửa port ở đây--%>
                    <a class="btn btn-outline-success" href="https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email&redirect_uri=http://localhost:8080/auctionWebApp/Account/GoogleLogin&response_type=code
    &client_id=968786308056-9k67nqlp92f8m7ak4060b75n1pjsfj0n.apps.googleusercontent.com&approval_prompt=force"
                       role="button">
                        <i class="fa fa-google-plus mr-3" aria-hidden="true"></i>
                        LOGIN WITH GOOGLE
                    </a>
                </div>
                <div class="text-center mt-3">
                    I don't have an account ?
                    <a href="${pageContext.request.contextPath}/auth/register">SIGN UP</a>
                </div>
            </form>
        </div>
    </jsp:body>
</m1:Auth>