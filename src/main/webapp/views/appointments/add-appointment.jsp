<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Dentist" %>
<%@ page import="model.Treatment" %>

<%
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

    <title>Add Appointment - Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        .appointment-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
        }

        .appointment-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .appointment-title {
            margin-bottom: 25px;
            text-align: center;
        }

        .appointment-title h2 {
            margin-bottom: 8px;
        }

        .appointment-title p {
            color: #666;
            margin: 0;
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

        .empty-message {
            padding: 12px;
            background: #fff3cd;
            border: 1px solid #ffeeba;
            border-radius: 6px;
            color: #856404;
            margin-bottom: 20px;
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

            <h2>Book New Appointment</h2>

            <p>
                Sunrise Dental Clinic
            </p>

        </div>


        <%-- =====================================================
             Check whether required records exist
             ===================================================== --%>

        <% if (patients == null || patients.isEmpty()
                || dentists == null || dentists.isEmpty()
                || treatments == null || treatments.isEmpty()) { %>

            <div class="empty-message">

                <strong>Unable to create appointment.</strong>

                <br><br>

                Please make sure that the following records
                are available:

                <ul>

                    <% if (patients == null || patients.isEmpty()) { %>
                        <li>At least one patient</li>
                    <% } %>

                    <% if (dentists == null || dentists.isEmpty()) { %>
                        <li>At least one dentist</li>
                    <% } %>

                    <% if (treatments == null || treatments.isEmpty()) { %>
                        <li>At least one treatment</li>
                    <% } %>

                </ul>

            </div>

        <% } %>


        <%-- =====================================================
             Appointment Form
             ===================================================== --%>

        <form method="post"
              action="${pageContext.request.contextPath}/appointments">

            <input type="hidden"
                   name="action"
                   value="add">


            <%-- =================================================
                 Patient
                 ================================================= --%>

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

                    <% if (patients != null) {

                        for (Patient patient : patients) { %>

                            <option value="<%= patient.getPatientId() %>">

                                <%= patient.getPatientName() %>

                                -
                                <%= patient.getContactNumber() %>

                            </option>

                    <%  }

                       } %>

                </select>

            </div>


            <%-- =================================================
                 Dentist
                 ================================================= --%>

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

                    <% if (dentists != null) {

                        for (Dentist dentist : dentists) { %>

                            <option value="<%= dentist.getDentistId() %>">

                                <%= dentist.getDentistName() %>

                                <% if (dentist.getSpecialization() != null
                                        && !dentist.getSpecialization().trim().isEmpty()) { %>

                                    -
                                    <%= dentist.getSpecialization() %>

                                <% } %>

                            </option>

                    <%  }

                       } %>

                </select>

            </div>


            <%-- =================================================
                 Treatment
                 ================================================= --%>

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

                    <% if (treatments != null) {

                        for (Treatment treatment : treatments) { %>

                            <option value="<%= treatment.getTreatmentId() %>">

                                <%= treatment.getTreatmentName() %>

                                -
                                Rs.
                                <%= treatment.getTreatmentPrice() %>

                            </option>

                    <%  }

                       } %>

                </select>

            </div>


            <%-- =================================================
                 Date and Time
                 ================================================= --%>

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
                           required>

                </div>


            </div>


            <%-- =================================================
                 Buttons
                 ================================================= --%>

            <div class="button-row">

                <button type="submit"
                        class="btn btn-primary">

                    Book Appointment

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