package com.example.shareMate.mapper;

import com.example.shareMate.domain.ShareMate;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

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

    @Select("""
            SELECT * FROM ShareMate
            WHERE memberId = #{memberId} AND boardId = #{boardId}
            """)
    ShareMate checkMateByMemberIdAndBoardId(String memberId, Integer boardId);

    @Delete("""
            DELETE FROM ShareMate
            WHERE memberId = #{memberId} AND boardId = #{boardId}
            """)
    Integer cancleMate(ShareMate shareMate);

    @Update("""
            UPDATE ShareMate
            SET approve = #{approve}
            WHERE id = #{id}
            """)
    Integer approveMate(ShareMate shareMate);

    @Delete("""
            DELETE FROM ShareMate WHERE boardId = #{boardId}
            """)
    void deleteShareMate(Integer boardId);

    @Select("""
            SELECT * FROM ShareMate WHERE memberId = #{memberId}
            """)
    List<ShareMate> selectShareByMemberId(String memberId);
}
