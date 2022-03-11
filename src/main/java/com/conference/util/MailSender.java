package com.conference.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class MailSender {
    static MailSender instance;
    Session session;

    private MailSender() {
        try (FileReader fis = new FileReader(
                "C:\\Users\\Никита\\IdeaProjects\\jConference\\src\\main\\resources\\mail.properties")) {
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

    public boolean sendMessage(String subject, String msg, String resipient){
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("jConferenceTeam"));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(resipient));
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

    public Map<String, Boolean> sendMessage(String subject, String msg, List<String> emails){
        Map<String, Boolean> res = new HashMap<>();
        for (String email : emails) {
            res.put(email, sendMessage(subject,msg,email));
        }
        return res;
    }
}
