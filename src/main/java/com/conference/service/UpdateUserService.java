package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.UserDAO;
import com.conference.entities.User;

import java.sql.Connection;

public class UpdateUserService {
    public static boolean updateUser(User user){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        boolean res = new UserDAO().updateUser(connection, user);
        pool.putBackConnection(connection);
        return res;
    }
}
