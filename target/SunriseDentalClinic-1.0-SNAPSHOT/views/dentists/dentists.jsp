
<%@ page import="java.util.List" %>
<%@ page import="model.Dentist" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Dentist> dentists =
            (List<Dentist>) request.getAttribute("dentists");

    String searchKeyword =
            (String) request.getAttribute("searchKeyword");

    if (searchKeyword == null) {
        searchKeyword = "";
    }

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

    <title>
        Dentist Management - Sunrise Dental Clinic
    </title>

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

        .button {
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

        .button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 5px 12px rgba(0,0,0,0.15);

            opacity: 0.95;
        }

        .primary {
            background: #0d6efd;

            color: white;
        }

        .back {
            background: #6c757d;

            color: white;
        }

        .edit {
            background: #ffc107;

            color: #212529;
        }

        .delete {
            background: #dc3545;

            color: white;
        }

        .search-form {
            display: flex;

            gap: 10px;

            margin-bottom: 25px;
        }

        .search-form input {
            flex: 1;

            padding: 12px 14px;

            border: 1px solid #ced4da;

            border-radius: 8px;

            font-size: 15px;

            outline: none;

            box-sizing: border-box;
        }

        .search-form input:focus {
            border-color: #0d6efd;

            box-shadow:
                0 0 0 3px rgba(13,110,253,0.15);
        }

        .search-form button {
            padding: 10px 22px;

            border: none;

            border-radius: 8px;

            background: #198754;

            color: white;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            transition: 0.25s;
        }

        .search-form button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 5px 12px rgba(0,0,0,0.15);
        }

        .message {
            padding: 14px 18px;

            margin-bottom: 20px;

            border-radius: 8px;

            font-weight: 600;
        }

        .success {
            background: #d1e7dd;

            color: #0f5132;

            border: 1px solid #badbcc;
        }

        .error {
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

            min-width: 750px;

            border-collapse: collapse;
        }

        th,
        td {
            padding: 15px;

            border-bottom: 1px solid #dee2e6;

            text-align: left;
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

        .dentist-name {
            font-weight: 600;

            color: #212529;
        }

        .specialization {
            color: #0d6efd;

            font-weight: 500;
        }

        .contact {
            color: #495057;
        }

        .actions {
            white-space: nowrap;
        }

        .actions .button {
            margin-right: 5px;

            margin-bottom: 3px;
        }

        .empty-message {
            text-align: center;

            padding: 35px;

            color: #6c757d;

            font-style: italic;
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

            .search-form {
                flex-direction: column;
            }

            .search-form input {
                width: 100%;
            }

            .search-form button {
                width: fit-content;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 750px;
            }

            .button {
                margin-bottom: 5px;
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

            <h1>Dentist Management</h1>

            <p>
                Manage dentists, specializations and contact details.
            </p>

        </div>

        <div class="button-group">

            <a class="button back"
               href="<%= dashboardUrl %>">
                Dashboard
            </a>

            <a class="button primary"
               href="<%= request.getContextPath() %>/dentists?action=add">
                + Add Dentist
            </a>

        </div>

    </div>


    <!-- =====================================================
         Success Message
         ===================================================== -->

    <% if (successMessage != null) { %>

        <div class="message success">
            <%= successMessage %>
        </div>

    <% } %>


    <!-- =====================================================
         Error Message
         ===================================================== -->

    <% if (errorMessage != null) { %>

        <div class="message error">
            <%= errorMessage %>
        </div>

    <% } %>


    <!-- =====================================================
         Search
         ===================================================== -->

    <form class="search-form"
          method="get"
          action="<%= request.getContextPath() %>/dentists">

        <input type="hidden"
               name="action"
               value="search">

        <input type="text"
               name="keyword"
               placeholder="Search by name, specialization or contact number"
               value="<%= searchKeyword %>">

        <button type="submit">
            Search
        </button>

    </form>


    <!-- =====================================================
         Dentist Table
         ===================================================== -->

    <% if (dentists == null || dentists.isEmpty()) { %>

        <div class="table-container">

            <p class="empty-message">
                No dentists found.
            </p>

        </div>

    <% } else { %>

        <div class="table-container">

            <table>

                <thead>

                <tr>

                    <th>ID</th>

                    <th>Dentist Name</th>

                    <th>Specialization</th>

                    <th>Contact Number</th>

                    <th>Actions</th>

                </tr>

                </thead>


                <tbody>

                <% for (Dentist dentist : dentists) { %>

                    <tr>

                        <td>
                            <%= dentist.getDentistId() %>
                        </td>

                        <td class="dentist-name">
                            <%= dentist.getDentistName() %>
                        </td>

                        <td class="specialization">
                            <%= dentist.getSpecialization() %>
                        </td>

                        <td class="contact">
                            <%= dentist.getContactNumber() %>
                        </td>

                        <td class="actions">

                            <a class="button edit"
                               href="<%= request.getContextPath() %>/dentists?action=edit&id=<%= dentist.getDentistId() %>">
                                Edit
                            </a>

                            <a class="button delete"
                               href="<%= request.getContextPath() %>/dentists?action=delete&id=<%= dentist.getDentistId() %>"
                               onclick="return confirm('Are you sure you want to delete this dentist?');">
                                Delete
                            </a>

                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>

    <% } %>

</div>

</body>

</html>
