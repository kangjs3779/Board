package com.example.shareMate.controller;

import com.example.shareMate.domain.ChildComment;
import com.example.shareMate.service.ChildCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("childComment")
@ResponseBody
public class ChildCommentController {
    @Autowired
    private ChildCommentService childCommentService;

    @GetMapping("list")
    public List<ChildComment> list(@RequestParam("commentId") Integer commentId, Authentication authentication) {
        List<ChildComment> comments = childCommentService.selectAllChildComment(commentId, authentication);
        System.out.println(comments);
        return comments;
    }

    @PostMapping("add")
    public ResponseEntity<Map<String, Object>> add(@RequestBody ChildComment childComment) {
        Map<String, Object> res = childCommentService.add(childComment);

        return ResponseEntity.ok().body(res);
    }

    @DeleteMapping("delete")
    public ResponseEntity<Map<String, Object>> delete(@RequestBody ChildComment childComment) {
        Map<String, Object> res = childCommentService.delete(childComment);

        return ResponseEntity.ok().body(res);
    }

    @GetMapping("get")
    public ChildComment get(@RequestParam("childCommentId") Integer childCommentId) {
        ChildComment childComment = childCommentService.selectChildCommentByChildId(childCommentId);
        return childComment;
    }

    @PatchMapping("modify")
    public ResponseEntity<Map<String, Object>> modify(@RequestBody ChildComment childComment) {
        Map<String, Object> res = childCommentService.modify(childComment);

        return ResponseEntity.ok().body(res);
    }
}
