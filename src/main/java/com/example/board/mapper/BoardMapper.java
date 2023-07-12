package com.example.board.mapper;

import com.example.board.domain.Board;
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
