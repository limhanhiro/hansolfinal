package kr.or.space.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.academy.vo.Academy;
import kr.or.academy.vo.AcademyPagingVo;
import kr.or.member.vo.Member;
import kr.or.space.model.dao.SpaceDao;
import kr.or.space.model.vo.Black;
import kr.or.space.model.vo.FileVO;
import kr.or.space.model.vo.Rental;
import kr.or.space.model.vo.ResSpace;
import kr.or.space.model.vo.Space;
import kr.or.space.model.vo.SpaceAdmin;
import kr.or.space.model.vo.SpaceMypage;
import kr.or.space.model.vo.SpacePageNavi;
import kr.or.space.model.vo.SpaceReview;
import kr.or.space.model.vo.SpaceTime;
import kr.or.space.model.vo.UseBoard;

@Service
public class SpaceService {
	@Autowired
	private SpaceDao dao;
	
	//공간등록 + 파일 업로드
	@Transactional
	public int insertSpace(Space s, ArrayList<FileVO> list, ArrayList<SpaceTime> stList) {
		int result1 = dao.insertSpace(s);
		int stResult = 0;
		int result=0;
		if(result1>0) {
			for(FileVO fv : list) {
				fv.setSpaceNo(s.getSpaceNo());
				result += dao.insertFile(fv);
			}
			for(SpaceTime st : stList) {
				st.setSpaceNo(s.getSpaceNo());
				stResult = dao.insertSpaceTime(st);
			}
		}else {
			return -1;
		}
		return result;		
	}
	
	public ArrayList<Space> selectAllSpace() {
		ArrayList<Space> list = dao.selectAllSpace();
		return list;
	}
	//모든 파일 가져오기
	public ArrayList<FileVO> selectFile() {
		ArrayList<FileVO> fileList = dao.selectFile();
		return fileList;
	}

	public Space selectOneSpace(int spaceNo) {
		return dao.selectOneSpace(spaceNo);
	}

