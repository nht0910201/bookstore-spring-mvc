<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="products" scope="request" type="java.util.List<com.hcmute.bookstore.models.Product>"/>
<m1:Admin>
    <jsp:attribute name="js">
         <script>
             $(document).ready(function () {
                 $('.t1').after('<div id="nav1" class="text-center mt-2 mb-2"></div>');
                 let itemsShown = 1;
                 let itemsTotal = $('.t1 .item1').length;
                 let numPages = itemsTotal / itemsShown;
                 for (let i = 0; i < numPages; i++) {
                     let pageNum = i + 1;
                     $('#nav1').append('<a href="#" class="btn-outline-info btn-sm text-decoration-none rounded-lg border border-warning" rel="' + i + '">&emsp;' + pageNum + '&emsp;</a> ');
                 }
                 $('.t1 .item1').hide();
                 $('.t1 .item1').slice(0, itemsShown).show();
                 $('#nav1 a:first').addClass('active');
                 $('#nav1 a').bind('click', function (e) {
                     e.preventDefault();
                     $('#nav1 a').removeClass('active');
                     $(this).addClass('active');
                     let currPage = $(this).attr('rel');
                     let startItem = currPage * itemsShown;
                     let endItem = startItem + itemsShown;
                     $('.t1 .item1').css('opacity', '0').hide().slice(startItem, endItem).css('display', 'block').animate({
                         opacity: 1
                     }, 300);
                 });
             });
         </script>
    </jsp:attribute>
    <jsp:body>
        <div class="col-sm-12 mt-1 p-0">
            <div class="w-100 bg-light d-flex justify-content-center">
                <a class="btn btn-outline-primary mr-3" href="" role="button">
                    <i class="fa fa-user" aria-hidden="true"></i>
                    User
                </a>
                <a class="btn btn-outline-warning mr-3" href="" role="button">
                    <i class="fa fa-bars" aria-hidden="true"></i>
                    Category
                </a>
                <a class="btn btn-outline-danger mr-3" href="#" role="button">
                    <i class="fa fa-product-hunt" aria-hidden="true"></i>
                    Product
                </a>
                <a class="btn btn-outline-success" href="#" role="button">
                    <i class="fa fa-shopping-bag" aria-hidden="true"></i>
                    Order
                </a>
            </div>
            <div class="container mt-3">
                <div class="d-flex justify-content-between">
                    <h3>Product</h3>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/add_product" role="button">Add Product
                        <i class="fa fa-plus" aria-hidden="true"></i>
                    </a>
                </div>
                <div class="d-flex flex-wrap t1">
                    <c:forEach items="${products}" var="product">
                        <div class="item1 card mx-auto" style="width: 15rem;">
                            <img src="${product.productImages.get(0).img_src}" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text" style="text-decoration-line: line-through">${product.price}</p>
                                <p class="card-text text-danger">${product.discount}%</p>
                                <p class="card-text font-weight-bold">${product.price-((product.price*product.discount)/100)}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </jsp:body>
</m1:Admin>