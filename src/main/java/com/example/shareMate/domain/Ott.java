package com.example.shareMate.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Ott {
    private Integer id;
    private String ott;
    private Integer limitedAttendance;
    private Integer cost;
    private String color;
    private String costPerPerson;
    private String logo;
    private String saveMoney;
    private Integer boardId;
    private Integer approve;
    private Integer shareMateId;
    private Date paymentDate;
}
