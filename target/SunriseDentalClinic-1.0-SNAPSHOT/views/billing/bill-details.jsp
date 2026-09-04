<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="model.Bill" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
List<Bill> bills =
(List<Bill>) request.getAttribute("bills");


Bill bill =
        (Bill) request.getAttribute("bill");


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

<title>Billing - Sunrise Dental Clinic</title>

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

    .billing-container {
        width: 92%;
        max-width: 1200px;

        margin: 45px auto;

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

    .btn {
        display: inline-block;

        padding: 10px 16px;

        border-radius: 8px;

        text-decoration: none;

        border: none;

        cursor: pointer;

        margin-right: 5px;

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

    .btn-info {
        background: #0dcaf0;

        color: #000;
    }

    .alert {
        padding: 14px 18px;

        border-radius: 8px;

        margin-bottom: 20px;

        font-weight: 600;
    }

    .alert-success {
        background: #d1e7dd;

        color: #0f5132;

        border: 1px solid #badbcc;
    }

    .alert-error {
        background: #f8d7da;

        color: #842029;

        border: 1px solid #f5c2c7;
    }

    .table-container {
        background: white;

        padding: 22px;

        border-radius: 12px;

        overflow-x: auto;

        box-shadow:
            0 4px 15px rgba(0,0,0,0.08);

        margin-bottom: 25px;
    }

    .table-container h3 {
        margin-top: 0;

        margin-bottom: 18px;

        color: #333;
    }

    table {
        width: 100%;

        border-collapse: collapse;
    }

    th,
    td {
        padding: 13px;

        border-bottom: 1px solid #ddd;

        text-align: left;

        white-space: nowrap;
    }

    th {
        background: #0d6efd;

        color: white;

        font-weight: 600;
    }

    tbody tr:hover {
        background: #f1f7ff;
    }

    .amount {
        font-weight: bold;

        color: #198754;
    }

    .status {
        display: inline-block;

        padding: 5px 10px;

        border-radius: 15px;

        font-size: 13px;

        font-weight: bold;
    }

    .status-paid {
        background: #d1e7dd;

        color: #0f5132;
    }

    .status-unpaid {
        background: #f8d7da;

        color: #842029;
    }

    .empty-message {
        text-align: center;

        padding: 40px;

        color: #666;
    }

    .action-form {
        display: inline;
    }

    .summary-box {
        display: flex;

        gap: 20px;

        margin-bottom: 25px;

        flex-wrap: wrap;
    }

    .summary-card {
        flex: 1;

        min-width: 180px;

        padding: 20px;

        background: white;

        border-radius: 12px;

        box-shadow:
            0 4px 15px rgba(0,0,0,0.08);

        border-left: 4px solid #0d6efd;
    }

    .summary-label {
        color: #666;

        font-size: 14px;
    }

    .summary-value {
        font-size: 23px;

        font-weight: bold;

        margin-top: 6px;

        color: #0d6efd;
    }

    @media (max-width: 768px) {

        .billing-container {
            width: 85%;

            margin: 20px auto;

            padding: 22px;
        }

        .page-header {
            align-items: flex-start;

            flex-direction: column;
        }

        .page-header h2 {
            font-size: 25px;
        }

        .table-container {
            padding: 15px;
        }

        .table {
            overflow-x: auto;
        }

        .btn {
            margin-bottom: 7px;
        }

        .summary-card {
            min-width: 100%;
        }
    }

</style>


</head>

<body>

<div class="billing-container">


<!-- ================================================= -->
<!-- Page Header -->
<!-- ================================================= -->

<div class="page-header">

    <h2>
        Billing Management
    </h2>

    <div>

        <a href="<%= request.getContextPath() %>/billing?action=generate"
           class="btn btn-primary">

            + Generate Bill

        </a>


        <a href="<%= dashboardUrl %>"
           class="btn btn-secondary">

            Dashboard

        </a>

    </div>

</div>


<!-- ================================================= -->
<!-- Messages -->
<!-- ================================================= -->

<%
    String successMessage =
            (String) session.getAttribute("successMessage");

    if (successMessage != null) {
%>

    <div class="alert alert-success">

        <%= successMessage %>

    </div>

<%
        session.removeAttribute("successMessage");
    }
%>


<%
    String errorMessage =
            (String) session.getAttribute("errorMessage");

    if (errorMessage != null) {
%>

    <div class="alert alert-error">

        <%= errorMessage %>

    </div>

<%
        session.removeAttribute("errorMessage");
    }
%>


<!-- ================================================= -->
<!-- Individual Bill Details -->
<!-- ================================================= -->

<%
    if (bill != null) {
%>

    <div class="table-container">

        <h3>
            Bill Details
        </h3>

        <table>

            <tr>

                <th>Bill ID</th>

                <td>
                    <%= bill.getBillId() %>
                </td>

            </tr>

            <tr>

                <th>Appointment ID</th>

                <td>
                    <%= bill.getAppointmentId() %>
                </td>

            </tr>

            <tr>

                <th>Consultation Fee</th>

                <td>
                    Rs. <%= bill.getConsultationFee() %>
                </td>

            </tr>

            <tr>

                <th>Treatment Fee</th>

                <td>
                    Rs. <%= bill.getTreatmentFee() %>
                </td>

            </tr>

            <tr>

                <th>Total Amount</th>

                <td class="amount">
                    Rs. <%= bill.getTotalAmount() %>
                </td>

            </tr>

            <tr>

                <th>Payment Status</th>

                <td>

                    <%
                        if ("PAID".equals(
                                bill.getPaymentStatus())) {
                    %>

                        <span class="status status-paid">
                            PAID
                        </span>

                    <%
                        } else {
                    %>

                        <span class="status status-unpaid">
                            UNPAID
                        </span>

                    <%
                        }
                    %>

                </td>

            </tr>

        </table>

        <br>


        <a href="<%= request.getContextPath() %>/billing"
           class="btn btn-secondary">

            Back to Billing

        </a>


        <a href="<%= request.getContextPath() %>/billing?action=receipt&id=<%= bill.getBillId() %>"
           class="btn btn-info"
           target="_blank">

            Print Receipt

        </a>

    </div>

<%
    }
%>


<!-- ================================================= -->
<!-- Summary -->
<!-- ================================================= -->

<%
    if (bills != null) {

        int totalBills = bills.size();

        int paidBills = 0;

        int unpaidBills = 0;

        BigDecimal totalRevenue =
                new BigDecimal("0.00");


        for (Bill b : bills) {

            if ("PAID".equals(
                    b.getPaymentStatus())) {

                paidBills++;

                if (b.getTotalAmount() != null) {

                    totalRevenue =
                            totalRevenue.add(
                                    b.getTotalAmount());
                }

            } else {

                unpaidBills++;
            }
        }
%>

    <div class="summary-box">


        <div class="summary-card">

            <div class="summary-label">
                Total Bills
            </div>

            <div class="summary-value">
                <%= totalBills %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-label">
                Paid Bills
            </div>

            <div class="summary-value">
                <%= paidBills %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-label">
                Unpaid Bills
            </div>

            <div class="summary-value">
                <%= unpaidBills %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-label">
                Paid Revenue
            </div>

            <div class="summary-value">
                Rs. <%= totalRevenue %>
            </div>

        </div>


    </div>

<%
    }
%>


<!-- ================================================= -->
<!-- Bills Table -->
<!-- ================================================= -->

<div class="table-container">

    <h3>
        All Bills
    </h3>


    <%
        if (bills == null || bills.isEmpty()) {
    %>

        <div class="empty-message">

            <p>
                No bills have been generated yet.
            </p>

            <a href="<%= request.getContextPath() %>/billing?action=generate"
               class="btn btn-primary">

                Generate First Bill

            </a>

        </div>

    <%
        } else {
    %>


        <table>

            <thead>

            <tr>

                <th>Bill ID</th>

                <th>Appointment ID</th>

                <th>Consultation</th>

                <th>Treatment</th>

                <th>Total</th>

                <th>Status</th>

                <th>Actions</th>

            </tr>

            </thead>


            <tbody>

            <%
                for (Bill b : bills) {
            %>

                <tr>

                    <td>
                        <%= b.getBillId() %>
                    </td>

                    <td>
                        <%= b.getAppointmentId() %>
                    </td>

                    <td>
                        Rs. <%= b.getConsultationFee() %>
                    </td>

                    <td>
                        Rs. <%= b.getTreatmentFee() %>
                    </td>

                    <td class="amount">
                        Rs. <%= b.getTotalAmount() %>
                    </td>

                    <td>

                        <%
                            if ("PAID".equals(
                                    b.getPaymentStatus())) {
                        %>

                            <span class="status status-paid">
                                PAID
                            </span>

                        <%
                            } else {
                        %>

                            <span class="status status-unpaid">
                                UNPAID
                            </span>

                        <%
                            }
                        %>

                    </td>


                    <td>

                        <a href="<%= request.getContextPath() %>/billing?action=details&id=<%= b.getBillId() %>"
                           class="btn btn-info">

                            View

                        </a>


                        <a href="<%= request.getContextPath() %>/billing?action=receipt&id=<%= b.getBillId() %>"
                           class="btn btn-secondary"
                           target="_blank">

                            Receipt

                        </a>


                        <form method="post"
                              action="<%= request.getContextPath() %>/billing"
                              class="action-form">

                            <input type="hidden"
                                   name="action"
                                   value="payment">


                            <input type="hidden"
                                   name="billId"
                                   value="<%= b.getBillId() %>">


                            <%
                                if ("PAID".equals(
                                        b.getPaymentStatus())) {
                            %>

                                <input type="hidden"
                                       name="paymentStatus"
                                       value="UNPAID">


                                <button type="submit"
                                        class="btn btn-warning">

                                    Mark Unpaid

                                </button>

                            <%
                                } else {
                            %>

                                <input type="hidden"
                                       name="paymentStatus"
                                       value="PAID">


                                <button type="submit"
                                        class="btn btn-success">

                                    Mark Paid

                                </button>

                            <%
                                }
                            %>

                        </form>


                        <a href="<%= request.getContextPath() %>/billing?action=delete&id=<%= b.getBillId() %>"
                           class="btn btn-danger"
                           onclick="return confirm('Are you sure you want to delete this bill?');">

                            Delete

                        </a>

                    </td>

                </tr>

            <%
                }
            %>

            </tbody>

        </table>


    <%
        }
    %>

</div>


</div>

</body>

</html>
