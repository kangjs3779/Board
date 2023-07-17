package com.example.shareMate.security;

import com.example.shareMate.domain.Board;
import com.example.shareMate.mapper.BoardMapper;
import com.example.shareMate.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component
public class CustomSecurityChecker {

    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private BoardMapper boardMapper;

    public boolean checkBoardWriter(Authentication authentication, Integer boardId) {
        Board board = boardMapper.selectBoardByBoardId(boardId);
        return board.getMemberId().equals(authentication.getName());
    }

}
