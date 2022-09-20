<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Product</title>

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
                                <a class="header-title btn btn-primary" href="/products">Back to Home</a>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table mb-0">
                                            <thead>
                                            <tr>
                                                <th colspan="3" style="text-align: center" class="font-weight-medium font-24 text-primary">Product Infomation</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td colspan="1" rowspan="5" class="col-3">
                                                        <img style="width: 200px" alt="Img-Product" src="${product.getImg()}">
                                                    </td>
                                                    <td class="col-4">
                                                        <p class="font-20 font-weight-medium"># ${product.getId()}</p>
                                                    </td>
                                                    <td class="col-5">
                                                        <p class="font-20 font-weight-medium text-pink">${product.getTitle()}</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <p class="font-20 font-weight-medium">Price</p>
                                                    </td>
                                                    <td>
                                                        <p class="font-20 font-weight-medium text-pink">${product.getPrice()}</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <p class="font-20 font-weight-medium">Quantity</p>
                                                    </td>
                                                    <td>
                                                        <p class="font-20 font-weight-medium text-pink">${product.getQuantity()}</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <p class="font-18">${product.getInfo()}</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        <a class="btn btn-success font-20" href="/products?action=order&id=${product.getId()}">
                                                            <i class="mdi mdi-cart-plus"></i>Buy
                                                        </a>
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