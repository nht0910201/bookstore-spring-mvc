<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<m1:MainLayout>
    <jsp:body>
        <div class="col-2">

        </div>
        <div class="col-8 d-flex flex-wrap">
            <div class="card mt-1" style="width: 18rem;">
                <img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Card title</h5>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">Ưu đãi</li>
                    <li class="list-group-item">Giá bán: (1 sản phẩm)</li>
                    <li class="list-group-item">
                        <input style="width: 100%" type="number" id="quantity" name="quantity" min="1" max="5">
                    </li>
                </ul>
                <div class="card-body mx-auto">
                        <%--                <a href="#" class="card-link">Card link</a>--%>
                        <%--                <a href="#" class="card-link">Another link</a>--%>
                    <a name="" id="" class="btn btn-outline-danger" href="#" role="button">
                        <i class="fa fa-trash" aria-hidden="true"></i>
                        Delete
                    </a>
                </div>
            </div>
        </div>
        <div class="col-2">

        </div>
    </jsp:body>
</m1:MainLayout>