	public ArrayList<FileVO> selectSpaceFile(int spaceNo) {
		return dao.selectSpaceFile(spaceNo);
	}
	//1개 공간 썸네일 가져오기
	public FileVO selectThumbnail(int spaceNo) {
		return dao.selectThumbnail(spaceNo);
	}
	//공간 삭제
	@Transactional
	public int deleteSpace(int spaceNo) {
		return dao.deleteSpace(spaceNo);
	}
	//1개 공간의 파일들 가져오기
	public ArrayList<FileVO> selectFileList(int spaceNo) {
		return dao.selectFileList(spaceNo);
	}
	//시간 조회
	public ArrayList<SpaceTime> selectSpaceTime(int spaceNo) {
		return dao.selectSpaceTime(spaceNo);
	}
	//하나의 시간 조회
	public SpaceTime selectOneTime(int stNo) {
		return dao.selectOneTime(stNo);
	}
	//공간 예약
	@Transactional
	public int insertRental(Rental r) {
		return dao.insertRental(r);
	}
	//한사람이 예약한 대관 내역 조회
	public ArrayList<Rental> selectRentalList(String memberId) {
		return dao.selectRentalList(memberId);
	}
	//모든 대관 리스트 조회
	public SpacePageNavi selectAllRental(int reqPage) {
		int numPerPage = 5;
		int end = reqPage*numPerPage;
		int start = end - numPerPage+1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		ArrayList<SpaceAdmin> rental = dao.selectAllRental(map);
		
		int totalCount = dao.selectTotalRentalCount();
		int totalPage = 0;
		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		}else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		
		String pageNavi = "<ul class='pagination'>";
		//이전버튼
		if(pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a href='/spaceAdmin.do?reqPage="+(pageNo-1)+"'>";
			pageNavi += "&lt;</a></li>";
		}
		//페이지숫자
		for(int i=0; i<pageNaviSize; i++) {
			if(pageNo == reqPage) {
				pageNavi += "<li id='click-page' class='active'>";
				pageNavi += "<a href='/spaceAdmin.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}else {
				pageNavi += "<li>";
				pageNavi += "<a href='/spaceAdmin.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		//다음버튼
		if(pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a href='/spaceAdmin.do?reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		
		SpacePageNavi page = new SpacePageNavi();
		page.setRList(rental);
		page.setPageNavi(pageNavi);
		page.setStart(start);
		return page;
	}
	//이메일
	public String selectEmail(String memberId) {
		return dao.selectEmail(memberId);
	}
	//상태 업데이트
	public int updateRentalStatus(int rentalNo) {
		return dao.updateRentalStatus(rentalNo);
	}
	//예약한 시간 조회
	public ArrayList<ResSpace> selectResSpace(int spaceNo) {
		return dao.selectResSapce(spaceNo);
	}
	//예약한 시간 리스트
	public ArrayList<ResSpace> selectResList(String selectDate, int spaceNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("selectDate", selectDate);
		map.put("spaceNo", spaceNo);
		return dao.selectResList(map);
	}
	//마이페이지 - 예약내역 조회
	public ArrayList<SpaceMypage> selectSpaceMypage(HashMap<String, Object> map) {
		return dao.selectSpaceMypage(map);
	}
	//사용 게시판-페이징
	@Transactional
	public SpacePageNavi selectSpacePageNavi(int reqPage) {
		int numPerPage = 10;
		int end = reqPage*numPerPage; 
		int start = end - numPerPage+1; 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		ArrayList<UseBoard> list = dao.selectUseBoardList(map);
		int totalCount = dao.selectTotalCount();
		int totalPage = 0;
		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		}else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		
		String pageNavi = "<ul class='pagination'>";
		//이전버튼
		if(pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a href='/selectSpaceBoardList.do?reqPage="+(pageNo-1)+"'>";
			pageNavi += "&lt;</a></li>";
		}
		//페이지숫자
		for(int i=0; i<pageNaviSize; i++) {
			if(pageNo == reqPage) {
				pageNavi += "<li class='click'>";
				pageNavi += "<a href='/selectSpaceBoardList.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}else {
				pageNavi += "<li>";
				pageNavi += "<a href='/selectSpaceBoardList.do?reqPage="+pageNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		//다음버튼
		if(pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a href='/selectSpaceBoardList.do?reqPage="+pageNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		
		SpacePageNavi page = new SpacePageNavi();
		page.setList(list);
		page.setPageNavi(pageNavi);
		page.setStart(start);
		return page;
	}
	//게시판 작성할 대관
	public Rental selectRentalNo(int rentalNo) {
		return dao.selectRentalNo(rentalNo);
	}
	//사용게시판 등록
	@Transactional
	public int insertUseBoard(UseBoard ub) {
		int result = dao.insertUseBoard(ub);
		if(result>0) {
			//사용게시판 작성으로 변경
			int result1 = dao.updatUsedBoard(ub.getRentalNo());
			return result1;
		}else {
			return -1;
		}
	}
	//사용 게시판 조회
	public UseBoard selectOneBoardView(int ubNo) {
		UseBoard ub = dao.selectOneBoardView(ubNo);
		return ub;
	}
	//게시판 삭제
	@Transactional
	public int deleteUseBoard(int ubNo) {
		//대관 번호 조회
		int rentalNo = dao.selectUbRentalNo(ubNo);
		//게시판 삭제
		int result1 = dao.deleteUseBoard(ubNo);
		if(result1>0) {
			//사용 게시판 확인 번호 수정
			int result = dao.updateNoBoard(rentalNo);
			return result;
		}else {
			return -1;
		}
	}
	//게시판 수정
	public int updateUseBoard(UseBoard u) {
		return dao.updateUseBoard(u);
	}
	//공간에 따른 리뷰 조회
	public SpacePageNavi selectSpaceReview(int spaceNo, int reqPage) {
		int numPerPage = 5;
		int end = reqPage*numPerPage;
		int start = end - numPerPage+1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("spaceNo", spaceNo);
		ArrayList<SpaceReview> srList = dao.selectSpaceReview(map);;
		
		int totalCount = dao.selectTotalReviewCount(spaceNo);
		int totalPage = 0;
		if(totalCount%numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		}else {
			totalPage = totalCount/numPerPage+1;
		}
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		
		String pageNavi = "<ul class='pagination'>";
		//이전버튼
		if(pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a href='/spaceView.do?reqPage="+(pageNo-1)+"&spaceNo="+spaceNo+"'>";
			pageNavi += "&lt;</a></li>";
		}
		//페이지숫자
		for(int i=0; i<pageNaviSize; i++) {
			if(pageNo == reqPage) {
				pageNavi += "<li class='active'>";
				pageNavi += "<a href='/spaceView.do?reqPage="+pageNo+"&spaceNo="+spaceNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}else {
				pageNavi += "<li>";
				pageNavi += "<a href='/spaceView.do?reqPage="+pageNo+"&spaceNo="+spaceNo+"'>";
				pageNavi += pageNo+"</a></li>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		//다음버튼
		if(pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a href='/spaceView.do?reqPage="+pageNo+"&spaceNo="+spaceNo+"'>";
			pageNavi += "&gt;</a></li>";
		}
		pageNavi += "</ul>";
		
		SpacePageNavi page = new SpacePageNavi();
		page.setSrList(srList);
		page.setPageNavi(pageNavi);
		page.setStart(start);
		return page;
		
	}
	//렌탈 정보
	public Rental selectRentalInfo(int rentalNo) {
		return dao.selectRentalInfo(rentalNo);
	}
	//리뷰 등록
	public int insertReview(SpaceReview sr) {
		return dao.insertReview(sr);
	}
	//리뷰 더보기
	public ArrayList<SpaceReview> moreSpaceReview(int start, int spaceNo) {
		int end = start +5;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start+1);
		map.put("end", end);
		map.put("spaceNo", spaceNo);
		ArrayList<SpaceReview> list = dao.moreSpaceReview(map);
		return list;
	}
	//리뷰총개수
	public int selectTotalReviewCount(int spaceNo) {
		return dao.selectTotalReviewCount(spaceNo);
	}
	//리뷰 리스트 조회
	public ArrayList<SpaceReview> selectSpaceReviewList(int spaceNo, int reqPage) {
		int start = reqPage;
		int end = start + 3;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("spaceNo", spaceNo);
		ArrayList<SpaceReview> list = dao.selectSpaceReview(map);
		return list;
	}
	//내가 쓴 리뷰 보기
	public ArrayList<SpaceReview> selectMyReview(String memberId) {
		return dao.selectMyReview(memberId);
	}
	//블랙리스트 추가
	@Transactional
	public void insertSpaceBlack() {
		//게시판 작성을 하지 않은 아이디 조회
		ArrayList<String> memberId= dao.selectBlackId();
		if(memberId.size() > 0) {
			for(String m : memberId) {
				//블랙리스트에 등록
				int result = dao.insertSpaceBlack(m);
				//블랙리스트에 등록 된 아이디가 예약했던 내역 삭제
				int result1 = dao.deleteRental(m);
			}
		}
		
	}
	//수정할 리뷰 조회
	public SpaceReview selectReviewInfo(int rentalNo) {
		return dao.selectReviewInfo(rentalNo);
	}
	//리뷰 수정
	public int updatetReview(SpaceReview sr) {
		return dao.updateReview(sr);
	}
	//블랙리스트 아이디 조회
	public ArrayList<Black> selectBalckList() {
		return dao.selectBlackList();
	}
	//리뷰삭제
	public int deleteReview(int rentalNo) {
		return dao.deleteReview(rentalNo);
	}
	//공간 수정
	@Transactional
	public int updateSpace(Space s, ArrayList<FileVO> list, ArrayList<SpaceTime> stList) {
		int result1 = dao.updateSpace(s);
		int stResult = 0;
		int result=0;
		if(result1>0) {
			int fResult = dao.deleteSpaceFile(s.getSpaceNo());
			if(fResult>0) {
				for(FileVO fv : list) {
					fv.setSpaceNo(s.getSpaceNo());
					result += dao.insertFile(fv);
				}
				for(SpaceTime st : stList) {
					stResult = dao.updateSpaceTime(st);
				}
			}
		}else {
			return -1;
		}
		
		return result;		
	}
	//삭제 공간 조회
	public ArrayList<Space> selectDelSpace() {
		return dao.selectDelSpace();
	}
	//예매 취소
	public int deleteRental(int rentalNo) {
		return dao.deleteRetnalNo(rentalNo);
	}
	//블랙리스트 소멸
	public void cancleBlackList(String time1) {
		dao.cancleBlackList(time1);
	}
	//삭제 된 블랙리스트
	public ArrayList<Black> selectDelBlack() {
		return dao.selectDelBlack();
	}
	//삭제 안된 공간 조회
	public ArrayList<Space> selectNoDelSpace() {
		return dao.selectNoDelSpace();
	}
	//공간 복구
	public int spaceRestore(int spaceNo) {
		return dao.spaceRestore(spaceNo);
	}
	//공간 완전 삭제
	public int realDeleteSpace(int spaceNo) {
		return dao.realDeleteSpace(spaceNo);
	}
	//블랙 된 횟수
	public int selectBalckCount(String memberId) {
		return dao.selectBlackCount(memberId);
	}
}
