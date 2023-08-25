package com.example.shareMate.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Payment {
    private Integer id;
    private String orderNumber;
    private Integer paidAmount;
    private String status;
    private String memberId;
    private Integer ottId;
    private Integer shareMateId;
    private Date inserted;

}
