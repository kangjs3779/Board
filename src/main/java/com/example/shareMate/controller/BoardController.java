package com.example.shareMate.controller;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.Member;
import com.example.shareMate.service.BoardService;
import com.example.shareMate.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("board")
public class BoardController {

    @Autowired
    private BoardService boardService;
    @Autowired
    private MemberService memberService;

    @GetMapping("home")
    public void home() {
        //홈페이지 포워드
    }

    @GetMapping("list")
    public void board(Model model) {
        //로그인한 사용자의 정보 불러옴
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        //shareroom 전체 게시글 조회
        Map<String, Object> info = boardService.selectAllBoard(authentication);


        model.addAllAttributes(info);
    }

    @GetMapping("detail")
    public void boardDetail(
            @RequestParam("boardId") Integer boardId,
            Model model) {
        //게시글 상세 조회
        Map<String, Object> info = boardService.selectBoardByDetailId(boardId);

        //로그인한 사용자의 정보 불러옴
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (!authentication.getName().equals("anonymousUser")) {
            Member member = memberService.selectMemberByUsername(authentication.getName());
            member.setLike(memberService.checkLikeByUsernameAndBoardId(authentication.getName(), boardId));

            info.put("member", member);
        }

        model.addAllAttributes(info);
    }

    @GetMapping("addBoard")
    @PreAuthorize("isAuthenticated()")
    public void addBoardForm(Authentication authentication, Model model) {
        //게시글 추가폼 포워드
        Member member = memberService.selectMemberByUsername(authentication.getName());

        model.addAttribute("member", member);
    }

    @PostMapping("addBoard")
    @PreAuthorize("isAuthenticated()")
    public String addBoardProcess(
            Authentication authentication,
            Board board,
            RedirectAttributes rttr
    ) {
        //게시글 추가 과정
        board.setMemberId(authentication.getName());
        boolean ok = boardService.addBoard(board);

        if (ok) {
            rttr.addFlashAttribute("message", "게시글이 추가되었습니다.");
            rttr.addFlashAttribute("status", "success");

            return "redirect:/board/detail?boardId=" + board.getId();

        } else {
            rttr.addFlashAttribute("message", "게시글이 추가하지 못했습니다.");
            rttr.addFlashAttribute("status", "fail");
            return "redirect:/board/addBoard";
        }
    }

    @PostMapping("delete")
    @PreAuthorize("isAuthenticated() and (@customSecurityChecker.checkBoardWriter(authentication, #boardId))")
    public String deleteProcess(
            Authentication authentication,
            Member member,
            @RequestParam("boardId") Integer boardId,
            RedirectAttributes rttr
    ) {
        //게시글 삭제 과정
        member.setUsername(authentication.getName());

        boolean ok = boardService.deleteBoard(boardId, member);

        if (ok) {
            rttr.addFlashAttribute("message", "해당 게시글이 삭제 되었습니다.");
            rttr.addFlashAttribute("status", "success");

            return "redirect:/board/list";
        } else {
            rttr.addFlashAttribute("message", "해당 게시글이 삭제하지 못했습니다.");
            rttr.addFlashAttribute("status", "fail");

            return "redirect:/board/detail?boardId=" + boardId;
        }

    }

    @GetMapping("modify")
    @PreAuthorize("isAuthenticated() and (@customSecurityChecker.checkBoardWriter(authentication, #boardId))")
    public void modifyForm(
            @RequestParam("boardId") Integer boardId,
            Model model,
            Authentication authentication) {
        //게시글 수정 폼 포워드
        //게시글 상세 정보 조회
        Map<String, Object> info = boardService.selectBoardByDetailId(boardId);

        //회원 정보 찾기
        Member member = memberService.selectMemberByUsername(authentication.getName());
        info.put("member", member);

        model.addAllAttributes(info);
    }

    @PostMapping("modify")
    @PreAuthorize("isAuthenticated()")
    public String modifyProcess(Board board, RedirectAttributes rttr) {
        //게시글 수정 과정
        boolean ok = boardService.modifyBoardByBoardId(board);

        if (ok) {
            rttr.addFlashAttribute("message", "게시글이 수정되었습니다.");
            rttr.addFlashAttribute("status", "success");

        } else {
            rttr.addFlashAttribute("message", "게시글이 수정되지 않았습니다.");
            rttr.addFlashAttribute("status", "fail");
        }

        return "redirect:/board/detail?boardId=" + board.getId();
    }

    @GetMapping("ottSearch")
    @ResponseBody
    public List<Board> ottSearch(@RequestParam("ott") String ott) {
        //로그인한 사용자의 정보 불러옴
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return boardService.ottSearch(ott, authentication);
    }
}
