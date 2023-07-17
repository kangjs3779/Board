package com.example.shareMate.service;

import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.MemberMapper;
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

        Integer count = memberMapper.addMember(member);

        return count == 1;
    }

    public Member selectMemberByUsername(String username) {
        Member member = memberMapper.selectMemberByUsername(username);

        return member;
    }

    public boolean modifyMemberByUsername(Member member) {
        Integer count;

        count = memberMapper.modifyMemberByUsername(member);

        return count == 1;
    }
}
