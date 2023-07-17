package com.example.shareMate.mapper;

import com.example.shareMate.domain.Board;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BoardMapper {
    @Select("""
            SELECT * FROM Board
            """)
    List<Board> selectBoardList();
}
