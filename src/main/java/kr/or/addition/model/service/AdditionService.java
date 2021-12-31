package kr.or.addition.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.addition.model.dao.AdditionDao;
import kr.or.addition.model.vo.Board;
import kr.or.addition.model.vo.BoardComment;
import kr.or.addition.model.vo.BoardNext;
import kr.or.addition.model.vo.BoardPageData;
import kr.or.addition.model.vo.BoardViewData;
import kr.or.addition.model.vo.LikeNo;
import kr.or.addition.model.vo.MyPageData;

@Service
public class AdditionService {
	@Autowired
	private AdditionDao dao;
	
	//글 리스트 조회
		public BoardPageData selectNoticeList(int boardType, int reqPage) {
			//고정공지
			ArrayList<Board> fixlist = dao.selectFixlist();
			// 한페이지에 보여줄 게시물 수
			int numPerPage = 10;
			int end = reqPage * numPerPage;
			int start = end - numPerPage + 1;
			// 한 페이지에 보여줄 게시물 목록 조회
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("start", start);
			map.put("end", end);
			map.put("boardType", boardType);
			ArrayList<Board> list = dao.selectNoticeList(map);
			// 페이지네비게이션 제작
			int totalCount = dao.totalCount(map);
			// 전체페이지수 계산
			int totalPage = 0;
			if (totalCount % numPerPage == 0) {
				totalPage = totalCount / numPerPage;
			} else {
				totalPage = totalCount / numPerPage + 1;
			}
			int pageNaviSize = 5;
			//요청페이지가 가운데 올 수 있는 pageNo설정
			int pageNo = 0;
			if(reqPage<4) {
				pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize +1;
			}else {
				pageNo = reqPage-2;
			}
			
			String pageNavi = "<ul id='pagination' class ='pagination pagination-lg'>";

			if(reqPage>=4) {
				pageNavi += "<li id='pageNum' class='page-item'>";
				if(boardType==1) {
					pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=1&reqPage="+(reqPage-1)+"'>";
				}else if(boardType==2) {
					pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=2&reqPage="+(reqPage-1)+"'>";
				}else {
					pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=3&reqPage="+(reqPage-1)+"'>";
				}
				pageNavi += "&lt;</a></li>";
			}
			
			//페이지숫자
			for(int i=0;i<pageNaviSize;i++) {
					if(pageNo == reqPage) {
						pageNavi += "<li id='pageNumAct' class ='page-item active'>";
						if(boardType==1) {
							pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=1&reqPage="+pageNo+"'>";
						}else if(boardType==2) {
							pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=2&reqPage="+pageNo+"'>";
						}else {
							pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=3&reqPage="+pageNo+"'>";
						}
						pageNavi += pageNo+"</a></li>";
					}else {
						pageNavi += "<li id='pageNum' class ='page-item'>";
						if(boardType==1) {
							pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=1&reqPage="+pageNo+"'>";
						}else if(boardType==2) {
							pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=2&reqPage="+pageNo+"'>";
						}else {
							pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=3&reqPage="+pageNo+"'>";
						}
						pageNavi += pageNo+"</a></li>";
					}
					pageNo++;
					if(pageNo>totalPage) {
						break;
					}
			}
			
			
			if(pageNo <= totalPage) {
				pageNavi += "<li id='pageNum' class ='page-item'>";
				if(boardType==1) {
					pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=1&reqPage="+(reqPage+1)+"'>";
				}else if(boardType==2) {
					pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=2&reqPage="+(reqPage+1)+"'>";
				}else {
					pageNavi += "<a class='page-link' href='/additionBoard.do?boardType=3&reqPage="+(reqPage+1)+"'>";
				}
				pageNavi += "&gt;</a></li>";
				
			}
			pageNavi +="</ul>";
			
			fixlist.addAll(list);
			BoardPageData bpd = new BoardPageData(fixlist, pageNavi, start,totalCount);
			return bpd;
		}

	
	//글쓰기
	@Transactional
	public int insertBoard(Board b) {
		int result = dao.insertBoard(b);
		return result;
	}

