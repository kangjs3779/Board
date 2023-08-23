package com.example.shareMate.domain;

import lombok.Data;

import java.time.LocalDate;
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
    private Integer roll;
    private Integer likeCount;
    private boolean likeCheck;
    private boolean mateCheck;
    private Integer mateCount;
    private Integer ottId;
    private LocalDate startDate;
    private LocalDate endDate;
    private boolean complete;
    private String ottMemberId;
    private String ottMemberPw;
}
