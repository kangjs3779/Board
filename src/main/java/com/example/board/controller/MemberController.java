package com.example.board.controller;

import com.example.board.domain.Member;
import com.example.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("login")
    public void loginForm() {
        System.out.println("login form working");
    }

    @GetMapping("join")
    public void joinForm() {
        //join form 포워드
    }

    @PostMapping("join")
    public String joinProcess(Member member, RedirectAttributes rttr) {
        System.out.println("join process working");

        boolean ok = memberService.addMember(member);

        if (ok) {
            rttr.addFlashAttribute("message", "회원가입이 되었습니다.");
            return "redirect:/member/login";
        } else {
            rttr.addFlashAttribute("message", "회원가입이 실패하였습니다.");
            return "redirect:/member/join";
        }

    }
}
