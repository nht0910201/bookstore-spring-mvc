<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<m1:MainLayout>
    <jsp:body>
        <div class="w-100 mx-auto mt-1 mb-1">
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active bg-warning"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1" class="bg-warning"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="2" class="bg-warning"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="3" class="bg-warning"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="4" class="bg-warning"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active" data-interval="3000">
                        <img src="https://www.bhdstar.vn/wp-content/uploads/2018/03/1920x1080-Pepsi-Back2School.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item" data-interval="3000">
                        <img src="https://www.bhdstar.vn/wp-content/uploads/2022/09/1920x1080-BanhKemLanh.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item" data-interval="3000">
                        <img src="https://www.bhdstar.vn/wp-content/uploads/2018/03/kết-TVC_update.png" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item" data-interval="3000">
                        <img src="https://www.bhdstar.vn/wp-content/uploads/2018/03/1920x1080-Popcorn.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item" data-interval="3000">
                        <img src="https://www.bhdstar.vn/wp-content/uploads/2018/03/App.jpg" class="d-block w-100" alt="...">
                    </div>
                </div>
                    <%--            <button class="carousel-control-prev" type="button" data-target="#carouselExampleIndicators" data-slide="prev">--%>
                    <%--                <span class="carousel-control-prev-icon" aria-hidden="true"></span>--%>
                    <%--                <span class="sr-only">Previous</span>--%>
                    <%--            </button>--%>
                    <%--            <button class="carousel-control-next" type="button" data-target="#carouselExampleIndicators" data-slide="next">--%>
                    <%--                <span class="carousel-control-next-icon" aria-hidden="true"></span>--%>
                    <%--                <span class="sr-only">Next</span>--%>
                    <%--            </button>--%>
            </div>
        </div>
    </jsp:body>
</m1:MainLayout>