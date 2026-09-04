<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>

<%
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

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Appointment Report - Sunrise Dental Clinic</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: auto;
        }

        /* ==============================
           Header
           ============================== */

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            background: white;
            padding: 20px 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .header h1 {
            margin: 0;
            color: #2c7be5;
            font-size: 28px;
        }

        /* ==============================
           Buttons
           ============================== */

        .btn {
            display: inline-block;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            font-weight: bold;
            transition: 0.2s;
        }

        .btn-dashboard {
            background: #6c757d;
        }

        .btn-dashboard:hover {
            background: #5c636a;
        }

        /* ==============================
           Statistics Cards
           ============================== */

        .cards {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: 0.2s;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow:
                0 5px 15px rgba(0, 0, 0, 0.12);
        }

        .card h2 {
            margin: 0;
            font-size: 34px;
        }

        .card p {
            margin-top: 10px;
            color: #666;
            font-weight: bold;
        }

        .total {
            border-left: 5px solid #007bff;
        }

        .pending {
            border-left: 5px solid #ffc107;
        }

        .completed {
            border-left: 5px solid #198754;
        }

        .cancelled {
            border-left: 5px solid #dc3545;
        }

        /* ==============================
           Report Summary
           ============================== */

        .report-box {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .report-box h3 {
            margin-top: 0;
            color: #2c7be5;
            font-size: 22px;
        }

        .report-box p {
            color: #666;
            line-height: 1.6;
        }

        .report-box ul {
            padding-left: 20px;
            line-height: 2;
        }

        .report-box li {
            color: #555;
        }

        .report-box strong {
            color: #222;
        }

        /* ==============================
           Responsive
           ============================== */

        @media (max-width: 600px) {

            body {
                padding: 10px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .header h1 {
                font-size: 23px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>

<div class="container">


    <!-- =================================================
         Header
         ================================================= -->

    <div class="header">

        <h1>
            Appointment Report
        </h1>

        <a href="<%= dashboardUrl %>"
           class="btn btn-dashboard">

            Dashboard

        </a>

    </div>


    <!-- =================================================
         Statistics Cards
         ================================================= -->

    <div class="cards">


        <!-- Total -->

        <div class="card total">

            <h2>
                ${totalAppointments}
            </h2>

            <p>
                Total Appointments
            </p>

        </div>


        <!-- Pending -->

        <div class="card pending">

            <h2>
                ${pendingAppointments}
            </h2>

            <p>
                Pending
            </p>

        </div>


        <!-- Completed -->

        <div class="card completed">

            <h2>
                ${completedAppointments}
            </h2>

            <p>
                Completed
            </p>

        </div>


        <!-- Cancelled -->

        <div class="card cancelled">

            <h2>
                ${cancelledAppointments}
            </h2>

            <p>
                Cancelled
            </p>

        </div>

    </div>


    <!-- =================================================
         Appointment Summary
         ================================================= -->

    <div class="report-box">

        <h3>
            Appointment Summary
        </h3>

        <p>

            This report shows the overall appointment statistics
            currently stored in the Sunrise Dental Clinic system.

        </p>

        <ul>

            <li>

                Total Appointments:

                <strong>
                    ${totalAppointments}
                </strong>

            </li>

            <li>

                Pending:

                <strong>
                    ${pendingAppointments}
                </strong>

            </li>

            <li>

                Completed:

                <strong>
                    ${completedAppointments}
                </strong>

            </li>

            <li>

                Cancelled:

                <strong>
                    ${cancelledAppointments}
                </strong>

            </li>

        </ul>

    </div>

</div>

</body>

</html>