package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Patient;
import util.DBConnection;

public class PatientDAO {

    /**
     * Add a new patient.
     */
    public boolean addPatient(Patient patient) {

        String sql = """
                INSERT INTO patients
                (patient_name, address, contact_number, email)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, patient.getPatientName());
            statement.setString(2, patient.getAddress());
            statement.setString(3, patient.getContactNumber());
            statement.setString(4, patient.getEmail());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get all patients.
     */
    public List<Patient> getAllPatients() {

        List<Patient> patients = new ArrayList<>();

        String sql = """
                SELECT patient_id,
                       patient_name,
                       address,
                       contact_number,
                       email
                FROM patients
                ORDER BY patient_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Patient patient = mapPatient(resultSet);

                patients.add(patient);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return patients;
    }

    /**
     * Get patient by ID.
     */
    public Patient getPatientById(int patientId) {

        String sql = """
                SELECT patient_id,
                       patient_name,
                       address,
                       contact_number,
                       email
                FROM patients
                WHERE patient_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, patientId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapPatient(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Search patients by name, phone number or email.
     */
    public List<Patient> searchPatients(String keyword) {

        List<Patient> patients = new ArrayList<>();

        String sql = """
                SELECT patient_id,
                       patient_name,
                       address,
                       contact_number,
                       email
                FROM patients
                WHERE patient_name LIKE ?
                   OR contact_number LIKE ?
                   OR email LIKE ?
                ORDER BY patient_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";

            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Patient patient = mapPatient(resultSet);

                    patients.add(patient);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return patients;
    }

    /**
     * Update patient details.
     */
    public boolean updatePatient(Patient patient) {

        String sql = """
                UPDATE patients
                SET patient_name = ?,
                    address = ?,
                    contact_number = ?,
                    email = ?
                WHERE patient_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, patient.getPatientName());
            statement.setString(2, patient.getAddress());
            statement.setString(3, patient.getContactNumber());
            statement.setString(4, patient.getEmail());
            statement.setInt(5, patient.getPatientId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete patient.
     */
    public boolean deletePatient(int patientId) {

        String sql = """
                DELETE FROM patients
                WHERE patient_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, patientId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Check whether contact number already exists.
     */
    public boolean contactNumberExists(
            String contactNumber,
            int excludePatientId) {

        String sql = """
                SELECT patient_id
                FROM patients
                WHERE contact_number = ?
                  AND patient_id <> ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, contactNumber);
            statement.setInt(2, excludePatientId);

            try (ResultSet resultSet = statement.executeQuery()) {

                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Check whether contact number already exists when adding.
     */
    public boolean contactNumberExists(String contactNumber) {

        String sql = """
                SELECT patient_id
                FROM patients
                WHERE contact_number = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, contactNumber);

            try (ResultSet resultSet = statement.executeQuery()) {

                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Convert ResultSet into Patient object.
     */
    private Patient mapPatient(ResultSet resultSet)
            throws SQLException {

        Patient patient = new Patient();

        patient.setPatientId(
                resultSet.getInt("patient_id"));

        patient.setPatientName(
                resultSet.getString("patient_name"));

        patient.setAddress(
                resultSet.getString("address"));

        patient.setContactNumber(
                resultSet.getString("contact_number"));

        patient.setEmail(
                resultSet.getString("email"));

        return patient;
    }
}