package com.example.board.security;

import com.example.board.domain.Member;
import com.example.board.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

@Component
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Member member = memberMapper.selectByUsername(username);

        if(member == null) {
            throw new UsernameNotFoundException(username + " 회원이 없습니다.");
        }

        UserDetails user = User.builder()
                .username(member.getUsername())
                .password(member.getPassword())
                .build();
        return user;
    }
}
