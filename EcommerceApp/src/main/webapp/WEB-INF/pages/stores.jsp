<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h1 class="text-center text-info mt-1">QUẢN LÝ CỬA HÀNG</h1>
<c:url value="/stores" var="action" />
<form:form method="post" action="${action}" modelAttribute="store" enctype="multipart/form-data">
    <form:errors path="*" element="div" cssClass="alert alert-danger" />

    <div class="form-floating mb-3 mt-3">
        <form:input class="form-control" id="name" placeholder="Tên cửa hàng" path="name" />
        <label for="name">Tên cửa hàng</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input class="form-control" id="address" placeholder="Địa chỉ cửa hàng" path="address" />
        <label for="address">Địa chỉ cửa hàng</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input class="form-control" id="phone" placeholder="Số điện thoại cửa hàng" path="phone" />
        <label for="phone">Số điện thoại cửa hàng</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:input class="form-control" id="email" placeholder="Email" path="email" />
        <label for="email">Email</label>
    </div>
    <div class="form-floating mb-3 mt-3">
        <form:select class="form-select" id="managerId" path="managerId">
            <c:forEach items="${users}" var="u">
                <c:choose>
                    <c:when test="${u.username == pageContext.request.userPrincipal.name}">
                        <option value="${u.id}" selected>${u.username}</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${u.id}">${u.username}</option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </form:select>
        <label for="categoryId" class="form-label">Người dùng tạo:</label>
    </div>
    <div class="form-floating">
        <button class="btn btn-info mt-1" type="submit">
            <c:choose>
                <c:when test="${store.id > 0}"> Cập nhật cửa hàng</c:when>
                <c:otherwise> Thêm cửa hàng</c:otherwise>
            </c:choose>
        </button>
        <form:hidden path="id" />
    </div>
</form:form>