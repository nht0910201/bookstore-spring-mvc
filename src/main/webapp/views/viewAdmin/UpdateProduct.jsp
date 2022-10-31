<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--<jsp:useBean id="productUpdate" scope="request" type="com.hcmute.bookstore.models.Product"/>--%>
<jsp:useBean id="categories" scope="request" type="java.util.List<com.hcmute.bookstore.models.Category>"/>
<jsp:useBean id="productImage" scope="request" type="java.util.List<com.hcmute.bookstore.models.ProductImage>"/>
<m1:Admin>
    <jsp:attribute name="css">
        <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all"
              rel="stylesheet" type="text/css"/>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdn.tiny.cloud/1/jlgjkipwsouwi1pd47mxpwmaf6hrnacs6f2yht3j4yekrfu5/tinymce/5/tinymce.min.js"
                referrerpolicy="origin"></script>
        <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/themes/fa/theme.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/js/locales/uk.min.js"></script>
        <script>
            $('#frmUpdateProduct').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#frmUpdateProduct',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#txtProName', 'Please fill your product name'),
                        Validator.isRequired('#txtPrice', 'Please fill your product price'),
                        Validator.isRequired('#txtDiscount', 'Please fill your product discount'),
                        Validator.isRequired('#txtSupplier', 'Please fill supplier'),
                        Validator.isRequired('#txtPublisher', 'Please fill publisher'),
                        Validator.isRequired('#txtAuthor', 'Please fill author of product'),
                        Validator.isRequired('#txtYear', 'Please fill year'),
                        Validator.isRequired('#txtDes', 'Please fill your product description'),
                        Validator.isRequired('#txtCat', 'Please fill your category'),
                        // Validator.isRequired('#pics', 'Please upload picture products')
                        Validator.isRequired('#txtQuantity', 'Please fill product quantity')
                    ],
                });
                $('#frmUpdateProduct').off('submit').submit();
            })
            tinymce.init({
                selector: '#txtDes',
                height: 250,
                plugins: 'paste image link autolink lists table media',
                menubar: false,
                toolbar: [
                    'undo redo | bold italic underline strikethrough | numlist bullist | alignleft aligncenter alignright | forecolor backcolor | table link image media'
                ],
            });
            $('#pics').fileinput({
                msgPlaceholder: 'Please choose at least 1 image',
                theme: 'fa',
                // minFileCount: 1,
                maxFileCount: 4,
                dropZoneEnabled: false,
                allowedFileExtensions: ['jpg', '.png'],
                captionClass: 'bo-0'
            });

            function remove(url) {
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Error!",
                            text: "Xoá ảnh không thành công",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else {
                        swal({
                            title: "Successfully",
                            text: "Xoá ảnh thành công",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        })
                            .then(function () {
                                    location.reload();
                                }
                            );
                    }
                });
            }

            function delProduct(url) {
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Error!",
                            text: "Xoá sản phẩm không thành công",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else {
                        swal({
                            title: "Successfully",
                            text: "Xoá sản phẩm thành công",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        })
                            .then(function () {
                                    location.reload();
                                }
                            );
                    }
                });
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="col-sm-12 mt-1 p-0">
            <div class="card-body w-75 mx-auto" style="background-color: white">
                <h3 class="text-center">UPDATE PRODUCT</h3>
                    <%--@elvariable id="productUpdate" type=""--%>
                <form:form method="post" id="frmUpdateProduct" modelAttribute="productUpdate"
                           enctype="multipart/form-data"
                           action="/admin/update_product/${productUpdate.id}">
                    <c:if test="${hasError}">
                        <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                            <strong>Update Product Fail: </strong> ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <c:if test="${hasNotify}">
                        <div class="alert alert-success alert-dismissible fade show w-75 mx-auto" role="alert">
                            <strong>Completed: </strong> ${successMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <div class="form-group">
                        <label for="txtProName" style="font-weight: bold">Product name:</label>
                        <input type="text" class="form-control" name="proname" id="txtProName"
                               value="${productUpdate.name}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtCat" style="font-weight: bold">Category:</label>
                        <select name="category" id="txtCat" class="w-100"
                                style="height: 40px">
                            <c:forEach items="${categories}" var="category">
                                <c:if test="${category.id == productUpdate.categoryId}">
                                    <option selected="selected"
                                            value="${productUpdate.categoryId}">${category.name}</option>
                                </c:if>
                                <c:if test="${category.id!= productUpdate.categoryId }">
                                    <option value="${category.id}">${category.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtPrice" style="font-weight: bold">Price: </label>
                        <input type="number" class="form-control" name="price" id="txtPrice"
                               value="${productUpdate.price}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtDiscount" style="font-weight: bold">Discount: </label>
                        <input type="number" class="form-control" name="discount" id="txtDiscount"
                               value="${productUpdate.discount}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtQuantity" style="font-weight: bold">Quantity: </label>
                        <input type="number" class="form-control" name="quantity" id="txtQuantity"
                               value="${productUpdate.quantity}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtSuplier" style="font-weight: bold">Supplier:</label>
                        <input type="text" class="form-control" name="supplier" id="txtSuplier"
                               value="${productUpdate.supplier}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtPublisher" style="font-weight: bold">Publisher:</label>
                        <input type="text" class="form-control" name="publisher" id="txtPublisher"
                               value="${productUpdate.publisher}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtYear" style="font-weight: bold">Year Publisher:</label> <br>
                        <input type="text" class="form-control" name="year" id="txtYear"
                               value="${productUpdate.publishYear}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtAuthor" style="font-weight: bold">Author:</label> <br>
                        <input type="text" class="form-control" name="author" id="txtAuthor"
                               value="${productUpdate.author}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtPage" style="font-weight: bold">Total Page:</label> <br>
                        <input type="number" class="form-control" name="pageNum" id="txtPage"
                               value="${productUpdate.pageNum}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtSize" style="font-weight: bold">Size:</label> <br>
                        <input type="text" class="form-control" name="size" id="txtSize" value="${productUpdate.size}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtDes" style="font-weight: bold">Full Description:</label>
                        <input type="text" class="form-control" name="description" id="txtDes" value="${productUpdate.description}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="image" style="font-weight: bold">Image:</label>
                        <div class="d-flex w-auto" id="image">
                            <c:forEach items="${productImage}" var="image">
                                <div class="d-flex flex-column w-auto">
                                    <img class="img-thumbnail" src="${image.img_src}" alt="None..."/>
                                    <button role="button" class="btn btn-outline-danger"
                                            onclick="remove('${pageContext.request.contextPath}/image/${image.id}/deleteImage?url=${image.img_src}')">
                                        <i class="fa fa-trash" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pics" style="font-weight: bold">Add Image</label>
                        <input type="file" name="imgs" id="pics" accept="image/*" multiple/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group d-flex">
                        <form:button type="submit" class="btn btn-primary w-50">Save Update</form:button>
                        <c:if test="${productUpdate.state == 'enable'}">
                            <button class="btn btn-danger w-50" onclick="delProduct('${pageContext.request.contextPath}/admin/delete_product/${productUpdate.id}')" type="button">
                                Delete Product
                            </button>
                        </c:if>
                    </div>
                    <c:if test="${productUpdate.state == 'disable'}">
                        <div class="form-group">
                            <h5>Sản phẩm đã xoá</h5>
                        </div>
                    </c:if>
                </form:form>
            </div>
        </div>
    </jsp:body>
</m1:Admin>