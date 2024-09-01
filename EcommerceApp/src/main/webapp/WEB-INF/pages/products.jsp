<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<h1 class="text-center text-info mt-1">QUẢN LÝ SẢN PHẨM</h1>

<c:url value="/products" var="action" />
<form:form method="post" action="${action}" modelAttribute="product" enctype="multipart/form-data">
    <form:errors path="*" element="div" cssClass="alert alert-danger" />

    <div class="form-floating mb-3 mt-3">
        <form:input class="form-control" id="name" placeholder="Tên sản phẩm" path="name" />
        <label for="name">Tên sản phẩm</label>
    </div>

    <div class="form-floating mb-3 mt-3">
        <form:input class="form-control" id="price" placeholder="Giá" path="price" />
        <label for="price">Giá sản phẩm</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input class="form-control" id="manufacturer" placeholder="Nhà sản xuất" path="manufacturer" />
        <label for="manufacturer">Nhà sản xuất:</label>
    </div>

    <div class="form-floating mb-3 mt-3">
        <form:input type="file" class="form-control" id="image" path="file" />
        <label for="image">Ảnh sản phẩm</label>

        <c:if test="${product.id > 0}">
            <img src="${product.image}" width="200" class="img-fluid" />
        </c:if>
    </div>

    <div class="form-floating mb-3 mt-3">
        <form:select class="form-select" id="categoryId" path="categoryId">
            <c:forEach items="${categories}" var="c">
                <c:choose>
                    <c:when test="${c.id == product.categoryId.id}">
                        <option value="${c.id}" selected>${c.name}</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${c.id}">${c.name}</option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </form:select>
        <label for="categoryId" class="form-label">Danh mục:</label>
    </div>


    <div class="form-floating mb-3 mt-3">
        <form:select class="form-select" id="storeId" path="storeId">
            <c:forEach items="${stores}" var="s">
                <c:choose>
                    <c:when test="${s.id == product.storeId.id}">
                        <option value="${s.id}" selected>${s.name}</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${s.id}">${s.name}</option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </form:select>
        <label for="categoryId" class="form-label">Cửa hàng:</label>
    </div>

    <div class="form-floating">
        <form:button class="btn btn-info mt-1" type="submit">
            <c:choose>
                <c:when test="${product.id > 0}">Cập nhật sản phẩm</c:when>
                <c:otherwise>Thêm sản phẩm</c:otherwise>
            </c:choose>
        </form:button>
        <form:hidden path="id" />
    </div>
</form:form>


