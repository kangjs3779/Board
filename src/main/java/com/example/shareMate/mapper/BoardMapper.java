package com.example.shareMate.mapper;

import com.example.shareMate.domain.Board;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BoardMapper {
    @Select("""
            SELECT * FROM Board 
            ORDER BY inserted DESC
            """)
    List<Board> selectBoardList();

    @Select("""
            SELECT * FROM Board WHERE id = #{boardId}
            """)
    Board selectBoardByBoardId(Integer boardId);

    @Insert("""
            INSERT INTO Board 
                (title, body, writer, memberId, roll, ottId, startDate, endDate, ottMemberId, ottMemberPw) 
            VALUES 
                (#{title}, #{body}, #{writer}, #{memberId}, #{roll}, #{ottId}, #{startDate}, #{endDate}, #{ottMemberId}, #{ottMemberPw})
            """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    Integer addBoard(Board board);

    @Delete("""
            DELETE FROM Board WHERE id = #{boardId}
            """)
    Integer deleteBoardByBoardId(Integer boardId);

    @Update("""
            UPDATE Board
            SET title = #{title}, body = #{body}, ottId = #{ottId}, startDate = #{startDate}, endDate = #{endDate}
            WHERE id = #{id}
            """)
    Integer modifyBoardByBoardId(Board board);

    @Select("""
            SELECT * FROM Board WHERE memberId = #{memberId}
            """)
    List<Board> selectBoardByMemberId(String memberId);

    @Delete("""
            DELETE FROM Board WHERE memberId = #{memberId}
            """)
    void deleteBoardBymemberId(String memberId);

    @Update("""
            UPDATE Board SET viewCount = viewCount + 1 WHERE id = #{boardId}
            """)
    void addViewCount(Integer boardId);

    @Select("""
            <script>
            SELECT * FROM Board
            <trim prefix="WHERE" prefixOverrides="AND |OR ">
                <if test="ottId != 0">
                    ottId = #{ottId}
                </if>
                <if test="(!memberId.isEmpty() and memberId != null) and (page == 'myboard')">
                   AND memberId = #{memberId}
                </if>
            </trim>
            ORDER BY inserted DESC
            </script>
            """)
    List<Board> selectBoardByOtt(Integer ottId, String memberId, String page);

    @Select("""
            SELECT * FROM Board WHERE memberId = #{memberId} AND roll = 1;
            """)
    List<Board> selectBoardByMemberIdAndRoll(String memberId);
}