	//글보기
	@Transactional
	public BoardViewData selectOneBoard(int boardNo) {
		int result = dao.updateReadCount(boardNo); //조회수올림
		Board b = dao.selectOneBoard(boardNo); //게시글정보
		ArrayList<BoardComment> list = dao.selectCommentList(boardNo);//댓글정보
		LikeNo l = dao.selectLikeSum(boardNo);
		BoardViewData bvd = new BoardViewData(list,l,b);
		return bvd;
	}
	
	//글삭제
	@Transactional
	public int boardDelete(int boardNo,String num) {
		int result=-1;
		if(!num.isEmpty()) {
			StringTokenizer sT1 = new StringTokenizer(num,"/");
			while(sT1.hasMoreTokens()) {
				boardNo =Integer.parseInt(sT1.nextToken());
				int result1 = dao.boardDelete(boardNo);
				result=1;
				if(result1 == 0) { 
					result=0; 
					break;
				}
			}
		}else if(boardNo!=0){
			result = dao.boardDelete(boardNo);
		}
		
		return result;
	}

	//댓글달기
	@Transactional
	public int insertComment(BoardComment bc) {
		int result= dao.insertComment(bc);
		return result;
	}

	//댓글삭제
	@Transactional
	public int deleteComment(int bcNo,int bcRef) {
		ArrayList<BoardComment> list=dao.chkReComment(bcNo);
		if(list.isEmpty()) { //대댓글없을때 or 대댓글일때
			if(bcRef!=0 ) { //대댓글일때 
				int result=-1;
				ArrayList<BoardComment> rlist=dao.chkReComment(bcRef);
				BoardComment bc=dao.chkDelComment(bcRef);
				if(rlist.size()==1 && bc.getBcDel()==1) { //다른 대댓없을때
					result = dao.deleteComment(bcNo);
					int result1 = dao.deleteComment(bcRef);
					if(result1 <= 0) {
						result=-1;
					}
				}else { //다른 대댓 있을때
					result = dao.deleteComment(bcNo);
				}
				return result;
			}else { //대댓글 없을때
				int result = dao.deleteComment(bcNo);
				return result;
			}
		}else {//대댓글있을때
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("del",1);
			map.put("bcNo", bcNo);
			map.put("bcContent", "삭제된 댓글입니다.");
			int result = dao.updateComment(map);
			return result;
		}
	}
	
