<%@ page import="model.Dentist" %>

<%
    Dentist dentist =
            (Dentist) request.getAttribute("dentist");

    boolean editMode = dentist != null;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>
        <%= editMode
                ? "Edit Dentist"
                : "Add Dentist" %>
        - Sunrise Dental Clinic
    </title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
        }

        .header {
            background-color: #2c7be5;
            color: white;
            padding: 20px;
        }

        .container {
            width: 600px;
            max-width: 90%;
            margin: 30px auto;
        }

        .card {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            margin-top: 20px;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            background-color: #2c7be5;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #1a68d1;
        }

        .cancel {
            display: inline-block;
            margin-left: 10px;
            padding: 11px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>
        Sunrise Dental Clinic
    </h1>

</div>


<div class="container">

    <div class="card">

        <h2>
            <%= editMode
                    ? "Edit Dentist"
                    : "Add New Dentist" %>
        </h2>


        <form method="post"
              action="<%= request.getContextPath() %>/dentists">

            <input type="hidden"
                   name="action"
                   value="<%= editMode
                           ? "update"
                           : "add" %>">


            <% if (editMode) { %>

                <input type="hidden"
                       name="dentistId"
                       value="<%= dentist.getDentistId() %>">

            <% } %>


            <label>
                Dentist Name
            </label>

            <input type="text"
                   name="dentistName"
                   maxlength="100"
                   required
                   value="<%= editMode
                           ? dentist.getDentistName()
                           : "" %>">


            <label>
                Specialization
            </label>

            <input type="text"
                   name="specialization"
                   maxlength="100"
                   required
                   placeholder="e.g. Orthodontist"
                   value="<%= editMode
                           ? dentist.getSpecialization()
                           : "" %>">


            <label>
                Contact Number
            </label>

            <input type="text"
                   name="contactNumber"
                   maxlength="15"
                   required
                   placeholder="e.g. 0771234567"
                   value="<%= editMode
                           ? dentist.getContactNumber()
                           : "" %>">


            <button type="submit">

                <%= editMode
                        ? "Update Dentist"
                        : "Add Dentist" %>

            </button>


            <a class="cancel"
               href="<%= request.getContextPath() %>/dentists">

                Cancel

            </a>

        </form>

    </div>

</div>

</body>

</html>