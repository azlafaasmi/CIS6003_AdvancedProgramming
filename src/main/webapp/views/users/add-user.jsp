<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Add User - Sunrise Dental Clinic</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/style.css">

<style>

    .page-container {
        width: 95%;
        max-width: 800px;
        margin: 30px auto;
    }

    .page-header {
        margin-bottom: 25px;
    }

    .page-header h1 {
        margin-bottom: 5px;
    }

    .form-card {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 7px;
        font-weight: bold;
    }

    .form-control {
        width: 100%;
        padding: 11px;
        border: 1px solid #ced4da;
        border-radius: 5px;
        font-size: 15px;
        box-sizing: border-box;
    }

    .form-control:focus {
        outline: none;
        border-color: #0d6efd;
    }

    .help-text {
        display: block;
        margin-top: 5px;
        color: #6c757d;
        font-size: 13px;
    }

    .button-group {
        margin-top: 25px;
    }

    .btn {
        display: inline-block;
        padding: 10px 18px;
        border-radius: 6px;
        text-decoration: none;
        border: none;
        cursor: pointer;
        font-size: 14px;
    }

    .btn-primary {
        background: #0d6efd;
        color: white;
    }

    .btn-secondary {
        background: #6c757d;
        color: white;
    }

    .btn:hover {
        opacity: 0.9;
    }

</style>


</head>

<body>

<div class="page-container">


<!-- =====================================================
     PAGE HEADER
     ===================================================== -->

<div class="page-header">

    <h1>Add New User</h1>

    <p>
        Create a new system user for Sunrise Dental Clinic.
    </p>

</div>


<!-- =====================================================
     FORM
     ===================================================== -->

<div class="form-card">

    <form method="post"
          action="<%= request.getContextPath() %>/users">

        <input type="hidden"
               name="action"
               value="add">


        <!-- USERNAME -->

        <div class="form-group">

            <label for="username">
                Username
            </label>

            <input type="text"
                   id="username"
                   name="username"
                   class="form-control"
                   maxlength="50"
                   required
                   autocomplete="off">

            <small class="help-text">
                Enter a unique username.
            </small>

        </div>


        <!-- PASSWORD -->

        <div class="form-group">

            <label for="password">
                Password
            </label>

            <input type="password"
                   id="password"
                   name="password"
                   class="form-control"
                   minlength="6"
                   required
                   autocomplete="new-password">

            <small class="help-text">
                Password must contain at least 6 characters.
            </small>

        </div>


        <!-- FULL NAME -->

        <div class="form-group">

            <label for="fullName">
                Full Name
            </label>

            <input type="text"
                   id="fullName"
                   name="fullName"
                   class="form-control"
                   maxlength="100"
                   required>

        </div>


        <!-- ROLE -->

        <div class="form-group">

            <label for="role">
                Role
            </label>

            <select id="role"
                    name="role"
                    class="form-control"
                    required>

                <option value="">
                    -- Select Role --
                </option>

                <option value="ADMIN">
                    ADMIN
                </option>

                <option value="RECEPTIONIST">
                    RECEPTIONIST
                </option>

            </select>

        </div>


        <!-- BUTTONS -->

        <div class="button-group">

            <button type="submit"
                    class="btn btn-primary">
                Add User
            </button>

            <a href="<%= request.getContextPath() %>/users"
               class="btn btn-secondary">
                Cancel
            </a>

        </div>

    </form>

</div>

</div>

</body>

</html>
