<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="product" scope="request" type="com.hcmute.mobilestore.models.Product"/>
<m1:MainLayout>
    <jsp:attribute name="js">
        <script>
            function add (url){
                $.getJSON(url, function (data) {
                    if (data === false) {
                        swal({
                            title: "Không thể thêm!",
                            text: "Sản phẩm đã có trong giỏ hàng !",
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
        <div class="card text-center">
            <div class="card-header">
                ${product.name}
            </div>
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div class="all mx-auto d-flex justify-content-center">
                        <div>
                            <ul class="list-img mt-2 list-unstyled">
                                <li class="img mb-3">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="0" id="one" class="border border-success rounded" style="width: 80px;height: 80px; object-fit: contain;" src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" alt="">
                                </li>
                                <li class="img mb-3">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="1" id="two" class="border border-success rounded"  style="width: 80px;height: 80px; object-fit: contain;" src="https://cdn.tgdd.vn/Products/Images/42/250102/samsung-galaxy-a13-5g-030921-052039-600x600.jpg" alt="">
                                </li>
                                <li class="img mb-3">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="2" id="three" class="border border-success rounded" style="width: 80px;height: 80px; object-fit: contain;"  src="https://cdn.tgdd.vn/Products/Images/42/232364/samsung-galaxy-a12-xanh-200x200.jpg" alt="">
                                </li>
                                <li class="img">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="3" id="four" class="border border-success rounded"  style="width: 80px;height: 80px; object-fit: contain;"  src="https://cdn.tgdd.vn/Products/Images/42/246195/samsung-galaxy-a73-5g-xanh-thumb-600x600.jpg" alt="">
                                </li>
                            </ul>
                        </div>
                        <div id="main_img" style="margin-left: 20px" >
                            <div id="carouselExampleIndicators" class="carousel slide" data-interval="2000" data-ride="carousel" style="width: 400px;height: 400px; object-fit: contain; box-shadow: none">
                                <ol class="carousel-indicators">
                                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active bg-secondary"></li>
                                    <li data-target="#carouselExampleIndicators" data-slide-to="1" class="bg-secondary"></li>
                                    <li data-target="#carouselExampleIndicators" data-slide-to="2" class="bg-secondary"></li>
                                    <li data-target="#carouselExampleIndicators" data-slide-to="3" class="bg-secondary"></li>
                                </ol>
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="d-block w-100" alt="...">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="https://cdn.tgdd.vn/Products/Images/42/250102/samsung-galaxy-a13-5g-030921-052039-600x600.jpg" class="d-block w-100" alt="...">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="https://cdn.tgdd.vn/Products/Images/42/232364/samsung-galaxy-a12-xanh-200x200.jpg" class="d-block w-100" alt="...">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="https://cdn.tgdd.vn/Products/Images/42/246195/samsung-galaxy-a73-5g-xanh-thumb-600x600.jpg" class="d-block w-100" alt="...">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <h5 class="card-title">Thông số sản phẩm</h5><br>
                        <p class="card-text">${product.description}</p><br>
                        <p class="card-text">Số lượng: ${product.quantity}</p><br>
                        <p class="card-text">Ưu đãi: ${product.discount}%</p><br>
                        <p class="card-text">Giá bán: ${product.price} VNĐ</p>
                    </div>
                </div>
            </div>
            <div class="card-footer text-muted">
                <button class="btn btn-danger" onclick="add('${pageContext.request.contextPath}/Product/AddToCart?pro_id=${product.id}&pro_name=${product.name}&price=${product.price}&quantity=1&acc_id=1')" role="button">
                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                    Add to Cart
                </button>
            </div>
        </div>
    </jsp:body>
</m1:MainLayout>