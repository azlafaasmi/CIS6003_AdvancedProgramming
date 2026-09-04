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
import model.Treatment;
import service.TreatmentService;

@WebServlet("/treatments")
public class TreatmentServlet extends HttpServlet {

    private TreatmentService treatmentService;

    @Override
    public void init() {
        treatmentService = new TreatmentService();
    }


    // ==============================
    // GET
    // ==============================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {

            listTreatments(request, response);

        } else if (action.equals("add")) {

            showAddForm(request, response);

        } else if (action.equals("edit")) {

            showEditForm(request, response);

        } else if (action.equals("delete")) {

            deleteTreatment(request, response);

        } else if (action.equals("search")) {

            searchTreatments(request, response);

        } else {

            listTreatments(request, response);
        }
    }


    // ==============================
    // POST
    // ==============================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            addTreatment(request, response);

        } else if ("update".equals(action)) {

            updateTreatment(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/treatments");
        }
    }


    // ==============================
    // List Treatments
    // ==============================
    private void listTreatments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Treatment> treatments =
                treatmentService.getAllTreatments();

        request.setAttribute(
                "treatments",
                treatments);

        request.getRequestDispatcher(
                "/views/treatments/treatments.jsp"
        ).forward(request, response);
    }


    // ==============================
    // Show Add Form
    // ==============================
    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/treatments/add-treatment.jsp"
        ).forward(request, response);
    }


    // ==============================
    // Add Treatment
    // ==============================
    private void addTreatment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String treatmentName =
                request.getParameter("treatmentName");

        String treatmentPrice =
                request.getParameter("treatmentPrice");

        HttpSession session =
                request.getSession();

        try {

            BigDecimal price =
                    new BigDecimal(
                            treatmentPrice != null
                                    ? treatmentPrice.trim()
                                    : "");

            Treatment treatment =
                    new Treatment();

            treatment.setTreatmentName(
                    treatmentName != null
                            ? treatmentName.trim()
                            : "");

            treatment.setTreatmentPrice(price);

            boolean success =
                    treatmentService.addTreatment(
                            treatment);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Treatment added successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to add treatment. "
                        + "Please check the entered details "
                        + "or treatment name.");

            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Please enter a valid treatment price.");
        }

        response.sendRedirect(
                request.getContextPath()
                + "/treatments");
    }


    // ==============================
    // Show Edit Form
    // ==============================
    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id =
                request.getParameter("id");

        try {

            int treatmentId =
                    Integer.parseInt(id);

            Treatment treatment =
                    treatmentService.getTreatmentById(
                            treatmentId);

            if (treatment == null) {

                request.getSession().setAttribute(
                        "errorMessage",
                        "Treatment not found.");

                response.sendRedirect(
                        request.getContextPath()
                        + "/treatments");

                return;
            }

            request.setAttribute(
                    "treatment",
                    treatment);

            request.getRequestDispatcher(
                    "/views/treatments/add-treatment.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Invalid treatment ID.");

            response.sendRedirect(
                    request.getContextPath()
                    + "/treatments");
        }
    }


    // ==============================
    // Update Treatment
    // ==============================
    private void updateTreatment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int treatmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "treatmentId"));

            String treatmentName =
                    request.getParameter(
                            "treatmentName");

            String treatmentPrice =
                    request.getParameter(
                            "treatmentPrice");

            BigDecimal price =
                    new BigDecimal(
                            treatmentPrice != null
                                    ? treatmentPrice.trim()
                                    : "");

            Treatment treatment =
                    new Treatment();

            treatment.setTreatmentId(
                    treatmentId);

            treatment.setTreatmentName(
                    treatmentName != null
                            ? treatmentName.trim()
                            : "");

            treatment.setTreatmentPrice(price);

            boolean success =
                    treatmentService.updateTreatment(
                            treatment);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Treatment updated successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to update treatment. "
                        + "Please check the entered details.");

            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Please enter a valid treatment ID "
                    + "and price.");
        }

        response.sendRedirect(
                request.getContextPath()
                + "/treatments");
    }


    // ==============================
    // Delete Treatment
    // ==============================
    private void deleteTreatment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int treatmentId =
                    Integer.parseInt(
                            request.getParameter("id"));

            boolean success =
                    treatmentService.deleteTreatment(
                            treatmentId);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Treatment deleted successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to delete treatment. "
                        + "The treatment may be linked "
                        + "to existing appointments.");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid treatment ID.");
        }

        response.sendRedirect(
                request.getContextPath()
                + "/treatments");
    }


    // ==============================
    // Search Treatments
    // ==============================
    private void searchTreatments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Treatment> treatments =
                treatmentService.searchTreatments(
                        keyword);

        request.setAttribute(
                "treatments",
                treatments);

        request.setAttribute(
                "searchKeyword",
                keyword);

        request.getRequestDispatcher(
                "/views/treatments/treatments.jsp"
        ).forward(request, response);
    }
}