<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Product</title>

    <jsp:include page="/WEB-INF/layout/css_head.jsp">
        <jsp:param name="page" value="edit"/>
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

                <!-- start page title -->
                <div class="row" style="margin-top: 20px">
                    <div class="col-12">
                        <div class="page-title-box" style="margin-bottom: 20px">
                            <a class="btn btn-warning" href="/products">Back to Home</a>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h3 class="text-primary">Input Infomation Product</h3>
                                <p class="sub-header">
                                    Please enter new product information. When you update new infomation please click <code class="text-danger font-15">Save</code> or if you don't want to update please press <code class="text-warning font-15">Back to Home</code>. <code class="font-15">Title</code>, <code class="font-15">Type</code>, <code class="font-15">Price</code>, and <code class="font-15">Quantity</code> are <code class="text-danger font-15">Required!!</code>.
                                </p>
                                <c:if test="${requestScope.errors != null}">
                                    <div class="alert alert-icon alert-danger alert-dismissible fade show mb-0"
                                         role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                        <strong>Errors!</strong> <br>
                                        <c:forEach items="${requestScope.errors}" var="item">
                                            <li>${item}</li>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <form class="form-horizontal" method="post" enctype="multipart/form-data">
                                    <div class="form-group row">
                                        <label class="col-lg-2 col-form-label" for="title">Title</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control" name="title" id="title" value="${requestScope['product'].getTitle()}" placeholder="Input title..."/>
                                        </div>
                                    </div>



                                    <div class="form-group row">
                                        <label class="col-lg-2 col-form-label">Type Product</label>
                                        <div class="col-lg-10">
                                            <select class="form-control" name="type" id="type">
                                                <c:forEach items="${requestScope['types']}" var="type">
                                                    <c:choose>
                                                        <c:when test="${type.getIdType() == requestScope['product'].getIdType()}">
                                                            <option selected value="${type.getIdType()}">${type.getType()}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${type.getIdType()}">${type.getType()}</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-lg-2 col-form-label" for="price">Price</label>
                                        <div class="col-lg-10">
                                            <input class="form-control" type="number" name="price" id="price" value="${requestScope['product'].getPrice()}" placeholder="Input price..."/>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-lg-2 col-form-label" for="quantity">Quantity</label>
                                        <div class="col-lg-10">
                                            <input class="form-control" type="number" name="quantity" id="quantity" value="${requestScope['product'].getQuantity()}" placeholder="Input quantity..."/>
                                        </div>
                                    </div>

                                    <div class="form-group row mb-0">
                                        <label class="col-lg-2 col-form-label">Image</label>
                                        <div class="col-lg-10">
                                            <input class="form-control" type="file" name="file" id="file" value="${requestScope['product'].getImg()}" placeholder="Input url img..."/>
                                        </div>
                                    </div>

                                    <div class="form-group row" style="margin-top: 16px">
                                        <label class="col-lg-2 col-form-label" for="info">Infomation</label>
                                        <div class="col-lg-10">
                                            <input class="form-control" rows="5" id="info" name="info" value="${requestScope['product'].getInfo()}" placeholder="Information Product..."/>
                                        </div>
                                    </div>

                                    <div class="form-group row" style="justify-content: right">
                                        <a class="btn btn-warning col-lg-2" href="/products">Back to Home</a>
                                        <input class="btn btn-primary col-lg-2" style="margin: 0 20px" type="submit" value="Save">
                                    </div>
                                </form>

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
        window.onload = function(e){
            <c:set var = "message" scope = "session" value = "${requestScope.messagee}"/>
            toastr["warning"]("${messagee}");
        }
    </script>
</c:if>
<c:if test="${requestScope.message != null}">
    <script>
        window.onload = function(e){
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
    <jsp:param name="page" value="edit"/>
</jsp:include>

</body>
</html>