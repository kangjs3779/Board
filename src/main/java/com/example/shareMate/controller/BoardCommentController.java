package com.example.shareMate.controller;

import com.example.shareMate.domain.BoardComment;
import com.example.shareMate.service.BoardCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("boardComment")
@ResponseBody
public class BoardCommentController {

    @Autowired
    private BoardCommentService boardCommentService;

    @GetMapping("list")
    public List<BoardComment> list(@RequestParam("boardId") Integer boardId) {
        //댓글 전체 조회
        List<BoardComment> list = boardCommentService.selectAllComment(boardId);

        return list;
    }

    @PostMapping("add")
    public ResponseEntity<Map<String, Object>> add(@RequestBody BoardComment boardComment) {
        // 댓글 등록
        Map<String, Object> res = boardCommentService.add(boardComment);
        return ResponseEntity.ok().body(res);
    }
}
