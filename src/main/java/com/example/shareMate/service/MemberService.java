package com.example.shareMate.service;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.BoardMapper;
import com.example.shareMate.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private BoardMapper boardMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;

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
                    boardMapper.deleteBoardByBoardId(board.getId());
                }
            }

            //회원정보 삭제
            count = memberMapper.deleteMemberByUsername(member);
        }
        return count == 1;
    }
}
