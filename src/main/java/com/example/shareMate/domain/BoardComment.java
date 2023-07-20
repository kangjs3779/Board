package com.example.shareMate.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BoardComment {

    private Integer id;
    private Integer boardId;
    private String nickname;
    private String body;
    private LocalDateTime inserted;
    private boolean editable;
    private String memberId;
    private boolean repliable;
}
