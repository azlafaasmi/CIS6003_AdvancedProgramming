package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Dentist;
import service.DentistService;

@WebServlet("/dentists")
public class DentistServlet extends HttpServlet {

    private DentistService dentistService;


    @Override
    public void init() {
        dentistService = new DentistService();
    }


    // ==============================
    // GET
    // ==============================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        if (action == null ||
            action.equals("list")) {

            listDentists(request, response);

        } else if (action.equals("add")) {

            showAddForm(request, response);

        } else if (action.equals("edit")) {

            showEditForm(request, response);

        } else if (action.equals("delete")) {

            deleteDentist(request, response);

        } else if (action.equals("search")) {

            searchDentists(request, response);

        } else {

            listDentists(request, response);
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

        String action =
                request.getParameter("action");

        if ("add".equals(action)) {

            addDentist(request, response);

        } else if ("update".equals(action)) {

            updateDentist(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/dentists");
        }
    }


    // ==============================
    // List
    // ==============================
    private void listDentists(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Dentist> dentists =
                dentistService.getAllDentists();

        request.setAttribute(
                "dentists",
                dentists);

        request.getRequestDispatcher(
                "/views/dentists/dentists.jsp"
        ).forward(request, response);
    }


    // ==============================
    // Add Form
    // ==============================
    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/dentists/add-dentist.jsp"
        ).forward(request, response);
    }


    // ==============================
    // Add Dentist
    // ==============================
    private void addDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String dentistName =
                request.getParameter("dentistName");

        String specialization =
                request.getParameter("specialization");

        String contactNumber =
                request.getParameter("contactNumber");


        Dentist dentist = new Dentist();

        dentist.setDentistName(
                dentistName != null
                        ? dentistName.trim()
                        : "");

        dentist.setSpecialization(
                specialization != null
                        ? specialization.trim()
                        : "");

        dentist.setContactNumber(
                contactNumber != null
                        ? contactNumber.trim()
                        : "");


        boolean success =
                dentistService.addDentist(dentist);


        HttpSession session =
                request.getSession();

        if (success) {

            session.setAttribute(
                    "successMessage",
                    "Dentist added successfully.");

        } else {

            session.setAttribute(
                    "errorMessage",
                    "Unable to add dentist. "
                    + "Please check the entered details "
                    + "or contact number.");
        }


        response.sendRedirect(
                request.getContextPath()
                + "/dentists");
    }


    // ==============================
    // Edit Form
    // ==============================
    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id =
                request.getParameter("id");

        try {

            int dentistId =
                    Integer.parseInt(id);

            Dentist dentist =
                    dentistService.getDentistById(
                            dentistId);

            if (dentist == null) {

                request.getSession().setAttribute(
                        "errorMessage",
                        "Dentist not found.");

                response.sendRedirect(
                        request.getContextPath()
                        + "/dentists");

                return;
            }

            request.setAttribute(
                    "dentist",
                    dentist);

            request.getRequestDispatcher(
                    "/views/dentists/add-dentist.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Invalid dentist ID.");

            response.sendRedirect(
                    request.getContextPath()
                    + "/dentists");
        }
    }


    // ==============================
    // Update
    // ==============================
    private void updateDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                            request.getParameter(
                                    "dentistId"));

            String dentistName =
                    request.getParameter(
                            "dentistName");

            String specialization =
                    request.getParameter(
                            "specialization");

            String contactNumber =
                    request.getParameter(
                            "contactNumber");


            Dentist dentist =
                    new Dentist();

            dentist.setDentistId(dentistId);

            dentist.setDentistName(
                    dentistName != null
                            ? dentistName.trim()
                            : "");

            dentist.setSpecialization(
                    specialization != null
                            ? specialization.trim()
                            : "");

            dentist.setContactNumber(
                    contactNumber != null
                            ? contactNumber.trim()
                            : "");


            boolean success =
                    dentistService.updateDentist(
                            dentist);


            HttpSession session =
                    request.getSession();


            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Dentist updated successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to update dentist. "
                        + "Please check the entered details.");
            }


        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Invalid dentist ID.");
        }


        response.sendRedirect(
                request.getContextPath()
                + "/dentists");
    }


    // ==============================
    // Delete
    // ==============================
    private void deleteDentist(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        try {

            int dentistId =
                    Integer.parseInt(
                            request.getParameter("id"));

            boolean success =
                    dentistService.deleteDentist(
                            dentistId);

            HttpSession session =
                    request.getSession();


            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Dentist deleted successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to delete dentist. "
                        + "The dentist may be linked "
                        + "to existing appointments.");
            }

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Invalid dentist ID.");
        }


        response.sendRedirect(
                request.getContextPath()
                + "/dentists");
    }


    // ==============================
    // Search
    // ==============================
    private void searchDentists(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Dentist> dentists =
                dentistService.searchDentists(keyword);

        request.setAttribute(
                "dentists",
                dentists);

        request.setAttribute(
                "searchKeyword",
                keyword);

        request.getRequestDispatcher(
                "/views/dentists/dentists.jsp"
        ).forward(request, response);
    }
}