<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="product" scope="request" type="com.hcmute.bookstore.models.Product"/>
<m1:MainLayout>
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
            window.onload = function () {
                var url_string = window.location.href; //window.location.href
                var url = new URL(url_string);
                var c = url.searchParams.get("search");
                $('#resSearch').text(c)
                $('#search').val(c)
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="text-danger">
            <h5 class="mt-4 ml-2 font-weight-bold">Result for search: <span class="text-primary" id="resSearch"></span> </h5>
<%--            <h5 class="mt-4 ml-1">(${products.size()} products)</h5>--%>
        </div>
        <div class="border mt-2 pr-0 ">
            <div class="d-flex flex-wrap t1">
                <div class="item1 card mx-auto" style="width: 15rem;">
                    <a href="/product/${product.id}">
                        <img src="${product.productImages.get(0).img_src}" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        <p class="card-text" style="text-decoration-line: line-through">${product.price}</p>
                        <p class="card-text text-danger">${product.discount}%</p>
                        <p class="card-text font-weight-bold">${product.price-((product.price*product.discount)/100)}</p>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</m1:MainLayout>