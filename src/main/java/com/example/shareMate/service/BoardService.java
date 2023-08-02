package com.example.shareMate.service;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.BoardComment;
import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.BoardCommentMapper;
import com.example.shareMate.mapper.BoardMapper;
import com.example.shareMate.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;
    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private BoardCommentMapper boardCommentMapper;
    @Autowired
    private BoardCommentService boardCommentService;

    public Map<String, Object> selectAllBoard() {
        Map<String, Object> info = new HashMap<>();

        //게시물 전체 조회
        List<Board> list = boardMapper.selectBoardList();

        //댓글 갯수
        for (Board board : list) {
            Integer commentCount = boardCommentMapper.selectCommentByBoarId(board.getId());
            board.setCommentCount(commentCount);
        }

        //map에 저장
        info.put("list", list);

        return info;
    }

    public Map<String, Object> selectBoardByDetailId(Integer boardId) {
        Map<String, Object> info = new HashMap<>();

        // 조회수 업데이트
        boardMapper.addViewCount(boardId);
        
        //상세 페이지 조회
        Board board = boardMapper.selectBoardByBoardId(boardId);


        //map에 저장
        info.put("board", board);

        return info;
    }

    public boolean addBoard(Board board) {
        //게시글 추가
        Integer count;

        count = boardMapper.addBoard(board);

        return count == 1;
    }

    public boolean deleteBoard(Integer boardId, Member member) {
        //게시글 삭제를 위한 메소드
        Integer count = 0;
        Member origin = memberMapper.selectMemberByUsername(member.getUsername());

        //비밀번호 확인
        if(passwordEncoder.matches(member.getPassword(), origin.getPassword())) {
            //댓글이 있는지 확인
            List<BoardComment> comments = boardCommentMapper.selectAllComment(boardId);

            if(comments.size() != 0) {
                //댓글이 있으면 삭제
                for(BoardComment comment : comments) {
                    boardCommentService.deleteComment(comment);
                }
            }
            //게시글 삭제
            count = boardMapper.deleteBoardByBoardId(boardId);
        }
        return count == 1;
    }

    public boolean modifyBoardByBoardId(Board board) {
        //게시글 수정
        Integer count = 0;

        count = boardMapper.modifyBoardByBoardId(board);

        return count == 1;
    }
}
