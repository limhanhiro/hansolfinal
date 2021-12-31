package kr.or.member.dao;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import kr.or.member.vo.DeleteMember;
import kr.or.member.vo.Member;
import kr.or.member.vo.MemberPage;


@Repository
public class MemberDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public Member selectOneMember(Member member) {
		Member m = sqlSession.selectOne("member.selectOneMember",member);
		if(m == null) {
			return null;
		}else {
			return m;
		}
	}
	public int insertMember(Member m) {
		int result = sqlSession.insert("member.insertMember",m);
		return result;
	}
	public Member selectOneMemberId(String memberId) {
		Member m = sqlSession.selectOne("member.selectOneId",memberId);
		if(m == null) {
			return null;
		}else {
			return m;
		}
	}
	public Member selectOneMemberEmail(String memberEmail) {
		Member m = sqlSession.selectOne("member.selectOneEmail",memberEmail);
		if(m == null) {
			return null;
		}else {
			return m;
		}
	}
	public Member selectOneMemberPw(String memberPassword) {
		Member m = sqlSession.selectOne("member.selectOnePw",memberPassword);
		if(m == null) {
			return null;
		}else {
			return m;
		}
	}
	public int updateMember(Member member) {
		int result = sqlSession.update("member.updateMember",member);
		return result;
	}
	public int searchidpw(Member member) {
		int result = sqlSession.update("member.searchidpw",member);
		return result;
	}
	
	public int updateMemberLevel(Member member) {
		int result = sqlSession.update("member.updateMemberLevel",member);
		return result;
	}
	public Member searchId(Member member) {
		Member m = sqlSession.selectOne("member.searchId",member);
		if(m == null) {
			return null;
		}else {
			return m;
		}
	}
	public ArrayList<Member> searchMember(HashMap<String,Object> map) {
		List<Member> list = sqlSession.selectList("member.searchMember",map);
		return (ArrayList<Member>)list;
	}
	public int totalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("addition.totalCount",map);
	}
	public int selectTotalCount() {
		int totalCount = sqlSession.selectOne("member.selectTotalCount");
		return totalCount;
	}
	public ArrayList<Member> selectAllMember(MemberPage paging) {
		List<Member> list = sqlSession.selectList("member.selectAllMember",paging);
		return (ArrayList<Member>)list;
	}
	public int searchTotalCount(HashMap<String, Object> map) {
		int totalCount = sqlSession.selectOne("member.searchTotalCount",map);
		return totalCount;
	}
	public ArrayList<DeleteMember> deleteMemberList(int memberNo) {
		List<DeleteMember> list = sqlSession.selectList("member.selectDeleteMember",memberNo);

		return (ArrayList<DeleteMember>)list;
	}
	public int deleteMember(int memberNo) {
		return sqlSession.delete("deleteMember", memberNo);
	}
	public int updatePassword(Member m) {
		int result = sqlSession.update("member.updatePassword",m);
		return result;
	}
}

