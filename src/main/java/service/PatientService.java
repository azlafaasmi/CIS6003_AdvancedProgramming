package service;

import java.util.List;

import dao.PatientDAO;
import model.Patient;
import util.ValidationUtil;

public class PatientService {

    private final PatientDAO patientDAO;

    public PatientService() {
        patientDAO = new PatientDAO();
    }

    /**
     * Add patient.
     */
    public boolean addPatient(Patient patient) {

        if (!isValidPatient(patient)) {
            return false;
        }

        // Contact number must be unique.
        if (patientDAO.contactNumberExists(
                patient.getContactNumber())) {

            return false;
        }

        return patientDAO.addPatient(patient);
    }

    /**
     * Get all patients.
     */
    public List<Patient> getAllPatients() {

        return patientDAO.getAllPatients();
    }

    /**
     * Get patient by ID.
     */
    public Patient getPatientById(int patientId) {

        if (patientId <= 0) {
            return null;
        }

        return patientDAO.getPatientById(patientId);
    }

    /**
     * Search patients.
     */
    public List<Patient> searchPatients(String keyword) {

        if (keyword == null) {
            keyword = "";
        }

        keyword = keyword.trim();

        if (keyword.isEmpty()) {
            return getAllPatients();
        }

        return patientDAO.searchPatients(keyword);
    }

    /**
     * Update patient.
     */
    public boolean updatePatient(Patient patient) {

        if (patient == null
                || patient.getPatientId() <= 0) {

            return false;
        }

        if (!isValidPatient(patient)) {
            return false;
        }

        // Check whether another patient has this number.
        if (patientDAO.contactNumberExists(
                patient.getContactNumber(),
                patient.getPatientId())) {

            return false;
        }

        return patientDAO.updatePatient(patient);
    }

    /**
     * Delete patient.
     */
    public boolean deletePatient(int patientId) {

        if (patientId <= 0) {
            return false;
        }

        return patientDAO.deletePatient(patientId);
    }

    /**
     * Validate patient data.
     */
    private boolean isValidPatient(Patient patient) {

        if (patient == null) {
            return false;
        }

        if (ValidationUtil.isEmpty(
                patient.getPatientName())) {

            return false;
        }

        if (ValidationUtil.isEmpty(
                patient.getAddress())) {

            return false;
        }

        if (!ValidationUtil.isValidPhone(
                patient.getContactNumber())) {

            return false;
        }

        /*
         * Email is optional according to your database
         * because the email column allows NULL.
         */
        if (!ValidationUtil.isEmpty(patient.getEmail())
                && !ValidationUtil.isValidEmail(
                        patient.getEmail())) {

            return false;
        }

        return true;
    }
}