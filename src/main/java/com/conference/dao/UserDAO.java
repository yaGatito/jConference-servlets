package com.conference.dao;

import com.conference.bean.Role;
import com.conference.bean.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private final static String URL = "jdbc:postgresql://localhost:5432/conf";
    private final static String UNAME = "postuser";
    private final static String UPASS = "root";

    private final static String FULL = URL + "?user=" + UNAME + "&password=" + UPASS;
    private final static String DRIVER = "org.postgresql.Driver";



    private Connection getConnection(){
        Connection connection;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL,UNAME,UPASS);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            connection = null;
        }
        return connection;
    }

    private static final String INSERT_USER = "\n" +
            "INSERT INTO users (id, role, name, lastname, email, password) " +
            "VALUES (default, ?, ?, ?, ?, ?)";

    public boolean insertUser(User user){
        try (PreparedStatement statement = getConnection().prepareStatement(INSERT_USER)) {
            statement.setInt(1,user.getRoleID());
            statement.setString(2,user.getName());
            statement.setString(3,user.getLastname());
            statement.setString(4,user.getEmail());
            statement.setString(5,user.getPassword());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String SELECT_ALL = "SELECT * FROM users";

    public List<User> selectAll(){
        List<User> users;
        try (PreparedStatement statement = getConnection().prepareStatement(SELECT_ALL)) {
            users = new ArrayList<>();
            ResultSet set = statement.executeQuery();
            while (set.next()){
                int id = set.getInt("id");
                int role = set.getInt("role");
                String name = set.getString("name");
                String lastname = set.getString("lastname");
                String email = set.getString("email");
                String password = set.getString("password");
                users.add(new User(id,role,name,lastname,email,password));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            users = null;
        }
        return users;
    }

    private static final String GET_BY_ID = "SELECT * FROM users WHERE id = ?";

    public User getByID(int id){
        try (PreparedStatement statement = getConnection().prepareStatement(GET_BY_ID)) {
            statement.setInt(1,id);
            ResultSet set = statement.executeQuery();
            set.next();
            int role = set.getInt("role");
            String name = set.getString("name");
            String lastname = set.getString("lastname");
            String email = set.getString("email");
            String password = set.getString("password");
            User user = new User(role,name,lastname,email,password);
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static final String SELECT_SPEAKER = "SELECT * FROM users WHERE role = 2"; //2 - Speaker

    public List<User> selectSpeakers(){
        List<User> users;
        try (PreparedStatement statement = getConnection().prepareStatement(SELECT_SPEAKER)) {
            users = new ArrayList<>();
            ResultSet set = statement.executeQuery();
            while (set.next()){
                int id = set.getInt("id");
                int role = set.getInt("role");
                String name = set.getString("name");
                String lastname = set.getString("lastname");
                String email = set.getString("email");
                String password = set.getString("password");
                users.add(new User(id,role,name,lastname,email,password));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            users = null;
        }
        return users;
    }
}
