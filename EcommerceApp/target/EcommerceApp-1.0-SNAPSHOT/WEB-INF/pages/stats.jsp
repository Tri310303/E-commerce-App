<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Arial, sans-serif';
    }
    h1 {
        color: #17a2b8;
        margin-top: 20px;
    }
    .table-container {
        background: #ffffff;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        margin-right: 10px;
    }
    .form-floating {
        margin-bottom: 10px;
    }
    .btn-success {
        background-color: #28a745;
        border-color: #28a745;
    }
    .alert-info {
        background-color: #d1ecf1;
        border-color: #bee5eb;
        color: #0c5460;
    }
    .chart-container {
        margin-top: 20px;
        width: 100%;
    }
    .chart-container canvas {
        width: 100% !important; /* Ensuring the canvas takes full width */
        height: 500px !important; /* Adjusting height */
    }
    .hr {
        margin: 20px 0;
        border: 0;
        border-top: 1px solid #e9ecef;
    }
    .table th, .table td {
        padding: 0.3rem;
    }
    .form-container {
        padding: 20px;
    }
</style>

<div class="container">
    <h1 class="text-center">THỐNG KÊ BÁN HÀNG</h1>

    <div class="row">
        <div class="col-md-8 table-container">
            <h3>Doanh thu theo sản phẩm</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Doanh thu</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${revenueByProducts}" var="p">
                        <tr>
                            <td>${p[0]}</td>
                            <td>${p[1]}</td>
                            <td>${String.format("%,d", p[2])} VNĐ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="col-md-5 chart-container">
            <canvas id="myChart"></canvas>
        </div>
    </div>

    <hr class="hr" />

    <div class="row">
        <div class="col-md-5 table-container form-container">
            <form method="get">
                <h3>Lựa chọn</h3>
                <div class="form-floating">
                    <input type="text" value="${param.year}" class="form-control" id="year" placeholder="Năm" name="year">
                    <label for="year">Năm</label>
                </div>
                <div class="form-floating">
                    <select class="form-select" id="period" name="period">
                        <option value="MONTH" ${param.period == 'MONTH' ? 'selected' : ''}>Theo tháng</option>
                        <option value="QUARTER" ${param.period == 'QUARTER' ? 'selected' : ''}>Theo quý</option>
                        <option value="YEAR" ${param.period == 'YEAR' ? 'selected' : ''}>Theo năm</option>
                    </select>
                    <label for="period" class="form-label">Chọn thời gian:</label>
                </div>
                <div class="form-floating">
                    <button class="btn btn-success">Lọc</button>
                </div>
            </form>
            <c:if test="${param.year != null}">
                <div class="alert alert-info">
                    <h4>Năm: ${param.year}</h4>
                    <h4>Thời gian: ${param.period}</h4>
                </div>
            </c:if>
        </div>

        <div class="col-md-6 table-container">
            <h3>Doanh thu theo kỳ</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Thời gian</th>
                        <th>Doanh thu</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${revenueByPeriod}" var="p">
                        <tr>
                            <td>${p[0]}</td>
                            <td>${String.format("%,d", p[1])} VNĐ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="col-12 chart-container">
            <canvas id="myChart2"></canvas>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="<c:url value='js/script.js' />"></script>
<script>
    let labels = [];
    let data = [];
    <c:forEach items="${revenueByProducts}" var="p">
        labels.push('${p[1]}');
        data.push(${p[2]});
    </c:forEach>

    let label2 = [];
    let data2 = [];
    <c:forEach items="${revenueByPeriod}" var="p">
        label2.push('${p[0]}');
        data2.push(${p[1]});
    </c:forEach>

    window.onload = function () {
        let ctx1 = document.getElementById("myChart");
        drawChartRevenue(ctx1, labels, data);

        let ctx2 = document.getElementById("myChart2");
        drawChartRevenue(ctx2, label2, data2);
    };
</script>