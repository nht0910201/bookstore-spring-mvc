<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="products" scope="request" type="java.util.List<com.hcmute.mobilestore.models.Product>"/>
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
        <div class="col-2">

        </div>
        <div class="col-8">
            <div class="mx-auto">
                <div class="container-fluid t1 d-flex flex-wrap">
                    <div class="row mt-2">
                        <c:forEach items="${products}" var="product">
                            <div class="card mr-1 mt-1" style="width: 18rem;">
                                <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${product.id}"><img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top" alt="..."></a>
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?pro_id=${product.id}">
                                                ${product.name}
                                        </a>
                                    </h5>
                                    <p class="card-text">
                                        <b>Mô tả:</b><br>${product.description}
                                    </p>
                                </div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">Số lượng: ${product.quantity}</li>
                                    <li class="list-group-item">Ưu đãi: ${product.discount}%</li>
                                    <li class="list-group-item">Giá bán: ${product.price}</li>
                                </ul>
                                <div class="card-body">
                                    <a class="btn btn-outline-info" href="${pageContext.request.contextPath}/Product/Detail?pro_id=${product.id}" role="button">
                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                        Detail
                                    </a>
                                    <button onclick="add('${pageContext.request.contextPath}/Product/AddToCart?pro_id=${product.id}&pro_name=${product.name}&price=${product.price}&quantity=1&acc_id=${authUser.id}')" class="btn btn-outline-danger" role="button">
                                        <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                        Add to Cart
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-2">

        </div>
    </jsp:body>
</m1:MainLayout>