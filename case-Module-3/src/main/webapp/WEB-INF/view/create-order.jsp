<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Order Infomation</title>

    <jsp:include page="/WEB-INF/layout/css_head.jsp">
        <jsp:param name="page" value="order"/>
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
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
<%--                                <c:if test="${requestScope.errors != null}">--%>
<%--                                    <div class="alert alert-icon alert-danger alert-dismissible fade show mb-0"--%>
<%--                                         role="alert">--%>
<%--                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">--%>
<%--                                            <span aria-hidden="true">×</span>--%>
<%--                                        </button>--%>
<%--                                        <strong>Errors!</strong> <br>--%>
<%--                                        <c:forEach items="${requestScope.errors}" var="item">--%>
<%--                                            <li>${item}</li>--%>
<%--                                        </c:forEach>--%>
<%--                                    </div>--%>
<%--                                </c:if>--%>

                                <div class="form-group row">
                                    <div class="table-responsive">
                                            <table class="table mb-0">
                                                <thead>
                                                    <tr>
                                                        <th colspan="3" style="text-align: center" class="font-weight-medium font-24 text-primary">
                                                            Order Information
                                                        </th>
                                                    </tr>
                                                </thead>
                                            </table>
                                            <table class="table mb-0">
                                                <tbody>
                                                    <tr>
                                                        <td colspan="1" rowspan="6" class="col-3">
                                                            <img style="width: 200px" alt="Img-Product" src="${requestScope['product'].getImg()}"/>
                                                        </td>
                                                        <td class="col-9">
                                                            <form class="form-horizontal" method="post" enctype="multipart/form-data">
                                                                <div class="form-group row">
                                                                    <label class="col-lg-2 col-form-label" for="idProduct">Ma San Pham</label>
                                                                    <div class="col-lg-10">
                                                                        <input type="text" class="form-control" name="idProduct" id="idProduct" value="${requestScope['product'].getId()}" readonly/>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-lg-2 col-form-label">Title</label>
                                                                    <div class="col-lg-10">
                                                                        <input type="text" class="form-control" name="title" id="title" value="${requestScope['product'].getTitle()}" readonly/>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-lg-2 col-form-label" for="price">Price</label>
                                                                    <div class="col-lg-10">
                                                                        <input class="form-control" type="number" name="price" id="price" value="${requestScope['price']}" readonly/>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-lg-2 col-form-label" for="quantity">Quantity</label>
                                                                    <div class="col-lg-10">
                                                                        <select class="btn bg-pink text-white font-18" name="quantity" id="quantity">
                                                                            <c:forEach begin="1" end="${product.getQuantity()}" var="i">
                                                                                <option value="${i}">${i}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-lg-2 col-form-label">Name Custome</label>
                                                                    <div class="col-lg-10">
                                                                        <input class="form-control" type="text" name="customer" id="customer"/>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row">
                                                                    <label class="col-lg-2 col-form-label">Address</label>
                                                                    <div class="col-lg-10">
                                                                        <input class="form-control" type="text" name="address" id="address"/>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group row" style="justify-content: right; margin-top: 10px">
                                                                    <a class="btn btn-warning col-lg-2" href="/products">Back to Home</a>
                                                                    <input class="btn btn-success col-lg-2" style="margin: 0 20px" type="submit" value="Buy"/>
                                                                </div>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                    </div>
                                </div>
                            </div>
                            <!-- end card-box -->
                        </div>
                        <!-- end card-->
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- container-fluid -->
        </div>
        <!-- content -->

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
<c:if test="${requestScope.messagee != null}">
    <script>
        window.onload = function (e) {
            <c:set var = "message" scope = "session" value = "${requestScope.messagee}"/>
            toastr["warning"]("${messagee}");
        }
    </script>
</c:if>
<c:if test="${requestScope.message != null}">
    <script>
        window.onload = function (e) {
            <c:set var = "message" scope = "session" value = "${requestScope.message}"/>
            toastr["info"]("${message}");
        }
    </script>
</c:if>
<!-- END wrapper -->
<jsp:include page="/WEB-INF/layout/right_bar.jsp"></jsp:include>

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
    <jsp:param name="page" value="order"/>
</jsp:include>

</body>
</html>