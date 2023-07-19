package com.example.shareMate.mapper;

import com.example.shareMate.domain.BoardComment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BoardCommentMapper {
    @Select("""
            SELECT * FROM BoardComment WHERE boardId = #{boardId}
            """)
    List<BoardComment> selectAllComment(Integer boardId);

    @Insert("""
            INSERT INTO BoardComment 
                (nickname, boardId, body, memberId)
            VALUES
                (#{nickname}, #{boardId}, #{body}, #{memberId})
            """)
    Integer add(BoardComment boardComment);

    @Select("""
            SELECT * FROM BoardComment WHERE id = #{commentId}
            """)
    BoardComment selectCommentByCommentId(Integer commentId);

    @Update("""
            UPDATE BoardComment
            SET body = #{body}
            WHERE id = #{id}
            """)
    Integer modifyComment(BoardComment boardComment);

    @Delete("""
            DELETE FROM BoardComment WHERE id = #{id}
            """)
    Integer deleteComment(BoardComment boardComment);
}
