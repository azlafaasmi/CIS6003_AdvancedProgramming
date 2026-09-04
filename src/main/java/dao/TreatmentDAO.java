package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Treatment;
import util.DBConnection;

public class TreatmentDAO {

    // ==============================
    // Add Treatment
    // ==============================
    public boolean addTreatment(Treatment treatment) {

        String sql = """
                INSERT INTO treatments
                (treatment_name, treatment_price)
                VALUES (?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, treatment.getTreatmentName());
            statement.setBigDecimal(2, treatment.getTreatmentPrice());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Get All Treatments
    // ==============================
    public List<Treatment> getAllTreatments() {

        List<Treatment> treatments = new ArrayList<>();

        String sql = """
                SELECT treatment_id,
                       treatment_name,
                       treatment_price
                FROM treatments
                ORDER BY treatment_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                treatments.add(mapTreatment(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return treatments;
    }


    // ==============================
    // Get Treatment By ID
    // ==============================
    public Treatment getTreatmentById(int treatmentId) {

        String sql = """
                SELECT treatment_id,
                       treatment_name,
                       treatment_price
                FROM treatments
                WHERE treatment_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, treatmentId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapTreatment(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // ==============================
    // Search Treatments
    // ==============================
    public List<Treatment> searchTreatments(String keyword) {

        List<Treatment> treatments = new ArrayList<>();

        String sql = """
                SELECT treatment_id,
                       treatment_name,
                       treatment_price
                FROM treatments
                WHERE treatment_name LIKE ?
                ORDER BY treatment_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";

            statement.setString(1, searchPattern);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {
                    treatments.add(mapTreatment(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return treatments;
    }


    // ==============================
    // Update Treatment
    // ==============================
    public boolean updateTreatment(Treatment treatment) {

        String sql = """
                UPDATE treatments
                SET treatment_name = ?,
                    treatment_price = ?
                WHERE treatment_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, treatment.getTreatmentName());
            statement.setBigDecimal(2, treatment.getTreatmentPrice());
            statement.setInt(3, treatment.getTreatmentId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Delete Treatment
    // ==============================
    public boolean deleteTreatment(int treatmentId) {

        String sql =
                "DELETE FROM treatments WHERE treatment_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, treatmentId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Check Treatment Name
    // ==============================
    public boolean treatmentNameExists(
            String treatmentName) {

        String sql = """
                SELECT treatment_id
                FROM treatments
                WHERE treatment_name = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, treatmentName);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Check Treatment Name
    // Excluding Current Treatment
    // ==============================
    public boolean treatmentNameExists(
            String treatmentName,
            int excludeTreatmentId) {

        String sql = """
                SELECT treatment_id
                FROM treatments
                WHERE treatment_name = ?
                  AND treatment_id <> ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, treatmentName);
            statement.setInt(2, excludeTreatmentId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Map ResultSet
    // ==============================
    private Treatment mapTreatment(ResultSet resultSet)
            throws SQLException {

        Treatment treatment = new Treatment();

        treatment.setTreatmentId(
                resultSet.getInt("treatment_id"));

        treatment.setTreatmentName(
                resultSet.getString("treatment_name"));

        treatment.setTreatmentPrice(
                resultSet.getBigDecimal("treatment_price"));

        return treatment;
    }
}