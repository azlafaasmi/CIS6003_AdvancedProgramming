package service;

import java.math.BigDecimal;
import java.util.List;

import dao.TreatmentDAO;
import model.Treatment;

public class TreatmentService {

    private final TreatmentDAO treatmentDAO;

    public TreatmentService() {
        treatmentDAO = new TreatmentDAO();
    }


    // ==============================
    // Add Treatment
    // ==============================
    public boolean addTreatment(Treatment treatment) {

        if (treatment == null) {
            return false;
        }

        String name = treatment.getTreatmentName();

        BigDecimal price = treatment.getTreatmentPrice();

        // Validate treatment name
        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        // Validate price
        if (price == null || price.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }

        name = name.trim();

        // Check duplicate treatment name
        if (treatmentDAO.treatmentNameExists(name)) {
            return false;
        }

        treatment.setTreatmentName(name);

        return treatmentDAO.addTreatment(treatment);
    }


    // ==============================
    // Get All Treatments
    // ==============================
    public List<Treatment> getAllTreatments() {

        return treatmentDAO.getAllTreatments();
    }


    // ==============================
    // Get Treatment By ID
    // ==============================
    public Treatment getTreatmentById(int treatmentId) {

        if (treatmentId <= 0) {
            return null;
        }

        return treatmentDAO.getTreatmentById(treatmentId);
    }


    // ==============================
    // Search Treatments
    // ==============================
    public List<Treatment> searchTreatments(String keyword) {

        if (keyword == null) {
            keyword = "";
        }

        keyword = keyword.trim();

        if (keyword.isEmpty()) {
            return treatmentDAO.getAllTreatments();
        }

        return treatmentDAO.searchTreatments(keyword);
    }


    // ==============================
    // Update Treatment
    // ==============================
    public boolean updateTreatment(Treatment treatment) {

        if (treatment == null) {
            return false;
        }

        if (treatment.getTreatmentId() <= 0) {
            return false;
        }

        String name = treatment.getTreatmentName();

        BigDecimal price = treatment.getTreatmentPrice();

        // Validate treatment name
        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        // Validate price
        if (price == null || price.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }

        name = name.trim();

        // Check duplicate name excluding current treatment
        if (treatmentDAO.treatmentNameExists(
                name,
                treatment.getTreatmentId())) {

            return false;
        }

        treatment.setTreatmentName(name);

        return treatmentDAO.updateTreatment(treatment);
    }


    // ==============================
    // Delete Treatment
    // ==============================
    public boolean deleteTreatment(int treatmentId) {

        if (treatmentId <= 0) {
            return false;
        }

        return treatmentDAO.deleteTreatment(treatmentId);
    }
}