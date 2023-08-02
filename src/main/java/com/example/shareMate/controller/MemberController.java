package com.example.shareMate.controller;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.Member;
import com.example.shareMate.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("login")
    public void loginForm() {
        //로그인 포워드
    }

    @GetMapping("signup")
    public void joinForm() {
        //join form 포워드
    }

    @PostMapping("signup")
    public String joinProcess(Member member, RedirectAttributes rttr) {
        //회원가입 과정
        boolean ok = memberService.addMember(member);

        if (ok) {
            rttr.addFlashAttribute("message", "회원가입이 되었습니다.");
            rttr.addFlashAttribute("status", "success");

            return "redirect:/member/login";
        } else {
            rttr.addFlashAttribute("message", "회원가입이 실패하였습니다.");
            rttr.addFlashAttribute("status", "fail");

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

        if (ok) {
            rttr.addFlashAttribute("message", "회원정보가 수정되었습니다.");
            rttr.addFlashAttribute("status", "success");
        } else {
            rttr.addFlashAttribute("message", "회원정보를 수정하지 못했습니다.");
            rttr.addFlashAttribute("status", "fail");
        }

        return "redirect:/member/myPage";
    }

    @PostMapping("delete")
    public String deleteProcess(
            Member member,
            RedirectAttributes rttr,
            HttpServletRequest request) throws Exception {

        boolean ok = memberService.deleteMemberByUsername(member);

        if (ok) {
            rttr.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
            rttr.addFlashAttribute("status", "success");
            //로그아웃
            request.logout();

            return "redirect:/member/login";
        } else {
            rttr.addFlashAttribute("message", "회원 탈퇴가 실패하였습니다.");
            rttr.addFlashAttribute("status", "fail");

            return "redirect:/member/myPage";
        }
    }

    @GetMapping("checkUsername")
    @ResponseBody
    public Map<String, Object> checkUserName(@RequestParam("username") String username) {
        //아이디 중복확인
        return memberService.checkUserName(username);
    }

    @GetMapping("checkEmail")
    @ResponseBody
    public Map<String, Object> checkEmail(@RequestParam("email") String email) {
        //이메일 중복확인
        return memberService.checkEmail(email);
    }

    @GetMapping("veriCode")
    @ResponseBody
    public String veriCode(@RequestParam("email") String email) {
        //인증코드 보내기
        return memberService.joinEmail(email);
    }

    @GetMapping("checkveriCode")
    @ResponseBody
    public Map<String, Object> checkVeriCode(@RequestParam("code") Integer code) {
        //인증코드 확인
        return memberService.checkVeriCode(code);
    }

    @GetMapping("list")
    @PreAuthorize("hasAuthority('admin')")
    public void list(Model model) {
        //회원 리스트 조회
        Map<String, Object> list = memberService.selectAllMember();

        model.addAllAttributes(list);
    }

    @GetMapping("myBoard")
    @PreAuthorize("isAuthenticated()")
    public void myBoard(Authentication authentication, Model model) {
        //내가 쓴 게시글 포워드
        Map<String, Object> list = memberService.selectMyBoardByUsername(authentication);

        model.addAllAttributes(list);
    }
}
