package com.example.board.controller;

import com.example.board.domain.Member;
import com.example.board.service.MemberService;
import lombok.extern.flogger.Flogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
        //로그인 포워드
    }

    @GetMapping("join")
    public void joinForm() {
        //join form 포워드
    }

    @PostMapping("join")
    public String joinProcess(Member member, RedirectAttributes rttr) {
        //회원가입 과정
        boolean ok = memberService.addMember(member);

        if (ok) {
            rttr.addFlashAttribute("message", "회원가입이 되었습니다.");
            return "redirect:/member/login";
        } else {
            rttr.addFlashAttribute("message", "회원가입이 실패하였습니다.");
            return "redirect:/member/join";
        }

    }

    @GetMapping("myPage")
    @PreAuthorize("isAuthenticated()")
    public void myPageForm(Authentication authentication, Model model) {
        //마이페이지 포워드
        Member member = memberService.selectMemberByUsername(authentication.getName());

        model.addAttribute("member", member);
    }

    @GetMapping("modify")
    @PreAuthorize("isAuthenticated()")
    public void modifyForm(Authentication authentication, Model model) {
        //수정페이지 포워드
        Member member = memberService.selectMemberByUsername(authentication.getName());

        model.addAttribute("member", member);
    }

    @PostMapping("modify")
    public String modifyProcess(Member member, RedirectAttributes rttr) {
        //수정페이지 과정
        boolean ok = memberService.modifyMemberByUsername(member);

        if(ok) {
            rttr.addFlashAttribute("message", "회원정보가 수정되었습니다.");
        } else {
            rttr.addFlashAttribute("message", "회원정보를 수정하지 못했습니다.");
        }

        return "redirect:/member/myPage";
    }
}
