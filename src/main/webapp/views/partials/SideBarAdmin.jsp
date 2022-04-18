<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="list-group" id="list-tab" role="tablist">
    <a class="list-group-item list-group-item-action active" id="list-products-list" data-toggle="list" href="#list-products" role="tab" aria-controls="products">
        Quản lý sản phẩm
    </a>
    <div class="btn-group">
        <button type="button" class="btn btn-light dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-expanded="false">
            <span class="sr-only">Toggle Dropdown</span>
        </button>
        <div class="dropdown-menu">
            <a class="list-group-item list-group-item-action" id="list-addpro-list" data-toggle="list" href="#list-addpro" role="tab" aria-controls="addpro">
                Thêm sản phẩm</a>
        </div>
    </div>
    <c:if test="${role == 0}">
        <a class="list-group-item list-group-item-action" id="list-users-list" data-toggle="list" href="#list-users" role="tab" aria-controls="users">
            Quản lý người dùng
        </a>
        <div class="btn-group">
            <button type="button" class="btn btn-light dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-expanded="false">
                <span class="sr-only">Toggle Dropdown</span>
            </button>
            <div class="dropdown-menu">
                <a class="list-group-item list-group-item-action" id="list-adduser-list" data-toggle="list" href="#list-adduser" role="tab" aria-controls="adduser">
                    Thêm người dùng</a>
            </div>
        </div>
    </c:if>
    <a class="list-group-item list-group-item-action" id="list-orders-list" data-toggle="list" href="#list-orders" role="tab" aria-controls="orders">
        Quản lý đơn hàng
    </a>
</div>