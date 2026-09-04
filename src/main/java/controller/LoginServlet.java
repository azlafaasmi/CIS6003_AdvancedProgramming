package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.LoginService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private LoginService loginService;

    @Override
    public void init() {
        loginService = new LoginService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/auth/login.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = loginService.login(username, password);

        if (user != null) {

    HttpSession session = request.getSession();

    String role = user.getRole();

    session.setAttribute("user", user);
    session.setAttribute("userId", user.getUserId());
    session.setAttribute("username", user.getUsername());
    session.setAttribute("fullName", user.getFullName());
    session.setAttribute("role", role);

    if ("ADMIN".equalsIgnoreCase(role)) {

        response.sendRedirect(
                request.getContextPath()
                + "/admin/dashboard");

    } else if ("RECEPTIONIST".equalsIgnoreCase(role)) {

        response.sendRedirect(
                request.getContextPath()
                + "/receptionist/dashboard");

    } else {

        response.sendRedirect(
                request.getContextPath()
                + "/login");
    }

} else {

    request.setAttribute(
            "error",
            "Invalid username or password."
    );

    request.getRequestDispatcher(
            "/views/auth/login.jsp"
    ).forward(request, response);
}
            }

}