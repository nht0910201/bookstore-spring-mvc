<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<t:account>
    <jsp:attribute name="css">
            <style>
                body {
                    height: 100vh;
                    background-color: white;
                    background-size: 100%;
                }
                form {
                    width: 35%;
                    padding: 25px 0;
                }
            </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            $('#formRegister').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#formRegister',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#registerName', 'Vui lòng nhập đầy đủ họ tên'),
                        Validator.isRequired('#registerAddress', 'Vui lòng nhập địa chỉ'),
                        Validator.isRequired('#registerEmail', 'Vui lòng nhập email'),
                        Validator.isRequired('#registerPhone','Vui lòng nhập số điện thoại'),
                        Validator.isRequired('#registerPassword','Vui lòng nhập đầy đủ mật khẩu'),
                        Validator.isEmail('#registerEmail','Vui lòng nhập email chính xác'),
                        Validator.minLength('#registerPassword',6),
                        Validator.isConfirmed('#registerConfirmPassword',function () {
                            return document.querySelector('#formRegister #registerPassword').value;
                        }, 'Vui lòng nhập mật khẩu chính xác')
                    ],
                });
                const email = $('#registerEmail').val();
                // Check if email exists
                $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?email=' + email, function (data) {
                    if (data === true) {
                        $('#formRegister').off('submit').submit();
                    } else {
                        swal({
                            title: "Tài khoản lỗi!",
                            text: "Email của bạn đã tồn tại!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    }
                });
            });

            $('registerName').select();
        </script>
    </jsp:attribute>
    <jsp:body>
        <c:if test="${hasNotify}">
            <div class="position-fixed top-0 right-0 p-3" style="z-index: 10; right: 0; top: 0;">
                <div id="liveToast" class="toast fade show bg-success" role="alert" aria-live="assertive" aria-atomic="true" data-delay="2000">
                    <div class="toast-header">
                        <strong class="mr-auto">Thông báo</strong>
                        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="toast-body ">
                            ${Message}
                    </div>
                </div>
            </div>
        </c:if>
        <form class="mx-auto shadow rounded-lg bg-white mt-5 " action="" method="post" id="formRegister">
            <!-- Logo -->
            <div class="text-center mb-3">
                <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">Đăng Ký</h3>
            </div>

            <!-- Họ và tên, địa chỉ, số điện thoại -->
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Họ và tên" class="form-control w-75" id="registerName" name="name">
                <span class="form-message mx-auto" style="margin-right: 185px;"></span>
            </div>

            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Địa chỉ" class="form-control w-75" id="registerAddress" name="address">
                <span class="form-message mx-auto" style="margin-right: 185px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Số điện thoại" class="form-control w-75" id="registerPhone" name="phone">
                <span class="form-message mx-auto" style="margin-right: 185px;"></span>
            </div>

            <!-- Email và password -->
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Email" name="email" class="form-control mr-1 w-75"id="registerEmail">
                <span class="form-message mx-auto" style="margin-right: 215px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="password" name="rawpwd" placeholder="Mật khẩu" class="form-control w-75" id="registerPassword">
                <span class="form-message mx-auto" style="margin-right: 180px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="password" placeholder="Nhập lại mật khẩu" class="form-control w-75" id="registerConfirmPassword">
                <span class="form-message mx-auto" style="margin-right: 130px;"></span>
            </div>


            <!-- Button đăng ký -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary w-75" id="btnRegister">Đăng ký</button>
            </div>

            <hr class="w-75 mx-auto bg-primary">
            <!-- Quay lai Home -->
            <div class="text-center">
                <a class="btn btn-outline-info" href="${pageContext.request.contextPath}/Home" role="button">
                    <i class="fa fa-home" aria-hidden="true"></i> Trang chủ
                </a>
            </div>
            <div class="text-center mt-3">
                Bạn đã có tài khoản?
                <a class="btn btn-outline-danger" id="switchLogin"  href="${pageContext.request.contextPath}/Account/Login" role="button">
                    Đăng nhập ngay
                </a>
            </div>
        </form>
    </jsp:body>
</t:account>
