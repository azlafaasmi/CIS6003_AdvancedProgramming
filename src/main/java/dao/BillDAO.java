package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Bill;
import util.DBConnection;

public class BillDAO {

    /**
     * Add a new bill.
     */
    public boolean addBill(Bill bill) {

        String sql =
                "INSERT INTO bills " +
                "(appointment_id, consultation_fee, treatment_fee, " +
                "total_amount, payment_status) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(
                    1,
                    bill.getAppointmentId());

            stmt.setBigDecimal(
                    2,
                    bill.getConsultationFee());

            stmt.setBigDecimal(
                    3,
                    bill.getTreatmentFee());

            stmt.setBigDecimal(
                    4,
                    bill.getTotalAmount());

            stmt.setString(
                    5,
                    bill.getPaymentStatus());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    /**
     * Get all bills.
     */
    public List<Bill> getAllBills() {

        List<Bill> bills = new ArrayList<>();

        String sql =
                "SELECT * FROM bills " +
                "ORDER BY bill_date DESC";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                bills.add(mapBill(rs));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return bills;
    }


    /**
     * Get a bill by bill ID.
     */
    public Bill getBillById(int billId) {

        String sql =
                "SELECT * FROM bills " +
                "WHERE bill_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, billId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return mapBill(rs);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    /**
     * Get a bill using appointment ID.
     */
    public Bill getBillByAppointmentId(
            int appointmentId) {

        String sql =
                "SELECT * FROM bills " +
                "WHERE appointment_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return mapBill(rs);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    /**
     * Check whether a bill already exists
     * for an appointment.
     */
    public boolean billExistsForAppointment(
            int appointmentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM bills " +
                "WHERE appointment_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    /**
     * Update payment status.
     */
    public boolean updatePaymentStatus(
            int billId,
            String paymentStatus) {

        String sql =
                "UPDATE bills " +
                "SET payment_status = ? " +
                "WHERE bill_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, paymentStatus);
            stmt.setInt(2, billId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    /**
     * Delete a bill.
     */
    public boolean deleteBill(int billId) {

        String sql =
                "DELETE FROM bills " +
                "WHERE bill_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, billId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    /**
     * Convert a ResultSet row into a Bill object.
     */
    private Bill mapBill(ResultSet rs)
            throws Exception {

        Bill bill = new Bill();

        bill.setBillId(
                rs.getInt("bill_id"));

        bill.setAppointmentId(
                rs.getInt("appointment_id"));

        bill.setConsultationFee(
                rs.getBigDecimal("consultation_fee"));

        bill.setTreatmentFee(
                rs.getBigDecimal("treatment_fee"));

        bill.setTotalAmount(
                rs.getBigDecimal("total_amount"));

        bill.setPaymentStatus(
                rs.getString("payment_status"));

        return bill;
    }
}