package com.example.shareMate.service;

import com.example.shareMate.domain.Payment;
import com.example.shareMate.mapper.PaymentMapper;
import com.example.shareMate.mapper.ShareMateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class PaymentService {
    @Autowired
    private PaymentMapper paymentMapper;
    @Autowired
    private ShareMateMapper shareMateMapper;

    public Map<String, Object> addPay(Payment payment) {
        Map<String, Object> res = new HashMap<>();

        Integer count = paymentMapper.addPay(payment);

        //결제 단계 수정
        if (payment.getStatus().equals("paid")) {
            //결제 단계를 3으로 수정
            shareMateMapper.updateApprove(payment.getShareMateId());
        }

        if (count == 1) {
            res.put("message", "결제가 완료되었습니다.");
        } else {
            res.put("message", "결제가 실패하였습니다.");
        }

        return res;
    }
}
