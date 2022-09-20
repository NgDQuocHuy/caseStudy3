<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description">
<meta content="Coderthemes" name="author">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- App favicon -->
<link rel="shortcut icon" href="/assets\images\favicon.ico">

<c:if test="${param.page == 'delete'}">
    <!-- Sweet Alert-->
    <link href="/assets\libs\sweetalert2\sweetalert2.min.css" rel="stylesheet" type="text/css">
</c:if>

<!-- Notification css (Toastr) -->
<link href="/assets\libs\toastr\toastr.min.css" rel="stylesheet" type="text/css">
<!-- App css -->
<link href="/assets\css\bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="/assets\css\icons.min.css" rel="stylesheet" type="text/css">
<link href="/assets\css\app.min.css" rel="stylesheet" type="text/css">