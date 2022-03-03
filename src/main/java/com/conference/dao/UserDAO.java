package com.conference.dao;

import com.conference.entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO  {

    private static final String INSERT_USER = "\n" +
            "INSERT INTO users (id, role, name, lastname, email, password) " +
            "VALUES (default, ?, ?, ?, ?, ?)";

    public boolean insertUser(Connection con, User user){
        try ( PreparedStatement statement = con.prepareStatement(INSERT_USER)) {
            statement.setInt(1,user.getRole());
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

    private static final String SELECT_ALL = "SELECT * FROM users ";

    public List<User> selectAll(Connection con){
        List<User> users;
        try (PreparedStatement statement = con.prepareStatement(SELECT_ALL)) {
            ResultSet set = statement.executeQuery();
            users = new ArrayList<>();
            while (set.next()){
                int id = set.getInt("id");
                int role = set.getInt("role");
                String name = set.getString("name");
                String lastname = set.getString("lastname");
                String email = set.getString("email");
                String password = set.getString("password");
                users.add(new User(id,role,name,lastname,email,password));
            }
            set.close();
        } catch (SQLException e) {
            e.printStackTrace();
            users = null;
        }
        return users;
    }

    private static final String SELECT_COUNT = "SELECT COUNT(*) FROM users ";

    public int getCount(Connection con){
        int count;
        try (PreparedStatement statement = con.prepareStatement(SELECT_COUNT)) {
            ResultSet set = statement.executeQuery();
            set.next();
            count = set.getInt("count");
            set.close();
        } catch (SQLException e) {
            e.printStackTrace();
            count = 0;
        }
        return count;
    }

    private static final String SELECT_LIMIT = "SELECT * FROM users ORDER BY id LIMIT ? OFFSET ?";

    public List<User> selectLimit(Connection con, int amount,int page){
        List<User> users;
        try (PreparedStatement statement = con.prepareStatement(SELECT_LIMIT)) {
            statement.setInt(1,amount);
            statement.setInt(2,amount*(page-1));
            ResultSet set = statement.executeQuery();
            users = new ArrayList<>();
            while (set.next()){
                int id = set.getInt("id");
                int role = set.getInt("role");
                String name = set.getString("name");
                String lastname = set.getString("lastname");
                String email = set.getString("email");
                String password = set.getString("password");
                users.add(new User(id,role,name,lastname,email,password));
            }
            set.close();
        } catch (SQLException e) {
            e.printStackTrace();
            users = null;
        }
        return users;
    }

    private static final String DELETE_BY_ID = "DELETE FROM users WHERE id = ?";

    public boolean deleteById(Connection con, int id){
        try(PreparedStatement statement = con.prepareStatement(DELETE_BY_ID)){
            statement.setInt(1,id);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String UPDATE_BY_ID = "UPDATE users SET name = ?, lastname = ?, email = ?, notify = ? WHERE id = ?";

    public boolean updateUser(Connection con, User user){
        try(PreparedStatement statement = con.prepareStatement(UPDATE_BY_ID)){
            statement.setString(1,user.getName());
            statement.setString(2,user.getLastname());
            statement.setString(3,user.getEmail());
            statement.setBoolean(4,user.getNotify());
            statement.setInt(5,user.getId());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String SET_ROLE = "UPDATE users SET role = ? WHERE id = ?";

    public boolean setRole(Connection con, int role, int id){
        try(PreparedStatement statement = con.prepareStatement(SET_ROLE)){
            statement.setInt(1,role);
            statement.setInt(2,id);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String GET_BY_ID = "SELECT * FROM users WHERE id = ?";

    public User getByID(Connection con, int id){
        try (PreparedStatement statement = con.prepareStatement(GET_BY_ID)) {
            statement.setInt(1,id);
            ResultSet set = statement.executeQuery();
            User user = null;
            while (set.next()) {
                int role = set.getInt("role");
                String name = set.getString("name");
                String lastname = set.getString("lastname");
                String email = set.getString("email");
                String password = set.getString("password");
                user = new User(role, name, lastname, email, password);
            }
            set.close();
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
private static final String LOGGED_USER = "SELECT * FROM users WHERE email = ? AND password = ?";

    public User loginUser(Connection con, String email, String password){
        User user = null;
        try (PreparedStatement statement = con.prepareStatement(LOGGED_USER)) {
            statement.setString(1,email);
            statement.setString(2,password);
            ResultSet set = statement.executeQuery();
            if(set.next()) {
                int id = set.getInt("id");
                int role = set.getInt("role");
                String name = set.getString("name");
                String lastname = set.getString("lastname");
                user = new User(id, role, name, lastname, email, password);
            }
            set.close();
        } catch (SQLException e) {
            user = null;
            e.printStackTrace();
        }
        return user;
    }

    private static final String SELECT_SPEAKER = "SELECT * FROM users WHERE role = 2"; //2 - Speaker

    public List<User> selectSpeakers(Connection con){
        List<User> users;
        try (PreparedStatement statement = con.prepareStatement(SELECT_SPEAKER)) {
            ResultSet set = statement.executeQuery();
            users = new ArrayList<>();
            while (set.next()){
                int id = set.getInt("id");
                int role = set.getInt("role");
                String name = set.getString("name");
                String lastname = set.getString("lastname");
                String email = set.getString("email");
                String password = set.getString("password");
                users.add(new User(id,role,name,lastname,email,password));
            }
            set.close();
        } catch (SQLException e) {
            e.printStackTrace();
            users = null;
        }
        return users;
    }
}
