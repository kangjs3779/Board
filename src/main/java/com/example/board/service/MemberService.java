package com.example.board.service;

import com.example.board.domain.Member;
import com.example.board.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean addMember(Member member) {
        //사용자의 비밀번호를 암호화
        String plain = member.getPassword();
        member.setPassword(passwordEncoder.encode(plain));
        System.out.println(member.getPassword());

        Integer count = memberMapper.addMember(member);

        return count == 1;
    }
}
