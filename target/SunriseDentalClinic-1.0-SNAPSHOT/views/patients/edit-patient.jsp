<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="model.Patient" %>

<%
    Patient patient =
            (Patient) request.getAttribute("patient");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Patient - Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        .page-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow:
                0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            text-decoration: none;
        }

        .btn-secondary:hover {
            background: #545b62;
        }

        .required {
            color: red;
        }

        .patient-id {
            background: #f1f3f5;
        }

        @media (max-width: 700px) {

            .form-row {
                grid-template-columns: 1fr;
            }

            .form-group.full-width {
                grid-column: auto;
            }
        }

    </style>

</head>

<body>

<div class="page-container">

    <div class="page-header">

        <div>

            <h1>Edit Patient</h1>

            <p>
                Update patient information.
            </p>

        </div>

        <a href="${pageContext.request.contextPath}/patients"
           class="btn btn-secondary">
            Back to Patients
        </a>

    </div>


    <div class="card">

        <% if (request.getAttribute("error") != null) { %>

            <div class="alert alert-danger">

                <%= request.getAttribute("error") %>

            </div>

        <% } %>


        <% if (patient != null) { %>

            <form method="post"
                  action="${pageContext.request.contextPath}/patients?action=update">

                <input type="hidden"
                       name="patientId"
                       value="<%= patient.getPatientId() %>">


                <div class="form-row">

                    <div class="form-group">

                        <label>
                            Patient ID
                        </label>

                        <input type="text"
                               class="patient-id"
                               value="<%= patient.getPatientId() %>"
                               readonly>

                    </div>


                    <div class="form-group">

                        <label for="patientName">
                            Patient Name
                            <span class="required">*</span>
                        </label>

                        <input type="text"
                               id="patientName"
                               name="patientName"
                               maxlength="100"
                               required
                               value="<%= patient.getPatientName() %>">

                    </div>


                    <div class="form-group">

                        <label for="contactNumber">
                            Contact Number
                            <span class="required">*</span>
                        </label>

                        <input type="text"
                               id="contactNumber"
                               name="contactNumber"
                               maxlength="15"
                               required
                               value="<%= patient.getContactNumber() %>">

                    </div>


                    <div class="form-group">

                        <label for="email">
                            Email
                        </label>

                        <input type="email"
                               id="email"
                               name="email"
                               maxlength="100"
                               value="<%= patient.getEmail() != null
                                        ? patient.getEmail()
                                        : "" %>">

                    </div>


                    <div class="form-group full-width">

                        <label for="address">
                            Address
                            <span class="required">*</span>
                        </label>

                        <textarea id="address"
                                  name="address"
                                  maxlength="255"
                                  required><%= patient.getAddress() %></textarea>

                    </div>

                </div>


                <div class="form-actions">

                    <button type="submit"
                            class="btn btn-primary">
                        Update Patient
                    </button>

                    <a href="${pageContext.request.contextPath}/patients"
                       class="btn btn-secondary">
                        Cancel
                    </a>

                </div>

            </form>

        <% } else { %>

            <div class="alert alert-danger">
                Patient not found.
            </div>

            <a href="${pageContext.request.contextPath}/patients"
               class="btn btn-secondary">
                Back to Patients
            </a>

        <% } %>

    </div>

</div>

</body>

</html>