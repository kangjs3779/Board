package com.example.shareMate.security;

import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.MemberMapper;
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
        //회원의 정보를 모두 조회함
        Member member = memberMapper.selectByUsername(username);

        if(member == null) {
            throw new UsernameNotFoundException(username + " 회원이 없습니다.");
        }

        //사용자의 정보를 넣어줌
        UserDetails user = User.builder()
                .username(member.getUsername())//사용자가 로그인한 아이디 정보
                .password(member.getPassword())//사용자가 로그인한 비밀번호 정보
                .authorities(member.getAuthority())//사용자의 권한 정보
                .build();
        return user;
    }
}
