package com.hcmute.cinema.Utils;

import com.hcmute.cinema.Config.Constant;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class MailUtils {
    private static int randomOTP;
    public static void send(String to, String sub, String msg) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        Session session = Session.getInstance(props, new javax.mail.Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Constant.SYSTEM_EMAIL,Constant.SYSTEM_EMAIL_PASSWORD);
            }
        });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Constant.SYSTEM_EMAIL));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(sub);
            message.setContent(msg, "text/html;charset=UTF-8");
            Transport.send(message);
            System.out.println("Send e-mail successfully");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public static boolean sendOTP(String email, String userOTP) {
        if (userOTP.equals("")) {
            try {
                Random rnd = new Random();
                int random = rnd.nextInt(999999);
                randomOTP = random;
                String.format("%06d", random);
                String subject = "OTP Verify From BHD Star";
                String message = "<!DOCTYPE html>\n"
                        + "<html lang=\"en\">\n"
                        + "\n"
                        + "<head>\n"
                        + "</head>\n"
                        + "\n"
                        + "<body>\n"
                        + "    <h3 style=\"color: blue;\">Your OTP</h3>\n"
                        + "    <div>Email :" + email + "</div>\n"
                        + "    <div>Your OTP :" + random + "</div>\n"
                        + "\n"
                        + "</body>\n"
                        + "\n"
                        + "</html>";
                MailUtils.send(email, subject, message);
                return true;
            } catch (Exception e) {
                return false;
            }
        } else {
            if (Integer.parseInt(userOTP,10) == randomOTP) {
                Random rnd = new Random();
                int random = rnd.nextInt(999999);
                randomOTP = random;
                return true;
            } else return false;
        }
    }

    public static void sendResetPassword(String email, String newPassword ){
        String subject = "Reset password request | Auction Website";
        String message = "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "\n"
                + "<head>\n"
                + "</head>\n"
                + "\n"
                + "<body>\n"
                + "    <h3 style=\"color: blue;\">Your password has been reset.</h3>\n"
                + "    <div>Email :" + email + "</div>\n"
                + "    <div>Your reset password :" + newPassword + "</div>\n"
                + "\n"
                + "</body>\n"
                + "\n"
                + "</html>";
        MailUtils.send(email, subject, message);
    }
}
