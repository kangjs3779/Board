package com.example.shareMate.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Board {
    private Integer id;
    private String title;
    private Date inserted;
    private String body;
    private String writer;
    private String memberId;
    private Integer viewCount;
    private Integer commentCount;
}
