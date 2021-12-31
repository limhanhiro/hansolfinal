package kr.or.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.addition.model.dao.AdditionDao;
import kr.or.addition.model.vo.Board;
import kr.or.member.dao.MemberDao;
import kr.or.member.vo.DeleteMember;
import kr.or.member.vo.Member;
import kr.or.member.vo.MemberPage;

@Service
public class MemberService {

	@Autowired
	private MemberDao dao;
	@Autowired
	private AdditionDao additiondao;

	public Member selectOneMemberPw(Member member) {
//		if(member.getMemberId().isEmpty() || member.getMemberPw().isEmpty()) {//입력 받은 문자열의 길이가 0인 경우
//			throw new IllegalArgumentException("아이디또는 패스워드를 입력해야 합니다."); // 아이디 비밀번호가 비어있는 경우 예외를 발생
//		}
		Member m = dao.selectOneMember(member);
		return m;
	}

	@Transactional
	public int insertMemberPw(Member m) {

		int result = dao.insertMember(m);
		return result;
	}

	public Member selectOneMemberId(String memberId) {
		Member m = dao.selectOneMemberId(memberId);
		return m;
	}

	public Member selectOneMemberEmail(String memberEmail) {
		Member m = dao.selectOneMemberEmail(memberEmail);
		return m;
	}

	public Member selectOneMemberPw(String memberPassword) {
		Member m = dao.selectOneMemberPw(memberPassword);
		return m;
	}

	public int updateMember(Member member) {
		int result = dao.updateMember(member);
		return result;
	}

	public int updateMemberLevel(Member member) {
		int result = dao.updateMemberLevel(member);
		return result;
	}

	public int searchidPw(Member member) {
		int result = dao.searchidpw(member);
		return result;
	}

	public Member searchId(Member member) {
		Member m = dao.searchId(member);
		return m;
	}

	public MemberPage searchMember(String search, int[] memberLevel, int reqPage) {
		// 1.startend계산
		int numPerPage = 10;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		MemberPage paging = new MemberPage();
		paging.setStart(start);
		paging.setEnd(end);
		// 2.hashmap 생성
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("memberLevel", memberLevel);
		map.put("search", search);
		ArrayList<Member> list = dao.searchMember(map);
		int totalCount = dao.searchTotalCount(map);
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		// 페이지네비 태그 제작 시작
		String pageNavi = "<ul class='pagination'>";
		String level = "";
		if (memberLevel != null) {
			for (int f = 0; f < memberLevel.length; f++) {
				level += "&memberLevel=" + memberLevel[f];
			}	
		}
		// 이전버튼
		if (pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a href='/searchMember.do?" + "search=" + search + "&reqPage=" + (pageNo - 1);
			if(memberLevel != null) {
				pageNavi += level;
			}
			pageNavi += "'>";
			pageNavi += "&lt;</a></li>";
		}
		// 페이지숫자
		for (int i = 0; i < pageNaviSize; i++) {

			if (pageNo == reqPage) {
				pageNavi += "<li class='active'>";
				pageNavi += "<a href='/searchMember.do?" + "search=" + search + "&reqPage=" + pageNo;
				if(memberLevel != null) {
					pageNavi += level;
				}
				pageNavi += "'>";
				pageNavi += pageNo + "</a></li>";
			} else {
				pageNavi += "<li>";
				pageNavi += "<a href='/searchMember.do?" + "search=" + search + "&reqPage=" + pageNo;
				if(memberLevel != null) {
					pageNavi += level;
				}
				pageNavi += "'>";
				pageNavi += pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		// 다음버튼

		if (pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a href='/searchMember.do?" + "search=" + search + "&reqPage=" + pageNo;
			if(memberLevel != null) {
				pageNavi += level;
			}
			pageNavi += "'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		System.out.println(level);
		// 게시물목록(ArrayList), 페이지네비(String), start(번호 표시용)
		MemberPage mpg = new MemberPage();
		mpg.setList(list);
		mpg.setPageNavi(pageNavi);
		mpg.setStart(start);
		return mpg;
	}

	public MemberPage selectAllMember(int reqPage) {
		int numPerPage = 10;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		MemberPage paging = new MemberPage();
		paging.setStart(start);
		paging.setEnd(end);
		ArrayList<Member> list = dao.selectAllMember(paging);
		int totalCount = dao.selectTotalCount();
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		// 페이지네비 태그 제작 시작
		String pageNavi = "<ul class='pagination'>";
		// 이전버튼
		if (pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a href='/allMember.do?reqPage=" + (pageNo - 1) + "'>";
			pageNavi += "&lt;</a></li>";
		}
		// 페이지숫자
		for (int i = 0; i < pageNaviSize; i++) {
			if (pageNo == reqPage) {
				pageNavi += "<li class='active'>";
				pageNavi += "<a href='/allMember.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo + "</a></li>";
			} else {
				pageNavi += "<li>";
				pageNavi += "<a href='/allMember.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		// 다음버튼
		if (pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a href='/allMember.do?reqPage=" + pageNo + "'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";

		// 게시물목록(ArrayList), 페이지네비(String), start(번호 표시용)
		MemberPage mpg = new MemberPage();
		mpg.setList(list);
		mpg.setPageNavi(pageNavi);
		mpg.setStart(start);
		return mpg;
	}
	
	public ArrayList<DeleteMember> deleteMemberFrm(int memberNo) {
		ArrayList<DeleteMember> list = dao.deleteMemberList(memberNo);
		return list;
	}

	public int deleteMember(int memberNo) {
		int result = dao.deleteMember(memberNo);
		result += dao.deleteMember(memberNo);
		return result;
	}

	public int updatePasswordPw(Member m) {
		int result = dao.updatePassword(m);
		return result;
	}

	public ArrayList<Board> selectFixlist() {
		ArrayList<Board> fixlist = additiondao.selectFixlist();
		return fixlist;
	}
}
