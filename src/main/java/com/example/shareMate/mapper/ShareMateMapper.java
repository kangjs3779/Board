package com.example.shareMate.mapper;

import com.example.shareMate.domain.ShareMate;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ShareMateMapper {
    @Insert("""
            INSERT INTO ShareMate
                (memberId, boardId, ottId)
            VALUES
                (#{memberId}, #{boardId}, #{ottId})
            """)
    Integer addMate(ShareMate shareMate);

    @Select("""
            SELECT * FROM ShareMate 
            WHERE boardId = #{boardId}
            """)
    List<ShareMate> checkShareMate(Integer boardId);

    @Select("""
            SELECT COUNT(*) FROM ShareMate
            WHERE boardId = #{boardId}
            """)
    Integer selectCountMate(Integer boardId);
}
