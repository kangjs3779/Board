package com.example.shareMate.service;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.BoardMapper;
import com.example.shareMate.mapper.MemberMapper;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.websocket.OnClose;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private BoardMapper boardMapper;
    @Autowired
    private BoardService boardService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private JavaMailSender mailSender;
    private Integer authNumber;
    @Value("${spring.mail.username}")
    private String username;

    public boolean addMember(Member member) {
        //사용자의 비밀번호를 암호화
        String plain = member.getPassword();
        member.setPassword(passwordEncoder.encode(plain));

        //회원 추가
        Integer count = memberMapper.addMember(member);

        return count == 1;
    }

    public Member selectMemberByUsername(String username) {
        //아이디로 회원 정보 조회
        Member member = memberMapper.selectMemberByUsername(username);

        return member;
    }

    public boolean modifyMemberByUsername(Member member) {
        //아이디로 회원 정보 수정
        Integer count;

        count = memberMapper.modifyMemberByUsername(member);

        return count == 1;
    }

    public boolean deleteMemberByUsername(Member member) {
        //아이디로 회원 정보 삭제
        Integer count = 0;

        //사용자가 입력한 비밀번호와 기존의 비밀번호 확인
        Member originMember = selectMemberByUsername(member.getUsername());

        if (passwordEncoder.matches(member.getPassword(), originMember.getPassword())) {
            //비밀번호 일치하면

            //작성한 게시글 유무 확인
            List<Board> boardList = boardMapper.selectBoardByMemberId(member.getUsername());
            if (boardList.size() != 0) {
                for (Board board : boardList) {
                    //작성한 게시글이 있으면 모두 삭제
                    boardService.deleteBoard(board.getId(), member);
                    //ott서비스 정보 모두 삭제

                }
            }

            //회원정보 삭제
            count = memberMapper.deleteMemberByUsername(member);
        }
        return count == 1;
    }

    public Map<String, Object> checkUserName(String username) {
        //아이디 중복 확인
        Member member = memberMapper.selectByUsername(username);
        System.out.println(username);
        System.out.println(member == null);

        return Map.of("available", member == null);
    }

    public  Map<String, Object> checkEmail(String email) {
        Map<String, Object> data = new HashMap<>();

        //이메일 중복 확인
        //중복된 이메일이 없으면 사용 가능
        Member member = memberMapper.selectMemberByEmail(email);
        data.put("available", member == null);

        return data;
    }

    public void makeRandomNumber() {
        //난수를 생성하는 메소드
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        authNumber = checkNum;
    }

    public String joinEmail(String email) {
        //보낼 메일 양식
        makeRandomNumber();

        String setFrom = username; // email-config에 설정한 자신의 이메일 주소를 입력
        String toMail = email;
        String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목
        String content =
                "홈페이지를 방문해주셔서 감사합니다." + 	//html 형식으로 작성 !
                        "<br><br>" +
                        "인증 번호는 " + authNumber + "입니다." +
                        "<br>" +
                        "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
        mailSend(setFrom, toMail, title, content);
        return Integer.toString(authNumber);
    }


    public void mailSend(String setFrom, String toMail, String title, String content) {
        //메일을 보내는 메소드
        MimeMessage message = mailSender.createMimeMessage();
        // true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            // true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
            helper.setText(content,true);
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public Map<String, Object> checkVeriCode(Integer code) {
        //사용자가 입력한 인증 번호와 인증메일의 인증번호 확인
        System.out.println("code : " + code);
        System.out.println("auth : " + authNumber);
        System.out.println(code.equals(authNumber));
        return Map.of("available", code.equals(authNumber));
    }

    public Map<String, Object> selectAllMember() {
        Map<String, Object> info = new HashMap<>();

        //회원 정보 전체 리스트 조회
       List<Member> list = memberMapper.selectAllMember();
       info.put("list", list);

       return info;
    }

    public Map<String, Object> selectMyBoardByUsername(Authentication authentication) {
        //내가 쓴 게시물 조회
        Map<String, Object> list = new HashMap<>();

        List<Board> board = memberMapper.selectMyBoardByUsername(authentication.getName());
        list.put("board", board);

        return  list;
    }
}
