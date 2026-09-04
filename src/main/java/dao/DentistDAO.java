package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Dentist;
import util.DBConnection;

public class DentistDAO {

    // ==============================
    // Add Dentist
    // ==============================
    public boolean addDentist(Dentist dentist) {

        String sql = """
                INSERT INTO dentists
                (dentist_name, specialization, contact_number)
                VALUES (?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, dentist.getDentistName());
            statement.setString(2, dentist.getSpecialization());
            statement.setString(3, dentist.getContactNumber());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ==============================
    // Get All Dentists
    // ==============================
    public List<Dentist> getAllDentists() {

        List<Dentist> dentists = new ArrayList<>();

        String sql = """
                SELECT dentist_id,
                       dentist_name,
                       specialization,
                       contact_number
                FROM dentists
                ORDER BY dentist_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                dentists.add(mapDentist(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dentists;
    }

    // ==============================
    // Get Dentist By ID
    // ==============================
    public Dentist getDentistById(int dentistId) {

        String sql = """
                SELECT dentist_id,
                       dentist_name,
                       specialization,
                       contact_number
                FROM dentists
                WHERE dentist_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, dentistId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapDentist(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ==============================
    // Search Dentists
    // ==============================
    public List<Dentist> searchDentists(String keyword) {

        List<Dentist> dentists = new ArrayList<>();

        String sql = """
                SELECT dentist_id,
                       dentist_name,
                       specialization,
                       contact_number
                FROM dentists
                WHERE dentist_name LIKE ?
                   OR specialization LIKE ?
                   OR contact_number LIKE ?
                ORDER BY dentist_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";

            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {
                    dentists.add(mapDentist(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dentists;
    }

    // ==============================
    // Update Dentist
    // ==============================
    public boolean updateDentist(Dentist dentist) {

        String sql = """
                UPDATE dentists
                SET dentist_name = ?,
                    specialization = ?,
                    contact_number = ?
                WHERE dentist_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, dentist.getDentistName());
            statement.setString(2, dentist.getSpecialization());
            statement.setString(3, dentist.getContactNumber());
            statement.setInt(4, dentist.getDentistId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ==============================
    // Delete Dentist
    // ==============================
    public boolean deleteDentist(int dentistId) {

        String sql =
                "DELETE FROM dentists WHERE dentist_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, dentistId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ==============================
    // Check Contact Number
    // ==============================
    public boolean contactNumberExists(
            String contactNumber,
            int excludeDentistId) {

        String sql = """
                SELECT dentist_id
                FROM dentists
                WHERE contact_number = ?
                  AND dentist_id <> ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, contactNumber);
            statement.setInt(2, excludeDentistId);

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
    // Check Contact Number
    // ==============================
    public boolean contactNumberExists(
            String contactNumber) {

        String sql = """
                SELECT dentist_id
                FROM dentists
                WHERE contact_number = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, contactNumber);

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
    private Dentist mapDentist(ResultSet resultSet)
            throws SQLException {

        Dentist dentist = new Dentist();

        dentist.setDentistId(
                resultSet.getInt("dentist_id"));

        dentist.setDentistName(
                resultSet.getString("dentist_name"));

        dentist.setSpecialization(
                resultSet.getString("specialization"));

        dentist.setContactNumber(
                resultSet.getString("contact_number"));

        return dentist;
    }
}