<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Vendor js -->
<script src="/assets\js\vendor.min.js"></script>

<c:if test="${param.page == 'delete'}">
    <!-- Sweet Alerts js -->
    <script src="/assets\libs\sweetalert2\sweetalert2.min.js"></script>

    <!-- Sweet alert init js-->
    <script src="/assets\js\pages\sweet-alerts.init.js"></script>
</c:if>

    <c:if test="${param.page == 'index'}">
    <!-- Chart JS -->
    <script src="/assets\libs\chart-js\Chart.bundle.min.js"></script>

    <!-- Sparkline charts -->
    <script src="/assets\libs\jquery-sparkline\jquery.sparkline.min.js"></script>

    <!-- Dashboard js -->
    <script src="/assets\js\pages\dashboard.init.js"></script>
</c:if>

<!-- Toastr js -->
<script src="/assets\libs\toastr\toastr.min.js"></script>

<script src="/assets\js\pages\toastr.init.js"></script>

<!-- App js -->
<script src="/assets\js\app.min.js"></script>