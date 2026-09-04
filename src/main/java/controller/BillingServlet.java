package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Appointment;
import model.Bill;
import model.Treatment;
import service.AppointmentService;
import service.BillingService;
import service.TreatmentService;

@WebServlet("/billing")
public class BillingServlet extends HttpServlet {

    private BillingService billingService;
    private AppointmentService appointmentService;
    private TreatmentService treatmentService;

    @Override
    public void init() {

        billingService = new BillingService();
        appointmentService = new AppointmentService();
        treatmentService = new TreatmentService();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {

            showBills(request, response);

            return;
        }

        switch (action) {

            case "generate":
                showGenerateBillForm(request, response);
                break;

            case "details":
                showBillDetails(request, response);
                break;

            case "receipt":
                showReceipt(request, response);
                break;

            case "delete":
                deleteBill(request, response);
                break;

            default:
                showBills(request, response);
                break;
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {

            response.sendRedirect(
                    request.getContextPath() + "/billing");

            return;
        }

        switch (action) {

            case "generate":
                generateBill(request, response);
                break;

            case "payment":
                updatePaymentStatus(request, response);
                break;

            default:
                response.sendRedirect(
                        request.getContextPath() + "/billing");
                break;
        }
    }


    /**
     * Display all bills.
     */
    private void showBills(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Bill> bills =
                billingService.getAllBills();

        request.setAttribute(
                "bills",
                bills);

        request.getRequestDispatcher(
                "/views/billing/bill-details.jsp"
        ).forward(request, response);
    }


    /**
     * Display generate bill page.
     */
    private void showGenerateBillForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Appointment> appointments =
                appointmentService.getAllAppointments();

        List<Treatment> treatments =
                treatmentService.getAllTreatments();

        request.setAttribute(
                "appointments",
                appointments);

        request.setAttribute(
                "treatments",
                treatments);

        request.setAttribute(
                "consultationFee",
                billingService.getConsultationFee());

        request.getRequestDispatcher(
                "/views/billing/generate-bill.jsp"
        ).forward(request, response);
    }


    /**
     * Generate a bill.
     */
    private void generateBill(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "appointmentId"));

            String treatmentFeeString =
                    request.getParameter(
                            "treatmentFee");

            BigDecimal treatmentFee =
                    new BigDecimal(
                            treatmentFeeString);

            boolean success =
                    billingService.generateBill(
                            appointmentId,
                            treatmentFee);

            if (success) {

                Bill bill =
                        billingService
                                .getBillByAppointmentId(
                                        appointmentId);

                session.setAttribute(
                        "successMessage",
                        "Bill generated successfully.");

                if (bill != null) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/billing?action=details&id="
                                    + bill.getBillId());

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/billing");
                }

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to generate bill. "
                        + "A bill may already exist for this appointment.");

                response.sendRedirect(
                        request.getContextPath()
                                + "/billing?action=generate");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid appointment or treatment fee.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/billing?action=generate");
        }
    }


    /**
     * Display bill details.
     */
    private void showBillDetails(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        try {

            int billId =
                    Integer.parseInt(
                            request.getParameter("id"));

            Bill bill =
                    billingService.getBillById(
                            billId);

            if (bill == null) {

                session.setAttribute(
                        "errorMessage",
                        "Bill not found.");

                response.sendRedirect(
                        request.getContextPath()
                                + "/billing");

                return;
            }

            request.setAttribute(
                    "bill",
                    bill);

            request.getRequestDispatcher(
                    "/views/billing/bill-details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid bill ID.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/billing");
        }
    }


    /**
     * Display printable receipt.
     */
    private void showReceipt(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        try {

            int billId =
                    Integer.parseInt(
                            request.getParameter("id"));

            Bill bill =
                    billingService.getBillById(
                            billId);

            if (bill == null) {

                session.setAttribute(
                        "errorMessage",
                        "Bill not found.");

                response.sendRedirect(
                        request.getContextPath()
                                + "/billing");

                return;
            }

            request.setAttribute(
                    "bill",
                    bill);

            request.getRequestDispatcher(
                    "/views/billing/receipt.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid bill ID.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/billing");
        }
    }


    /**
     * Update payment status.
     */
    private void updatePaymentStatus(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int billId =
                    Integer.parseInt(
                            request.getParameter("billId"));

            String paymentStatus =
                    request.getParameter(
                            "paymentStatus");

            boolean success =
                    billingService.updatePaymentStatus(
                            billId,
                            paymentStatus);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Payment status updated successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to update payment status.");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid bill ID.");
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/billing");
    }


    /**
     * Delete a bill.
     */
    private void deleteBill(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int billId =
                    Integer.parseInt(
                            request.getParameter("id"));

            boolean success =
                    billingService.deleteBill(
                            billId);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Bill deleted successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to delete bill.");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid bill ID.");
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/billing");
    }
}