package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ReportService;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {

    private ReportService reportService;

    @Override
    public void init() {
        reportService = new ReportService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "totalAppointments",
                reportService.getTotalAppointments());

        request.setAttribute(
                "pendingAppointments",
                reportService.getPendingAppointments());

        request.setAttribute(
                "completedAppointments",
                reportService.getCompletedAppointments());

        request.setAttribute(
                "cancelledAppointments",
                reportService.getCancelledAppointments());

        request.getRequestDispatcher(
                "/views/reports/appointment-report.jsp")
                .forward(request, response);
    }
}