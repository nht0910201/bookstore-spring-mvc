<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="product" scope="request" type="com.hcmute.bookstore.models.Product"/>
<jsp:useBean id="product_image" scope="request" type="java.util.List<com.hcmute.bookstore.models.ProductImage>"/>
<m1:SubLayout>
    <jsp:attribute name="js">
        <script>
            function addToCart (url){
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Không thể thêm!",
                            text: "Sản phẩm đã có trong giỏ hàng hoặc đã hết hàng !",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else swal({
                        title: "Thêm thành công!",
                        text: "Bạn đã thêm sản phẩm vào giỏ hàng",
                        icon: "success",
                        button: "OK!",
                        closeOnClickOutside: false,
                    });
                });
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="row bg-white d-flex justify-content-center">
            <div class="all col-sm-5 mt-4 p-0">
                <div class="all mt-5">
                    <ul class="list-img mt-2 w-25">
                        <c:forEach items="${product_image}" var="image" varStatus="loop">
                            <li class="img mb-3 border border-warning w-50">
                                <img id="${loop.index+1}" onclick="changeImage('${loop.index+1}')" class="img-fluid"
                                     src="${image.img_src}" alt="">
                            </li>
                        </c:forEach>
                    </ul>
                    <div id="main_img" class="w-50">
                        <img id="img_main" class="img-fluid" src="${product_image.get(0).img_src}" alt="">
                    </div>
                </div>
            </div>
            <div class="mt-5 p-3 col-sm-3 border rounded-lg shadow">
                <h3 style="font-family: sans-serif">${product.name}</h3>
                <p>Nhà cung cấp: ${product.supplier}</p>
                <p>NXB: ${product.publisher}</p>
                <p>Năm: ${product.publishYear}</p>
                <fmt:parseNumber var="price" type="number" integerOnly="true" value="${product.price}"/>
                <p style="text-decoration-line: line-through">Giá gốc: ${price} VNĐ</p>
                <p class="text-danger">Sales: ${product.discount}%</p>
                <fmt:parseNumber var="priceSales" type="number" integerOnly="true"
                                 value="${product.price - (product.price*product.discount/100)}"/>
                <p class="text-primary">Còn: ${priceSales} VNĐ</p>
                <button type="button" onclick="addToCart('${pageContext.request.contextPath}/cart/addToCart?pro_id=${product.id}&pro_name=${product.name}&price=${product.price}&quantity=1&discount=${product.discount}&user_id=${authUser.id}')" class="btn btn-primary">
                    <i class="fa fa-cart-plus" aria-hidden="true"></i>
                    Add To Cart
                </button>
            </div>
            <hr class="w-100 mx-auto bg-primary" style="margin-top: 80px">
        </div>
        <div class="row justify-content-center">
            <div class="col-sm-4 p-3">
                <h5>Thông tin chi tiết</h5>
                <p>Nhà cung cấp: ${product.publisher}</p>
                <p>Nhà xuất bản: ${product.supplier}</p>
                <p>Năm xuất bản: ${product.publishYear}</p>
                <p>Kích thước: ${product.size}</p>
                <p>Số trang: ${product.pageNum}</p>
            </div>
            <div class="col-sm-4 p-3">
                <h5>Tóm tắt nội dung</h5>
                <p>${product.description}</p>
            </div>
        </div>
    </jsp:body>
</m1:SubLayout>