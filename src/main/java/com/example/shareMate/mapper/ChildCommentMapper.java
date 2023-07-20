package com.example.shareMate.mapper;

import com.example.shareMate.domain.ChildComment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ChildCommentMapper {
    @Select("""
            SELECT * FROM ChildComment WHERE commentId = #{commentId} ORDER BY inserted DESC
            """)
    List<ChildComment> selectAllChildComment(Integer commentId);

    @Insert("""
            INSERT INTO ChildComment
                (body, commentId, memberId, nickname)
            VALUES
                (#{body}, #{commentId}, #{memberId}, #{nickname})
            """)
    Integer add(ChildComment childComment);

    @Delete("""
            DELETE FROM ChildComment WHERE id = #{id}
            """)
    Integer delete(ChildComment childComment);

    @Select("""
            SELECT * FROM ChildComment WHERE id = #{childCommentId}
            """)
    ChildComment selectChildCommentByChildId(Integer childCommentId);

    @Update("""
            UPDATE ChildComment
            SET body = #{body}
            WHERE id = #{id}
            """)
    Integer modify(ChildComment childComment);
}
