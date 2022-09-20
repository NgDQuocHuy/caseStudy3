<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>List Order</title>

  <jsp:include page="/WEB-INF/layout/css_head.jsp">
    <jsp:param name="page" value="listorder"/>
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
            <div class="input-group-append">
              <input name="action" hidden value="orderlist" />
              <select class="btn btn-secondary text-warning" name="date" id="date">
                <option class="bg-dark text-warning" value="-1">All</option>
                <c:forEach var = "i" begin = "1" end = "31">
                  <c:choose>
                    <c:when test="${i == requestScope.date}">
                      <option selected class="bg-dark text-warning" value="${i}">Ngày ${i}</option>
                    </c:when>
                    <c:otherwise>
                      <option class="bg-dark text-warning" value="${i}">Ngày ${i}</option>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </select>
            </div>
            <div class="input-group-append">
              <select class="btn btn-secondary text-warning" name="month" id="month">
                <option class="bg-dark text-warning" value="-1">All</option>
                <c:forEach var = "i" begin = "1" end = "12">
                  <c:choose>
                    <c:when test="${i == requestScope.month}">
                      <option selected class="bg-dark text-warning" value="${i}">Tháng ${i}</option>
                    </c:when>
                    <c:otherwise>
                      <option class="bg-dark text-warning" value="${i}">Tháng ${i}</option>
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
              <h4 class="page-title">List Order</h4>
            </div>
          </div>
        </div>
        <!-- end page title -->

        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-body">
                <div class="table-responsive mt-3">
                  <table class="table table-hover table-centered mb-0">
                    <thead>
                    <tr>
                      <th>Code Order</th>
                      <th>Information</th>
                      <th>Price</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope['orderDetails']}" var="orderDetail">
                      <tr>
                        <td>
                          <div class="overflow-hidden">
                            <p class="mb-0 font-weight-light font-24"># <a href="/products?action=vieworder&id=${orderDetail.getIdOrder()}">${orderDetail.getIdOrder()}</a></p>
                            <span class="font-15">${orderDetail.getTimeCreat()}</span>
                          </div>
                        </td>
                        <td>
                          <div class="overflow-hidden">
                            <p class="mb-0 font-weight-light font-24"><a href="/products?action=vieworder&id=${orderDetail.getIdOrder()}">${orderDetail.getCustomer()}</a></p>
                            <span class="font-15">${orderDetail.getAddress()}</span>
                          </div>
                        </td>
                        <td>
                          <p class="font-22 font-weight-light">${orderDetail.getTotalPrice()}</p>
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
                  <a href="products?action=orderlist&page=${page - 1}&date=${requestScope.date}&month=${requestScope.month}" aria-controls="basic-datatable" data-dt-idx="0" tabindex="0" class="page-link">
                    <i class="mdi mdi-chevron-left"></i>
                  </a>
                </li>
              </c:if>
              <c:forEach begin="1" end="${noOfPages}" var="i">
                <c:choose>
                  <c:when test="${page == i}">
                    <li class="paginate_button page-item active">
                      <a href="products?action=orderlist&page=${i}&date=${requestScope.date}&month=${requestScope.month}" aria-controls="basic-datatable" data-dt-idx="1" tabindex="0" class="page-link">${i}</a>
                    </li>
                  </c:when>
                  <c:otherwise>
                    <li class="paginate_button page-item">
                      <a href="products?action=orderlist&page=${i}&date=${requestScope.date}&month=${requestScope.month}" aria-controls="basic-datatable" data-dt-idx="1" tabindex="0" class="page-link">${i}</a>
                    </li>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
              <c:if test="${page < noOfPages}">
                <li class="paginate_button page-item next" id="basic-datatable_next">
                  <a href="products?action=orderlist&page=${page + 1}&date=${requestScope.date}&month=${requestScope.month}" aria-controls="basic-datatable" data-dt-idx="7" tabindex="0" class="page-link">
                    <i class="mdi mdi-chevron-right"></i>
                  </a>
                </li>
              </c:if>
            </ul>
          </div>
        </div>
        <!-- end row -->

      </div>
      <!-- container-fluid -->

    </div> <!-- content -->

    <!-- Footer Start -->
    <footer class="footer">
      <jsp:include page="/WEB-INF/layout/footer_page.jsp"></jsp:include>
    </footer>
    <!-- end Footer -->
  </div>
  <!-- =========================================================== -->
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