package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.RevenueReportService;

@WebServlet("/revenue-report")
public class RevenueReportServlet extends HttpServlet {

    private RevenueReportService revenueReportService;

    @Override
    public void init() {

        revenueReportService =
                new RevenueReportService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "totalBills",
                revenueReportService.getTotalBills());

        request.setAttribute(
                "paidBills",
                revenueReportService.getPaidBills());

        request.setAttribute(
                "unpaidBills",
                revenueReportService.getUnpaidBills());

        request.setAttribute(
                "totalRevenue",
                revenueReportService.getTotalRevenue());

        request.setAttribute(
                "paidRevenue",
                revenueReportService.getPaidRevenue());

        request.setAttribute(
                "unpaidRevenue",
                revenueReportService.getUnpaidRevenue());

        request.getRequestDispatcher(
                "/views/reports/revenue-report.jsp")
                .forward(request, response);
    }
}