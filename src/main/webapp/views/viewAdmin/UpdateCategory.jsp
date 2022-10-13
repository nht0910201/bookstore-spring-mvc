<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m1" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:useBean id="categories" scope="request" type="java.util.List<com.hcmute.bookstore.models.Category>"/>
<jsp:useBean id="category" scope="request" type="com.hcmute.bookstore.models.Category"/>
<m1:Admin>
    <jsp:attribute name="js">
        <script>
            $('#frmUpdateCategory').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#frmUpdateCategory',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#txtName', 'Please fill your user name'),
                    ],
                });
                $('#frmUpdateCategory').off('submit').submit();
            })
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="col-sm-12 mt-1 p-0">
            <div class="card-body w-50 mx-auto" style="background-color: white">
                <h3 class="text-center">UPDATE CATEGORY</h3>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-100 mx-auto" role="alert">
                        <strong>Update Category Fail: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <c:if test="${hasNotify}">
                    <div class="alert alert-success alert-dismissible fade show w-100 mx-auto" role="alert">
                        <strong>Completed: </strong> ${successMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <form id="frmUpdateCategory" method="post" action="/admin/update_category/${category.id}">
                    <div class="form-group">
                        <label for="txtName" style="font-weight: bold">Name</label>
                        <input type="text" class="form-control" name="name" id="txtName" value="${category.name}"/>
                        <span class="form-message text-danger"></span>
                    </div>
                    <div class="form-group">
                        <label for="parent_category" style="font-weight: bold">Parent Category</label>
                        <select name="parent_category" class="form-control" id="parent_category">
                            <c:if test="${category.parent_id==0}">
                                <option selected value="0">None</option>
                                <c:forEach items="${categories}" var="cat">
                                    <c:if test="${category.id != cat.id && cat.parent_id == 0}">
                                        <option value="${cat.id}">${cat.name}</option>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${category.parent_id != 0}">
                                <option value="0">None</option>
                                <c:forEach items="${categories}" var="cat">
                                    <c:if test="${category.parent_id==cat.id}">
                                        <option selected value="${cat.id}">${cat.name}</option>
                                    </c:if>
                                    <c:if test="${category.id != cat.id && cat.parent_id == 0}">
                                        <option value="${cat.id}">${cat.name}</option>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="form-control btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </jsp:body>
</m1:Admin>