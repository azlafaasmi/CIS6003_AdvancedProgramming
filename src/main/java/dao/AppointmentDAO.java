package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Appointment;
import util.DBConnection;

public class AppointmentDAO {

    // ==============================
    // Add Appointment
    // ==============================
    public boolean addAppointment(Appointment appointment) {

        String sql = """
                INSERT INTO appointments
                (appointment_no, patient_id, dentist_id, treatment_id,
                 appointment_date, appointment_time, status)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, appointment.getAppointmentNo());
            statement.setInt(2, appointment.getPatientId());
            statement.setInt(3, appointment.getDentistId());
            statement.setInt(4, appointment.getTreatmentId());
            statement.setDate(5, appointment.getAppointmentDate());
            statement.setTime(6, appointment.getAppointmentTime());
            statement.setString(7, appointment.getStatus());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Get All Appointments
    // ==============================
    public List<Appointment> getAllAppointments() {

        List<Appointment> appointments = new ArrayList<>();

        String sql = """
                SELECT a.appointment_id,
                       a.appointment_no,
                       a.patient_id,
                       a.dentist_id,
                       a.treatment_id,
                       a.appointment_date,
                       a.appointment_time,
                       a.status,
                       p.patient_name,
                       d.dentist_name,
                       t.treatment_name
                FROM appointments a
                INNER JOIN patients p
                    ON a.patient_id = p.patient_id
                INNER JOIN dentists d
                    ON a.dentist_id = d.dentist_id
                INNER JOIN treatments t
                    ON a.treatment_id = t.treatment_id
                ORDER BY a.appointment_date DESC,
                         a.appointment_time DESC,
                         a.appointment_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                appointments.add(mapAppointment(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointments;
    }


    // ==============================
    // Get Appointment By ID
    // ==============================
    public Appointment getAppointmentById(int appointmentId) {

        String sql = """
                SELECT a.appointment_id,
                       a.appointment_no,
                       a.patient_id,
                       a.dentist_id,
                       a.treatment_id,
                       a.appointment_date,
                       a.appointment_time,
                       a.status,
                       p.patient_name,
                       d.dentist_name,
                       t.treatment_name
                FROM appointments a
                INNER JOIN patients p
                    ON a.patient_id = p.patient_id
                INNER JOIN dentists d
                    ON a.dentist_id = d.dentist_id
                INNER JOIN treatments t
                    ON a.treatment_id = t.treatment_id
                WHERE a.appointment_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, appointmentId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapAppointment(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // ==============================
    // Get Appointment By Number
    // ==============================
    public Appointment getAppointmentByNumber(
            String appointmentNo) {

        String sql = """
                SELECT a.appointment_id,
                       a.appointment_no,
                       a.patient_id,
                       a.dentist_id,
                       a.treatment_id,
                       a.appointment_date,
                       a.appointment_time,
                       a.status,
                       p.patient_name,
                       d.dentist_name,
                       t.treatment_name
                FROM appointments a
                INNER JOIN patients p
                    ON a.patient_id = p.patient_id
                INNER JOIN dentists d
                    ON a.dentist_id = d.dentist_id
                INNER JOIN treatments t
                    ON a.treatment_id = t.treatment_id
                WHERE a.appointment_no = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, appointmentNo);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapAppointment(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // ==============================
    // Search Appointments
    // ==============================
    public List<Appointment> searchAppointments(
            String keyword) {

        List<Appointment> appointments = new ArrayList<>();

        String sql = """
                SELECT a.appointment_id,
                       a.appointment_no,
                       a.patient_id,
                       a.dentist_id,
                       a.treatment_id,
                       a.appointment_date,
                       a.appointment_time,
                       a.status,
                       p.patient_name,
                       d.dentist_name,
                       t.treatment_name
                FROM appointments a
                INNER JOIN patients p
                    ON a.patient_id = p.patient_id
                INNER JOIN dentists d
                    ON a.dentist_id = d.dentist_id
                INNER JOIN treatments t
                    ON a.treatment_id = t.treatment_id
                WHERE a.appointment_no LIKE ?
                   OR p.patient_name LIKE ?
                   OR d.dentist_name LIKE ?
                   OR t.treatment_name LIKE ?
                   OR a.status LIKE ?
                ORDER BY a.appointment_date DESC,
                         a.appointment_time DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";

            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);
            statement.setString(4, searchPattern);
            statement.setString(5, searchPattern);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {
                    appointments.add(mapAppointment(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointments;
    }


    // ==============================
    // Update Appointment
    // ==============================
    public boolean updateAppointment(
            Appointment appointment) {

        String sql = """
                UPDATE appointments
                SET patient_id = ?,
                    dentist_id = ?,
                    treatment_id = ?,
                    appointment_date = ?,
                    appointment_time = ?,
                    status = ?
                WHERE appointment_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, appointment.getPatientId());
            statement.setInt(2, appointment.getDentistId());
            statement.setInt(3, appointment.getTreatmentId());
            statement.setDate(4, appointment.getAppointmentDate());
            statement.setTime(5, appointment.getAppointmentTime());
            statement.setString(6, appointment.getStatus());
            statement.setInt(7, appointment.getAppointmentId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Update Appointment Status
    // ==============================
    public boolean updateStatus(
            int appointmentId,
            String status) {

        String sql = """
                UPDATE appointments
                SET status = ?
                WHERE appointment_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, appointmentId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Delete Appointment
    // ==============================
    public boolean deleteAppointment(
            int appointmentId) {

        String sql =
                "DELETE FROM appointments WHERE appointment_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, appointmentId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ==============================
    // Check Appointment Number
    // ==============================
    public boolean appointmentNumberExists(
            String appointmentNo) {

        String sql = """
                SELECT appointment_id
                FROM appointments
                WHERE appointment_no = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, appointmentNo);

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
    // Check Time Conflict
    // ==============================
    public boolean appointmentExistsAtTime(
            int dentistId,
            java.sql.Date appointmentDate,
            java.sql.Time appointmentTime,
            int excludeAppointmentId) {

        String sql = """
                SELECT appointment_id
                FROM appointments
                WHERE dentist_id = ?
                  AND appointment_date = ?
                  AND appointment_time = ?
                  AND status <> 'CANCELLED'
                  AND appointment_id <> ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, dentistId);
            statement.setDate(2, appointmentDate);
            statement.setTime(3, appointmentTime);
            statement.setInt(4, excludeAppointmentId);

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
    private Appointment mapAppointment(
            ResultSet resultSet)
            throws SQLException {

        Appointment appointment =
                new Appointment();

        appointment.setAppointmentId(
                resultSet.getInt("appointment_id"));

        appointment.setAppointmentNo(
                resultSet.getString("appointment_no"));

        appointment.setPatientId(
                resultSet.getInt("patient_id"));

        appointment.setDentistId(
                resultSet.getInt("dentist_id"));

        appointment.setTreatmentId(
                resultSet.getInt("treatment_id"));

        appointment.setAppointmentDate(
                resultSet.getDate("appointment_date"));

        appointment.setAppointmentTime(
                resultSet.getTime("appointment_time"));

        appointment.setStatus(
                resultSet.getString("status"));

        appointment.setPatientName(
                resultSet.getString("patient_name"));

        appointment.setDentistName(
                resultSet.getString("dentist_name"));

        appointment.setTreatmentName(
                resultSet.getString("treatment_name"));

        return appointment;
    }
}