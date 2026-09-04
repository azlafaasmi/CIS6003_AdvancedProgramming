
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<User> users =
            (List<User>) request.getAttribute("users");

    String successMessage =
            (String) session.getAttribute("successMessage");

    String errorMessage =
            (String) session.getAttribute("errorMessage");

    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");


    // =========================================================
    // Role-Based Dashboard URL
    // =========================================================

    User loggedInUser =
            (User) session.getAttribute("user");

    String dashboardUrl =
            request.getContextPath() + "/login";

    if (loggedInUser != null) {

        String role = loggedInUser.getRole();

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

    <title>User Management - Sunrise Dental Clinic</title>

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

        .page-container {
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

        .page-header {
            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 20px;

            margin-bottom: 25px;

            border-bottom: 3px solid #0d6efd;

            padding-bottom: 18px;
        }

        .page-header h1 {
            margin: 0 0 6px 0;

            color: #0d6efd;

            font-size: 32px;

            font-weight: 700;
        }

        .page-header p {
            margin: 0;

            color: #6c757d;

            font-size: 15px;
        }

        .button-group {
            display: flex;

            gap: 10px;

            flex-wrap: wrap;

            justify-content: flex-end;
        }

        .btn {
            display: inline-block;

            padding: 10px 17px;

            border-radius: 8px;

            text-decoration: none;

            border: none;

            cursor: pointer;

            font-size: 14px;

            font-weight: 600;

            transition: 0.25s;
        }

        .btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 5px 12px rgba(0,0,0,0.15);

            opacity: 0.95;
        }

        .btn-primary {
            background: #0d6efd;

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

        .btn-secondary {
            background: #6c757d;

            color: white;
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

        .table-container {
            overflow-x: auto;

            background: white;

            border-radius: 12px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.08);
        }

        table {
            width: 100%;

            border-collapse: collapse;

            min-width: 800px;
        }

        th,
        td {
            padding: 15px;

            text-align: left;

            border-bottom: 1px solid #dee2e6;
        }

        th {
            background: #0d6efd;

            color: white;

            font-weight: 600;

            font-size: 14px;
        }

        td {
            color: #333;

            font-size: 14px;
        }

        tbody tr {
            transition: 0.2s;
        }

        tbody tr:hover {
            background: #f1f7ff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .role-badge {
            display: inline-block;

            padding: 6px 12px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: bold;

            letter-spacing: 0.3px;
        }

        .role-admin {
            background: #e2e3ff;

            color: #333399;
        }

        .role-receptionist {
            background: #cff4fc;

            color: #055160;
        }

        .actions {
            white-space: nowrap;
        }

        .actions .btn {
            margin-right: 5px;

            margin-bottom: 3px;
        }

        .empty-message {
            text-align: center;

            padding: 35px;

            color: #6c757d;

            font-style: italic;
        }

        .user-count {
            margin-bottom: 15px;

            color: #6c757d;

            font-size: 14px;
        }

        @media (max-width: 768px) {

            .page-container {
                width: 92%;

                margin: 20px auto;

                padding: 22px;
            }

            .page-header {
                flex-direction: column;

                align-items: flex-start;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .button-group {
                width: 100%;

                justify-content: flex-start;
            }

            .btn {
                margin-bottom: 5px;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 800px;
            }
        }

    </style>

</head>

<body>

<div class="page-container">

    <!-- =====================================================
         Page Header
         ===================================================== -->

    <div class="page-header">

        <div>

            <h1>User Management</h1>

            <p>
                Manage system administrators and receptionists.
            </p>

        </div>

        <div class="button-group">

            <a href="<%= dashboardUrl %>"
               class="btn btn-secondary">
                Dashboard
            </a>

            <a href="<%= request.getContextPath() %>/users?action=add"
               class="btn btn-primary">
                + Add User
            </a>

        </div>

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
         User Table
         ===================================================== -->

    <div class="table-container">

        <table>

            <thead>

                <tr>

                    <th>ID</th>

                    <th>Username</th>

                    <th>Full Name</th>

                    <th>Role</th>

                    <th>Created At</th>

                    <th>Actions</th>

                </tr>

            </thead>


            <tbody>

            <% if (users != null && !users.isEmpty()) { %>

                <% for (User user : users) { %>

                    <tr>

                        <td>
                            <%= user.getUserId() %>
                        </td>

                        <td>
                            <%= user.getUsername() %>
                        </td>

                        <td>
                            <%= user.getFullName() %>
                        </td>

                        <td>

                            <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>

                                <span class="role-badge role-admin">
                                    ADMIN
                                </span>

                            <% } else { %>

                                <span class="role-badge role-receptionist">
                                    RECEPTIONIST
                                </span>

                            <% } %>

                        </td>

                        <td>

                            <%= user.getCreatedAt() != null
                                    ? user.getCreatedAt()
                                    : "-" %>

                        </td>

                        <td class="actions">

                            <a href="<%= request.getContextPath() %>/users?action=edit&id=<%= user.getUserId() %>"
                               class="btn btn-warning">
                                Edit
                            </a>

                            <a href="<%= request.getContextPath() %>/users?action=delete&id=<%= user.getUserId() %>"
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete this user?');">
                                Delete
                            </a>

                        </td>

                    </tr>

                <% } %>

            <% } else { %>

                <tr>

                    <td colspan="6"
                        class="empty-message">

                        No users found.

                    </td>

                </tr>

            <% } %>

            </tbody>

        </table>

    </div>

</div>

</body>

</html>

