package service;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import dao.AppointmentDAO;
import model.Appointment;
import util.AppointmentNumberGenerator;

public class AppointmentService {

    private final AppointmentDAO appointmentDAO;

    public AppointmentService() {
        appointmentDAO = new AppointmentDAO();
    }

    // ==========================================
    // Add Appointment
    // ==========================================

    public boolean addAppointment(Appointment appointment) {

        if (appointment == null) {
            return false;
        }

        // Validate patient
        if (appointment.getPatientId() <= 0) {
            return false;
        }

        // Validate dentist
        if (appointment.getDentistId() <= 0) {
            return false;
        }

        // Validate treatment
        if (appointment.getTreatmentId() <= 0) {
            return false;
        }

        // Validate date
        Date appointmentDate =
                appointment.getAppointmentDate();

        if (appointmentDate == null) {
            return false;
        }

        // Validate time
        Time appointmentTime =
                appointment.getAppointmentTime();

        if (appointmentTime == null) {
            return false;
        }

        // Appointment date cannot be in the past
        Date today = new Date(
                System.currentTimeMillis());

        if (appointmentDate.before(today)) {
            return false;
        }

        // Check dentist availability
        if (appointmentDAO.appointmentExistsAtTime(
                appointment.getDentistId(),
                appointmentDate,
                appointmentTime,
                0)) {

            return false;
        }

        // Generate appointment number
        String appointmentNo =
                AppointmentNumberGenerator.generate();

        // Make sure generated number is unique
        while (appointmentDAO.appointmentNumberExists(
                appointmentNo)) {

            appointmentNo =
                    AppointmentNumberGenerator.generate();
        }

        appointment.setAppointmentNo(
                appointmentNo);

        // Default status
        if (appointment.getStatus() == null
                || appointment.getStatus().trim().isEmpty()) {

            appointment.setStatus("PENDING");
        }

        return appointmentDAO.addAppointment(
                appointment);
    }

    // ==========================================
    // Get All Appointments
    // ==========================================

    public List<Appointment> getAllAppointments() {

        return appointmentDAO.getAllAppointments();
    }

    // ==========================================
    // Get Appointment By ID
    // ==========================================

    public Appointment getAppointmentById(
            int appointmentId) {

        if (appointmentId <= 0) {
            return null;
        }

        return appointmentDAO.getAppointmentById(
                appointmentId);
    }

    // ==========================================
    // Get Appointment By Number
    // ==========================================

    public Appointment getAppointmentByNumber(
            String appointmentNo) {

        if (appointmentNo == null
                || appointmentNo.trim().isEmpty()) {

            return null;
        }

        return appointmentDAO.getAppointmentByNumber(
                appointmentNo.trim());
    }

    // ==========================================
    // Search Appointments
    // ==========================================

    public List<Appointment> searchAppointments(
            String keyword) {

        if (keyword == null) {
            keyword = "";
        }

        return appointmentDAO.searchAppointments(
                keyword.trim());
    }

    // ==========================================
    // Update Appointment
    // ==========================================

    public boolean updateAppointment(
            Appointment appointment) {

        if (appointment == null) {
            return false;
        }

        if (appointment.getAppointmentId() <= 0) {
            return false;
        }

        if (appointment.getPatientId() <= 0) {
            return false;
        }

        if (appointment.getDentistId() <= 0) {
            return false;
        }

        if (appointment.getTreatmentId() <= 0) {
            return false;
        }

        if (appointment.getAppointmentDate() == null) {
            return false;
        }

        if (appointment.getAppointmentTime() == null) {
            return false;
        }

        // Appointment date cannot be in the past
        Date today = new Date(
                System.currentTimeMillis());

        if (appointment.getAppointmentDate()
                .before(today)) {

            return false;
        }

        // Check whether another appointment
        // already exists for this dentist
        if (appointmentDAO.appointmentExistsAtTime(
                appointment.getDentistId(),
                appointment.getAppointmentDate(),
                appointment.getAppointmentTime(),
                appointment.getAppointmentId())) {

            return false;
        }

        return appointmentDAO.updateAppointment(
                appointment);
    }

    // ==========================================
    // Update Appointment Status
    // ==========================================

    public boolean updateStatus(
            int appointmentId,
            String status) {

        if (appointmentId <= 0) {
            return false;
        }

        if (status == null
                || status.trim().isEmpty()) {

            return false;
        }

        String normalizedStatus =
                status.trim().toUpperCase();

        if (!normalizedStatus.equals("PENDING")
                && !normalizedStatus.equals("CONFIRMED")
                && !normalizedStatus.equals("COMPLETED")
                && !normalizedStatus.equals("CANCELLED")) {

            return false;
        }

        return appointmentDAO.updateStatus(
                appointmentId,
                normalizedStatus);
    }

    // ==========================================
    // Delete Appointment
    // ==========================================

    public boolean deleteAppointment(
            int appointmentId) {

        if (appointmentId <= 0) {
            return false;
        }

        return appointmentDAO.deleteAppointment(
                appointmentId);
    }

    // ==========================================
    // Check Appointment Number
    // ==========================================

    public boolean appointmentNumberExists(
            String appointmentNo) {

        if (appointmentNo == null
                || appointmentNo.trim().isEmpty()) {

            return false;
        }

        return appointmentDAO.appointmentNumberExists(
                appointmentNo.trim());
    }

    // ==========================================
    // Check Dentist Availability
    // ==========================================

    public boolean appointmentExistsAtTime(
            int dentistId,
            Date appointmentDate,
            Time appointmentTime,
            int appointmentId) {

        if (dentistId <= 0
                || appointmentDate == null
                || appointmentTime == null) {

            return false;
        }

        return appointmentDAO.appointmentExistsAtTime(
                dentistId,
                appointmentDate,
                appointmentTime,
                appointmentId);
    }
}