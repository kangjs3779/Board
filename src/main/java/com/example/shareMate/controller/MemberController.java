package com.example.shareMate.controller;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.Member;
import com.example.shareMate.domain.ShareMate;
import com.example.shareMate.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.One;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import software.amazon.awssdk.services.s3.endpoints.internal.Value;

import java.util.HashMap;
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
        Map<String, Object> info = memberService.selectInfoByMemberId(authentication.getName());

        //파티장 정보 조회
        Map<String, Object> leaderInfo = memberService.selectLeaderInfoByMemberId(authentication.getName());

        //회원 정보 조회
        Member member = memberService.selectMemberByUsername(authentication.getName());

        info.put("member", member);
        model.addAllAttributes(info);
        model.addAllAttributes(leaderInfo);

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

    @GetMapping("checkNickname")
    @ResponseBody
    public Map<String, Object> checkNickname(@RequestParam("nickname") String nickname) {
        //닉네임 중복확인
        return memberService.checkNickname(nickname);
    }

    @GetMapping("veriCode")
    @ResponseBody
    public String veriCode(@RequestParam("email") String email) {
        //인증코드 보내기
        return memberService.joinEmail(email);
    }

    @GetMapping("sendInfoEmail")
    @ResponseBody
    public  void sendInfoEmail(
            @RequestParam("email") String email,
            @RequestParam("ott") String ott,
            @RequestParam("boardId") Integer boardId) {
        //메이트 메일로 정보 보내기
        memberService.sendInfoEmail(email, ott, boardId);
        System.out.println(email + ", " + ott);
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
        Map<String, Object> info = memberService.selectMyBoardByUsername(authentication);

        model.addAllAttributes(info);
    }

    @GetMapping("myBoardList")
    @ResponseBody
    public Map<String, Object> 제myBoardList(Authentication authentication) {
        //내가 쓴 게시글 포워드
        Map<String, Object> info = memberService.selectMyBoardByUsername(authentication);

        return info;
    }

    @DeleteMapping("myBoardDelete/{boardId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(
            @PathVariable("boardId") Integer boardId,
            @RequestBody Member member) {
        //내가 쓴 게시글에서 게시글 삭제
        Map<String, Object> res = memberService.deleteMyboard(boardId, member);

        return ResponseEntity.ok().body(res);
    }

    @GetMapping("findInfo")
    public void findInfoForward() {
        //아이디/비밀번호찾기 포워드
    }

    @GetMapping("findEmailAndName")
    @ResponseBody
    public Map<String, Object> findEmailAndName(
            @RequestParam("email") String email,
            @RequestParam("name") String name) {
        return  memberService.findEmailAndName(email, name);
    }

    @GetMapping("findIdAndEmail")
    @ResponseBody
    public Map<String, Object> findIdAndEmail(
            @RequestParam("email") String email,
            @RequestParam("id") String id) {
        return memberService.findIdAndEmail(id,email);
    }

    @PatchMapping("completeEmail")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> completeEmail(@RequestBody ShareMate shareMate) {
        Map<String, Object> res = memberService.completeEmail(shareMate);

        return ResponseEntity.ok().body(res);
    }
}
