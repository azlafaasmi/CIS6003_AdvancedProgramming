<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.User" %>

<%
List<Appointment> appointments =
(List<Appointment>) request.getAttribute("appointments");

String searchKeyword =
        (String) request.getAttribute("searchKeyword");

if (appointments == null) {
    appointments = new java.util.ArrayList<Appointment>();
}


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

<title>Appointments - Sunrise Dental Clinic</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/style.css">

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
        max-width: 1400px;

        margin: 40px auto;

        padding: 30px;

        background: rgba(255,255,255,0.97);

        border-radius: 18px;

        box-shadow:
            0 10px 35px rgba(0,0,0,0.15);
    }

    .page-header {
        display: flex;

        justify-content: space-between;

        align-items: center;

        margin-bottom: 25px;

        flex-wrap: wrap;

        gap: 15px;
    }

    .page-header h2 {
        margin: 0;

        color: #0d6efd;

        font-size: 30px;
    }

    .page-header p {
        margin: 7px 0 0;

        color: #666;

        font-size: 15px;
    }

    .card {
        background: #ffffff;

        border-radius: 12px;

        padding: 25px;

        box-shadow:
            0 4px 15px rgba(0,0,0,0.08);
    }

    .toolbar {
        display: flex;

        justify-content: space-between;

        gap: 15px;

        margin-bottom: 20px;

        flex-wrap: wrap;
    }

    .search-form {
        display: flex;

        gap: 8px;

        flex: 1;

        max-width: 600px;
    }

    .search-input {
        flex: 1;

        padding: 11px 14px;

        border: 1px solid #ced4da;

        border-radius: 8px;

        font-size: 14px;

        outline: none;
    }

    .search-input:focus {
        border-color: #0d6efd;

        box-shadow:
            0 0 0 3px rgba(13,110,253,0.15);
    }

    .btn {
        display: inline-block;

        padding: 9px 15px;

        border: none;

        border-radius: 8px;

        text-decoration: none;

        cursor: pointer;

        font-size: 14px;

        font-weight: 600;

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

    .btn-secondary {
        background: #6c757d;

        color: white;
    }

    .table-container {
        overflow-x: auto;
    }

    table {
        width: 100%;

        border-collapse: collapse;

        min-width: 1050px;

        background: white;
    }

    th,
    td {
        padding: 13px;

        border-bottom: 1px solid #ddd;

        text-align: left;

        vertical-align: middle;
    }

    th {
        background: #0d6efd;

        color: white;

        font-weight: 600;
    }

    tbody tr:hover {
        background-color: #f1f7ff;
    }

    .appointment-number {
        font-weight: bold;

        color: #0d6efd;
    }

    .status {
        display: inline-block;

        padding: 5px 10px;

        border-radius: 15px;

        font-size: 12px;

        font-weight: bold;
    }

    .status-pending {
        background: #fff3cd;

        color: #856404;
    }

    .status-confirmed {
        background: #d1ecf1;

        color: #0c5460;
    }

    .status-completed {
        background: #d4edda;

        color: #155724;
    }

    .status-cancelled {
        background: #f8d7da;

        color: #721c24;
    }

    .action-buttons {
        display: flex;

        gap: 6px;

        flex-wrap: wrap;
    }

    .action-buttons .btn {
        font-size: 12px;

        padding: 7px 10px;
    }

    .status-form {
        display: flex;

        gap: 5px;

        margin-top: 7px;
    }

    .status-select {
        padding: 6px;

        border: 1px solid #ccc;

        border-radius: 5px;

        font-size: 12px;

        background: white;
    }

    .no-data {
        text-align: center;

        padding: 40px;

        color: #777;
    }

    .message {
        padding: 12px 15px;

        border-radius: 8px;

        margin-bottom: 20px;

        font-weight: 600;
    }

    .success-message {
        background: #d4edda;

        color: #155724;

        border: 1px solid #c3e6cb;
    }

    .error-message {
        background: #f8d7da;

        color: #721c24;

        border: 1px solid #f5c6cb;
    }

    .info-message {
        background: #d1ecf1;

        color: #0c5460;

        border: 1px solid #bee5eb;
    }

    @media (max-width: 768px) {

        .page-container {
            width: 85%;

            padding: 22px;

            margin: 20px auto;
        }

        .page-header {
            flex-direction: column;

            align-items: flex-start;

            gap: 15px;
        }

        .page-header h2 {
            font-size: 25px;
        }

        .search-form {
            max-width: 100%;

            width: 100%;
        }

        .toolbar {
            flex-direction: column;
        }

        .card {
            padding: 15px;
        }

        .btn {
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

        <h2>
            Appointment Management
        </h2>

        <p>
            Manage patient appointments at Sunrise Dental Clinic
        </p>

    </div>


    <div>

        <!-- Role-based Dashboard -->

        <a href="<%= dashboardUrl %>"
           class="btn btn-secondary">

            Dashboard

        </a>


        <a href="${pageContext.request.contextPath}/appointments?action=add"
           class="btn btn-primary">

            + New Appointment

        </a>

    </div>

</div>


<!-- =====================================================
     Success / Error Messages
     ===================================================== -->

<%
    String successMessage =
            (String) session.getAttribute("successMessage");

    String errorMessage =
            (String) session.getAttribute("errorMessage");


    if (successMessage != null) {
%>

    <div class="message success-message">

        <%= successMessage %>

    </div>

<%
        session.removeAttribute("successMessage");
    }


    if (errorMessage != null) {
%>

    <div class="message error-message">

        <%= errorMessage %>

    </div>

<%
        session.removeAttribute("errorMessage");
    }
%>


<!-- =====================================================
     Main Card
     ===================================================== -->

<div class="card">


    <!-- =================================================
         Search Toolbar
         ================================================= -->

    <div class="toolbar">

        <form method="get"
              action="${pageContext.request.contextPath}/appointments"
              class="search-form">

            <input type="hidden"
                   name="action"
                   value="search">


            <input type="text"
                   name="keyword"
                   class="search-input"
                   placeholder="Search appointment, patient, dentist or treatment..."
                   value="<%= searchKeyword != null
                           ? searchKeyword
                           : "" %>">


            <button type="submit"
                    class="btn btn-success">

                Search

            </button>


            <a href="${pageContext.request.contextPath}/appointments"
               class="btn btn-secondary">

                Clear

            </a>

        </form>

    </div>


    <!-- =================================================
         Appointment Table
         ================================================= -->

    <div class="table-container">

        <table>

            <thead>

            <tr>

                <th>#</th>

                <th>Appointment No.</th>

                <th>Patient</th>

                <th>Dentist</th>

                <th>Treatment</th>

                <th>Date</th>

                <th>Time</th>

                <th>Status</th>

                <th>Actions</th>

            </tr>

            </thead>


            <tbody>

            <%
                if (appointments.isEmpty()) {
            %>

                <tr>

                    <td colspan="9"
                        class="no-data">

                        No appointments found.

                    </td>

                </tr>

            <%
                } else {

                    int rowNumber = 1;

                    for (Appointment appointment :
                            appointments) {

                        String status =
                                appointment.getStatus();

                        if (status == null) {
                            status = "PENDING";
                        }

                        String statusClass =
                                "status-pending";


                        if ("CONFIRMED".equals(status)) {

                            statusClass =
                                    "status-confirmed";

                        } else if ("COMPLETED".equals(status)) {

                            statusClass =
                                    "status-completed";

                        } else if ("CANCELLED".equals(status)) {

                            statusClass =
                                    "status-cancelled";
                        }
            %>

                <tr>


                    <!-- Row Number -->

                    <td>
                        <%= rowNumber++ %>
                    </td>


                    <!-- Appointment Number -->

                    <td>

                        <span class="appointment-number">

                            <%= appointment.getAppointmentNo() %>

                        </span>

                    </td>


                    <!-- Patient -->

                    <td>

                        <strong>

                            <%= appointment.getPatientName() != null
                                    ? appointment.getPatientName()
                                    : "N/A" %>

                        </strong>

                    </td>


                    <!-- Dentist -->

                    <td>

                        <%= appointment.getDentistName() != null
                                ? appointment.getDentistName()
                                : "N/A" %>

                    </td>


                    <!-- Treatment -->

                    <td>

                        <%= appointment.getTreatmentName() != null
                                ? appointment.getTreatmentName()
                                : "N/A" %>

                    </td>


                    <!-- Date -->

                    <td>

                        <%= appointment.getAppointmentDate() %>

                    </td>


                    <!-- Time -->

                    <td>

                        <%= appointment.getAppointmentTime() %>

                    </td>


                    <!-- Status -->

                    <td>

                        <span class="status <%= statusClass %>">

                            <%= status %>

                        </span>


                        <!-- Status Update -->

                        <form method="post"
                              action="${pageContext.request.contextPath}/appointments"
                              class="status-form">

                            <input type="hidden"
                                   name="action"
                                   value="status">


                            <input type="hidden"
                                   name="appointmentId"
                                   value="<%= appointment.getAppointmentId() %>">


                            <select name="status"
                                    class="status-select">


                                <option value="PENDING"
                                        <%= "PENDING".equals(status)
                                                ? "selected"
                                                : "" %>>

                                    Pending

                                </option>


                                <option value="CONFIRMED"
                                        <%= "CONFIRMED".equals(status)
                                                ? "selected"
                                                : "" %>>

                                    Confirmed

                                </option>


                                <option value="COMPLETED"
                                        <%= "COMPLETED".equals(status)
                                                ? "selected"
                                                : "" %>>

                                    Completed

                                </option>


                                <option value="CANCELLED"
                                        <%= "CANCELLED".equals(status)
                                                ? "selected"
                                                : "" %>>

                                    Cancelled

                                </option>


                            </select>


                            <button type="submit"
                                    class="btn btn-warning">

                                Update

                            </button>

                        </form>

                    </td>


                    <!-- Actions -->

                    <td>

                        <div class="action-buttons">


                            <a href="${pageContext.request.contextPath}/appointments?action=edit&id=<%= appointment.getAppointmentId() %>"
                               class="btn btn-primary">

                                Edit

                            </a>


                            <a href="${pageContext.request.contextPath}/appointments?action=delete&id=<%= appointment.getAppointmentId() %>"
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete this appointment?');">

                                Delete

                            </a>


                        </div>

                    </td>

                </tr>

            <%
                    }
                }
            %>

            </tbody>

        </table>

    </div>

</div>


</div>

</body>

</html>
