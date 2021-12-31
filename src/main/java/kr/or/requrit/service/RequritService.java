package kr.or.requrit.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.requrit.dao.RequritDao;
import kr.or.requrit.vo.Requrit;
import kr.or.requrit.vo.RequritPageData;
import kr.or.requrit.vo.RequritPagingVo;


@Service
public class RequritService {
	@Autowired
	private RequritDao dao;

	public int requritInsert(Requrit r) {
		int result = dao.requritInsert(r);
		return result;
	}

	/*public ArrayList<Requrit> selectRequritList() {
		ArrayList<Requrit> list = dao.selectRequritList();
		return null;
	}*/

	public RequritPageData selectRequritPageData(int reqPage) {
		int numPerPage = 10;
		int end = reqPage*numPerPage;
		int start = end - numPerPage +1;
		RequritPagingVo paging = new RequritPagingVo();
		paging.setStart(start);
		paging.setEnd(end);
		ArrayList<Requrit> list = dao.selectRequritList(paging);
		for(Requrit r : list) {
			LocalDate now = LocalDate.now();
			String endDate = r.getRequritEnd();
			LocalDate date = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE);
			long period = ChronoUnit.DAYS.between(now, date);
			r.setPeriod(period);
		}
		int totalCount = dao.selectTotalCount();
		int totalPage = 0;
		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		} else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		//페이지네비 태그 제작 시작
		String pageNavi = "<ul class='pagination'>";
		//이전버튼
		if(pageNo != 1) {
			pageNavi += "<li id='pageNum' class ='page-item'>";
			pageNavi += "<a class='page-link' href='/requritList.do?reqPage="+(pageNo-1)+"'>";
			pageNavi += "&lt;</a></li>";
		}
		//페이지숫자
		for(int i=0; i<pageNaviSize; i++) {
			if(pageNo == reqPage) {
				pageNavi += "<li id='pageNumAct' class ='page-item active'>";
				pageNavi += "<a class='page-link' href='/requritList.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}else {
				pageNavi += "<li id='pageNum' class ='page-item'>";
				pageNavi += "<a class='page-link' href='/requritList.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		//다음버튼
		if(pageNo <= totalPage) {
			pageNavi += "<li id='pageNum' class ='page-item'>";
			pageNavi += "<a class='page-link' href='/requritList.do?reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		
		//게시물목록(ArrayList), 페이지네비(String), start(번호 표시용)
		RequritPageData rpd = new RequritPageData();
		rpd.setList(list);
		rpd.setPageNavi(pageNavi);
		rpd.setStart(start);
		return rpd;
	}

	public Requrit selectOneRequrit(int requritNo) {
		Requrit r = dao.selectOneRequrit(requritNo);
		LocalDate now = LocalDate.now();
		String endDate = r.getRequritEnd();
		LocalDate date = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE);
		long period = ChronoUnit.DAYS.between(now, date);
		r.setPeriod(period);
		return r;
	}
	@Transactional
	public int deleteRequrit2(int requritNo) {
		int result = dao.deleteRequrit2(requritNo);
		if(result > 0) {
			result = dao.deleteResumeCount(requritNo);
			if(result == 0) {
				return 1;
			}else {
			result = dao.deleteResume(requritNo);
			return result;
			}
		}else{
			return result;
		}
	}

	public Requrit updateRequritFrm(int requritNo) {
		Requrit r = dao.selectOneRequrit(requritNo);
		return r;
	}

	public int updateRequritFrm(Requrit r) {
		int result = dao.updateRequrit(r);
		return result;
	}

	public RequritPageData selectRequritPageDataLast(int reqPage) {
		int numPerPage = 10;
		int end = reqPage*numPerPage;
		int start = end - numPerPage +1;
		RequritPagingVo paging = new RequritPagingVo();
		paging.setStart(start);
		paging.setEnd(end);
		ArrayList<Requrit> list = dao.selectRequritListDelete(paging);
		for(Requrit r : list) {
			LocalDate now = LocalDate.now();
			String endDate = r.getRequritEnd();
			LocalDate date = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE);
			long period = ChronoUnit.DAYS.between(now, date);
			r.setPeriod(period);
		}
		int totalCount = dao.selectTotalCountDelete();
		int totalPage = 0;
		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		} else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		//페이지네비 태그 제작 시작
		String pageNavi = "<ul class='pagination'>";
		//이전버튼
		if(pageNo != 1) {
			pageNavi += "<li id='pageNum' class ='page-item'>";
			pageNavi += "<a class='page-link' href='/deleteRequritList.do?reqPage="+(pageNo-1)+"'>";
			pageNavi += "&lt;</a></li>";
		}
		//페이지숫자
		for(int i=0; i<pageNaviSize; i++) {
			if(pageNo == reqPage) {
				pageNavi += "<li id='pageNumAct' class ='page-item active'>";
				pageNavi += "<a class='page-link' href='/deleteRequritList.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}else {
				pageNavi += "<li id='pageNum' class ='page-item'>";
				pageNavi += "<a class='page-link' href='/deleteRequritList.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		//다음버튼
		if(pageNo <= totalPage) {
			pageNavi += "<li id='pageNum' class ='page-item'>";
			pageNavi += "<a class='page-link' href='/deleteRequritList.do?reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		
		//게시물목록(ArrayList), 페이지네비(String), start(번호 표시용)
		RequritPageData rpd = new RequritPageData();
		rpd.setList(list);
		rpd.setPageNavi(pageNavi);
		rpd.setStart(start);
		return rpd;
	}
	@Transactional
	public int RevivalrequritFrm(Requrit r) {
		int result = dao.updateRequrit(r);
		if(result>0) {
			result = dao.revivalRequrit(r.getRequritNo());
			return result;
		}else {
			result = 0;
			return result;
		}
	}
}
