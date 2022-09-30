<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="product" scope="request" type="com.hcmute.bookstore.models.Product"/>
<jsp:useBean id="product_image" scope="request" type="java.util.List<com.hcmute.bookstore.models.ProductImage>"/>
<m1:SubLayout>
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
                <a class="btn btn-outline-danger" href="#" role="button">
                    <i class="fa fa-cart-plus" aria-hidden="true"></i>
                    Thêm vào giỏ hàng
                </a>
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
        <hr class="w-100  mt-5 mx-auto bg-primary">
        <div class="border mt-2 pr-0 ">
            <h3 class="bg-primary text-white text-center">SẢN PHẨM LIÊN QUAN</h3>
            <div class="d-flex flex-wrap t1">
                <div class="item1 card mx-auto" style="width: 15rem;">
                    <img src="https://picsum.photos/200/300" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Name</h5>
                        <p class="card-text" style="text-decoration-line: line-through">Price}</p>
                        <p class="card-text text-danger">Discount</p>
                        <p class="card-text font-weight-bold">Price New</p>
                            <%--                            <a href="#" class="btn btn-primary">Go somewhere</a>--%>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</m1:SubLayout>