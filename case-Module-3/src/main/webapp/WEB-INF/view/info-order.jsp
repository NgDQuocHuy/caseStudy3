<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Info Order</title>

    <jsp:include page="/WEB-INF/layout/css_head.jsp">
        <jsp:param name="page" value="info"/>
    </jsp:include>
</head>

<body>

<!-- Begin page -->
<div id="wrapper">

    <!-- Topbar Start -->
    <jsp:include page="/WEB-INF/layout/top_nav_bar.jsp"></jsp:include>
    <!-- end Topbar -->

    <!-- ========== Left Sidebar Start ========== -->
    <jsp:include page="/WEB-INF/layout/left_sidebar.jsp"></jsp:include>
    <!-- Left Sidebar End -->

    <!-- ============================================================== -->
    <!-- Start Page Content here -->
    <!-- ============================================================== -->

    <div class="content-page">
        <div class="content">

            <!-- Start Content-->
            <div class="container-fluid">

                <!-- end page title -->

                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table mb-0">
                                            <thead>
                                            <tr>
                                                <th colspan="3" style="text-align: center" class="font-weight-medium font-24 text-primary">Order Success</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td class="col-4">
                                                    <p class="font-20 font-weight-medium">Customer name</p>
                                                </td>
                                                <td class="col-5">
                                                    <p class="font-20 font-weight-medium text-pink">${orderDetail.getCustomer()}</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <p class="font-20 font-weight-medium">Address</p>
                                                </td>
                                                <td>
                                                    <p class="font-20 font-weight-medium text-pink">${orderDetail.getAddress()}</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <p class="font-20 font-weight-medium">Quantity</p>
                                                </td>
                                                <td>
                                                    <p class="font-20 font-weight-medium text-pink">${orderDetail.getQuantity()}</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <p class="font-20 font-weight-medium">Price</p>
                                                </td>
                                                <td>
                                                    <fmt:setLocale value = "vi_VN"/>
                                                    <p class="font-20 font-weight-medium text-pink"><fmt:formatNumber value = "${orderDetail.getTotalPrice()}" type = "currency"/></p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <p class="font-20 font-weight-medium">Total Price</p>
                                                </td>
                                                <td>
                                                    <p class="font-20 font-weight-medium text-pink"><fmt:formatNumber value = "${orderDetail.getTotalPrice() * orderDetail.getQuantity()}" type = "currency"/></p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <a class="header-title btn btn-primary" href="/products">Back to Home</a>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

            </div> <!-- container-fluid -->

        </div> <!-- content -->

        <!-- Footer Start -->
        <footer class="footer">
            <jsp:include page="/WEB-INF/layout/footer_page.jsp"></jsp:include>
        </footer>
        <!-- end Footer -->
    </div>
    <!-- ============================================================== -->
    <!-- End Page content -->
    <!-- ============================================================== -->
</div>

<c:if test="${requestScope.message != null}">
    <script>
        window.load = function(e){
            <c:set var = "message" scope = "session" value = "${requestScope.message}"/>
            toastr["info"]("${message}");
        }
    </script>
</c:if>
<!-- END wrapper -->

<script>
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
</script>

<jsp:include page="/WEB-INF/layout/js_footer.jsp">
    <jsp:param name="page" value="info"/>
</jsp:include>

</body>
</html>