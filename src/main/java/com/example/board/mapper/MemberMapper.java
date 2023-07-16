package com.example.board.mapper;

import com.example.board.domain.Member;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface MemberMapper {

    @Insert("""
            INSERT INTO Member (username, password, nickname, idNumber, address, email)
            VALUES (#{username}, #{password}, #{nickname}, #{idNumber}, #{address}, #{email})
            """)
    Integer addMember(Member member);

    @Select("""
            SELECT * FROM Member WHERE username = #{username}
            """)
    Member selectByUsername(String username);
}
