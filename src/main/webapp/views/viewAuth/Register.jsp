<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<m1:Auth>
    <jsp:attribute name="css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <script>
            $('#formRegister').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#formRegister',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#registerName', 'Vui lòng nhập đầy đủ họ tên'),
                        Validator.isRequired('#registerDob', 'Vui lòng chọn ngày tháng năm sinh'),
                        Validator.isRequired('#registerEmail', 'Vui lòng nhập email'),
                        Validator.isRequired('#registerPhone', 'Vui lòng nhập số điện thoại'),
                        Validator.isRequired('#registerPassword', 'Vui lòng nhập đầy đủ mật khẩu'),
                        Validator.isEmail('#registerEmail', 'Vui lòng nhập email chính xác'),
                        Validator.minLength('#registerPassword', 6),
                        Validator.isConfirmed('#registerConfirmPassword', function () {
                            return document.querySelector('#formRegister #registerPassword').value;
                        }, 'Vui lòng nhập mật khẩu chính xác')
                    ],
                });
                const email = $('#registerEmail').val();
                const otp = $('#registerOTP').val();
                if (otp !== '') {
                    $.getJSON('${pageContext.request.contextPath}/auth/sendOTP?email=' + email+'&otp=' +otp, function (otpData) {
                        if (otpData === false) {
                            swal({
                                title: "Wrong OTP!",
                                text: "Your OTP is invalid. Please try again!",
                                icon: "error",
                                button: "OK!",
                                dangerMode: true,
                                closeOnClickOutside: false,
                            });
                        } else {
                            $('#formRegister').off('submit').submit();
                        }
                    });
                } else {
                    swal({
                        title: "Wrong OTP!",
                        text: "Your OTP is invalid. Please try again!",
                        icon: "error",
                        button: "OK!",
                        dangerMode: true,
                        closeOnClickOutside: false,
                    });
                }
            });
            $('#btnOTP').on('click', function () {
                $('#btnOTP').html('<div class="spinner-grow text-primary" role="status"> <span class="sr-only">Loading...</span></div>');
                if ($('#registerEmail').val() == 0) {
                    swal({
                        title: "Invalid email!",
                        text: "Please fill your valid email!",
                        icon: "warning",
                        button: "OK!",
                    });
                } else {
                    const otp = $('#registerOTP').val();
                    const email = $('#registerEmail').val();
                    $.getJSON('${pageContext.request.contextPath}/auth/sendOTP?email=' + email + '&otp=' + otp, function (data) {
                        $('#btnOTP').html('OTP')
                        if (data === false) {
                            swal({
                                title: "Failed!",
                                text: "Please click send OTP to your email again!",
                                icon: "error",
                                button: "OK!",
                            });
                        } else swal({
                            title: "Successfully!",
                            text: "Your OTP has been sent to your email!",
                            icon: "success",
                            button: "OK!",
                        });
                    });
                }
            });
            $(function () {
                $("#registerDob").datepicker();
            });
            $('registerName').select();

        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="mx-auto col-lg-5 mt-lg-5">
            <form class="p-5 mx-auto border rounded-lg shadow bg-light" id="formRegister" method="post">
                <div class="text-center mb-3">
                    <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">
                        <b>SIGN UP</b>
                    </h3>
                </div>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                        <strong>Sign Up Fail: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <div class="form-group">
                    <input type="text" placeholder="Name" autofocus class="form-control" id="registerName" name="name"
                           aria-describedby="emailHelp">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <input type="text" placeholder="Date of birth (dd/mm/yyyy)" class="form-control" id="registerDob"
                           name="dob">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <input type="text" placeholder="Phone" class="form-control" id="registerPhone" name="phone">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <div class="d-flex d-inline-block ">
                        <input type="email" placeholder="Email" class="form-control" id="registerEmail" name="email">
                        <button type="button" class="btn btn-outline-info ml-1" id="btnOTP">OTP</button>
                    </div>
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <input type="text" placeholder="OTP" name="otp" class="form-control" id="registerOTP">
                    <span class="form-message"></span>
                </div>
                <div class="form-group">
                    <input type="password" placeholder="Password" class="form-control" id="registerPassword"
                           name="password">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="form-group">
                    <input type="password" placeholder="Confirm password" class="form-control" id="registerConfirmPassword">
                    <span class="form-message mx-auto text-danger"></span>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary w-100" id="btnRegister">Sign Up</button>
                </div>
                <hr class="w-75 mx-auto bg-primary">
                <!-- Quay lai Home -->
                <div class="text-center">
                    <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/Home" role="button">
                        <i class="fa fa-home" aria-hidden="true"></i> Home
                    </a>
                </div>
                <div class="text-center mt-3">
                    I have an account ?
                    <a class="btn btn-outline-danger" id="switchLogin"
                       href="${pageContext.request.contextPath}/auth/login" role="button">
                        SING IN
                    </a>
                </div>
            </form>
        </div>
    </jsp:body>
</m1:Auth>