package com.example.shareMate.service;

import com.example.shareMate.domain.BoardComment;
import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.BoardCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardCommentService {
    @Autowired
    private BoardCommentMapper boardCommentMapper;
    @Autowired
    private MemberService memberService;

    public List<BoardComment> selectAllComment(Integer boardId, Authentication authentication) {
        //댓글 전체 조회
        List<BoardComment> comments = boardCommentMapper.selectAllComment(boardId);

        //로그인을 한 사용자이면
        if (authentication != null) {
            System.out.println("시작 : " + authentication.getName());
            for (BoardComment comment : comments) {
                //회원의 정보를 찾아서
                Member member = memberService.selectMemberByUsername(authentication.getName());
                System.out.println(authentication.getName() + ", " + member.getUsername());
                //comment자바빈에 로그인한 정보와 회원의 정보가 같은지 다른지의 결과를 넣음
                comment.setEditable(authentication.getName().equals(member.getUsername()));
            }
        }

        return comments;
    }

    public Map<String, Object> add(BoardComment boardComment) {
        Map<String, Object> res = new HashMap<String, Object>();

        Integer count = boardCommentMapper.add(boardComment);

        if (count == 1) {
            res.put("message", "댓글이 등록되었습니다.");
        } else {
            res.put("message", "댓글이 등록되지 않았습니다.");
        }

        return res;
    }
}