	//댓글수정
	@Transactional
	public int updateComment(int bcNo, String bcContent) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bcNo", bcNo);
		map.put("bcContent", bcContent);
		int result = dao.updateComment(map);
		return result;
	}

	//새글수 조회
	public int selectNewCount(int boardType) {
		int nCount =dao.selectNewCount(boardType);
		return nCount;
	}

	//검색
	public BoardPageData searchKeyword(int reqPage,int boardType,String keyword,String type) {
		int numPerPage = 10;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		// 한 페이지에 보여줄 게시물 목록 조회
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("boardType", boardType);
		map.put("keyword", keyword);
		map.put("type",type);
		ArrayList<Board> list=dao.searchKeyword(map);
		// 페이지네비게이션 제작
		int totalCount = dao.totalKCount(map);
		// 전체페이지수 계산
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}
		int pageNaviSize = 5;
		//요청페이지가 가운데 올 수 있는 pageNo설정
		int pageNo = 0;
		if(reqPage<4) {
			pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize +1;
		}else {
			pageNo = reqPage-2;
		}
		
		
		String pageNavi = "<ul id='pagination' class ='pagination pagination-lg'>";

		if(reqPage>=4) {
			pageNavi += "<li id='pageNum' class='page-item'>";
			if(boardType==1) {
				pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=1&reqPage="+(reqPage-1)+"'>";
			}else if(boardType==2) {
				pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=2&reqPage="+(reqPage-1)+"'>";
			}else {
				pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=3&reqPage="+(reqPage-1)+"'>";
			}
			pageNavi += "&lt;</a></li>";
		}
		
		//페이지숫자
		for(int i=0;i<pageNaviSize;i++) {
				if(pageNo == reqPage) {
					pageNavi += "<li id='pageNumAct' class ='page-item active'>";
					if(boardType==1) {
						pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=1&reqPage="+pageNo+"'>";
					}else if(boardType==2) {
						pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=2&reqPage="+pageNo+"'>";
					}else {
						pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=3&reqPage="+pageNo+"'>";
					}
					pageNavi += pageNo+"</a></li>";
				}else {
					pageNavi += "<li id='pageNum' class ='page-item'>";
					if(boardType==1) {
						pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=1&reqPage="+pageNo+"'>";
					}else if(boardType==2) {
						pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=2&reqPage="+pageNo+"'>";
					}else {
						pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=3&reqPage="+pageNo+"'>";
					}
					pageNavi += pageNo+"</a></li>";
				}
				pageNo++;
				if(pageNo>totalPage) {
					break;
				}
		}
		
		
		if(pageNo <= totalPage) {
			pageNavi += "<li id='pageNum' class ='page-item'>";
			if(boardType==1) {
				pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=1&reqPage="+(reqPage+1)+"'>";
			}else if(boardType==2) {
				pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=2&reqPage="+(reqPage+1)+"'>";
			}else {
				pageNavi += "<a class='page-link' href='/searchKeyword.do?type="+type+"&keyword="+keyword+"&boardType=3&reqPage="+(reqPage+1)+"'>";
			}
			pageNavi += "&gt;</a></li>";
		
		}
		pageNavi +="</ul>";
		
		BoardPageData bpd = new BoardPageData(list, pageNavi, start,totalCount);
		return bpd;
	}
	
	//글수정
	@Transactional
	public int boardUpdate(Board b) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo",b.getBoardNo());
		map.put("boardTitle",b.getBoardTitle());
		map.put("boardContent",b.getBoardContent());
		map.put("filename",b.getFilename());
		map.put("filepath",b.getFilepath());
		if(b.getBoardType()==1) {
		map.put("keyword","fix");
		map.put("boardFix",b.getBoardFix());
		}else if(b.getBoardType()==2){
		map.put("keyword","secret");
		map.put("boardLevel",b.getBoardLevel());
		}else {
		map.put("keyword","");
		}
		int result=dao.boardUpdate(map);
		return result;
	}

	
	//이전글다음글 목록
	public BoardNext selectNextBoard(int boardNo,int boardType) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("boardType", boardType);
		BoardNext info = dao.selectNextBoard(map);
		return info;
	}

	//글규제
	@Transactional
	public int regulationBoard(int boardNo) {
		int result=dao.regulationBoard(boardNo);
		return result;
	}
	
	//규제해제
	@Transactional
	public int removeRegulationBoard(int boardNo) {
		int result=dao.removeRegulationBoard(boardNo);
		return result;
	}

	//좋아요
	public int boardLike(int checkNum,int boardNo, String memberId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("memberId", memberId);
		map.put("checkNum", checkNum);
		int result = dao.boardLike(map);
		return result;
	}

	//싫어요
	public int boardDislike(int boardNo, String memberId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("memberId", memberId);
		int result = dao.boardDislike(map);
		return result;
	}

	//좋아요수
	public LikeNo selectLikeSum(int boardNo) {
		LikeNo l = dao.selectLikeSum(boardNo);
		return l;
	}

	//좋아요 했는지 체크
	public LikeNo selectLikeChk(int boardNo, String memberId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("memberId", memberId);
		LikeNo chk= dao.selectLikeChk(map);
		return chk;
	}
	
	//내가쓴글
	public MyPageData myFree(String memberId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("boardType", 1);
		ArrayList<Board> noticeList=dao.myList(map);
		map.put("boardType", 3);
		ArrayList<Board> freeList=dao.myList(map);
		map.put("boardType", 2);
		ArrayList<Board> qnaList=dao.myList(map);
		ArrayList<BoardComment> commentList=dao.myCommentList(memberId);
		MyPageData mpd= new MyPageData(commentList,noticeList,freeList,qnaList);
		return mpd;
	}

	//이벤트글 수
	public int totalEventCount() {
		int result=dao.totalEventCount();
		return result;
	}

	//이벤트 글 조회
	public ArrayList<Board> eventMore(int start) {
		int length=3;
		int end = start+length-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("boardType", 5);
		ArrayList<Board> list = dao.selectNoticeList(map);
		return list;
	}


}
