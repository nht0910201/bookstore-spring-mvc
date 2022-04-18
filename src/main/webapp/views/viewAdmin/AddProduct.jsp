<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tab-pane fade" id="list-addpro" role="tabpanel" aria-labelledby="list-addpro-list">
    <div class="card-body mx-auto">
        <form method="post" id="frmAddProduct"
              action="/Admin/ProductManage/Add" enctype="multipart/form-data">
            <div class="form-group">
                <label for="txtProName" style="font-weight: bold">Tên sản phẩm:</label>
                <input type="text" class="form-control" name="name" id="txtProName">
                <span class="form-message" ></span>
            </div>
            <div class="form-group">
                <label for="txtCat" style="font-weight: bold">Danh mục sản phẩm:</label>
                <select name="supid" id="txtCat" class="w-100">
                    <option value="">Select a Category</option>
                    <c:forEach items="${suppliers}" var="supplier">
                        <option value="${supplier.id}">${supplier.name}</option>
                    </c:forEach>
                </select>
                <span class="form-message" ></span>
            </div>
            <div class="form-group">
                <label for="txtQuantity" style="font-weight: bold">Số lượng:</label>
                <input type="number" class="form-control " name="quantity" id="txtQuantity">
                <span class="form-message" ></span>
            </div>
            <div class="form-group">
                <label for="txtPrice" style="font-weight: bold">Giá: </label>
                <input type="number" class="form-control" name="price" id="txtPrice">
                <span class="form-message" ></span>
            </div>
            <div class="form-group">
                <label for="txtDiscount" style="font-weight: bold">Giảm giá:</label>
                <input type="number" value="0" class="form-control" name="discount" id="txtDiscount">
                <span class="form-message" ></span>
            </div>
            <div class="form-group">
                <label for="txtDes" style="font-weight: bold">Mô tả:</label>
                <input type="text" class="form-control" name="des" id="txtDes">
                <span class="form-message" ></span>
            </div>
            <%--<div class="form-group">--%>
            <%--    <input type="file" name="pics[]" id="pics" multiple>--%>
            <%--    <span class="form-message" ></span>--%>
            <%--</div>--%>
            <button type="submit" class="btn w-100 text-light" style="background-color: darkblue">Thêm sản phẩm</button>
        </form>
    </div>
</div>