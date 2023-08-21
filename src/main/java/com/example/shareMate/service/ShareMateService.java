package com.example.shareMate.service;

import com.example.shareMate.domain.ShareMate;
import com.example.shareMate.mapper.ShareMateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class ShareMateService {
    @Autowired
    private ShareMateMapper shareMateMapper;

    public Map<String, Object> addMate(ShareMate shareMate) {
        Map<String, Object> info = new HashMap<>();

        Integer count = shareMateMapper.addMate(shareMate);

        if (count == 1) {
            info.put("message", "신청이 추가되었습니다.");
        } else {
            info.put("message", "신청이 추가되지 않았습니다.");
        }

        return info;
    }

    public Map<String, Object> checkShareMate(Integer boardId) {
        Map<String, Object> info = new HashMap<>();

        //메이트 정보 찾기
        List<ShareMate> mates = shareMateMapper.checkShareMate(boardId);

        //메이트 수 조회
        Integer countMate = shareMateMapper.selectCountMate(boardId);

        info.put("mates", mates);
        info.put("countMate", countMate);

        return info;
    }

    public Map<String, Object> cancleMate(ShareMate shareMate) {
        Map<String, Object> info = new HashMap<>();

        Integer count = shareMateMapper.cancleMate(shareMate);

        if (count == 1) {
            info.put("message", "신청이 취소되었습니다.");
        } else {
            info.put("message", "신청이 취소되지 않았습니다.");
        }

        return info;
    }
}
