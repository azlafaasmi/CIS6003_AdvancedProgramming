<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Dentist" %>
<%@ page import="model.Treatment" %>

<%
    Appointment appointment =
            (Appointment) request.getAttribute("appointment");

    List<Patient> patients =
            (List<Patient>) request.getAttribute("patients");

    List<Dentist> dentists =
            (List<Dentist>) request.getAttribute("dentists");

    List<Treatment> treatments =
            (List<Treatment>) request.getAttribute("treatments");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Appointment - Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        body {
            background-color: #f5f7fa;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .appointment-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
        }

        .appointment-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .appointment-title {
            text-align: center;
            margin-bottom: 25px;
        }

        .appointment-title h2 {
            margin-bottom: 8px;
        }

        .appointment-title p {
            color: #666;
            margin: 0;
        }

        .appointment-number {
            background: #f1f3f5;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 25px;
            text-align: center;
        }

        .appointment-number strong {
            color: #007bff;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 11px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #007bff;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .button-row {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            padding: 11px 20px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            cursor: pointer;
            font-size: 15px;
        }

        .btn-primary {
            background: #007bff;
            color: white;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .required {
            color: red;
        }

        .status-info {
            padding: 12px;
            background: #e9f7fe;
            border: 1px solid #bee5eb;
            border-radius: 6px;
            margin-bottom: 20px;
            color: #0c5460;
        }

        @media (max-width: 600px) {

            .appointment-container {
                margin: 20px auto;
                padding: 15px;
            }

            .appointment-card {
                padding: 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .button-row {
                flex-direction: column;
            }

        }

    </style>

</head>

<body>

<div class="appointment-container">

    <div class="appointment-card">

        <div class="appointment-title">

            <h2>Edit Appointment</h2>

            <p>
                Sunrise Dental Clinic
            </p>

        </div>


        <!-- Appointment Number -->

        <div class="appointment-number">

            Appointment Number:

            <strong>
                <%= appointment.getAppointmentNo() %>
            </strong>

        </div>


        <!-- Current Status -->

        <div class="status-info">

            Current Status:

            <strong>
                <%= appointment.getStatus() %>
            </strong>

            <br>

            <small>
                Appointment status can be changed
                from the appointment management page.
            </small>

        </div>


        <!-- Appointment Form -->

        <form method="post"
              action="${pageContext.request.contextPath}/appointments">

            <input type="hidden"
                   name="action"
                   value="update">

            <input type="hidden"
                   name="appointmentId"
                   value="<%= appointment.getAppointmentId() %>">


            <!-- Patient -->

            <div class="form-group">

                <label for="patientId">

                    Patient
                    <span class="required">*</span>

                </label>

                <select id="patientId"
                        name="patientId"
                        class="form-control"
                        required>

                    <option value="">
                        -- Select Patient --
                    </option>

                    <%
                        if (patients != null) {

                            for (Patient patient : patients) {

                                boolean selected =
                                        patient.getPatientId()
                                        == appointment.getPatientId();
                    %>

                        <option value="<%= patient.getPatientId() %>"
                                <%= selected ? "selected" : "" %>>

                            <%= patient.getPatientName() %>

                            -
                            <%= patient.getContactNumber() %>

                        </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <!-- Dentist -->

            <div class="form-group">

                <label for="dentistId">

                    Dentist
                    <span class="required">*</span>

                </label>

                <select id="dentistId"
                        name="dentistId"
                        class="form-control"
                        required>

                    <option value="">
                        -- Select Dentist --
                    </option>

                    <%
                        if (dentists != null) {

                            for (Dentist dentist : dentists) {

                                boolean selected =
                                        dentist.getDentistId()
                                        == appointment.getDentistId();
                    %>

                        <option value="<%= dentist.getDentistId() %>"
                                <%= selected ? "selected" : "" %>>

                            <%= dentist.getDentistName() %>

                            <%
                                if (dentist.getSpecialization() != null
                                    && !dentist.getSpecialization()
                                    .trim().isEmpty()) {
                            %>

                                -
                                <%= dentist.getSpecialization() %>

                            <%
                                }
                            %>

                        </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <!-- Treatment -->

            <div class="form-group">

                <label for="treatmentId">

                    Treatment
                    <span class="required">*</span>

                </label>

                <select id="treatmentId"
                        name="treatmentId"
                        class="form-control"
                        required>

                    <option value="">
                        -- Select Treatment --
                    </option>

                    <%
                        if (treatments != null) {

                            for (Treatment treatment : treatments) {

                                boolean selected =
                                        treatment.getTreatmentId()
                                        == appointment.getTreatmentId();
                    %>

                        <option value="<%= treatment.getTreatmentId() %>"
                                <%= selected ? "selected" : "" %>>

                            <%= treatment.getTreatmentName() %>

                            -
                            Rs.
                            <%= treatment.getTreatmentPrice() %>

                        </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <!-- Date and Time -->

            <div class="form-row">

                <div class="form-group">

                    <label for="appointmentDate">

                        Appointment Date
                        <span class="required">*</span>

                    </label>

                    <input type="date"
                           id="appointmentDate"
                           name="appointmentDate"
                           class="form-control"
                           value="<%= appointment.getAppointmentDate() %>"
                           required>

                </div>


                <div class="form-group">

                    <label for="appointmentTime">

                        Appointment Time
                        <span class="required">*</span>

                    </label>

                    <input type="time"
                           id="appointmentTime"
                           name="appointmentTime"
                           class="form-control"
                           value="<%= appointment.getAppointmentTime() != null
                                   ? appointment.getAppointmentTime()
                                   .toString().substring(0, 5)
                                   : "" %>"
                           required>

                </div>

            </div>


            <!-- Buttons -->

            <div class="button-row">

                <button type="submit"
                        class="btn btn-primary">

                    Update Appointment

                </button>

                <a href="${pageContext.request.contextPath}/appointments"
                   class="btn btn-secondary">

                    Cancel

                </a>

            </div>

        </form>

    </div>

</div>


<script>

    // Prevent selecting a past date

    const dateInput =
        document.getElementById("appointmentDate");

    const today =
        new Date().toISOString().split("T")[0];

    dateInput.min = today;

</script>

</body>

</html>