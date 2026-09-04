package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.UserService;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    // =========================================================
    // GET REQUESTS
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            listUsers(request, response);
            return;
        }

        switch (action) {

            case "add":
                showAddForm(request, response);
                break;

            case "edit":
                showEditForm(request, response);
                break;

            case "delete":
                deleteUser(request, response);
                break;

            default:
                listUsers(request, response);
                break;
        }
    }

    // =========================================================
    // POST REQUESTS
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/users");

            return;
        }

        switch (action) {

            case "add":
                addUser(request, response);
                break;

            case "update":
                updateUser(request, response);
                break;

            default:

                response.sendRedirect(
                        request.getContextPath() + "/users");

                break;
        }
    }

    // =========================================================
    // LIST USERS
    // =========================================================

    private void listUsers(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users =
                userService.getAllUsers();

        request.setAttribute("users", users);

        request.getRequestDispatcher(
                "/views/users/users.jsp")
                .forward(request, response);
    }

    // =========================================================
    // SHOW ADD USER FORM
    // =========================================================

    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/users/add-user.jsp")
                .forward(request, response);
    }

    // =========================================================
    // ADD USER
    // =========================================================

    private void addUser(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        String fullName =
                request.getParameter("fullName");

        String role =
                request.getParameter("role");

        boolean success =
                userService.addUser(
                        username,
                        password,
                        fullName,
                        role);

        if (success) {

            session.setAttribute(
                    "successMessage",
                    "User added successfully.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/users");

        } else {

            session.setAttribute(
                    "errorMessage",
                    "Unable to add user. "
                    + "Please check the details or "
                    + "make sure the username is unique.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/users?action=add");
        }
    }

    // =========================================================
    // SHOW EDIT USER FORM
    // =========================================================

    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        try {

            int userId =
                    Integer.parseInt(
                            request.getParameter("id"));

            User user =
                    userService.getUserById(userId);

            if (user == null) {

                session.setAttribute(
                        "errorMessage",
                        "User not found.");

                response.sendRedirect(
                        request.getContextPath()
                                + "/users");

                return;
            }

            request.setAttribute(
                    "user",
                    user);

            request.getRequestDispatcher(
                    "/views/users/edit-user.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid user ID.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/users");
        }
    }

    // =========================================================
    // UPDATE USER
    // =========================================================

    private void updateUser(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int userId =
                    Integer.parseInt(
                            request.getParameter("userId"));

            String username =
                    request.getParameter("username");

            String password =
                    request.getParameter("password");

            String fullName =
                    request.getParameter("fullName");

            String role =
                    request.getParameter("role");

            boolean success =
                    userService.updateUser(
                            userId,
                            username,
                            password,
                            fullName,
                            role);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "User updated successfully.");

                response.sendRedirect(
                        request.getContextPath()
                                + "/users");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to update user. "
                        + "Please check the details.");

                response.sendRedirect(
                        request.getContextPath()
                                + "/users?action=edit&id="
                                + userId);
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid user ID.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/users");
        }
    }

    // =========================================================
    // DELETE USER
    // =========================================================

    private void deleteUser(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int userId =
                    Integer.parseInt(
                            request.getParameter("id"));

            boolean success =
                    userService.deleteUser(userId);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "User deleted successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to delete user.");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid user ID.");
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/users");
    }
}