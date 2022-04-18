<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<t:admin>
    <jsp:attribute name="js">
        <script>
            //validate when add prodct
            $('#frmAddProduct').on('submit', function (e) {
                e.preventDefault();
                // tinymce.triggerSave();
                Validator({
                    form: '#frmAddProduct',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#txtProName', 'Vui lòng nhập tên sản phẩm'),
                        Validator.isRequired('#txtPrice', 'Vui lòng nhập giá'),
                        Validator.isRequired('#txtQuantity', 'Vui lòng nhập số lượng sản phẩm'),
                        Validator.isRequired('#txtDes', 'Vui lòng nhập mô tả sản phẩm'),
                        Validator.isRequired('#txtCat', 'Vui lòng nhập nhà cung cấp'),
                        // Validator.isRequired('#pics', 'Please upload picture products')
                    ],
                });
                $('#frmAddProduct').off('submit').submit();
            });

            $('#frmAddUser').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#frmAddUser',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#txtName', 'Vui lòng nhập đầy đủ họ tên'),
                        Validator.isRequired('#txtAddress', 'Vui lòng nhập địa chỉ'),
                        Validator.isRequired('#txtEmail', 'Vui lòng nhập email'),
                        Validator.isRequired('#txtPhoneNumber','Vui lòng nhập số điện thoại'),
                        Validator.isRequired('#txtPass','Vui lòng nhập đầy đủ mật khẩu'),
                        Validator.isEmail('#txtEmail','Vui lòng nhập email chính xác'),
                        Validator.minLength('#txtPass',6),
                    ],
                });
                const email = $('#txtEmail').val();
                // Check if email exists
                $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?email=' + email, function (data) {
                    if (data === true) {
                        $('#frmAddUser').off('submit').submit();
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

            function edit(type, id) {
                $("td input").removeAttr('disabled');
                $("#btnEdit"+type+id).attr('hidden', true);
                $("#btnSave"+type+id).removeAttr('hidden');
                $("#btnCancel"+type+id).removeAttr('hidden');
            }
            function cancel(type, id) {
                $("td input").attr('disabled', true);
                $("#btnEdit"+type+id).attr('hidden', false);
                $("#btnSave"+type+id).attr('hidden', true);
                $("#btnCancel"+type+id).attr('hidden', true);
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="tab-content" id="nav-tabContent">
            <%--Products Managemant--%>
            <jsp:include page="../../views/viewAdmin/ProductManage.jsp"/>
            <%--Thêm sản phẩm--%>
            <jsp:include page="../../views/viewAdmin/AddProduct.jsp"/>
            <%--Quản lý người dùng--%>
            <jsp:include page="../../views/viewAdmin/UserManage.jsp"/>
            <%--Thêm người dùng--%>
            <jsp:include page="../../views/viewAdmin/AddUser.jsp"/>
            <%--Quản lý đơn hàng--%>
            <jsp:include page="../../views/viewAdmin/OrderManage.jsp"/>
        </div>
    </jsp:body>
</t:admin>