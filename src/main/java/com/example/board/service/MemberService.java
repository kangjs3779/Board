package com.example.board.service;

import com.example.board.domain.Member;
import com.example.board.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    public boolean addMember(Member member) {
        Integer count = memberMapper.addMember(member);

        return count == 1;
    }
}
