package com.example.shareMate.mapper;

import com.example.shareMate.domain.Ott;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface OttMapper {

    @Select("""
            SELECT * FROM Ott
            """)
    List<Ott> selectOtt();
}
