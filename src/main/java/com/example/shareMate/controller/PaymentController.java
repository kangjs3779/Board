package com.example.shareMate.controller;

import com.example.shareMate.domain.Payment;
import com.example.shareMate.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@ResponseBody
@RequestMapping("payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @PutMapping("addPay")
    public ResponseEntity<Map<String, Object>> addPay(@RequestBody Payment payment) {
        System.out.println(payment);
        Map<String, Object> res = paymentService.addPay(payment);

        return ResponseEntity.ok().body(res);

    }
}
