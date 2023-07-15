package com.example.board.mapper;

import com.example.board.domain.Member;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

    @Insert("""
            INSERT INTO Member (id, password, nickname, idNumber, address, email)
            VALUES (#{id}, #{password}, #{nickname}, #{idNumber}, #{address}, #{email})
            """)
    Integer addMember(Member member);
}
