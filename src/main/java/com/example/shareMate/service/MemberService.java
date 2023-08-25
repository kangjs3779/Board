package com.example.shareMate.service;

import com.example.shareMate.domain.*;
import com.example.shareMate.mapper.*;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
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
    @Autowired
    private BoardCommentMapper boardCommentMapper;
    private Integer authNumber;
    @Value("${spring.mail.username}")
    private String username;
    @Autowired
    private LikeBoardMapper likeBoardMapper;
    @Autowired
    private OttMapper ottMapper;
    @Autowired
    private ShareMateMapper shareMateMapper;
    @Autowired
    private PaymentMapper paymentMapper;

    public boolean addMember(Member member) {
        //사용자의 비밀번호를 암호화
        String plain = member.getPassword();
        String encoder = passwordEncoder.encode(plain);
        member.setPassword(encoder);

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
        Integer count = 0;

        if (member.getPassword() == null) {
            //회원 정보 수정할떄
            count = memberMapper.modifyMemberByUsername(member);
        } else {
            //비밀번호 수정할 때
            //사용자가 입력한 비밀번호를 암호화
            String plain = member.getPassword();
            String encoder = passwordEncoder.encode(plain);
            member.setPassword(encoder);

            count = memberMapper.modifyPasswordByUsername(member);
        }
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

        return Map.of("available", member == null);
    }

    public Map<String, Object> checkEmail(String email) {
        Map<String, Object> data = new HashMap<>();

        //이메일 중복 확인
        //중복된 이메일이 없으면 사용 가능
        Member member = memberMapper.selectMemberByEmail(email);
        data.put("available", member == null);

        return data;
    }

    public void makeRandomNumber() {
        //회원가입 시 필요한 난수를 생성하는 메소드
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        authNumber = checkNum;
    }

    public String joinEmail(String email) {
        //회원가입 시 보낼 메일 양식
        makeRandomNumber();

        String setFrom = username; // email-config에 설정한 자신의 이메일 주소를 입력
        String toMail = email;
        String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목
        String content =
                "Share Mate 홈페이지를 방문해주셔서 감사합니다." +    //html 형식으로 작성 !
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
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            // true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
            helper.setText(content, true);
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public Map<String, Object> checkVeriCode(Integer code) {
        //사용자가 입력한 인증 번호와 인증메일의 인증번호 확인
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
        Map<String, Object> info = new HashMap<>();

        //내가 쓴 게시물 조회
        List<Board> boards = memberMapper.selectMyBoardByUsername(authentication.getName());

        //게시글 정보 입력하는 메소드
        boardService.boardInfo(boards, authentication);

        //ott서비스 전체 조회
        List<Ott> otts = ottMapper.selectOtt();

        info.put("boards", boards);
        info.put("otts", otts);

        return info;
    }

    public Map<String, Object> deleteMyboard(Integer boardId, Member member) {
        //내가 쓴 게시물 한번에 삭제하기
        Map<String, Object> res = new HashMap<>();

        //게시글 삭제
        boolean ok = boardService.deleteBoard(boardId, member);

        if (ok) {
            res.put("message", "선택한 게시글이 삭제 되었습니다.");
        } else {
            res.put("message", "선택한 게시글이 삭제 되지않았습니다.");
        }

        return res;

    }

    public Map<String, Object> checkNickname(String nickname) {
        //닉네임 중복확인
        Member member = memberMapper.selectByNickname(nickname);

        return Map.of("available", member == null);
    }

    public Map<String, Object> findEmailAndName(String email, String name) {
        //이름과 이메일로 회원 확인
        Member member = memberMapper.selectMemberByNameAndEmail(email, name);
        return Map.of("check", member != null, "member", member);
    }

    public Map<String, Object> findIdAndEmail(String id, String email) {
        //아이디와 이메일로 회원확인
        Member member = memberMapper.selectMemberByIdAndEmail(email, id);
        return Map.of("check", member != null, "member", member);
    }

    public Map<String, Object> checkeByUsernameAndBoardId(String memberId, Integer boardId) {
        Map<String, Object> check = new HashMap<>();

        //좋아요를 누른 게시글인지 확인
        Like like = likeBoardMapper.checkLikeByUsernameAndBoardId(memberId, boardId);
        check.put("like", like != null);

        //sharemate 참여한 게시글인지 확인
        ShareMate shareMate = shareMateMapper.checkMateByMemberIdAndBoardId(memberId, boardId);
        check.put("mate", shareMate != null);

        return check;
    }

    public Map<String, Object> selectInfoByMemberId(String memberId) {

        Map<String, Object> info = new HashMap<>();

        //내가 참여 중인 (파티원으로서)메이트 정보 찾기
        List<ShareMate> shareMates = shareMateMapper.selectShareByMemberId(memberId);

        //ott정보 찾기
        List<Ott> otts = new ArrayList<>();

        //결제 정보 찾기
        List<Payment> payments = new ArrayList<>();

        for(int i = 0; i < shareMates.size(); i++) {
            Ott ott = ottMapper.selectOttByOttId(shareMates.get(i).getOttId());
            //쉐어메이트 아이디 넣기
            ott.setShareMateId(shareMates.get(i).getId());

            //게시글 아이디 넣기
            ott.setBoardId(shareMates.get(i).getBoardId());

            //한 명당 내는 요금 넣기
            Integer costPerPerson = ott.getCost()/ott.getLimitedAttendance();
            DecimalFormat df = new DecimalFormat("#,###");
            ott.setCostPerPerson(df.format(costPerPerson));

            //승인 단계 넣기
            ott.setApprove(shareMates.get(i).getApprove());

            //결제 정보
            Payment payment = paymentMapper.selectPaymentByShareId(shareMates.get(i).getId());

            payments.add(payment);

            System.out.println(payment);

            otts.add(ott);
        }

        info.put("sharMates", shareMates);
        info.put("otts", otts);
        info.put("payments", payments);


        return info;
    }

    public Map<String, Object> selectLeaderInfoByMemberId(String memberId) {
        Map<String, Object> leaderInfo = new HashMap<>();
        DecimalFormat df = new DecimalFormat("#,###");

        //내가 쓴 게시글이면서 파티장인 서비스의 메이트들 정보 찾기 = 내가 구독 중인 서비스의 메이트 정보(리더로서)
        List<Board> leaderBoard = boardMapper.selectBoardByMemberIdAndRoll(memberId);

        //참여 신청한 메이트 정보 찾기
        List<ShareMate> mates = new ArrayList<>();

        for(Board board : leaderBoard) {
            //해당 게시글의 메이트들을 조회함
            List<ShareMate> shareMate = shareMateMapper.selectLeaderShareByBoardId(board.getId());

            for(int i = 0; i < shareMate.size(); i++) {
                Integer costPerPerson = shareMate.get(i).getCost()/shareMate.get(i).getLimitedAttendance();
                shareMate.get(i).setCostPerPerson(df.format(costPerPerson));

                mates.add(shareMate.get(i));
                System.out.println(shareMate.get(i));
            }
        }

        leaderInfo.put("mates", mates);

        return leaderInfo;
    }
}
