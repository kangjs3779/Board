package com.example.shareMate.service;

import com.example.shareMate.domain.ChildComment;
import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.ChildCommentMapper;
import com.example.shareMate.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChildCommentService {
    @Autowired
    private ChildCommentMapper childCommentMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private MemberMapper memberMapper;

    public List<ChildComment> selectAllChildComment(Integer commentId, Authentication authentication) {
        List<ChildComment> comments = childCommentMapper.selectAllChildComment(commentId);

        if (authentication != null) {
            //로그인한 사용자라면

            for (ChildComment comment : comments) {
                //답글의 아이디로 회원정보 탐색
                Member member = memberMapper.selectMemberByUsername(comment.getMemberId());

                //로그인 시 사용한 아이디와 탐색한 정보의 아이디가 일치하면 ture 아니면 false
                comment.setEditable(authentication.getName().equals(member.getUsername()));
            }
        }

        return comments;
    }

    public Map<String, Object> add(ChildComment childComment) {
        Map<String, Object> res = new HashMap<>();

        Integer count = childCommentMapper.add(childComment);

        if (count == 1) {
            res.put("message", "답글이 등록되었습니다.");
        } else {
            res.put("message", "답글이 등록되지 않았습니다.");
        }
        return res;
    }

    public Map<String, Object> delete(ChildComment childComment) {
        Map<String, Object> res = new HashMap<>();

        Integer count = childCommentMapper.delete(childComment);

        if (count == 1) {
            res.put("message", "답글이 삭제되었습니다.");
        } else {
            res.put("message", "답글이 삭제되지 않았습니다.");
        }
        return res;
    }

    public ChildComment selectChildCommentByChildId(Integer childCommentId) {
        ChildComment childComment = childCommentMapper.selectChildCommentByChildId(childCommentId);

        return childComment;
    }

    public Map<String, Object> modify(ChildComment childComment) {
        Map<String, Object> res = new HashMap<>();

        Integer count = childCommentMapper.modify(childComment);

        if(count == 1) {
            res.put("message", "답글이 수정되었습니다.");
        } else {
            res.put("message", "답글이 수정되지 않았습니다.");
        }

        return res;
    }
}
