<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add Patient - Sunrise Dental Clinic</title>

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

        .required {
            color: red;
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

        .alert-danger {
            margin-bottom: 20px;
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

            <h1>Add Patient</h1>

            <p>
                Register a new patient in the clinic.
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


        <form method="post"
              action="${pageContext.request.contextPath}/patients?action=add">

            <div class="form-row">

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
                           value="<%= request.getAttribute("patient") != null
                                    ? ((model.Patient) request.getAttribute("patient")).getPatientName()
                                    : "" %>">

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
                           placeholder="e.g. 0771234567"
                           value="<%= request.getAttribute("patient") != null
                                    ? ((model.Patient) request.getAttribute("patient")).getContactNumber()
                                    : "" %>">

                </div>


                <div class="form-group">

                    <label for="email">
                        Email
                    </label>

                    <input type="email"
                           id="email"
                           name="email"
                           maxlength="100"
                           placeholder="patient@example.com"
                           value="<%= request.getAttribute("patient") != null
                                    ? ((model.Patient) request.getAttribute("patient")).getEmail()
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
                              required><%= request.getAttribute("patient") != null
                                    ? ((model.Patient) request.getAttribute("patient")).getAddress()
                                    : "" %></textarea>

                </div>

            </div>


            <div class="form-actions">

                <button type="submit"
                        class="btn btn-primary">
                    Add Patient
                </button>

                <a href="${pageContext.request.contextPath}/patients"
                   class="btn btn-secondary">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</div>

</body>

</html>