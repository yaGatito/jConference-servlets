package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.UserDAO;
import com.conference.entities.User;
import com.conference.util.Validation;

import java.sql.Connection;

public class UpdateUserService {
    public static boolean updateUser(String name, String lastname, String email, String notify, User user) {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        boolean emailB = Validation.validate(Validation.PatternString.EMAIL, email);
        boolean nameB = Validation.validate(Validation.PatternString.NAME, name);
        boolean lastnameB = Validation.validate(Validation.PatternString.NAME, lastname);
        if (!emailB || !nameB || !lastnameB) {
            return false;
        }
        boolean res = new UserDAO().updateUser(connection, user);
        user.setName(name);
        user.setLastname(lastname);
        user.setEmail(email);
        user.setNotify(notify != null);
        pool.putBackConnection(connection);
        return res;
    }
}
