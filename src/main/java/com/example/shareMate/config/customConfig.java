package com.example.shareMate.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Configuration
@EnableMethodSecurity
public class customConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf().disable();

        http.formLogin()
                .loginPage("/member/login")
                .defaultSuccessUrl("/board/list", true)
                .failureHandler((request, response, exception) -> {
                    // 실패 시 처리할 로직 구현
                    String errorMessage = "로그인 실패하였습니다.";
                    request.setAttribute("message", errorMessage);
                    String redirectUrl = "/member/login?message=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8);
                    response.sendRedirect(redirectUrl);
                });

        http.logout().logoutUrl("/member/logout");

        return http.build();
    }
}
