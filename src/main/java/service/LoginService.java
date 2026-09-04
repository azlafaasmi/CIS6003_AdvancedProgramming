package service;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

public class LoginService {

    private final UserDAO userDAO;

    public LoginService() {
        this.userDAO = new UserDAO();
    }

    public User login(String username, String password) {

        if (username == null || password == null) {
            return null;
        }

        username = username.trim();

        User user = userDAO.findByUsername(username);

        if (user == null) {
            return null;
        }

        String storedPassword = user.getPassword();

        /*
         * Supports BCrypt passwords.
         */
        if (storedPassword != null
                && storedPassword.startsWith("$2")) {

            if (PasswordUtil.checkPassword(
                    password,
                    storedPassword)) {

                return user;
            }

            return null;
        }

        /*
         * Temporary support for the existing database
         * account where password is currently plaintext.
         */
        if (password.equals(storedPassword)) {

            /*
             * Upgrade plaintext password to BCrypt after
             * successful login.
             */
            String newHash =
                    PasswordUtil.hashPassword(password);

            userDAO.updatePassword(
                    user.getUserId(),
                    newHash
            );

            user.setPassword(newHash);

            return user;
        }

        return null;
    }
}