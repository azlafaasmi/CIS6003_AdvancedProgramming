<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Search Appointment - Sunrise Dental Clinic</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 600px;
            margin: 70px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.12);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #34495e;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 15px;
        }

        .buttons {
            text-align: center;
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            padding: 11px 20px;
            margin: 5px;
            border-radius: 5px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-search {
            background-color: #3498db;
            color: white;
        }

        .btn-search:hover {
            background-color: #2980b9;
        }

        .btn-back {
            background-color: #7f8c8d;
            color: white;
        }

        .btn-back:hover {
            background-color: #636e72;
        }

        .info {
            background-color: #ecf0f1;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            color: #555;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

    </style>

</head>

<body>

<div class="container">

    <h2>🔎 Search Appointment</h2>

    <div class="info">
        Enter the appointment number to search for a specific appointment.
    </div>

    <%
        String errorMessage =
                (String) session.getAttribute("errorMessage");

        if (errorMessage != null) {
    %>

        <div class="error">
            <%= errorMessage %>
        </div>

    <%
            session.removeAttribute("errorMessage");
        }
    %>

    <form action="<%= request.getContextPath() %>/appointments"
          method="get">

        <input type="hidden"
               name="action"
               value="search">

        <div class="form-group">

            <label for="appointmentNo">
                Appointment Number
            </label>

            <input type="text"
                   id="appointmentNo"
                   name="appointmentNo"
                   placeholder="Example: APT-20260903123045-1"
                   required>

        </div>

        <div class="buttons">

            <button type="submit"
                    class="btn btn-search">
                Search Appointment
            </button>

            <a href="<%= request.getContextPath() %>/appointments"
               class="btn btn-back">
                Back to Appointments
            </a>

        </div>

    </form>

</div>

</body>
</html>