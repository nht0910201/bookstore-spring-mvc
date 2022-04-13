<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<m1:MainLayout>
    <jsp:body>
        <div class="mx-auto">
            <div class="container-fluid t1">
                <div class="row mt-2">
                    <c:forEach items="${products}" var="product">
                        <div class="card mr-1 mt-1" style="width: 18rem;">
                            <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top" alt="...">
                            <div class="card-body">
                                    <h5 class="card-title">${product.name}</h5>
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
                                <a name="" id="" class="btn btn-outline-info" href="#" role="button">
                                    <i class="fa fa-eye" aria-hidden="true"></i>
                                    Detail
                                </a>
                                <a name="" id="" class="btn btn-outline-danger" href="#" role="button">
                                    <i class="fa fa-heart" aria-hidden="true"></i>
                                    Favourite
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </jsp:body>
</m1:MainLayout>