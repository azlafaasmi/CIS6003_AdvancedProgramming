package service;

import java.util.List;

import dao.DentistDAO;
import model.Dentist;
import util.ValidationUtil;

public class DentistService {

    private final DentistDAO dentistDAO;

    public DentistService() {
        dentistDAO = new DentistDAO();
    }


    // ==============================
    // Add Dentist
    // ==============================
    public boolean addDentist(Dentist dentist) {

        if (dentist == null) {
            return false;
        }

        if (!isValidName(dentist.getDentistName())) {
            return false;
        }

        if (!isValidSpecialization(
                dentist.getSpecialization())) {
            return false;
        }

        if (!isValidContact(
                dentist.getContactNumber())) {
            return false;
        }

        if (dentistDAO.contactNumberExists(
                dentist.getContactNumber())) {
            return false;
        }

        return dentistDAO.addDentist(dentist);
    }


    // ==============================
    // Get All Dentists
    // ==============================
    public List<Dentist> getAllDentists() {

        return dentistDAO.getAllDentists();
    }


    // ==============================
    // Get Dentist
    // ==============================
    public Dentist getDentistById(int dentistId) {

        return dentistDAO.getDentistById(dentistId);
    }


    // ==============================
    // Search
    // ==============================
    public List<Dentist> searchDentists(
            String keyword) {

        if (keyword == null ||
            keyword.trim().isEmpty()) {

            return dentistDAO.getAllDentists();
        }

        return dentistDAO.searchDentists(
                keyword.trim());
    }


    // ==============================
    // Update Dentist
    // ==============================
    public boolean updateDentist(Dentist dentist) {

        if (dentist == null) {
            return false;
        }

        if (dentist.getDentistId() <= 0) {
            return false;
        }

        if (!isValidName(dentist.getDentistName())) {
            return false;
        }

        if (!isValidSpecialization(
                dentist.getSpecialization())) {
            return false;
        }

        if (!isValidContact(
                dentist.getContactNumber())) {
            return false;
        }

        if (dentistDAO.contactNumberExists(
                dentist.getContactNumber(),
                dentist.getDentistId())) {
            return false;
        }

        return dentistDAO.updateDentist(dentist);
    }


    // ==============================
    // Delete
    // ==============================
    public boolean deleteDentist(int dentistId) {

        if (dentistId <= 0) {
            return false;
        }

        return dentistDAO.deleteDentist(dentistId);
    }


    // ==============================
    // Validation
    // ==============================
    private boolean isValidName(String name) {

        return name != null
                && !name.trim().isEmpty()
                && name.trim().length() <= 100;
    }


    private boolean isValidSpecialization(
            String specialization) {

        return specialization != null
                && !specialization.trim().isEmpty()
                && specialization.trim().length() <= 100;
    }


    private boolean isValidContact(String contact) {

        if (contact == null ||
            contact.trim().isEmpty()) {

            return false;
        }

        return ValidationUtil.isValidPhone(
                contact.trim());
    }
}