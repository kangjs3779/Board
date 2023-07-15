package com.example.board.domain;

import lombok.Data;

@Data
public class Member {
    private String id;
    private String password;
    private String idNumber;
    private String nickname;
    private String address;
    private String email;
}
