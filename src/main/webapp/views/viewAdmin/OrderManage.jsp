<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tab-pane fade" id="list-orders" role="tabpanel" aria-labelledby="list-orders-list">
    Quản lý đơn hàng
    <div class="accordion" id="accordionExample">
        <c:forEach items="${list_Order}" var="orderItem">
            <div class="card">
                <div class="card-header" id="headingOne">
                    <h2 class="mb-0">
                        <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne${orderItem.id}" aria-expanded="true" aria-controls="collapseOne">
                                ${orderItem.id}
                        </button>
                        <c:choose>
                            <c:when test = "${orderItem.status == 'complete'}">
                                <form method="post" action="/Admin/Manage/Authorize" id="form_Order${orderItem.id}">
                                    <input type="hidden" value="${orderItem.id}" name="order_ id">
                                    <button class="btn btn-danger text-right d-inline-block" type="submit" >
                                        Accept
                                    </button>
                                </form>
                            </c:when>
                            <c:when test = "${orderItem.status == 'Accepted'}">
                              <span class="btn btn-primary" aria-readonly="true" >ACCEPTED </span>
                            </c:when>
                        </c:choose>
                    </h2>
                </div>
                <c:forEach items="${cart_item}" var="item">
                    <c:if test = "${orderItem.id == item.order_id}">
                        <div id="collapseOne${orderItem.id}" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                            <div class="card-body">
                                Tên sản phẩm: ${item.pro_name} <span class="text-primary" > Giá: ${item.price}</span>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:forEach>
    </div>
</div>