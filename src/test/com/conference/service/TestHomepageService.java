package com.conference.service;


import com.conference.dao.DBCPoolTest;
import com.conference.dao.Tables;
import com.conference.dao.TestDAO;
import com.conference.entities.User;
import org.junit.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class TestHomepageService {
    private static final DBCPoolTest pool = DBCPoolTest.getInstance();
    private static final Connection connection = pool.getConnection();

    @Before
    public void clear(){
        TestDAO.deleteAllFrom(Tables.users, connection);
    }

    @Test
    public void testCreateUserWithNullAndEmptyString(){
        List<User> users = new ArrayList<>();
        for (int i = 0; i < 8; i++){
            User user = new User(3,"Test"+i,"Test"+i,"testemail"+i+"@gmail.com","passwordTest"+i,true);
            users.add(user);
        }
        users.get(0).setName(null);
        users.get(1).setLastname(null);
        users.get(2).setEmail(null);
        users.get(3).setPassword(null);

        users.get(4).setName("");
        users.get(5).setLastname("");
        users.get(6).setEmail("");
        users.get(7).setPassword("");
        for (User user : users) {
            Assert.assertFalse(HomepageService.createUser(connection, user));
        }
    }

    @Test
    public void testCreateUserWithInvalidString(){
        List<User> users = new ArrayList<>();
        for (int i = 0; i < 8; i++){
            User user = new User(3,"Test"+i,"Test"+i,"testemail"+i+"@gmail.com","passwordTest"+i,true);
            users.add(user);
        }
        users.get(0).setName("Name$");
        users.get(1).setLastname("Lastname1");
        users.get(2).setEmail("%Emailasasd@gmail.com");
        users.get(3).setName("Phobius1");

        users.get(4).setName("!Sdawd%");
        users.get(5).setLastname("%AdasdAw4");
        users.get(6).setEmail("Adasdas@@gmail.com");
        users.get(7).setName("Asdasdqsdasdasfdsfsdfsdfsdfaad");
        for (User user : users) {
            Assert.assertFalse(HomepageService.createUser(connection, user));
        }
    }

    @Test
    public void testCreateValidUsers(){
        List<User> users = new ArrayList<>();
        for (int i = 0; i < 8; i++){
            User user = new User(3,"Test","Test","testemail"+i+"@gmail.com","passwordTest"+i,true);
            users.add(user);
        }
        for (User user : users) {
            Assert.assertTrue(HomepageService.createUser(connection, user));
        }
    }
}
