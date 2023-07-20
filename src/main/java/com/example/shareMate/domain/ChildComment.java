package com.example.shareMate.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ChildComment {
    private Integer id;
    private String body;
    private Integer commentId;
    private String memberId;
    private String nickname;
    private LocalDateTime inserted;
    private boolean editable;
}
