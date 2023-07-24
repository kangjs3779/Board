package com.example.shareMate.domain;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Member {
    private String username;
    private String password;
    private String idNumber;
    private String nickname;
    private String address;
    private String email;
    private String authority;

}
