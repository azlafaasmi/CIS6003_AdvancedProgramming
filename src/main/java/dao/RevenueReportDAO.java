package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

public class RevenueReportDAO {

    public int getTotalBills() {

        String sql =
                "SELECT COUNT(*) FROM bills";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement stmt =
                        conn.prepareStatement(sql);

                ResultSet rs =
                        stmt.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getPaidBills() {

        String sql =
                "SELECT COUNT(*) FROM bills WHERE payment_status='PAID'";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement stmt =
                        conn.prepareStatement(sql);

                ResultSet rs =
                        stmt.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getUnpaidBills() {

        String sql =
                "SELECT COUNT(*) FROM bills WHERE payment_status='UNPAID'";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement stmt =
                        conn.prepareStatement(sql);

                ResultSet rs =
                        stmt.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public BigDecimal getTotalRevenue() {

        String sql =
                "SELECT COALESCE(SUM(total_amount),0) FROM bills";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement stmt =
                        conn.prepareStatement(sql);

                ResultSet rs =
                        stmt.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getBigDecimal(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }

    public BigDecimal getPaidRevenue() {

        String sql =
                "SELECT COALESCE(SUM(total_amount),0) FROM bills WHERE payment_status='PAID'";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement stmt =
                        conn.prepareStatement(sql);

                ResultSet rs =
                        stmt.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getBigDecimal(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }

    public BigDecimal getUnpaidRevenue() {

        String sql =
                "SELECT COALESCE(SUM(total_amount),0) FROM bills WHERE payment_status='UNPAID'";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement stmt =
                        conn.prepareStatement(sql);

                ResultSet rs =
                        stmt.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getBigDecimal(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }
}