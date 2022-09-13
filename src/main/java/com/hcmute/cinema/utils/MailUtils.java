package com.hcmute.cinema.utils;

import com.hcmute.cinema.Config.Constant;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class MailUtils {
    private static int randomOTP;

    public static void send(String to, String sub, String msg) {
        try {
            JavaMailSenderImpl emailSender = new JavaMailSenderImpl();
            emailSender.setHost("smtp.gmail.com");
            emailSender.setPort(587);
            emailSender.setUsername(Constant.SYSTEM_EMAIL);
            emailSender.setPassword(Constant.SYSTEM_EMAIL_PASSWORD);

            Properties properties = new Properties();
            properties.setProperty("mail.smtp.auth", "true");
            properties.setProperty("mail.smtp.starttls.enable", "true");
            emailSender.setJavaMailProperties(properties);

            MimeMessage message = emailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message);
            helper.setFrom(new InternetAddress(Constant.SYSTEM_EMAIL));
            helper.setTo(to);
            helper.setSubject(sub);
            helper.setText(msg, true);
            emailSender.send(message);
        }catch (Exception e){
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
                        + "    <div>Your OTP :" + random + "</div>\n"
                        + "\n"
                        + "</body>\n"
                        + "\n"
                        + "</html>";
                MailUtils.send(email, subject, message);
                return true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            if (Integer.parseInt(userOTP,10) == randomOTP) {
                Random rnd = new Random();
                int random = rnd.nextInt(999999);
                randomOTP = random;
                return true;
            } else return false;
        }
        return false;
    }

    public static void sendResetPassword(String email, String newPassword ) throws MessagingException {
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
