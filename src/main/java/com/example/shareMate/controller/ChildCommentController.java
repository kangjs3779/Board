package com.example.shareMate.controller;

import com.example.shareMate.domain.ChildComment;
import com.example.shareMate.service.ChildCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("childComment")
@ResponseBody
public class ChildCommentController {
    @Autowired
    private ChildCommentService childCommentService;

    @GetMapping("list")
    public List<ChildComment> list(@RequestParam("commentId") Integer commentId) {
        List<ChildComment> comments = childCommentService.selectAllChildComment(commentId);
        return comments;
    }
}
