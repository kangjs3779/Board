package com.example.shareMate.service;

import com.example.shareMate.domain.Board;
import com.example.shareMate.domain.BoardComment;
import com.example.shareMate.domain.Like;
import com.example.shareMate.domain.Member;
import com.example.shareMate.mapper.BoardCommentMapper;
import com.example.shareMate.mapper.BoardMapper;
import com.example.shareMate.mapper.LikeBoardMapper;
import com.example.shareMate.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseStatus;

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
    @Autowired
    private LikeBoardMapper likeBoardMapper;

    public Map<String, Object> selectAllBoard(Authentication authentication) {
        Map<String, Object> info = new HashMap<>();

        //게시물 전체 조회
        List<Board> list = boardMapper.selectBoardList();

        for (Board board : list) {
            //댓글 갯수
            Integer commentCount = boardCommentMapper.selectCommentByBoarId(board.getId());
            board.setCommentCount(commentCount);

            //좋아요 갯수
            Integer likeCount = likeBoardMapper.selectLikeCountByBoardId(board.getId());
            board.setLikeCount(likeCount);

            //좋아요 확인
            Like like = likeBoardMapper.checkLikeByUsernameAndBoardId(authentication.getName(), board.getId());
            if(like != null) {
                //좋아요를 누른 게시글이면
                board.setLikeCheck(true);
            }
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

        //ott서비스 이름 치환
        switch (board.getOtt()) {
            case "netflix" :
                board.setOtt("넷플릭스");
                break;
            case "disney" :
                board.setOtt("디즈니플러스");
                break;
            case "tiving" :
                board.setOtt("티빙");
                break;
            case "wavve" :
                board.setOtt("웨이브");
                break;
            case "watcha" :
                board.setOtt("왓챠");
                break;
            case "apple" :
                board.setOtt("애플TV");
                break;
            case "laftel" :
                board.setOtt("라프텔");
                break;
            case "prime" :
                board.setOtt("프라임 비디오");
                break;

        }

        //map에 저장
        info.put("board", board);

        return info;
    }

    public boolean addBoard(Board board) {
        //게시글 추가
        Integer count;
        System.out.println(board);
        count = boardMapper.addBoard(board);

        return count == 1;
    }

    public boolean deleteBoard(Integer boardId, Member member) {
        //게시글 삭제를 위한 메소드
        Integer count = 0;
        Member origin = memberMapper.selectMemberByUsername(member.getUsername());

        //비밀번호 확인
        if (passwordEncoder.matches(member.getPassword(), origin.getPassword())) {
            //댓글이 있는지 확인
            List<BoardComment> comments = boardCommentMapper.selectAllComment(boardId);

            if (comments.size() != 0) {
                //댓글이 있으면 삭제
                for (BoardComment comment : comments) {
                    boardCommentService.deleteComment(comment);
                }
            }

            //좋아요 있는지 확인
            Integer like = likeBoardMapper.selectLikeCountByBoardId(boardId);

            if(like != 0 ) {
                //좋아요가 있으면
                likeBoardMapper.deleteLikeByBoardId(boardId);
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

    public List<Board> ottSearch(String ott, Authentication authentication) {
        //ott서비스 검색을 포함한 게시물 전체 조회
        List<Board> list =  boardMapper.selectBoardByOtt(ott);

        for (Board board : list) {
            //댓글 갯수
            Integer commentCount = boardCommentMapper.selectCommentByBoarId(board.getId());
            board.setCommentCount(commentCount);

            //좋아요 갯수
            Integer likeCount = likeBoardMapper.selectLikeCountByBoardId(board.getId());
            board.setLikeCount(likeCount);

            //좋아요 확인
            Like like = likeBoardMapper.checkLikeByUsernameAndBoardId(authentication.getName(), board.getId());
            if(like != null) {
                //좋아요를 누른 게시글이면
                board.setLikeCheck(true);
            }
        }

        return list;
    }
}
