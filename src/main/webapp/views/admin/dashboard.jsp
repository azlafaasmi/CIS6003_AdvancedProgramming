<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(
            request.getContextPath() + "/login"
        );
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendError(
            HttpServletResponse.SC_FORBIDDEN,
            "Access denied."
        );
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>
        Admin Dashboard - Sunrise Dental Clinic
    </title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            min-height: 100vh;

            background-image:
                linear-gradient(
                    rgba(244, 246, 249, 0.82),
                    rgba(244, 246, 249, 0.88)
                ),
                url("https://completesmilesbv.com.au/wp-content/uploads/2025/05/image_7cf549fd02377ef8c2be517be7b8f90c.jpeg");

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;

            color: #333;
        }

        .header {
            background-color: rgba(44, 123, 229, 0.95);
            color: white;
            padding: 20px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .header h1 {
            margin: 0;
        }

        .header p {
            margin: 6px 0 0;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 10px;

            box-shadow:
                0 3px 12px rgba(0, 0, 0, 0.12);

            backdrop-filter: blur(3px);
        }

        .welcome {
            border-left: 6px solid #2c7be5;
        }

        .menu {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .menu a {
            display: inline-block;

            padding: 15px 20px;

            background-color: #2c7be5;
            color: white;

            text-decoration: none;

            border-radius: 6px;

            font-weight: bold;

            transition:
                background-color 0.2s,
                transform 0.2s,
                box-shadow 0.2s;
        }

        .menu a:hover {
            background-color: #1a68d1;

            transform: translateY(-2px);

            box-shadow:
                0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .report {
            background-color: #198754 !important;
        }

        .report:hover {
            background-color: #157347 !important;
        }

        .logout {
            background-color: #dc3545 !important;
        }

        .logout:hover {
            background-color: #b02a37 !important;
        }

        @media (max-width: 600px) {

            .container {
                width: 95%;
            }

            .header {
                padding: 15px;
            }

            .header h1 {
                font-size: 24px;
            }

            .menu {
                flex-direction: column;
            }

            .menu a {
                width: 100%;
                text-align: center;
            }
        }

    </style>

</head>

<body>

<div class="header">

    <h1>
        Sunrise Dental Clinic
    </h1>

    <p>
        Administrator Dashboard
    </p>

</div>


<div class="container">

    <!-- Welcome -->

    <div class="card welcome">

        <h2>
            Welcome, <%= user.getFullName() %>
        </h2>

        <p>
            <strong>Username:</strong>
            <%= user.getUsername() %>
        </p>

        <p>
            <strong>Role:</strong>
            <%= user.getRole() %>
        </p>

    </div>


    <!-- Management -->

    <div class="card">

        <h3>
            System Management
        </h3>

        <div class="menu">

            <a href="<%= request.getContextPath() %>/users">
             Manage Users
            </a>

            <a href="<%= request.getContextPath() %>/dentists">
                Manage Dentists
            </a>

            <a href="<%= request.getContextPath() %>/treatments">
                 Manage Treatments
            </a>

            <a href="<%= request.getContextPath() %>/patients">
                Manage Patients
            </a>

            <a href="<%= request.getContextPath() %>/appointments">
                Manage Appointments
            </a>

            <a href="<%= request.getContextPath() %>/billing">
                 Billing
            </a>

        </div>

    </div>


    <!-- Reports -->

    <div class="card">

        <h3>
            Reports
        </h3>

        <div class="menu">

            <a class="report"
               href="<%= request.getContextPath() %>/revenue-report">

                Revenue Report

            </a>

            <a class="report"
               href="<%= request.getContextPath() %>/reports">

              Appointment Report

            </a>

        </div>

    </div>


    <!-- Other -->

    <div class="card">

        <h3>
            Other

        </h3>

        <div class="menu">

            <a href="<%= request.getContextPath() %>/help">
                Help
            </a>

            <a class="logout"
               href="<%= request.getContextPath() %>/logout">

                Logout

            </a>

        </div>

    </div>

</div>

</body>
</html>