package com.example.shareMate.controller;

import com.example.shareMate.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping("list")
    public void board(Model model) {
        //shareroom 전체 게시글 조회
        Map<String, Object> info = boardService.selectBoard();

        model.addAllAttributes(info);
    }

    @GetMapping("detail")
    public void boardDetail(
            @RequestParam("boardId") Integer boardId,
            Model model) {
        Map<String, Object> info = boardService.selectBoardByDetailId(boardId);

        model.addAllAttributes(info);
    }
}
