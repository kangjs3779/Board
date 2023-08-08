package com.example.shareMate.controller;

import com.example.shareMate.domain.Like;
import com.example.shareMate.service.LikeBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("board")
public class LikeBoardController {
    @Autowired
    private LikeBoardService likeBoardService;

    @PutMapping("addLike")
    @ResponseBody
    public Map<String, Object> addLike(@RequestBody Like like, Authentication authentication) {
        //좋아요 누름
        like.setMemberId(authentication.getName());
        return likeBoardService.addLike(like);
    }

    @DeleteMapping("deleteLike")
    @ResponseBody
    public Map<String, Object> deleteLike(@RequestBody Like like, Authentication authentication) {
        //좋아요 취소
        like.setMemberId(authentication.getName());
        return likeBoardService.deleteLike(like);
    }

    @GetMapping("likeCount")
    @ResponseBody
    public Like likeCount(@RequestParam("boardId") Integer boardId) {
        //좋아요 개수 조회
        Like like = likeBoardService.likeCount(boardId);
        return like;
    }
}
