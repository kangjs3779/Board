package com.example.board.service;

import com.example.board.domain.Board;
import com.example.board.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;

    public Map<String, Object> selectBoard() {
        Map<String, Object> info = new HashMap<>();

        //게시물 조회
        List<Board> list = boardMapper.selectBoardList();

        //map에 저장
        info.put("list", list);

        return info;
    }
}
