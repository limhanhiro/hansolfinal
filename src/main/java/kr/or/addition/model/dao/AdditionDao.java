package kr.or.addition.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.addition.model.vo.Board;
import kr.or.addition.model.vo.BoardComment;
import kr.or.addition.model.vo.BoardNext;
import kr.or.addition.model.vo.LikeNo;

@Repository
public class AdditionDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Board> selectNoticeList(HashMap<String, Object> map) {
		List<Board> list = sqlSession.selectList("addition.noticeList",map);
		return (ArrayList<Board>)list;
	}

	public int totalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("addition.totalCount",map);
	}

	public int insertBoard(Board b) {
		return sqlSession.insert("addition.insertBoard",b);
	}

	public int selectBoardNo() {
		return sqlSession.selectOne("addition.getBoardNo");
	}

	public Board selectOneBoard(int boardNo) {
		return sqlSession.selectOne("addition.selectOneBoard",boardNo);
	}

	public int boardDelete(int boardNo) {
		return sqlSession.delete("addition.boardDelete",boardNo);
	}

	public int updateReadCount(int boardNo) {
		return sqlSession.update("addition.updateReadCount",boardNo);
	}

	public ArrayList<BoardComment> selectCommentList(int boardNo) {
		List<BoardComment> list= sqlSession.selectList("addition.selectCommentList",boardNo);
		return (ArrayList<BoardComment>)list;
	}

	public int insertComment(BoardComment bc) {
		return sqlSession.insert("addition.insertComment",bc);
	}

	public int deleteComment(int bcNo) {
		return sqlSession.delete("addition.deleteComment",bcNo);
	}

	public int updateComment(HashMap<String, Object> map) {
		return sqlSession.update("addition.updateComment",map);
	}

	public int selectNewCount(int boardType) {
		return sqlSession.selectOne("addition.selectNewCount",boardType);
	}

	public ArrayList<Board> searchKeyword(HashMap<String, Object> map) {
		List<Board> list = sqlSession.selectList("addition.searchKeyword",map);
		return (ArrayList<Board>)list;
	}
	
	public int totalKCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("addition.totalKCount",map);
	}

	public int boardUpdate(HashMap<String, Object> map) {
		return sqlSession.update("addition.boardUpdate",map);
	}

	public BoardNext selectNextBoard(HashMap<String, Object> map) {
		return sqlSession.selectOne("addition.selectNextBoard",map);
	}

	public int fixCount() {
		return sqlSession.selectOne("addition.fixCount");
	}

	public ArrayList<Board> selectFixlist() {
		List<Board> fixlist = sqlSession.selectList("addition.selectFixlist");
		return (ArrayList<Board>)fixlist;
	}

	public int regulationBoard(int boardNo) {
		return sqlSession.update("addition.regulationBoard",boardNo);
	}
	
	public int removeRegulationBoard(int boardNo) {
		return sqlSession.update("addition.removeRegulationBoard",boardNo);
	}

	public int boardLike(HashMap<String, Object> map) {
		return sqlSession.update("addition.boardLike",map);
	}

	public int boardDislike(HashMap<String, Object> map) {
		return sqlSession.delete("addition.boardDislike",map);
	}

	public LikeNo selectLikeSum(int boardNo) {
		return sqlSession.selectOne("addition.selectLikeSum",boardNo);
	}

	public LikeNo selectLikeChk(HashMap<String, Object> map) {
		return sqlSession.selectOne("addition.selectLikeChk",map);
	}

	public ArrayList<Board> myList(HashMap<String, Object> map) {
		List<Board> list = sqlSession.selectList("addition.myList",map);
		return (ArrayList<Board>)list;
	}

	public ArrayList<BoardComment> myCommentList(String memberId) {
		List<BoardComment> bcList = sqlSession.selectList("addition.myCommentList",memberId);
		return (ArrayList<BoardComment>)bcList;
	}

	public ArrayList<BoardComment> chkReComment(int bcNo) {
		List<BoardComment> list = sqlSession.selectList("addition.chkReComment",bcNo);
		return (ArrayList<BoardComment>)list;
	}

	public BoardComment chkDelComment(int bcRef) {
		return sqlSession.selectOne("addition.chkDelComment",bcRef);
	}

	public int totalEventCount() {
		return sqlSession.selectOne("addition.totalEventCount");
	}

	public ArrayList<Board> eventMore(HashMap<String, Object> map) {
		List<Board> list = sqlSession.selectList("addition.eventMore",map);
		return (ArrayList<Board>)list;
	}

}
