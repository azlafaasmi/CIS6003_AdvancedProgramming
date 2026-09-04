<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>

<%
    java.math.BigDecimal totalRevenue =
            (java.math.BigDecimal) request.getAttribute("totalRevenue");

    java.math.BigDecimal paidRevenue =
            (java.math.BigDecimal) request.getAttribute("paidRevenue");

    java.math.BigDecimal unpaidRevenue =
            (java.math.BigDecimal) request.getAttribute("unpaidRevenue");

    Integer totalBills =
            (Integer) request.getAttribute("totalBills");

    Integer paidBills =
            (Integer) request.getAttribute("paidBills");

    Integer unpaidBills =
            (Integer) request.getAttribute("unpaidBills");


    // =====================================================
    // Default Values
    // =====================================================

    if (totalRevenue == null) {
        totalRevenue = java.math.BigDecimal.ZERO;
    }

    if (paidRevenue == null) {
        paidRevenue = java.math.BigDecimal.ZERO;
    }

    if (unpaidRevenue == null) {
        unpaidRevenue = java.math.BigDecimal.ZERO;
    }

    if (totalBills == null) {
        totalBills = 0;
    }

    if (paidBills == null) {
        paidBills = 0;
    }

    if (unpaidBills == null) {
        unpaidBills = 0;
    }


    // =====================================================
    // Revenue Percentages
    // =====================================================

    double paidPercentage = 0;
    double unpaidPercentage = 0;

    if (totalRevenue.compareTo(java.math.BigDecimal.ZERO) > 0) {

        paidPercentage =
                paidRevenue
                        .divide(
                                totalRevenue,
                                4,
                                java.math.RoundingMode.HALF_UP)
                        .doubleValue()
                        * 100;

        unpaidPercentage =
                unpaidRevenue
                        .divide(
                                totalRevenue,
                                4,
                                java.math.RoundingMode.HALF_UP)
                        .doubleValue()
                        * 100;
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

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Revenue Report - Sunrise Dental Clinic</title>

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
            max-width: 1100px;
            margin: 0 auto;
        }

        /* ==============================
           Header
           ============================== */

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: white;
            padding: 22px 25px;
            border-radius: 10px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .header h1 {
            margin: 0;
            color: #2c7be5;
        }

        .header p {
            margin-top: 8px;
            margin-bottom: 0;
            color: #666;
        }

        .buttons {
            display: flex;
            gap: 8px;
        }

        /* ==============================
           Buttons
           ============================== */

        .btn {
            display: inline-block;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
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

        .btn-billing {
            background: #007bff;
        }

        .btn-billing:hover {
            background: #0069d9;
        }

        /* ==============================
           Revenue Cards
           ============================== */

        .revenue-cards {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.1);
            transition: 0.2s;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow:
                0 5px 15px rgba(0, 0, 0, 0.12);
        }

        .card-title {
            font-size: 15px;
            color: #666;
            margin-bottom: 10px;
        }

        .card-value {
            font-size: 28px;
            font-weight: bold;
            color: #333;
        }

        .total-card {
            border-left: 5px solid #007bff;
        }

        .paid-card {
            border-left: 5px solid #198754;
        }

        .unpaid-card {
            border-left: 5px solid #dc3545;
        }

        /* ==============================
           Bill Statistics
           ============================== */

        .bill-cards {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .bill-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .bill-card h3 {
            margin: 0 0 10px 0;
            color: #333;
        }

        .bill-number {
            font-size: 30px;
            font-weight: bold;
        }

        /* ==============================
           Revenue Summary
           ============================== */

        .summary {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .summary h2 {
            margin-top: 0;
            color: #2c7be5;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid #ddd;
        }

        .summary-row:last-child {
            border-bottom: none;
        }

        .summary-label {
            font-weight: bold;
        }

        .summary-value {
            font-weight: bold;
        }

        .paid-text {
            color: #198754;
        }

        .unpaid-text {
            color: #dc3545;
        }

        .total-text {
            color: #007bff;
        }

        /* ==============================
           Percentage Section
           ============================== */

        .percentage-box {
            margin-top: 25px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .percentage-box h3 {
            margin-top: 0;
            color: #333;
        }

        .percentage-row {
            margin-bottom: 20px;
        }

        .percentage-row:last-child {
            margin-bottom: 0;
        }

        .percentage-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .progress {
            width: 100%;
            height: 18px;
            background: #ddd;
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-paid {
            height: 100%;
            background: #198754;
            transition: width 0.5s ease;
        }

        .progress-unpaid {
            height: 100%;
            background: #dc3545;
            transition: width 0.5s ease;
        }

        /* ==============================
           Footer
           ============================== */

        .footer-note {
            text-align: center;
            margin-top: 30px;
            color: #777;
            font-size: 14px;
        }

        /* ==============================
           Responsive
           ============================== */

        @media (max-width: 700px) {

            body {
                padding: 10px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .buttons {
                width: 100%;
                flex-wrap: wrap;
            }

            .btn {
                text-align: center;
            }

            .summary-row {
                gap: 15px;
            }

        }

        /* ==============================
           Print
           ============================== */

        @media print {

            body {
                background: white;
            }

            .header .buttons {
                display: none;
            }

            .card,
            .bill-card,
            .summary {
                box-shadow: none;
                border: 1px solid #ddd;
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

        <div>

            <h1>
                Revenue Report
            </h1>

            <p>
                Sunrise Dental Clinic
            </p>

        </div>

        <div class="buttons">

            <a href="${pageContext.request.contextPath}/billing"
               class="btn btn-billing">

                Billing

            </a>

            <a href="<%= dashboardUrl %>"
               class="btn btn-dashboard">

                Dashboard

            </a>

        </div>

    </div>


    <!-- =================================================
         Revenue Cards
         ================================================= -->

    <div class="revenue-cards">


        <!-- Total Revenue -->

        <div class="card total-card">

            <div class="card-title">

                Total Revenue

            </div>

            <div class="card-value">

                Rs.
                <%= totalRevenue.setScale(
                        2,
                        java.math.RoundingMode.HALF_UP) %>

            </div>

        </div>


        <!-- Paid Revenue -->

        <div class="card paid-card">

            <div class="card-title">

                Paid Revenue

            </div>

            <div class="card-value paid-text">

                Rs.
                <%= paidRevenue.setScale(
                        2,
                        java.math.RoundingMode.HALF_UP) %>

            </div>

        </div>


        <!-- Unpaid Revenue -->

        <div class="card unpaid-card">

            <div class="card-title">

                Unpaid Revenue

            </div>

            <div class="card-value unpaid-text">

                Rs.
                <%= unpaidRevenue.setScale(
                        2,
                        java.math.RoundingMode.HALF_UP) %>

            </div>

        </div>

    </div>


    <!-- =================================================
         Bill Statistics
         ================================================= -->

    <div class="bill-cards">


        <!-- Total Bills -->

        <div class="bill-card">

            <h3>
                Total Bills
            </h3>

            <div class="bill-number">

                <%= totalBills %>

            </div>

        </div>


        <!-- Paid Bills -->

        <div class="bill-card">

            <h3>
                Paid Bills
            </h3>

            <div class="bill-number paid-text">

                <%= paidBills %>

            </div>

        </div>


        <!-- Unpaid Bills -->

        <div class="bill-card">

            <h3>
                Unpaid Bills
            </h3>

            <div class="bill-number unpaid-text">

                <%= unpaidBills %>

            </div>

        </div>

    </div>


    <!-- =================================================
         Revenue Summary
         ================================================= -->

    <div class="summary">

        <h2>
            Revenue Summary
        </h2>


        <!-- Total Revenue -->

        <div class="summary-row">

            <span class="summary-label">

                Total Revenue

            </span>

            <span class="summary-value total-text">

                Rs.
                <%= totalRevenue.setScale(
                        2,
                        java.math.RoundingMode.HALF_UP) %>

            </span>

        </div>


        <!-- Paid Revenue -->

        <div class="summary-row">

            <span class="summary-label">

                Paid Revenue

            </span>

            <span class="summary-value paid-text">

                Rs.
                <%= paidRevenue.setScale(
                        2,
                        java.math.RoundingMode.HALF_UP) %>

            </span>

        </div>


        <!-- Unpaid Revenue -->

        <div class="summary-row">

            <span class="summary-label">

                Outstanding / Unpaid Revenue

            </span>

            <span class="summary-value unpaid-text">

                Rs.
                <%= unpaidRevenue.setScale(
                        2,
                        java.math.RoundingMode.HALF_UP) %>

            </span>

        </div>


        <!-- =================================================
             Payment Collection
             ================================================= -->

        <div class="percentage-box">

            <h3>
                Payment Collection Status
            </h3>


            <!-- Paid -->

            <div class="percentage-row">

                <div class="percentage-label">

                    <span>
                        Paid
                    </span>

                    <span>

                        <%= String.format(
                                "%.2f",
                                paidPercentage) %>%

                    </span>

                </div>

                <div class="progress">

                    <div
                        id="paidProgress"
                        class="progress-paid">
                    </div>

                </div>

            </div>


            <!-- Unpaid -->

            <div class="percentage-row">

                <div class="percentage-label">

                    <span>
                        Unpaid
                    </span>

                    <span>

                        <%= String.format(
                                "%.2f",
                                unpaidPercentage) %>%

                    </span>

                </div>

                <div class="progress">

                    <div
                        id="unpaidProgress"
                        class="progress-unpaid">
                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- =================================================
         Footer
         ================================================= -->

    <div class="footer-note">

        Revenue report generated from the current billing records.

    </div>

</div>


<!-- =================================================
     Dynamic Progress Bars
     ================================================= -->

<script>

    document.getElementById("paidProgress").style.width =
        "<%= paidPercentage %>%";

    document.getElementById("unpaidProgress").style.width =
        "<%= unpaidPercentage %>%";

</script>

</body>

</html>