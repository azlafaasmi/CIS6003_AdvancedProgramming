package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Appointment;
import model.Dentist;
import model.Patient;
import model.Treatment;
import service.AppointmentService;
import service.DentistService;
import service.PatientService;
import service.TreatmentService;

@WebServlet("/appointments")
public class AppointmentServlet extends HttpServlet {

private AppointmentService appointmentService;
private PatientService patientService;
private DentistService dentistService;
private TreatmentService treatmentService;

    @Override
public void init() {

    appointmentService = new AppointmentService();
    patientService = new PatientService();
    dentistService = new DentistService();
    treatmentService = new TreatmentService();
}

    // =========================================================
    // GET
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {

            listAppointments(request, response);

        } else if (action.equals("add")) {

            showAddForm(request, response);

        } else if (action.equals("edit")) {

            showEditForm(request, response);

        } else if (action.equals("delete")) {

            deleteAppointment(request, response);

        } else if (action.equals("search")) {

            searchAppointments(request, response);

        } else {

            listAppointments(request, response);
        }
    }

    // =========================================================
    // POST
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            addAppointment(request, response);

        } else if ("update".equals(action)) {

            updateAppointment(request, response);

        } else if ("status".equals(action)) {

            updateStatus(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/appointments");
        }
    }

    // =========================================================
    // LIST APPOINTMENTS
    // =========================================================

    private void listAppointments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Appointment> appointments =
                appointmentService.getAllAppointments();

        request.setAttribute(
                "appointments",
                appointments);

        request.getRequestDispatcher(
                "/views/appointments/appointments.jsp"
        ).forward(request, response);
    }

    // =========================================================
    // SHOW ADD FORM
    // =========================================================

