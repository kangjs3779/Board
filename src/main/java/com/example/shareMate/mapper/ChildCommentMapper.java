package com.example.shareMate.mapper;

import com.example.shareMate.domain.ChildComment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ChildCommentMapper {
    @Select("""
            SELECT * FROM ChildComment WHERE commentId = #{commentId}
            """)
    List<ChildComment> selectAllChildComment(Integer commentId);
}
