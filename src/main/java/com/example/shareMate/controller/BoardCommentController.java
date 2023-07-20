package com.example.shareMate.controller;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.BoardComment;
import com.example.shareMate.service.BoardCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
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
    public List<BoardComment> list(@RequestParam("boardId") Integer boardId, Authentication authentication) {
        //댓글 전체 조회
        List<BoardComment> list = boardCommentService.selectAllComment(boardId, authentication);

        return list;
    }

    @PostMapping("add")
    public ResponseEntity<Map<String, Object>> add(@RequestBody BoardComment boardComment) {
        // 댓글 등록
        Map<String, Object> res = boardCommentService.add(boardComment);
        return ResponseEntity.ok().body(res);
    }

    @GetMapping("get")
    public BoardComment get(@RequestParam("commentId") Integer commentId) {
        //해당 댓글 조회
        BoardComment boardComment = boardCommentService.selectCommentByCommentId(commentId);

        return boardComment;
    }

    @PatchMapping("modify")
    public ResponseEntity<Map<String, Object>> modify(@RequestBody BoardComment boardComment) {
        //댓글 수정
        Map<String, Object> res = boardCommentService.modifyComment(boardComment);

        return ResponseEntity.ok().body(res);
    }

    @DeleteMapping("delete")
    public ResponseEntity<Map<String, Object>> delete(@RequestBody BoardComment boardComment) {
        //댓글 삭제
        Map<String, Object> res = boardCommentService.deleteComment(boardComment);

        return ResponseEntity.ok().body(res);
    }
}
