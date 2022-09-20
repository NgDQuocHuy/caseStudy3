<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>QH Store</title>

        <jsp:include page="/WEB-INF/layout/css_head.jsp">
            <jsp:param name="page" value="index"/>
        </jsp:include>
    </head>

    <body>

        <!-- Begin page -->
        <div id="wrapper">
            <!-- Topbar Start -->
            <div class="navbar-custom">
                <form action="/products">
                    <ul class="list-unstyled topnav-menu float-right mb-0">
                        <li class="app-search d-none d-lg-block">
                            <div class="input-group">
                                <input type="text" hint="search" name="search" value="${requestScope.search}"
                                       class="form-control" placeholder="Search...">
                                <div class="input-group-append">
                                    <select class="btn btn-secondary text-warning" name="idType" id="idType">
                                        <option class="bg-dark text-warning" value="-1">All</option>
                                        <c:forEach items="${requestScope['types']}" var="type">
                                            <c:choose>
                                                <c:when test="${type.getIdType() == requestScope.idType}">
                                                    <option selected class="bg-dark text-warning"
                                                            value="${type.getIdType()}">${type.getType()}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option class="bg-dark text-warning"
                                                            value="${type.getIdType()}">${type.getType()}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                    <button class="btn btn-primary" type="get">
                                        <i class="fe-search"></i>
                                    </button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </form>
            </div>

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
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">
                                    <h4 class="page-title">List Product</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <a class="header-title btn btn-primary" href="/products?action=create">Add new Product</a>

                                        <div class="table-responsive mt-3">
                                            <table class="table table-hover table-centered mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Product</th>
                                                        <th>Price</th>
                                                        <th>Quantity</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${requestScope['products']}" var="product">
                                                    <tr>
                                                        <td>
                                                            <p class="font-22 font-weight-light"class="font-22 font-weight-light">${product.getId()}</p>
                                                        </td>
                                                        <td>
                                                            <img src="${product.getImg()}" alt="product-img" height="80px" title="product-img" class="float-left mr-5">
                                                            <div class="overflow-hidden">
                                                                <p class="mb-0 font-weight-light font-24"><a href="/products?action=view&id=${product.getId()}">${product.getTitle()}</a></p>
                                                                <c:forEach items="${requestScope['types']}" var="type">
                                                                    <c:if test="${product.getIdType() == type.getIdType()}">
                                                                        <span class="font-15">${type.getType()}</span>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <p class="font-22 font-weight-light">${product.getPrice()}</p>
                                                        </td>
                                                        <td>
                                                            <p class="font-22 font-weight-light">${product.getQuantity()}</p>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group dropdown">
                                                                <a href="javascript: void(0);" class="dropdown-toggle arrow-none btn btn-light btn-sm font-20" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
                                                                <div class="dropdown-menu dropdown-menu-right">
                                                                    <a class="dropdown-item" href="/products?action=edit&id=${product.getId()}"><i class="mdi mdi-pencil mr-1 text-muted"></i>Edit</a>
                                                                    <a class="dropdown-item" href="/products?action=delete&id=${product.getId()}"><i class="mdi mdi-delete mr-1 text-muted"></i>Remove</a>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="justify-content: center">
                            <div class="dataTables_paginate paging_simple_numbers" id="basic-datatable_paginate">
                                    <ul class="pagination pagination-rounded">
                                        <c:if test="${page != 1}">
                                            <li class="paginate_button page-item previous disabled" id="basic-datatable_previous">
                                                <a href="products?page=${page - 1}&search=${requestScope.search}&idType=${requestScope.idType}" aria-controls="basic-datatable" data-dt-idx="0" tabindex="0" class="page-link">
                                                    <i class="mdi mdi-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="1" end="${noOfPages}" var="i">
                                            <c:choose>
                                                <c:when test="${page == i}">
                                                    <li class="paginate_button page-item active">
                                                        <a href="products?page=${i}&search=${requestScope.search}&idType=${requestScope.idType}" aria-controls="basic-datatable" data-dt-idx="1" tabindex="0" class="page-link">${i}</a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="paginate_button page-item">
                                                        <a href="products?page=${i}&search=${requestScope.search}&idType=${requestScope.idType}" aria-controls="basic-datatable" data-dt-idx="1" tabindex="0" class="page-link">${i}</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:if test="${page < noOfPages}">
                                            <li class="paginate_button page-item next" id="basic-datatable_next">
                                                <a href="products?page=${page + 1}&search=${requestScope.search}&idType=${requestScope.idType}" aria-controls="basic-datatable" data-dt-idx="7" tabindex="0" class="page-link">
                                                    <i class="mdi mdi-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
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

        <jsp:include page="/WEB-INF/layout/js_footer.jsp">
            <jsp:param name="page" value="index"/>
        </jsp:include>
    </body>
</html>