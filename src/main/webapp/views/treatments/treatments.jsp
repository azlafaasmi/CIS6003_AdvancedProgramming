
<%@ page import="java.util.List" %>
<%@ page import="model.Treatment" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Treatment> treatments =
            (List<Treatment>) request.getAttribute("treatments");

    String searchKeyword =
            (String) request.getAttribute("searchKeyword");

    String successMessage =
            (String) session.getAttribute("successMessage");

    String errorMessage =
            (String) session.getAttribute("errorMessage");

    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");


    // =========================================================
    // Role-Based Dashboard URL
    // =========================================================

    User user = (User) session.getAttribute("user");

    String dashboardUrl =
            request.getContextPath() + "/login";

    if (user != null) {

        String role = user.getRole();

        if ("ADMIN".equalsIgnoreCase(role)) {

            dashboardUrl =
                    request.getContextPath() + "/admin/dashboard";

        } else if ("RECEPTIONIST".equalsIgnoreCase(role)) {

            dashboardUrl =
                    request.getContextPath() + "/receptionist/dashboard";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Treatment Management - Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/assets/css/style.css">

    <style>

        body {
            margin: 0;
            padding: 0;

            font-family: Arial, Helvetica, sans-serif;

            background:
                linear-gradient(
                    rgba(255,255,255,0.90),
                    rgba(240,248,255,0.95)
                ),
                url("https://images.unsplash.com/photo-1606811971618-4486d14f3f99?auto=format&fit=crop&w=1600&q=80");

            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            width: 92%;
            max-width: 1200px;

            margin: 45px auto;
            padding: 35px;

            background: rgba(255,255,255,0.97);

            border-radius: 18px;

            box-shadow:
                0 10px 35px rgba(0,0,0,0.15);

            box-sizing: border-box;
        }

        h1 {
            margin-top: 0;
            margin-bottom: 25px;

            color: #0d6efd;

            font-size: 32px;
            font-weight: 700;

            border-bottom: 3px solid #0d6efd;

            padding-bottom: 12px;
        }

        .mb-3 {
            margin-bottom: 20px;
        }

        .mb-4 {
            margin-bottom: 25px;
        }

        .btn {
            display: inline-block;

            padding: 10px 18px;
            margin-right: 6px;

            border-radius: 8px;

            text-decoration: none;

            font-weight: 600;

            border: none;

            cursor: pointer;

            transition: 0.25s;
        }

        .btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 5px 12px rgba(0,0,0,0.15);
        }

        .btn-primary {
            background: #0d6efd;
            color: white;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-success {
            background: #198754;
            color: white;
        }

        .btn-warning {
            background: #ffc107;
            color: #212529;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .form-control {
            padding: 11px 14px;

            border: 1px solid #ced4da;

            border-radius: 8px;

            font-size: 15px;

            outline: none;

            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: #0d6efd;

            box-shadow:
                0 0 0 3px rgba(13,110,253,0.15);
        }

        .alert {
            padding: 14px 18px;

            margin-bottom: 20px;

            border-radius: 8px;

            font-weight: 600;
        }

        .alert-success {
            background: #d1e7dd;

            color: #0f5132;

            border: 1px solid #badbcc;
        }

        .alert-danger {
            background: #f8d7da;

            color: #842029;

            border: 1px solid #f5c2c7;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;

            border-radius: 10px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.08);
        }

        .table {
            width: 100%;

            border-collapse: collapse;

            background: white;

            overflow: hidden;
        }

        .table thead {
            background: #0d6efd;
            color: white;
        }

        .table th {
            padding: 15px;

            text-align: left;

            font-size: 15px;
        }

        .table td {
            padding: 14px;

            border-bottom: 1px solid #e9ecef;

            color: #333;
        }

        .table tbody tr:hover {
            background: #f1f7ff;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .empty-message {
            text-align: center;

            padding: 25px !important;

            color: #6c757d !important;

            font-style: italic;
        }

        .price {
            font-weight: 600;

            color: #198754;
        }

        .actions {
            white-space: nowrap;
        }

        @media (max-width: 768px) {

            .container {
                width: 92%;

                margin: 20px auto;

                padding: 22px;
            }

            h1 {
                font-size: 25px;
            }

            .form-control {
                width: 100% !important;

                margin-bottom: 10px;
            }

            .table-wrapper {
                overflow-x: auto;
            }

            .table {
                min-width: 700px;
            }

            .btn {
                margin-bottom: 6px;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <!-- =====================================================
         Header
         ===================================================== -->

    <h1>Treatment Management</h1>

    <div class="mb-3">

        <a href="<%= dashboardUrl %>"
           class="btn btn-secondary">
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/treatments?action=add"
           class="btn btn-primary">
            Add Treatment
        </a>

    </div>


    <!-- =====================================================
         Success Message
         ===================================================== -->

    <% if (successMessage != null) { %>

        <div class="alert alert-success">
            <%= successMessage %>
        </div>

    <% } %>


    <!-- =====================================================
         Error Message
         ===================================================== -->

    <% if (errorMessage != null) { %>

        <div class="alert alert-danger">
            <%= errorMessage %>
        </div>

    <% } %>


    <!-- =====================================================
         Search
         ===================================================== -->

    <form method="get"
          action="<%= request.getContextPath() %>/treatments"
          class="mb-4">

        <input type="hidden"
               name="action"
               value="search">

        <input type="text"
               name="keyword"
               placeholder="Search treatment..."
               value="<%= searchKeyword != null ? searchKeyword : "" %>"
               class="form-control"
               style="display:inline-block; width:300px;">

        <button type="submit"
                class="btn btn-success">
            Search
        </button>

        <a href="<%= request.getContextPath() %>/treatments"
           class="btn btn-secondary">
            Clear
        </a>

    </form>


    <!-- =====================================================
         Treatment Table
         ===================================================== -->

    <div class="table-wrapper">

        <table class="table">

            <thead>

            <tr>

                <th>ID</th>

                <th>Treatment Name</th>

                <th>Price (LKR)</th>

                <th>Actions</th>

            </tr>

            </thead>


            <tbody>

            <% if (treatments != null && !treatments.isEmpty()) { %>

                <% for (Treatment treatment : treatments) { %>

                    <tr>

                        <td>
                            <%= treatment.getTreatmentId() %>
                        </td>

                        <td>
                            <%= treatment.getTreatmentName() %>
                        </td>

                        <td class="price">
                            LKR <%= treatment.getTreatmentPrice() %>
                        </td>

                        <td class="actions">

                            <a href="<%= request.getContextPath() %>/treatments?action=edit&id=<%= treatment.getTreatmentId() %>"
                               class="btn btn-warning">
                                Edit
                            </a>

                            <a href="<%= request.getContextPath() %>/treatments?action=delete&id=<%= treatment.getTreatmentId() %>"
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete this treatment?');">
                                Delete
                            </a>

                        </td>

                    </tr>

                <% } %>

            <% } else { %>

                <tr>

                    <td colspan="4"
                        class="empty-message">
                        No treatments found.
                    </td>

                </tr>

            <% } %>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>

