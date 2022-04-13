<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<t:account>
    <jsp:attribute name="js">
        <script>
            // Log in form
            Validator({
                form: '#formLogin',
                formGroupSelector: '.form-group',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#loginEmail', 'Vui lòng nhập tài khoản của bạn'),
                    Validator.isRequired('#loginPassword','Vui lòng nhập mật khẩu của bạn'),
                ],
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <form class=" mx-auto shadow rounded-lg bg-white mt-5 " action="" method="post" id="formLogin">
            <!-- Logo image -->
            <div class="text-center mb-3">
                <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">Đăng Nhập</h3>
                <i class="fa fa-user-circle fa-3x mx-auto" aria-hidden="true"></i>
            </div>
                <%--Alert--%>
            <c:if test="${hasError}">
                <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                    <strong>Sai tài khoản hoặc mật khẩu!</strong> ${errorMessage}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>

            <!-- Username và password -->
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Tài khoản" name="email" class="form-control w-75" id="loginEmail" autofocus >
                <span class="form-message mx-auto" style="margin-right: 215px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="password" placeholder="Mật khẩu" name="password" class="form-control w-75" id="loginPassword">
                <span class="form-message mx-auto" style="margin-right: 185px;"></span>
            </div>


            <!-- Button đăng nhập -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary w-75" id="btnLogIn">Đăng nhập</button>
            </div>
            <div class="text-center mt-2">
                <a class="text-primary" href="${pageContext.request.contextPath}/Account/ForgotPassword">
                    Quên mật khẩu?
                </a>
            </div>

            <hr class="w-75 mx-auto bg-primary">
            <!-- Đăng nhập với Google -->
            <div class="text-center">
                    <%--Sửa port ở đây--%>
                <a class="btn btn-outline-danger" href="https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email&redirect_uri=http://localhost:8080/auctionWebApp/Account/GoogleLogin&response_type=code
    &client_id=968786308056-9k67nqlp92f8m7ak4060b75n1pjsfj0n.apps.googleusercontent.com&approval_prompt=force" role="button">
                    <i class="fa fa-google-plus mr-3" aria-hidden="true"></i>
                    Đăng nhập với Google
                </a>
            </div>
            <div class="text-center mt-3">
                Chưa có tài khoản?
                <a class="btn btn-outline-success" id="switchRegister" href="${pageContext.request.contextPath}/Account/Register" role="button">
                    Đăng ký ngay
                </a>
            </div>
        </form>
    </jsp:body>
</t:account>