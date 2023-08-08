package com.example.shareMate.service;

import com.example.shareMate.domain.Like;
import com.example.shareMate.mapper.LikeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.s3.endpoints.internal.Value;

import java.util.HashMap;
import java.util.Map;

@Service
public class LikeBoardService {
    @Autowired
    private LikeBoardMapper likeBoardMapper;

    public Map<String, Object> addLike(Like like) {
        Map<String, Object> addLike = new HashMap<>();

        Integer count = likeBoardMapper.addLike(like);

        if(count == 1) {
            addLike.put("message", "해당 개시글을 좋아합니다.");
        } else {
            addLike.put("message", "좋아요 추가가 되지 않았습니다.");
        }

        return addLike;
    }

    public Map<String, Object> deleteLike(Like like) {
        Map<String, Object> deleteLike = new HashMap<>();

        Integer count = likeBoardMapper.deleteLike(like);

        if(count == 1) {
            deleteLike.put("message", "해당 개시글 좋아요를 취소했습니다.");
        } else {
            deleteLike.put("message", "좋아요 취소가 되지 않았습니다.");
        }

        return deleteLike;
    }

    public Like likeCount(Integer boardId) {
        Like like = likeBoardMapper.likeCount(boardId);

        return like;
    }
}
