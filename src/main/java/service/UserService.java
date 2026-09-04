package service;

import java.util.List;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    /**
     * Add a new user.
     */
    public boolean addUser(
            String username,
            String password,
            String fullName,
            String role) {

        if (username == null ||
                username.trim().isEmpty()) {
            return false;
        }

        if (password == null ||
                password.length() < 6) {
            return false;
        }

        if (fullName == null ||
                fullName.trim().isEmpty()) {
            return false;
        }

        if (!isValidRole(role)) {
            return false;
        }

        username = username.trim();
        fullName = fullName.trim();

        if (userDAO.usernameExists(username)) {
            return false;
        }

        User user = new User();

        user.setUsername(username);

        /*
         * Store password securely using BCrypt.
         */
        user.setPassword(
                PasswordUtil.hashPassword(password));

        user.setFullName(fullName);
        user.setRole(role);

        return userDAO.addUser(user);
    }


    /**
     * Get all users.
     */
    public List<User> getAllUsers() {

        return userDAO.getAllUsers();
    }


    /**
     * Get user by ID.
     */
    public User getUserById(int userId) {

        if (userId <= 0) {
            return null;
        }

        return userDAO.getUserById(userId);
    }


    /**
     * Update an existing user.
     *
     * If password is blank, the existing password
     * will be retained.
     */
    public boolean updateUser(
            int userId,
            String username,
            String password,
            String fullName,
            String role) {

        if (userId <= 0) {
            return false;
        }

        if (username == null ||
                username.trim().isEmpty()) {
            return false;
        }

        if (fullName == null ||
                fullName.trim().isEmpty()) {
            return false;
        }

        if (!isValidRole(role)) {
            return false;
        }

        username = username.trim();
        fullName = fullName.trim();

        User existingUser =
                userDAO.getUserById(userId);

        if (existingUser == null) {
            return false;
        }

        /*
         * Check username duplication.
         */
        if (!username.equals(
                existingUser.getUsername())
                && userDAO.usernameExists(username)) {

            return false;
        }

        User user = new User();

        user.setUserId(userId);
        user.setUsername(username);
        user.setFullName(fullName);
        user.setRole(role);

        /*
         * Keep old password if no new password
         * was entered.
         */
        if (password == null ||
                password.trim().isEmpty()) {

            user.setPassword(
                    existingUser.getPassword());

        } else {

            if (password.length() < 6) {
                return false;
            }

            user.setPassword(
                    PasswordUtil.hashPassword(password));
        }

        return userDAO.updateUser(user);
    }


    /**
     * Delete a user.
     */
    public boolean deleteUser(int userId) {

        if (userId <= 0) {
            return false;
        }

        return userDAO.deleteUser(userId);
    }


    /**
     * Check whether username already exists.
     */
    public boolean usernameExists(
            String username) {

        if (username == null ||
                username.trim().isEmpty()) {
            return false;
        }

        return userDAO.usernameExists(
                username.trim());
    }


    /**
     * Validate user role.
     */
    private boolean isValidRole(String role) {

        return "ADMIN".equals(role)
                || "RECEPTIONIST".equals(role);
    }
}