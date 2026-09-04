<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
model.Treatment treatment =
(model.Treatment) request.getAttribute("treatment");

boolean editMode = treatment != null;

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>
    <%= editMode ? "Edit Treatment" : "Add Treatment" %>
    - Sunrise Dental Clinic
</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/style.css">

<style>

    body {
        margin: 0;
        padding: 0;

        font-family: Arial, Helvetica, sans-serif;

        background:
            linear-gradient(
                rgba(255,255,255,0.90),
                rgba(240,248,255,0.95)
            ),
            url("https://images.unsplash.com/photo-1606811971618-4486d14f3f99?auto=format&fit=crop&w=1600&q=80");

        background-size: cover;
        background-position: center;
        background-attachment: fixed;
    }

    .container {
        width: 90%;
        max-width: 650px;

        margin: 60px auto;

        padding: 35px;

        background: rgba(255,255,255,0.97);

        border-radius: 18px;

        box-shadow:
            0 10px 35px rgba(0,0,0,0.15);
    }

    h1 {
        margin-top: 0;
        margin-bottom: 30px;

        color: #0d6efd;

        font-size: 30px;

        font-weight: 700;

        border-bottom: 3px solid #0d6efd;

        padding-bottom: 12px;
    }

    .mb-3 {
        margin-bottom: 22px;
    }

    label {
        display: block;

        margin-bottom: 8px;

        font-weight: 600;

        color: #333;

        font-size: 15px;
    }

    .form-control {
        width: 100%;

        box-sizing: border-box;

        padding: 12px 14px;

        border: 1px solid #ced4da;

        border-radius: 8px;

        font-size: 15px;

        outline: none;

        transition: 0.2s;
    }

    .form-control:focus {
        border-color: #0d6efd;

        box-shadow:
            0 0 0 3px rgba(13,110,253,0.15);
    }

    .btn {
        display: inline-block;

        padding: 11px 20px;

        margin-right: 8px;

        border-radius: 8px;

        border: none;

        text-decoration: none;

        font-size: 15px;

        font-weight: 600;

        cursor: pointer;

        transition: 0.25s;
    }

    .btn:hover {
        transform: translateY(-2px);

        box-shadow:
            0 5px 12px rgba(0,0,0,0.15);
    }

    .btn-primary {
        background: #0d6efd;

        color: white;
    }

    .btn-secondary {
        background: #6c757d;

        color: white;
    }

    @media (max-width: 768px) {

        .container {
            width: 85%;

            margin: 25px auto;

            padding: 25px;
        }

        h1 {
            font-size: 25px;
        }

        .btn {
            margin-bottom: 8px;
        }

    }

</style>

</head>

<body>

<div class="container">

<h1>
    <%= editMode ? "Edit Treatment" : "Add Treatment" %>
</h1>


<form method="post"
      action="<%= request.getContextPath() %>/treatments">

    <input type="hidden"
           name="action"
           value="<%= editMode ? "update" : "add" %>">


    <% if (editMode) { %>

        <input type="hidden"
               name="treatmentId"
               value="<%= treatment.getTreatmentId() %>">

    <% } %>


    <!-- Treatment Name -->

    <div class="mb-3">

        <label for="treatmentName">
            Treatment Name
        </label>

        <input type="text"
               id="treatmentName"
               name="treatmentName"
               class="form-control"
               maxlength="100"
               required
               value="<%= editMode
                       ? treatment.getTreatmentName()
                       : "" %>">

    </div>


    <!-- Treatment Price -->

    <div class="mb-3">

        <label for="treatmentPrice">
            Treatment Price (LKR)
        </label>

        <input type="number"
               id="treatmentPrice"
               name="treatmentPrice"
               class="form-control"
               min="0.01"
               step="0.01"
               required
               value="<%= editMode
                       ? treatment.getTreatmentPrice()
                       : "" %>">

    </div>


    <!-- Buttons -->

    <button type="submit"
            class="btn btn-primary">

        <%= editMode
                ? "Update Treatment"
                : "Add Treatment" %>

    </button>


    <a href="<%= request.getContextPath() %>/treatments"
       class="btn btn-secondary">

        Cancel

    </a>

</form>

</div>

</body>

</html>