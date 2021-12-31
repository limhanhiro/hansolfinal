package kr.or.requrit.dao;


import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.requrit.vo.Requrit;
import kr.or.requrit.vo.RequritPageData;
import kr.or.requrit.vo.RequritPagingVo;

@Repository
public class RequritDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int requritInsert(Requrit r) {
		int result = sqlSession.insert("requrit.requritInsert",r);
		return result;
	}

	public ArrayList<Requrit> selectRequritList(RequritPagingVo paging) {
		List<Requrit> list = sqlSession.selectList("requrit.selectRequritList",paging);
		return (ArrayList<Requrit>)list;
	}

	public int selectTotalCount() {
		int totalCount = sqlSession.selectOne("requrit.selectTotalCount");
		return totalCount;
	}

	public Requrit selectOneRequrit(int requritNo) {
		Requrit r = sqlSession.selectOne("requrit.selectOneRequrit",requritNo);
		return r;
	}

	public int deleteRequrit2(int requritNo) {
		int result = sqlSession.update("requrit.deleteRequrit2",requritNo);
		return result;
	}

	public int updateRequrit(Requrit r) {
		int result = sqlSession.update("requrit.updateRequrit",r);
		return result;
	}

	public int selectTotalCountDelete() {
		int totalCount = sqlSession.selectOne("requrit.selectTotalCountDelete");
		return totalCount;
	}

	public ArrayList<Requrit> selectRequritListDelete(RequritPagingVo paging) {
		List<Requrit> list = sqlSession.selectList("requrit.selectRequritListDelete",paging);
		return (ArrayList<Requrit>)list;
	}

	public int revivalRequrit(int requritNo) {
		int result = sqlSession.update("requrit.revivalRequrit",requritNo);
		return result;
	}

	public int deleteResume(int requritNo) {
		int result = sqlSession.delete("resume.deleteResume",requritNo);
		return result;
	}

	public int deleteResumeCount(int requritNo) {
		int result = sqlSession.selectOne("resume.deleteResumeCount",requritNo);
		return result;
	}
}
