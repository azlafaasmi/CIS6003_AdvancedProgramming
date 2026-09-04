
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Sunrise Dental Clinic - Login</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        /* =========================================
           Header
           ========================================= */

        .site-header {
            position: fixed;

            top: 0;
            left: 0;

            width: 100%;

            height: 70px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 40px;

            background: rgba(255, 255, 255, 0.96);

            box-shadow:
                0 2px 10px rgba(0, 0, 0, 0.12);

            z-index: 1000;
        }

        .logo {
            font-size: 22px;

            font-weight: bold;

            color: #267ace;
        }

        .clinic-info {
            font-size: 14px;

            color: #666;
        }


        /* =========================================
           Login Container
           ========================================= */

        .login-container {
            min-height: 100vh;

            padding-top: 90px;
            padding-bottom: 80px;
        }


        /* =========================================
           Footer
           ========================================= */

        .site-footer {
            position: fixed;

            bottom: 0;
            left: 0;

            width: 100%;

            background: rgba(255, 255, 255, 0.96);

            color: #666;

            text-align: center;

            padding: 14px;

            font-size: 13px;

            box-shadow:
                0 -2px 10px rgba(0, 0, 0, 0.08);

            z-index: 1000;
        }


        /* =========================================
           Mobile
           ========================================= */

        @media (max-width: 600px) {

            .site-header {
                padding: 0 20px;
            }

            .logo {
                font-size: 18px;
            }

            .clinic-info {
                display: none;
            }

            .login-container {
                padding-top: 85px;
                padding-bottom: 70px;
            }
        }

    </style>

</head>


<body>


    <!-- =========================================
         Header
         ========================================= -->

    <header class="site-header">

        <div class="logo">
            🦷 Sunrise Dental Clinic
        </div>

        <div class="clinic-info">
            Dental Clinic Management System
        </div>

    </header>



    <!-- =========================================
         Login Section
         ========================================= -->

    <div class="login-container">

        <div class="login-card">

            <h1>Sunrise Dental Clinic</h1>

            <p class="subtitle">
                Dental Clinic Management System
            </p>


            <!-- Error Message -->

            <% if (request.getAttribute("error") != null) { %>

                <div class="alert alert-danger">

                    <%= request.getAttribute("error") %>

                </div>

            <% } %>


            <!-- Login Form -->

            <form method="post"
                  action="${pageContext.request.contextPath}/login">


                <div class="form-group">

                    <label for="username">
                        Username
                    </label>

                    <input type="text"
                           id="username"
                           name="username"
                           required
                           autocomplete="username">

                </div>



                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <input type="password"
                           id="password"
                           name="password"
                           required
                           autocomplete="current-password">

                </div>



                <button type="submit"
                        class="btn btn-primary">

                    Login

                </button>


            </form>

        </div>

    </div>



    <!-- =========================================
         Footer
         ========================================= -->

    <footer class="site-footer">

        © 2026 Sunrise Dental Clinic |
        Dental Clinic Management System

    </footer>


</body>

</html>

