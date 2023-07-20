package com.example.shareMate.service;

import com.example.shareMate.domain.ChildComment;
import com.example.shareMate.mapper.ChildCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChildCommentService {
    @Autowired
    private ChildCommentMapper childCommentMapper;

    public List<ChildComment> selectAllChildComment(Integer commentId) {
        List<ChildComment> comments = childCommentMapper.selectAllChildComment(commentId);
        return comments;
    }
}
