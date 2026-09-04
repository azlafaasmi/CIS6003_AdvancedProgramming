<%@ page import="model.Bill" %>

<%
    Bill bill = (Bill) request.getAttribute("bill");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Receipt - Sunrise Dental Clinic</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            margin: 0;
            padding: 30px;
        }

        .receipt {
            width: 700px;
            max-width: 100%;
            margin: 0 auto;
            background: white;
            padding: 40px;
            box-sizing: border-box;
        }

        .clinic-header {
            text-align: center;
            border-bottom: 2px solid #333;
            padding-bottom: 20px;
            margin-bottom: 25px;
        }

        .clinic-header h1 {
            margin: 0 0 8px 0;
            font-size: 28px;
        }

        .clinic-header p {
            margin: 5px 0;
            color: #555;
        }

        .receipt-title {
            text-align: center;
            margin: 20px 0;
            font-size: 22px;
            font-weight: bold;
        }

        .receipt-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .receipt-table th,
        .receipt-table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        .receipt-table th {
            text-align: left;
            width: 55%;
        }

        .receipt-table td {
            text-align: right;
        }

        .total-row th,
        .total-row td {
            border-top: 2px solid #333;
            border-bottom: 2px solid #333;
            font-size: 18px;
            font-weight: bold;
        }

        .status {
            text-align: center;
            margin: 25px 0;
            padding: 10px;
            font-weight: bold;
            border: 1px solid #333;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
            color: #555;
        }

        .button-area {
            text-align: center;
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            padding: 10px 18px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-print {
            background: #007bff;
            color: white;
        }

        .btn-back {
            background: #6c757d;
            color: white;
        }

        .error {
            text-align: center;
            padding: 30px;
            background: white;
            max-width: 600px;
            margin: auto;
        }


        @media print {

            body {
                background: white;
                padding: 0;
            }

            .receipt {
                width: 100%;
                padding: 20px;
            }

            .button-area {
                display: none;
            }

        }

    </style>

</head>

<body>


<%
    if (bill == null) {
%>

    <div class="error">

        <h2>
            Receipt Not Available
        </h2>

        <p>
            The requested bill could not be found.
        </p>

        <a href="<%= request.getContextPath() %>/billing"
           class="btn btn-back">
            Back to Billing
        </a>

    </div>

<%
    } else {
%>


<div class="receipt">


    <!-- ============================================= -->
    <!-- Clinic Header -->
    <!-- ============================================= -->

    <div class="clinic-header">

        <h1>
            Sunrise Dental Clinic
        </h1>

        <p>
            Professional Dental Care
        </p>

        <p>
            Dental Treatment & Consultation Services
        </p>

    </div>


    <!-- ============================================= -->
    <!-- Receipt Title -->
    <!-- ============================================= -->

    <div class="receipt-title">

        PAYMENT RECEIPT

    </div>


    <!-- ============================================= -->
    <!-- Receipt Information -->
    <!-- ============================================= -->

    <table class="receipt-table">

        <tr>

            <th>
                Bill ID
            </th>

            <td>
                <%= bill.getBillId() %>
            </td>

        </tr>


        <tr>

            <th>
                Appointment ID
            </th>

            <td>
                <%= bill.getAppointmentId() %>
            </td>

        </tr>


        <tr>

            <th>
                Consultation Fee
            </th>

            <td>
                Rs. <%= bill.getConsultationFee() %>
            </td>

        </tr>


        <tr>

            <th>
                Treatment Fee
            </th>

            <td>
                Rs. <%= bill.getTreatmentFee() %>
            </td>

        </tr>


        <tr class="total-row">

            <th>
                TOTAL AMOUNT
            </th>

            <td>
                Rs. <%= bill.getTotalAmount() %>
            </td>

        </tr>

    </table>


    <!-- ============================================= -->
    <!-- Payment Status -->
    <!-- ============================================= -->

    <div class="status">

        Payment Status:

        <%= bill.getPaymentStatus() %>

    </div>


    <!-- ============================================= -->
    <!-- Footer -->
    <!-- ============================================= -->

    <div class="footer">

        <p>
            Thank you for choosing Sunrise Dental Clinic.
        </p>

        <p>
            We wish you a healthy and happy smile!
        </p>

    </div>


    <!-- ============================================= -->
    <!-- Buttons -->
    <!-- ============================================= -->

    <div class="button-area">

        <button type="button"
                class="btn btn-print"
                onclick="window.print();">
            Print Receipt
        </button>


        <a href="<%= request.getContextPath() %>/billing"
           class="btn btn-back">
            Back to Billing
        </a>

    </div>


</div>


<%
    }
%>


</body>
</html>