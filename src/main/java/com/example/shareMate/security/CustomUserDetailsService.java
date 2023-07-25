package com.example.shareMate.security;

import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //회원의 정보를 모두 조회함
        System.out.println("실행");
        Member member = memberMapper.selectByUsername(username);
        System.out.println(member);

        if (member == null) {
            throw new UsernameNotFoundException(username + " 회원이 없습니다.");
        }

        List<GrantedAuthority> list = new ArrayList<>();

        for(String auth : member.getAuthority()) {
            list.add(new SimpleGrantedAuthority(auth));
        }

        UserDetails user = User.builder()
                .username(member.getUsername()) // 사용자가 로그인한 아이디 정보
                .authorities(list)
                .password(member.getPassword()) // 사용자가 로그인한 비밀번호 정보
                .build();
        System.out.println(user);
        return user;
    }
}
