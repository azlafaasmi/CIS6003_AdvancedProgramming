package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.User;
import util.DBConnection;

public class UserDAO {

    // =========================================================
    // ADD USER
    // =========================================================

    public boolean addUser(User user) {

        String sql =
                "INSERT INTO users " +
                "(username, password, full_name, role) " +
                "VALUES (?, ?, ?, ?)";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getRole());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET ALL USERS
    // =========================================================

    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        String sql =
                "SELECT * FROM users " +
                "ORDER BY user_id DESC";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                User user = mapUser(rs);

                users.add(user);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return users;
    }


    // =========================================================
    // GET USER BY ID
    // =========================================================

    public User getUserById(int userId) {

        String sql =
                "SELECT * FROM users " +
                "WHERE user_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return mapUser(rs);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // FIND USER BY USERNAME
    // Required by LoginService
    // =========================================================

    public User findByUsername(String username) {

        String sql =
                "SELECT * FROM users " +
                "WHERE username = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return mapUser(rs);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // UPDATE USER
    // =========================================================

    public boolean updateUser(User user) {

        String sql =
                "UPDATE users SET " +
                "username = ?, " +
                "password = ?, " +
                "full_name = ?, " +
                "role = ? " +
                "WHERE user_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getRole());
            stmt.setInt(5, user.getUserId());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE PASSWORD
    // Required by LoginService
    // =========================================================

    public boolean updatePassword(
            int userId,
            String password) {

        String sql =
                "UPDATE users " +
                "SET password = ? " +
                "WHERE user_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, password);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELETE USER
    // =========================================================

    public boolean deleteUser(int userId) {

        String sql =
                "DELETE FROM users " +
                "WHERE user_id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, userId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK USERNAME EXISTS
    // =========================================================

    public boolean usernameExists(String username) {

        String sql =
                "SELECT user_id " +
                "FROM users " +
                "WHERE username = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {

                return rs.next();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // MAP RESULTSET TO USER OBJECT
    // =========================================================

    private User mapUser(ResultSet rs)
            throws java.sql.SQLException {

        User user = new User();

        user.setUserId(
                rs.getInt("user_id"));

        user.setUsername(
                rs.getString("username"));

        user.setPassword(
                rs.getString("password"));

        user.setFullName(
                rs.getString("full_name"));

        user.setRole(
                rs.getString("role"));

        user.setCreatedAt(
                rs.getTimestamp("created_at"));

        return user;
    }
}