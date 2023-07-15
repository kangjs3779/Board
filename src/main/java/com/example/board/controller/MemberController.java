package com.example.board.controller;

import com.example.board.domain.Member;
import com.example.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("member")
public class MemberController {

    @Autowired
    private MemberService memberService;

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
    public String joinProcess(Member member) {
        System.out.println("join process working");

        boolean ok = memberService.addMember(member);

        return "redirect:/member/login";
    }
}
