package com.example.shareMate.domain;

import lombok.Data;

@Data
public class ShareMate {
    //share mate 정보
    private Integer id;
    private String memberId;
    private Integer boardId;
    private Integer ottId;
    private String nickname;
    private Integer approve;

    //ott 정보
    private String ott;
    private Integer limitedAttendance;
    private Integer cost;
    private String costPerPerson;
    private String color;

    //member 정보
    private String name;
    private String email;
}
