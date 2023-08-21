package com.example.shareMate.controller;

import com.example.shareMate.domain.ShareMate;
import com.example.shareMate.service.ShareMateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("shareMate")
@ResponseBody
public class ShareMateController {

    @Autowired
    private ShareMateService shareMateService;

    @GetMapping("checkShareMate")
    public Map<String, Object> checkShareMate(@RequestParam("boardId") Integer boardId) {
        Map<String, Object> info = shareMateService.checkShareMate(boardId);

        return info;
    }

    @PutMapping("addMate")
    public void addMate(@RequestBody ShareMate shareMate) {
        boolean ok = shareMateService.addMate(shareMate);
    }
}
