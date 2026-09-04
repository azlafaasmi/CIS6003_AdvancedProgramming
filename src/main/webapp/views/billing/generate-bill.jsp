<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="model.Appointment" %>

<%
    List<Appointment> appointments =
            (List<Appointment>) request.getAttribute("appointments");

    BigDecimal consultationFee =
            (BigDecimal) request.getAttribute("consultationFee");

    if (consultationFee == null) {
        consultationFee = new BigDecimal("1000.00");
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Generate Bill - Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/assets/css/style.css">

    <style>

        .billing-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .billing-title {
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .fee-box {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .fee-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
        }

        .total-row {
            border-top: 2px solid #333;
            margin-top: 10px;
            padding-top: 15px;
            font-size: 20px;
            font-weight: bold;
        }

        .button-row {
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            margin-right: 8px;
        }

        .btn-primary {
            background: #007bff;
            color: white;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .alert {
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }

        .empty-message {
            padding: 15px;
            background: #fff3cd;
            color: #856404;
            border-radius: 5px;
        }

    </style>

</head>

<body>

<div class="billing-container">

    <h2 class="billing-title">
        Generate Bill
    </h2>


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


    <%
        if (appointments == null || appointments.isEmpty()) {
    %>

        <div class="empty-message">
            No appointments are currently available for billing.
        </div>

        <div class="button-row">

            <a href="<%= request.getContextPath() %>/billing"
               class="btn btn-secondary">
                Back to Billing
            </a>

            <a href="<%= request.getContextPath() %>/appointments"
               class="btn btn-primary">
                Manage Appointments
            </a>

        </div>

    <%
        } else {
    %>


    <form method="post"
          action="<%= request.getContextPath() %>/billing">

        <input type="hidden"
               name="action"
               value="generate">


        <!-- Appointment -->

        <div class="form-group">

            <label for="appointmentId">
                Select Appointment
            </label>

            <select id="appointmentId"
                    name="appointmentId"
                    class="form-control"
                    required>

                <option value="">
                    -- Select Appointment --
                </option>

                <%
                    for (Appointment appointment : appointments) {
                %>

                    <option value="<%= appointment.getAppointmentId() %>">

                        <%= appointment.getAppointmentNo() %>
                        -
                        <%= appointment.getPatientName() %>
                        -
                        <%= appointment.getTreatmentName() %>
                        -
                        <%= appointment.getAppointmentDate() %>
                        <%= appointment.getAppointmentTime() %>

                    </option>

                <%
                    }
                %>

            </select>

        </div>


        <!-- Consultation Fee -->

        <div class="fee-box">

            <div class="fee-row">

                <span>
                    Consultation Fee
                </span>

                <span>
                    Rs.
                    <span id="consultationFee">
                        <%= consultationFee %>
                    </span>
                </span>

            </div>


            <div class="fee-row">

                <span>
                    Treatment Fee
                </span>

                <span>
                    Rs.
                    <span id="displayTreatmentFee">
                        0.00
                    </span>
                </span>

            </div>


            <div class="fee-row total-row">

                <span>
                    Total Amount
                </span>

                <span>
                    Rs.
                    <span id="displayTotal">
                        <%= consultationFee %>
                    </span>
                </span>

            </div>

        </div>


        <!-- Treatment Fee -->

        <div class="form-group">

            <label for="treatmentFee">
                Treatment Fee (Rs.)
            </label>

            <input type="number"
                   id="treatmentFee"
                   name="treatmentFee"
                   class="form-control"
                   min="0"
                   step="0.01"
                   placeholder="Enter treatment fee"
                   required>

        </div>


        <!-- Buttons -->

        <div class="button-row">

            <button type="submit"
                    class="btn btn-primary">
                Generate Bill
            </button>

            <a href="<%= request.getContextPath() %>/billing"
               class="btn btn-secondary">
                Cancel
            </a>

        </div>

    </form>


    <%
        }
    %>

</div>


<script>

    const treatmentFeeInput =
        document.getElementById("treatmentFee");

    const displayTreatmentFee =
        document.getElementById("displayTreatmentFee");

    const displayTotal =
        document.getElementById("displayTotal");

    const consultationFee =
        parseFloat(
            document.getElementById("consultationFee").innerText
        );


    if (treatmentFeeInput) {

        treatmentFeeInput.addEventListener(
            "input",
            function () {

                let treatmentFee =
                    parseFloat(this.value);

                if (isNaN(treatmentFee)) {
                    treatmentFee = 0;
                }

                let total =
                    consultationFee + treatmentFee;


                displayTreatmentFee.innerText =
                    treatmentFee.toFixed(2);

                displayTotal.innerText =
                    total.toFixed(2);
            }
        );
    }

</script>

</body>
</html>