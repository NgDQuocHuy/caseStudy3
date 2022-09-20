<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>List Product</title>

  <jsp:include page="/WEB-INF/layout/css_head.jsp">
    <jsp:param name="page" value="index"/>
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
  <jsp:param name="page" value="index"/>
</jsp:include>
</body>
</html>