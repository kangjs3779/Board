package com.example.shareMate.service;

import com.example.shareMate.domain.Ott;
import com.example.shareMate.mapper.OttMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OttService {
    @Autowired
    private OttMapper ottMapper;
    public List<Ott> selectOtt() {
        //ott서비스 모두 조회
       List<Ott> otts = ottMapper.selectOtt();

       return otts;
    }
}
