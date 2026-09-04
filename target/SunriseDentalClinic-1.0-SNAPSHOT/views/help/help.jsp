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

    <title>Help - Sunrise Dental Clinic</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            color: #333;
        }

        /* ==============================
           Header
           ============================== */

        .header {
            background: linear-gradient(135deg, #2c7be5, #1a5fb4);
            color: white;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.12);
        }

        .header h1 {
            margin: 0;
            font-size: 30px;
        }

        .header p {
            margin: 8px 0 0;
            font-size: 15px;
            opacity: 0.95;
        }

        /* ==============================
           Main Container
           ============================== */

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 35px auto;
        }

        /* ==============================
           Cards
           ============================== */

        .card {
            background: white;
            padding: 25px;
            margin-bottom: 22px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.08);
            border: 1px solid #e9ecef;
        }

        .card:hover {
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.12);
        }

        .card h2 {
            color: #2c7be5;
            margin-top: 0;
            margin-bottom: 18px;
            font-size: 21px;
        }

        /* ==============================
           Steps
           ============================== */

        .step {
            margin-bottom: 10px;
            padding: 13px 16px;
            background: #f8f9fa;
            border-left: 5px solid #2c7be5;
            border-radius: 5px;
            font-size: 15px;
        }

        .step:last-child {
            margin-bottom: 0;
        }

        /* ==============================
           Back Button
           ============================== */

        .button-area {
            text-align: center;
            margin: 35px 0 20px;
        }

        .back-btn {
            display: inline-block;
            padding: 13px 24px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            font-size: 15px;
            transition: 0.2s;
        }

        .back-btn:hover {
            background: #218838;
            transform: translateY(-1px);
        }

        /* ==============================
           Footer
           ============================== */

        .footer {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 14px;
        }

        /* ==============================
           Responsive Design
           ============================== */

        @media (max-width: 600px) {

            .container {
                width: 94%;
                margin: 20px auto;
            }

            .header h1 {
                font-size: 24px;
            }

            .card {
                padding: 20px;
            }

            .card h2 {
                font-size: 19px;
            }

            .step {
                font-size: 14px;
            }

        }

    </style>

</head>

<body>

    <!-- =================================================
         Header
         ================================================= -->

    <div class="header">

        <h1>Sunrise Dental Clinic - Help Guide</h1>

        <p>
            User guide for managing the Sunrise Dental Clinic system
        </p>

    </div>


    <!-- =================================================
         Main Content
         ================================================= -->

    <div class="container">


        <!-- =================================================
             1. Login
             ================================================= -->

        <div class="card">

            <h2>1. Login</h2>

            <div class="step">
                Enter username and password.
            </div>

            <div class="step">
                Click Login.
            </div>

            <div class="step">
                The appropriate dashboard will open based on the user's role.
            </div>

        </div>


        <!-- =================================================
             2. Patient Management
             ================================================= -->

        <div class="card">

            <h2>2. Patient Management</h2>

            <div class="step">
                Click Patients.
            </div>

            <div class="step">
                Click Add Patient.
            </div>

            <div class="step">
                Enter patient details.
            </div>

            <div class="step">
                Click Save.
            </div>

        </div>


        <!-- =================================================
             3. Dentist Management
             ================================================= -->

        <div class="card">

            <h2>3. Dentist Management</h2>

            <div class="step">
                Open Dentists module.
            </div>

            <div class="step">
                Add or update dentist information.
            </div>

        </div>


        <!-- =================================================
             4. Treatment Management
             ================================================= -->

        <div class="card">

            <h2>4. Treatment Management</h2>

            <div class="step">
                Open Treatments.
            </div>

            <div class="step">
                Add treatment name and cost.
            </div>

            <div class="step">
                Save treatment.
            </div>

        </div>


        <!-- =================================================
             5. Appointment Management
             ================================================= -->

        <div class="card">

            <h2>5. Appointment Management</h2>

            <div class="step">
                Open Appointments.
            </div>

            <div class="step">
                Select patient.
            </div>

            <div class="step">
                Select dentist.
            </div>

            <div class="step">
                Choose date and time.
            </div>

            <div class="step">
                Save appointment.
            </div>

        </div>


        <!-- =================================================
             6. Billing
             ================================================= -->

        <div class="card">

            <h2>6. Billing</h2>

            <div class="step">
                Open Billing.
            </div>

            <div class="step">
                Create bill.
            </div>

            <div class="step">
                Enter charges.
            </div>

            <div class="step">
                Mark bill as PAID or UNPAID.
            </div>

        </div>


        <!-- =================================================
             7. Appointment Report
             ================================================= -->

        <div class="card">

            <h2>7. Appointment Report</h2>

            <div class="step">
                Open Appointment Report.
            </div>

            <div class="step">
                Review appointment statistics.
            </div>

        </div>


        <!-- =================================================
             8. Revenue Report
             ================================================= -->

        <div class="card">

            <h2>8. Revenue Report</h2>

            <div class="step">
                Open Revenue Report.
            </div>

            <div class="step">
                View total revenue.
            </div>

            <div class="step">
                Review paid and unpaid revenue.
            </div>

        </div>


        <!-- =================================================
             9. User Management
             ================================================= -->

        <div class="card">

            <h2>9. User Management</h2>

            <div class="step">
                Open Users.
            </div>

            <div class="step">
                Add or edit staff accounts.
            </div>

        </div>


        <!-- =================================================
             10. Logout
             ================================================= -->

        <div class="card">

            <h2>10. Logout</h2>

            <div class="step">
                Click Logout to securely exit the system.
            </div>

        </div>


        <!-- =================================================
             Dashboard Button
             ================================================= -->

        <div class="button-area">

            <a class="back-btn"
               href="<%= dashboardUrl %>">
                Back to Dashboard
            </a>

        </div>

    </div>


    <!-- =================================================
         Footer
         ================================================= -->

    <div class="footer">

        Sunrise Dental Clinic Management System

    </div>

</body>

</html>