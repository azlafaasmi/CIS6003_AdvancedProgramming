<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sunrise Dental Clinic</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body{
            background:#f4f7fa;
            color:#333;
        }

        .navbar{
            background:#0d6efd;
            color:white;
            padding:15px 40px;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .logo{
            font-size:28px;
            font-weight:bold;
        }

        .login-btn{
            text-decoration:none;
            background:white;
            color:#0d6efd;
            padding:10px 20px;
            border-radius:5px;
            font-weight:bold;
            transition:0.3s;
        }

        .login-btn:hover{
            background:#e9ecef;
        }

        .hero{
            min-height:80vh;
            display:flex;
            align-items:center;
            justify-content:center;
            text-align:center;
            padding:40px;
            background:linear-gradient(rgba(13,110,253,0.85),
                    rgba(13,110,253,0.85)),
                    url('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5');
            background-size:cover;
            background-position:center;
            color:white;
        }

        .hero-content{
            max-width:800px;
        }

        .hero h1{
            font-size:55px;
            margin-bottom:20px;
        }

        .hero p{
            font-size:20px;
            line-height:1.8;
            margin-bottom:30px;
        }

        .hero a{
            display:inline-block;
            background:white;
            color:#0d6efd;
            padding:15px 35px;
            text-decoration:none;
            border-radius:6px;
            font-size:18px;
            font-weight:bold;
        }

        .features{
            padding:60px 30px;
            text-align:center;
        }

        .features h2{
            margin-bottom:40px;
            color:#0d6efd;
        }

        .feature-container{
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
            gap:25px;
            max-width:1200px;
            margin:auto;
        }

        .card{
            background:white;
            padding:25px;
            border-radius:10px;
            box-shadow:0 3px 10px rgba(0,0,0,0.1);
        }

        .card h3{
            margin-bottom:15px;
            color:#0d6efd;
        }

        .about{
            background:white;
            padding:60px 30px;
            text-align:center;
        }

        .about h2{
            color:#0d6efd;
            margin-bottom:20px;
        }

        .about p{
            max-width:900px;
            margin:auto;
            line-height:1.8;
        }

        footer{
            background:#0d6efd;
            color:white;
            text-align:center;
            padding:20px;
        }

        @media(max-width:768px){
            .hero h1{
                font-size:38px;
            }

            .hero p{
                font-size:18px;
            }
        }
    </style>
</head>
<body>

<!-- Navigation -->
<div class="navbar">
    <div class="logo">🦷 Sunrise Dental Clinic</div>

    <a class="login-btn"
       href="<%= request.getContextPath() %>/login">
        Login
    </a>
</div>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">

        <h1>Welcome to Sunrise Dental Clinic</h1>

        <p>
            Modern Dental Clinic Management System designed to manage
            patients, dentists, treatments, appointments, billing,
            and reports efficiently through a centralized platform.
        </p>

        <a href="<%= request.getContextPath() %>/login">
            Access System
        </a>

    </div>
</section>

<!-- Features -->
<section class="features">

    <h2>System Features</h2>

    <div class="feature-container">

        <div class="card">
            <h3>Patient Management</h3>
            <p>
                Add, update, view and manage patient records efficiently.
            </p>
        </div>

        <div class="card">
            <h3>Dentist Management</h3>
            <p>
                Maintain dentist information and clinic resources.
            </p>
        </div>

        <div class="card">
            <h3>Treatment Management</h3>
            <p>
                Record and organize treatment details and costs.
            </p>
        </div>

        <div class="card">
            <h3>Appointment Scheduling</h3>
            <p>
                Schedule and manage patient appointments with ease.
            </p>
        </div>

        <div class="card">
            <h3>Billing System</h3>
            <p>
                Manage invoices and patient billing information.
            </p>
        </div>

        <div class="card">
            <h3>Reports & Analytics</h3>
            <p>
                Generate appointment and revenue reports instantly.
            </p>
        </div>

    </div>

</section>

<!-- About -->
<section class="about">

    <h2>About the Project</h2>

    <p>
        The Sunrise Dental Clinic Management System is a web-based
        application developed using Java, JSP, Servlets, Maven,
        Apache Tomcat and MySQL. The system helps automate clinic
        operations and improve efficiency by providing centralized
        management of patients, appointments, treatments, billing,
        and reporting.
    </p>

</section>

<!-- Footer -->
<footer>
    <p>
        © 2026 Sunrise Dental Clinic Management System |
        Developed using Java JSP/Servlet Technology
    </p>
</footer>

</body>
</html>