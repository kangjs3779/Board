package com.example.board.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Board {
    private Integer id;
    private String title;
    private Date inserted;
    private String body;
    private String writer;
}
