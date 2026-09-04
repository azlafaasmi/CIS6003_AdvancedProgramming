package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;
import service.PatientService;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() {

        patientService = new PatientService();
    }

    /**
     * Handle GET requests.
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.isBlank()) {

            listPatients(request, response);

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
                deletePatient(request, response);
                break;

            case "search":
                searchPatients(request, response);
                break;

            default:
                listPatients(request, response);
                break;
        }
    }

    /**
     * Handle POST requests.
     */
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {

            addPatient(request, response);

        } else if ("update".equalsIgnoreCase(action)) {

            updatePatient(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/patients"
            );
        }
    }

    /**
     * Display all patients.
     */
    private void listPatients(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Patient> patients =
                patientService.getAllPatients();

        request.setAttribute(
                "patients",
                patients
        );

        request.getRequestDispatcher(
                "/views/patients/patients.jsp"
        ).forward(request, response);
    }

    /**
     * Show Add Patient page.
     */
    private void showAddForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/patients/add-patient.jsp"
        ).forward(request, response);
    }

    /**
     * Show Edit Patient page.
     */
    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        if (idParameter == null
                || idParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/patients"
            );

            return;
        }

        try {

            int patientId =
                    Integer.parseInt(idParameter);

            Patient patient =
                    patientService.getPatientById(
                            patientId);

            if (patient == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/patients"
                );

                return;
            }

            request.setAttribute(
                    "patient",
                    patient
            );

            request.getRequestDispatcher(
                    "/views/patients/edit-patient.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/patients"
            );
        }
    }

    /**
     * Add patient.
     */
    private void addPatient(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String patientName =
                request.getParameter("patientName");

        String address =
                request.getParameter("address");

        String contactNumber =
                request.getParameter("contactNumber");

        String email =
                request.getParameter("email");

        Patient patient = new Patient();

        patient.setPatientName(
                clean(patientName));

        patient.setAddress(
                clean(address));

        patient.setContactNumber(
                clean(contactNumber));

        patient.setEmail(
                clean(email));

        boolean success =
                patientService.addPatient(patient);

        if (success) {

            request.getSession().setAttribute(
                    "successMessage",
                    "Patient added successfully."
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/patients"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Unable to add patient. "
                    + "Please check the information "
                    + "or make sure the contact number "
                    + "is not already registered."
            );

            request.setAttribute(
                    "patient",
                    patient
            );

            request.getRequestDispatcher(
                    "/views/patients/add-patient.jsp"
            ).forward(request, response);
        }
    }

    /**
     * Update patient.
     */
    private void updatePatient(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("patientId");

        try {

            int patientId =
                    Integer.parseInt(idParameter);

            String patientName =
                    request.getParameter("patientName");

            String address =
                    request.getParameter("address");

            String contactNumber =
                    request.getParameter("contactNumber");

            String email =
                    request.getParameter("email");

            Patient patient = new Patient();

            patient.setPatientId(patientId);

            patient.setPatientName(
                    clean(patientName));

            patient.setAddress(
                    clean(address));

            patient.setContactNumber(
                    clean(contactNumber));

            patient.setEmail(
                    clean(email));

            boolean success =
                    patientService.updatePatient(
                            patient);

            if (success) {

                request.getSession().setAttribute(
                        "successMessage",
                        "Patient updated successfully."
                );

                response.sendRedirect(
                        request.getContextPath()
                        + "/patients"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Unable to update patient. "
                        + "Please check the information "
                        + "or make sure the contact number "
                        + "is not already registered."
                );

                request.setAttribute(
                        "patient",
                        patient
                );

                request.getRequestDispatcher(
                        "/views/patients/edit-patient.jsp"
                ).forward(request, response);
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/patients"
            );
        }
    }

    /**
     * Delete patient.
     */
    private void deletePatient(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String idParameter =
                request.getParameter("id");

        try {

            int patientId =
                    Integer.parseInt(idParameter);

            boolean success =
                    patientService.deletePatient(
                            patientId);

            if (success) {

                request.getSession().setAttribute(
                        "successMessage",
                        "Patient deleted successfully."
                );

            } else {

                request.getSession().setAttribute(
                        "errorMessage",
                        "Unable to delete patient. "
                        + "The patient may be linked "
                        + "to an existing appointment."
                );
            }

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "errorMessage",
                    "Invalid patient ID."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                + "/patients"
        );
    }

    /**
     * Search patients.
     */
    private void searchPatients(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Patient> patients =
                patientService.searchPatients(keyword);

        request.setAttribute(
                "patients",
                patients
        );

        request.setAttribute(
                "searchKeyword",
                keyword
        );

        request.getRequestDispatcher(
                "/views/patients/patients.jsp"
        ).forward(request, response);
    }

    /**
     * Remove unnecessary whitespace.
     */
    private String clean(String value) {

        if (value == null) {
            return "";
        }

        return value.trim();
    }
}