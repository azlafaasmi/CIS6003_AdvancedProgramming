<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>
<%@ page import="model.User" %>

<%
    List<Patient> patients =
            (List<Patient>) request.getAttribute("patients");

    String searchKeyword =
            (String) request.getAttribute("searchKeyword");

    if (patients == null) {
        patients = new java.util.ArrayList<Patient>();
    }

    if (searchKeyword == null) {
        searchKeyword = "";
    }

    String successMessage =
            (String) session.getAttribute("successMessage");

    String errorMessage =
            (String) session.getAttribute("errorMessage");

    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");


    // =====================================================
    // Role-based Dashboard URL
    // =====================================================

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

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Patients - Sunrise Dental Clinic</title>


    <!-- Main CSS -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">


    <style>

        body {
            background: #f4f7fb;
        }


        .page-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }


        /* =====================================================
           Page Header
           ===================================================== */

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }


        .page-header h1 {
            margin-bottom: 5px;
        }


        .page-header p {
            margin-top: 0;
            color: #777;
        }


        /* =====================================================
           Card
           ===================================================== */

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;

            box-shadow:
                0 5px 20px rgba(0, 0, 0, 0.08);
        }


        /* =====================================================
           Top Actions / Search
           ===================================================== */

        .top-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
        }


        .search-form {
            display: flex;
            gap: 8px;
            flex: 1;
            max-width: 600px;
        }


        .search-form input {
            flex: 1;
            padding: 11px 14px;

            border: 1px solid #ccc;
            border-radius: 6px;

            font-size: 15px;
        }


        /* =====================================================
           Buttons
           ===================================================== */

        .btn {
            display: inline-block;

            padding: 9px 14px;

            border: none;
            border-radius: 6px;

            font-size: 14px;
            font-weight: 600;

            cursor: pointer;

            text-decoration: none;

            transition: 0.2s;
        }


        .btn-primary {
            background: #2c7be5;
            color: white;
        }


        .btn-primary:hover {
            background: #1a68d1;
        }


        .btn-success {
            background: #198754;
            color: white;
            text-decoration: none;
        }


        .btn-success:hover {
            background: #146c43;
        }


        .btn-warning {
            background: #ffc107;
            color: #212529;
            text-decoration: none;
        }


        .btn-warning:hover {
            background: #e0a800;
        }


        .btn-danger {
            background: #dc3545;
            color: white;
            text-decoration: none;
        }


        .btn-danger:hover {
            background: #bb2d3b;
        }


        .btn-light {
            background: #e9ecef;
            color: #212529;
            text-decoration: none;
        }


        .btn-light:hover {
            background: #d3d7db;
        }


        .btn-secondary {
            background: #6c757d;
            color: white;
            text-decoration: none;
        }


        .btn-secondary:hover {
            background: #5c636a;
        }


        /* =====================================================
           Table
           ===================================================== */

        .table-container {
            overflow-x: auto;
        }


        table {
            width: 100%;
            border-collapse: collapse;
        }


        th,
        td {
            padding: 13px 12px;

            text-align: left;

            border-bottom: 1px solid #eee;
        }


        th {
            background: #f8f9fa;

            font-weight: bold;

            color: #333;
        }


        tr:hover {
            background: #fafafa;
        }


        /* =====================================================
           Action Buttons
           ===================================================== */

        .actions {
            white-space: nowrap;
        }


        .actions .btn {
            margin-right: 5px;

            padding: 7px 10px;

            font-size: 13px;
        }


        /* =====================================================
           Alerts
           ===================================================== */

        .alert {
            margin-bottom: 20px;

            padding: 13px 16px;

            border-radius: 6px;
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


        /* =====================================================
           Empty State
           ===================================================== */

        .empty-state {
            text-align: center;

            padding: 50px 20px;

            color: #777;
        }


        .empty-state h3 {
            color: #555;

            margin-bottom: 10px;
        }


        /* =====================================================
           Patient Count
           ===================================================== */

        .patient-count {
            margin-bottom: 15px;

            color: #666;
        }


        /* =====================================================
           Bottom Actions
           ===================================================== */

        .bottom-actions {
            margin-top: 20px;

            margin-bottom: 25px;

            text-align: left;
        }


        /* =====================================================
           Responsive Design
           ===================================================== */

        @media (max-width: 700px) {

            .page-header {
                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }


            .top-actions {
                flex-direction: column;

                align-items: stretch;
            }


            .search-form {
                max-width: none;
            }


            .actions .btn {
                display: inline-block;

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

            <h1>
                Patient Management
            </h1>

            <p>
                Manage Sunrise Dental Clinic patients.
            </p>

        </div>


        <!-- Add Patient -->

        <a href="${pageContext.request.contextPath}/patients?action=add"
           class="btn btn-success">

            + Add Patient

        </a>

    </div>


    <!-- =====================================================
         Dashboard Button
         ===================================================== -->

    <div class="bottom-actions">

        <a href="<%= dashboardUrl %>"
           class="btn btn-secondary">

            Back to Dashboard

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
         Patient Card
         ===================================================== -->

    <div class="card">


        <!-- =================================================
             Search
             ================================================= -->

        <div class="top-actions">

            <form method="get"
                  action="${pageContext.request.contextPath}/patients"
                  class="search-form">


                <input type="hidden"
                       name="action"
                       value="search">


                <input type="text"
                       name="keyword"
                       placeholder="Search by name, phone or email..."
                       value="<%= searchKeyword %>">


                <button type="submit"
                        class="btn btn-primary">

                    Search

                </button>


                <% if (!searchKeyword.isBlank()) { %>

                    <a href="${pageContext.request.contextPath}/patients"
                       class="btn btn-light">

                        Clear

                    </a>

                <% } %>


            </form>

        </div>


        <!-- =================================================
             Patient Count
             ================================================= -->

        <div class="patient-count">

            <strong>
                <%= patients.size() %>
            </strong>

            patient(s) found.

        </div>


        <!-- =================================================
             Empty State
             ================================================= -->

        <% if (patients.isEmpty()) { %>


            <div class="empty-state">

                <h3>
                    No patients found
                </h3>


                <% if (!searchKeyword.isBlank()) { %>

                    <p>

                        No patients matched
                        "<%= searchKeyword %>".

                    </p>

                <% } else { %>

                    <p>

                        There are currently no patients
                        registered.

                    </p>

                <% } %>


                <a href="${pageContext.request.contextPath}/patients?action=add"
                   class="btn btn-primary">

                    Add First Patient

                </a>

            </div>


        <% } else { %>


            <!-- =================================================
                 Patient Table
                 ================================================= -->

            <div class="table-container">

                <table>


                    <thead>

                    <tr>

                        <th>
                            ID
                        </th>

                        <th>
                            Patient Name
                        </th>

                        <th>
                            Address
                        </th>

                        <th>
                            Contact Number
                        </th>

                        <th>
                            Email
                        </th>

                        <th>
                            Actions
                        </th>

                    </tr>

                    </thead>


                    <tbody>


                    <% for (Patient patient : patients) { %>


                        <tr>


                            <!-- Patient ID -->

                            <td>

                                <%= patient.getPatientId() %>

                            </td>


                            <!-- Patient Name -->

                            <td>

                                <strong>

                                    <%= patient.getPatientName() %>

                                </strong>

                            </td>


                            <!-- Address -->

                            <td>

                                <%= patient.getAddress() %>

                            </td>


                            <!-- Contact Number -->

                            <td>

                                <%= patient.getContactNumber() %>

                            </td>


                            <!-- Email -->

                            <td>

                                <%= patient.getEmail() != null
                                        && !patient.getEmail().isBlank()
                                        ? patient.getEmail()
                                        : "-" %>

                            </td>


                            <!-- Actions -->

                            <td class="actions">


                                <!-- =================================
                                     Edit Patient
                                     ================================= -->

                                <a href="${pageContext.request.contextPath}/patients?action=edit&id=<%= patient.getPatientId() %>"
                                   class="btn btn-warning">

                                    Edit

                                </a>


                                <!-- =================================
                                     Delete Patient
                                     ================================= -->

                                <a href="${pageContext.request.contextPath}/patients?action=delete&id=<%= patient.getPatientId() %>"
                                   class="btn btn-danger"
                                   onclick='return confirmDelete("<%= patient.getPatientName()
                                           .replace("\\", "\\\\")
                                           .replace("\"", "\\\"")
                                           .replace("\r", "\\r")
                                           .replace("\n", "\\n") %>");'>

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


</div>


<!-- =========================================================
     Delete Confirmation JavaScript
     ========================================================= -->

<script>

    function confirmDelete(patientName) {

        return confirm(
            "Are you sure you want to delete patient '" +
            patientName +
            "'?"
        );

    }

</script>


</body>

</html>