package com.example.shareMate.mapper;

import com.example.shareMate.domain.BoardComment;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BoardCommentMapper {
    @Select("""
            SELECT * FROM BoardComment WHERE boardId = #{boardId}
            """)
    List<BoardComment> selectAllComment(Integer boardId);

    @Insert("""
            INSERT INTO BoardComment 
                (nickname, boardId, body)
            VALUES
                (#{nickname}, #{boardId}, #{body})
            """)
    Integer add(BoardComment boardComment);
}
