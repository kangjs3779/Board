package com.example.shareMate.mapper;

import com.example.shareMate.domain.Member;
import org.apache.ibatis.annotations.*;

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

    @Select("""
            SELECT * FROM Member WHERE username = #{username}
            """)
    Member selectMemberByUsername(String username);

    @Update("""
            UPDATE Member 
            SET nickname = #{nickname},
                address = #{address},
                email = #{email}
            WHERE username = #{username}
            """)
    Integer modifyMemberByUsername(Member member);

    @Delete("""
            DELETE FROM Member WHERE username = #{username}
            """)
    Integer deleteMemberByUsername(Member member);
}
