package com.example.shareMate.mapper;

import com.example.shareMate.domain.Like;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface LikeBoardMapper {

    @Insert("""
            INSERT INTO LikeBoard
                (boardId, memberId)
            VALUES
                (#{boardId}, #{memberId})
            """)
    Integer addLike(Like like);

    @Delete("""
            DELETE FROM LikeBoard 
            WHERE boardId = #{boardId} AND memberId = #{memberId}
            """)
    Integer deleteLike(Like like);

    @Select("""
            SELECT COUNT(*) likeCount FROM LikeBoard WHERE boardId = #{boardId}
            """)
    Like likeCount(Integer boardId);

    @Select("""
            SELECT * FROM LikeBoard WHERE memberId = #{memberId} AND boardId = #{boardId}
            """)
    Like checkLikeByUsernameAndBoardId(String memberId, Integer boardId);
}