private void showAddForm(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    List<Patient> patients =
            patientService.getAllPatients();

    List<Dentist> dentists =
            dentistService.getAllDentists();

    List<Treatment> treatments =
            treatmentService.getAllTreatments();

    request.setAttribute(
            "patients",
            patients);

    request.setAttribute(
            "dentists",
            dentists);

    request.setAttribute(
            "treatments",
            treatments);

    request.getRequestDispatcher(
            "/views/appointments/add-appointment.jsp"
    ).forward(request, response);
}

    // =========================================================
    // ADD APPOINTMENT
    // =========================================================

    private void addAppointment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int patientId =
                    Integer.parseInt(
                            request.getParameter(
                                    "patientId"));

            int dentistId =
                    Integer.parseInt(
                            request.getParameter(
                                    "dentistId"));

            int treatmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "treatmentId"));

            String dateString =
                    request.getParameter(
                            "appointmentDate");

            String timeString =
                    request.getParameter(
                            "appointmentTime");

            Date appointmentDate =
                    Date.valueOf(dateString);

            Time appointmentTime =
                    Time.valueOf(timeString + ":00");

            Appointment appointment =
                    new Appointment();

            appointment.setPatientId(patientId);

            appointment.setDentistId(dentistId);

            appointment.setTreatmentId(treatmentId);

            appointment.setAppointmentDate(
                    appointmentDate);

            appointment.setAppointmentTime(
                    appointmentTime);

            appointment.setStatus("PENDING");

            boolean success =
                    appointmentService.addAppointment(
                            appointment);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Appointment created successfully. "
                        + "Appointment No: "
                        + appointment.getAppointmentNo());

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to create appointment. "
                        + "The dentist may already have "
                        + "an appointment at the selected date "
                        + "and time.");
            }

        } catch (IllegalArgumentException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid appointment date or time.");

        } catch (Exception e) {

            session.setAttribute(
                    "errorMessage",
                    "An error occurred while creating "
                    + "the appointment.");
        }

        response.sendRedirect(
                request.getContextPath()
                + "/appointments");
    }

    // =========================================================
    // SHOW EDIT FORM
    // =========================================================

    private void showEditForm(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session =
            request.getSession();

    try {

        int appointmentId =
                Integer.parseInt(
                        request.getParameter("id"));

        Appointment appointment =
                appointmentService.getAppointmentById(
                        appointmentId);

        if (appointment == null) {

            session.setAttribute(
                    "errorMessage",
                    "Appointment not found.");

            response.sendRedirect(
                    request.getContextPath()
                    + "/appointments");

            return;
        }

        // Load patients
        List<Patient> patients =
                patientService.getAllPatients();

        // Load dentists
        List<Dentist> dentists =
                dentistService.getAllDentists();

        // Load treatments
        List<Treatment> treatments =
                treatmentService.getAllTreatments();

        // Send data to JSP
        request.setAttribute(
                "appointment",
                appointment);

        request.setAttribute(
                "patients",
                patients);

        request.setAttribute(
                "dentists",
                dentists);

        request.setAttribute(
                "treatments",
                treatments);

        request.getRequestDispatcher(
                "/views/appointments/edit-appointment.jsp"
        ).forward(request, response);

    } catch (NumberFormatException e) {

        session.setAttribute(
                "errorMessage",
                "Invalid appointment ID.");

        response.sendRedirect(
                request.getContextPath()
                + "/appointments");
    }
}
    // =========================================================
    // UPDATE APPOINTMENT
    // =========================================================

    private void updateAppointment(
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

            int patientId =
                    Integer.parseInt(
                            request.getParameter(
                                    "patientId"));

            int dentistId =
                    Integer.parseInt(
                            request.getParameter(
                                    "dentistId"));

            int treatmentId =
                    Integer.parseInt(
                            request.getParameter(
                                    "treatmentId"));

            String dateString =
                    request.getParameter(
                            "appointmentDate");

            String timeString =
                    request.getParameter(
                            "appointmentTime");

            Date appointmentDate =
                    Date.valueOf(dateString);

            Time appointmentTime =
                    Time.valueOf(timeString + ":00");

            Appointment appointment =
                    new Appointment();

            appointment.setAppointmentId(
                    appointmentId);

            appointment.setPatientId(
                    patientId);

            appointment.setDentistId(
                    dentistId);

            appointment.setTreatmentId(
                    treatmentId);

            appointment.setAppointmentDate(
                    appointmentDate);

            appointment.setAppointmentTime(
                    appointmentTime);

            boolean success =
                    appointmentService.updateAppointment(
                            appointment);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Appointment updated successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to update appointment. "
                        + "The dentist may already have "
                        + "an appointment at the selected "
                        + "date and time.");
            }

        } catch (IllegalArgumentException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid appointment date or time.");

        } catch (Exception e) {

            session.setAttribute(
                    "errorMessage",
                    "An error occurred while updating "
                    + "the appointment.");
        }

        response.sendRedirect(
                request.getContextPath()
                + "/appointments");
    }

    // =========================================================
    // UPDATE STATUS
    // =========================================================

    private void updateStatus(
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

            String status =
                    request.getParameter(
                            "status");

            boolean success =
                    appointmentService.updateStatus(
                            appointmentId,
                            status);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Appointment status updated successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to update appointment status.");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid appointment ID.");
        }

        response.sendRedirect(
                request.getContextPath()
                + "/appointments");
    }

    // =========================================================
    // DELETE APPOINTMENT
    // =========================================================

    private void deleteAppointment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession();

        try {

            int appointmentId =
                    Integer.parseInt(
                            request.getParameter("id"));

            boolean success =
                    appointmentService.deleteAppointment(
                            appointmentId);

            if (success) {

                session.setAttribute(
                        "successMessage",
                        "Appointment deleted successfully.");

            } else {

                session.setAttribute(
                        "errorMessage",
                        "Unable to delete appointment.");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "errorMessage",
                    "Invalid appointment ID.");
        }

        response.sendRedirect(
                request.getContextPath()
                + "/appointments");
    }

    // =========================================================
    // SEARCH APPOINTMENTS
    // =========================================================

    private void searchAppointments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Appointment> appointments =
                appointmentService.searchAppointments(
                        keyword);

        request.setAttribute(
                "appointments",
                appointments);

        request.setAttribute(
                "searchKeyword",
                keyword);

        request.getRequestDispatcher(
                "/views/appointments/search-appointment.jsp"
        ).forward(request, response);
    }
}