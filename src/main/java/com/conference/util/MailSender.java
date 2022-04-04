package com.conference.util;

import com.conference.entities.Event;
import com.conference.entities.User;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class MailSender {
    private static final String workMail = "dclazovskyi@gmail.com";
    private static MailSender instance;
    Session session;

    private MailSender() {
        try (FileReader fis = new FileReader(
                "C:\\Users\\Nikita\\IdeaProjects\\jConference\\src\\main\\resources\\mail.properties")) {
            Properties prop = new Properties();
            prop.load(fis);
            session = Session.getInstance(prop, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(prop.getProperty("mail.username"),prop.getProperty("mail.password"));
                }
            });
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static MailSender getInstance(){
        if (instance == null){
            instance = new MailSender();
        }
        return instance;
    }

    public Map<String, Boolean> sendChangesMessages(Map<String, String> changes, Set<User> recipients, Event event){
        Map<String, Boolean> res = new HashMap<>();

        StringBuffer msgSubject = new StringBuffer();
        msgSubject.append("Changes in ").append(event.getTopic());

        StringBuffer msgBody = new StringBuffer();
        for (Map.Entry<String, String> entry : changes.entrySet()) {
            msgBody.append(entry.getKey());
            msgBody.append(" changed to ");
            msgBody.append(entry.getValue());
            msgBody.append(".<br/>");
        }

        for (User recipient : recipients) {
            if (workMail != null){
                recipient.setEmail(workMail);
            }

            StringBuffer msg = new StringBuffer();
            msg.
                    append("Hello, ").
                    append(recipient.getName()).
                    append("! ").
                    append("We should inform you that we have some changes in ").
                    append(event.getTopic()).
                    append(" event.<br/>");
            msg.append(msgBody);
            res.put(recipient.getEmail(),sendMsg(msgSubject.toString(), msg.toString(), recipient.getEmail()));
        }

        return res;
    }

    private boolean sendMsg(String subject, String msg, String recipient){
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("jConferenceTeam"));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            MimeBodyPart mimeBodyPart = new MimeBodyPart();

            mimeBodyPart.setContent(msg, "text/html; charset=utf-8");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
