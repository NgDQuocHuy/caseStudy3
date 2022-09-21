<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Order</title>

    <jsp:include page="/WEB-INF/layout/css_head.jsp">
        <jsp:param name="page" value="view"/>
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
                                <a class="header-title btn btn-primary" href="/products?action=orderlist">Back to Home</a>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table mb-0">
                                            <thead>
                                            <tr>
                                                <th colspan="3" style="text-align: center" class="font-weight-medium font-24 text-primary">Order Infomation</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td colspan="1" rowspan="6" class="col-3">
                                                    <img style="width: 200px" alt="Img-Product" src="${product.getImg()}">
                                                </td>
                                                <td class="col-4">
                                                    <p class="font-20 font-weight-medium">Name Customer</p>
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
                                                    <p class="font-20 font-weight-medium">Time Create Order</p>
                                                </td>
                                                <td>
                                                    <p class="font-20 font-weight-medium text-pink">${orderDetail.getTimeCreat()}</p>
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
                                                    <p class="font-20 font-weight-medium text-pink"><fmt:formatNumber value = "${product.getPrice()}" type = "currency"/></p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <p class="font-20 font-weight-medium">Total Price</p>
                                                </td>
                                                <td>
                                                    <p class="font-20 font-weight-medium text-pink"><fmt:formatNumber value = "${orderDetail.getTotalPrice()}" type = "currency"/></p>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
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
<!-- END wrapper -->
<jsp:include page="/WEB-INF/layout/right_bar.jsp"></jsp:include>

<jsp:include page="/WEB-INF/layout/js_footer.jsp">
    <jsp:param name="page" value="view"/>
</jsp:include>

</body>
</html>