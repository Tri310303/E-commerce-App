<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<h1 class="text-center text-info mt-1">QUẢN LÝ CỬA HÀNG</h1>

<a class="btn btn-primary me-2" href="<c:url value='stores' />">Thêm cửa hàng</a>
<table class="table table-striped mt-1">
    <tr>
        <th>Id</th>
        <th>Tên cửa hàng</th>
        <th>Địa chỉ</th>
        <th>Số điện thoại</th>
        <th>email</th>
        <th>Người sở hữu</th>
        <th></th>
    </tr>
    <c:forEach items="${stores}" var="s">
        <tr>
            <td>${s.id}</td>
            <td>${s.name}</td>
            <td>${s.address}</td>
            <td>${s.phone}</td>
            <td>${s.email}</td>
            <td>${s.managerId.firstName}</td>
            <td>
                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal.name == null}">
                    </c:when>
                    <c:when test="${pageContext.request.userPrincipal.name != null}">
                        <c:url value="/api/stores/${s.id}" var="http://localhost:8080/EcommerceApp/stores/" />
                        <a class="btn btn-info" href="<c:url value="/stores/${s.id}" />">Cập nhật</a>
                        <button onclick="deleteStore(${s.id})" class="btn btn-danger">Xóa</button>
                    </c:when>
                </c:choose>

            </td>
        </tr>
    </c:forEach>
</table>

<script>
    function deleteStore(id) {
        if (confirm("Bạn có chắc chắn muốn xóa cửa hàng này không?")) {
            fetch(`http://localhost:8080/EcommerceApp/stores/${id}`, {
                method: 'delete'
            })
                .then(response => {
                    if (response.status === 204) {
                        location.reload();
                    } else {
                        alert("Xóa cửa hàng không thành công.");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("Đã xảy ra lỗi khi xóa cửa hàng.");
                });
        }
    }
</script>