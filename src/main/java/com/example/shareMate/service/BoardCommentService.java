package com.example.shareMate.service;

import com.example.shareMate.domain.BoardComment;
import com.example.shareMate.mapper.BoardCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardCommentService {
    @Autowired
    private BoardCommentMapper boardCommentMapper;

    public List<BoardComment> selectAllComment(Integer boardId) {

        //댓글 전체 조회
        List<BoardComment> comments = boardCommentMapper.selectAllComment(boardId);

        return comments;
    }

    public Map<String, Object> add(BoardComment boardComment) {
        Map<String, Object> res = new HashMap<String, Object>();

        Integer count = boardCommentMapper.add(boardComment);

        if (count == 1) {
            res.put("message", "댓글이 등록되었습니다.");
        } else {
            res.put("message", "댓글이 등록되지 않았습니다.");
        }

        return res;
    }
}
