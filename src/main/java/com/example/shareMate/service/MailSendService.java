package com.example.shareMate.service;

import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.util.Random;


@Service
public class MailSendService {

    private Integer authNumber;

    public void makeRandomNumber() {
        //난수를 생성하는 메소드
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        authNumber = checkNum;
    }

    public String joinEmail(String email) {
        //보낼 메일 양식
        makeRandomNumber();

        String toMail = email;
        String title = "회원가입을 위하 인증 코드 메일입니다.";
        String message = "홈페이지를 방문해주셔서 감사합니다." +
                        "<br><br>" +
                        "인증번호는 " + authNumber + " 입니다." +
                        "<br><br>" +
                        "해당 인증번호를 인증번호 확인한에 기입하여 주시기바랍니다.";
        mailSend(message, toMail, title);
        return Integer.toString(authNumber);
    }


    public void mailSend(String message, String email, String title) {
        //메일을 보내는 메소드


    }
}
