<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tab-pane fade show active" id="list-products" role="tabpanel" aria-labelledby="list-products-list">
    <div class="card mx-auto justify-content-center d-flex"  id="accordionProducts">
        <div class="text-center mt-3">
            <h3 class="text-primary">Quản lý sản phẩm</h3>
        </div>
        <c:forEach items="${products}" var="product">
            <form method="post"  action="/Admin/ProductManage/${product.id}/Update" >
                <div class="card">
                    <div class="card-header" id="headingProducts">
                        <h2 class="mb-0">
                            <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse"
                                    data-target="#<c:out value="collapse${product.id}"/>" aria-expanded="true" aria-controls="<c:out value="collapse${product.id}"/>">
                                <b>${product.name}</b>
                            </button>
                        </h2>
                    </div>
                    <div id="<c:out value="collapse${product.id}"/>" class="collapse" aria-labelledby="headingProducts" data-parent="#accordionProducts">
                        <table class="list-group list-group-flush">
                            <tr>
                                <td><img src="https://cdn.tgdd.vn/Products/Images/42/262402/Samsung-Galaxy-A13-cam-thumb-600x600.jpg" class="card-img-top" alt="..."></td>
                            </tr>
                            <tr>
                                <td class="list-group-item"><b>Tên sản phẩm:</b></td>
                                <td><input class="w-100" value="${product.name}" name="name" disabled></td>
                            </tr>
                            <tr>
                                <td class="list-group-item"><b>Số lượng:</b></td>
                                <td class="w-75"><input class="w-100" type="number" value="${product.quantity}" name="quantity" disabled></td>
                            </tr>
                            <tr>
                                <td class="list-group-item"><b>Giá:</b></td>
                                <td><input type="number" class="w-100" value="${product.price}" name="price" disabled></td>
                            </tr>
                            <tr>
                                <td class="list-group-item"><b>Giảm giá(%):</b></td>
                                <td><input type="number" class="w-100" value="${product.discount}" name="discount" disabled></td>
                            </tr>
                            <tr>
                                <td class="list-group-item"><b>Mô tả:</b></td>
                                <td><input type="text" class="w-100" value="${product.description}" name="des" disabled></td>
                            </tr>
                        </table>
                        <div class="card-body justify-content-center d-flex">
                            <button type="button" id="<c:out value="btnEditPro${product.id}"/>"
                                    class=" btn btn-outline-primary mr-1"
                                    onclick="edit('Pro', ${product.id})">
                                Chỉnh sửa thông tin
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </button>
                            <button type="submit" id="<c:out value="btnSavePro${product.id}"/>"
                                    hidden class=" btn btn-outline-primary mr-1 w-25">
                                Lưu
                            </button>
                            <button type="button" id="<c:out value="btnCancelPro${product.id}"/>"
                                    hidden class=" btn btn-outline-primary mr-1 w-25"
                                    onclick="cancel('Pro', ${product.id})">
                                Hủy
                            </button>
                            <button type="submit" class=" btn btn-outline-danger mr-1"
                                    formaction="/Admin/ProductManage/${product.id}/Delete">
                                Xóa
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </c:forEach>
    </div>
</div>