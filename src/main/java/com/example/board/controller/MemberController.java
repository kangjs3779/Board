package com.example.board.controller;

import com.example.board.domain.Member;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("member")
public class MemberController {

    @GetMapping("login")
    public void loginForm() {
        System.out.println("login form working");
    }

    @PostMapping("login")
    public void loginProcess() {
        System.out.println("login process working");
    }

    @GetMapping("join")
    public void joinForm() {
        //join form 포워드
    }

    @PostMapping("join")
    public void joinProcess() {
        System.out.println("join process working");
    }
}
