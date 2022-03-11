package com.conference;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.entity.User;
import com.conference.util.MailSender;

import java.util.List;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        EventDAO edao = new EventDAO();
        Set<User> users = edao.selectRecipients(DBCPool.getInstance().getConnection(), 20);
        System.out.println(users);

    }

}
