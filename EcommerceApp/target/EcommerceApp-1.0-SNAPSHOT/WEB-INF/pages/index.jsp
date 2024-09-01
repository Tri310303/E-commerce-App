<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<h1 class="text-center text-info mt-1">QUẢN TRỊ SẢN PHẨM</h1>
<c:choose>
    <c:when test="${pageContext.request.userPrincipal.name == null}">
    </c:when>
    <c:when test="${pageContext.request.userPrincipal.name != null}">

        <div class="mb-3">
            <a class="btn btn-success me-2" href="<c:url value='/products' />">Thêm sản phẩm</a>
            <a class="btn btn-danger" href="<c:url value='/index2' />">Cửa hàng</a>
            <a class=" btn btn-warning " href="<c:url value="/check" />">Đăng ký Tiểu thương/Doanh nghiệp</a>
            <a class=" btn btn-info " href="<c:url value="/stats" />">Thống kê</a>
        </div>
    </c:when>
</c:choose>

<table class="table table-striped mt-1">
    <tr>
        <th></th>
        <th>Id</th>
        <th>Tên</th>
        <th>Nhà sản xuất</th>
        <th>Cửa hàng bán</th>
        <th>Giá</th>
        <th></th>
    </tr>
    <c:forEach items="${products}" var="p">
        <tr>
            <td> <img class="card-img-top" src="${p.image}" alt="${p.name}" style="width:200px;"></td>
            <td>${p.id}</td>
            <td>${p.name}</td>
            <td>${p.manufacturer}</td>
            <td>${p.storeId.name}</td>
            <td>${String.format("%,d", p.price)} VNĐ</td>
            <td>
                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal.name == null}">
                    </c:when>
                    <c:when test="${pageContext.request.userPrincipal.name != null}">
                        <c:url value="/api/products/${p.id}" var="url" />
                        <a class="btn btn-info" href="<c:url value="/products/${p.id}" />">Cập nhật</a>
                        <button onclick="deleteProduct('${url}',${p.id})" class="btn btn-danger">Xóa</button>
                    </c:when>
                </c:choose>

            </td>
        </tr>
    </c:forEach>
</table>

<script src="<c:url value="/js/script.js" />"></script>
