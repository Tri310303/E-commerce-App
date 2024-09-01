<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title class="text-center text-info mt-1">QUẢN TRỊ SẢN PHẨM</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center text-info mt-1">ĐĂNG KÝ DOANH NGHIỆP</h1>
        <table class="table table-bordered table-striped" id="usersTable">
            <thead class="thead-dark">
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${inactiveUsers}" var="user">
                    <tr>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.active}">
                                    Active
                                </c:when>
                                <c:otherwise>
                                    Inactive
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:url value="/api/confirm/" var="urlConfirm">
                                <c:param name="userId" value="${user.id}"/>
                            </c:url>
                            <c:if test="${!user.active}">
                                <button class="btn btn-primary" onclick="confirmUser('${urlConfirm}',${user.id},'${user.username}')">Confirm</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>

    <script src="<c:url value='/js/script.js' />"></script>
    <script>
        function confirmUser(url, userId, username) {
            // Confirm the user activation (simulated with an alert)
            if (confirm('Are you sure you want to activate user: ' + username + '?')) {
                alert('User ' + username + ' activated.');
                fetch(url,{
                    method:"post"
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return; // Assuming the server returns JSON data
                })
                .then(data => {
                    // Update the UI based on the server response
                    var rows = document.getElementById("usersTable").rows;
                    for (var i = 1; i < rows.length; i++) {
                        var cell = rows[i].cells[0]; // Assuming username is in the first cell
                        if (cell.innerHTML.trim() === username) {
                            rows[i].cells[3].innerHTML = 'Active'; // Update status to Active
                            break;
                        }
                    }
                })
                .catch(error => {
                    console.error('There has been a problem with your fetch operation:', error);
                    alert('Failed to activate user: ' + username); // Show error message
                });
            }
        }
    </script>
</body>
</html>
