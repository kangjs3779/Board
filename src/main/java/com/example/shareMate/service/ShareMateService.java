package com.example.shareMate.service;

import com.example.shareMate.domain.Ott;
import com.example.shareMate.domain.ShareMate;
import com.example.shareMate.mapper.OttMapper;
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
    @Autowired
    private OttMapper ottMapper;

    public Map<String, Object> addMate(ShareMate shareMate) {
        Map<String, Object> info = new HashMap<>();

        //해당 구독 서비스의 제한 인원 탐색
        Integer limitedAttendance = ottMapper.selectOttByOttId(shareMate.getOttId()).getLimitedAttendance();
        //현재 모집된 인원 탐색
        Integer currentMateCount = shareMateMapper.selectCountMate(shareMate.getBoardId());

        if (limitedAttendance > currentMateCount) {
            //해당 구독 서비스의 제한 인원보다 현재 모집된 인원이 적으면
            Integer count = shareMateMapper.addMate(shareMate);

            info.put("message", count == 1 ? "신청이 추가되었습니다." : "신청이 추가되지 않았습니다.");
        } else {
            //해당 구독 서비스의 인원이 모두 차면?
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

    public boolean approveMate(ShareMate shareMate) {
        Integer count = shareMateMapper.approveMate(shareMate);
        System.out.println("service : " + shareMate);

        return count == 1;
    }
}
