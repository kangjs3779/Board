package com.example.shareMate.mapper;

import com.example.shareMate.domain.Payment;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface PaymentMapper {
    @Insert("""
            INSERT INTO Payment
                (orderNumber, paidAmount, status, memberId, ottId, shareMateId)
            VALUES
                (#{orderNumber}, #{paidAmount}, #{status}, #{memberId}, #{ottId}, #{shareMateId})
            """)
    Integer addPay(Payment payment);

    @Select("""
            SELECT * FROM Payment WHERE shareMateId = #{shareMateId}
            """)
    Payment selectPaymentByShareId(Integer shareMateId);
}
