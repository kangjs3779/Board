package com.example.shareMate.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;


@Data
public class Member {
    private String username;
    private String password;
    private String phoneNum;
    private String nickname;
    private String address;
    private String email;
    private Date inserted;
    private List<String> authority;
    private String name;

}
