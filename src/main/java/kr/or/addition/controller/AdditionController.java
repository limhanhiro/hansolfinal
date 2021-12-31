package kr.or.addition.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.addition.model.service.AdditionService;
import kr.or.addition.model.vo.Board;
import kr.or.addition.model.vo.BoardComment;
import kr.or.addition.model.vo.BoardNext;
import kr.or.addition.model.vo.BoardPageData;
import kr.or.addition.model.vo.BoardViewData;
import kr.or.addition.model.vo.LikeNo;
import kr.or.addition.model.vo.MyPageData;
import kr.or.member.vo.Member;

@Controller
public class AdditionController {
	@Autowired
	private AdditionService service;

	@RequestMapping(value = "/addition.do")
	public String addition() {
		return "addition/addition";
	}

	// 글리스트조회 공지
	@RequestMapping(value = "/additionBoard.do")
	public String notice(int boardType, int reqPage, Model model) {
		BoardPageData bpd = service.selectNoticeList(boardType, reqPage);
		int nCount = service.selectNewCount(boardType);
		model.addAttribute("totalCount", bpd.getTotalCount());
		model.addAttribute("list", bpd.getList());
		model.addAttribute("pageNavi", bpd.getPageNavi());
		model.addAttribute("start", bpd.getStart());
		model.addAttribute("nCount", nCount);
		if (boardType == 1) {
			model.addAttribute("headerText", "공지사항");
			return "addition/notice";
		} else if (boardType == 2) {
			model.addAttribute("headerText", "FAQ • 1대1문의");
			return "addition/qna";
		} else{
			model.addAttribute("headerText", "소통게시판");
			return "addition/free";
		}
	}

	// 글쓰기폼이동
	@RequestMapping(value = "/boardWriteFrm.do")
	public String boardWriteFrm(int boardType, Model model) {
		model.addAttribute("boardType", boardType);
		if(boardType==1) {
			model.addAttribute("headerText", "공지사항");
		}else if(boardType==2) {
			model.addAttribute("headerText", "1대1 문의");
		}else if(boardType==3) {
			model.addAttribute("headerText", "소통게시판");
		}else {
			model.addAttribute("headerText", "이벤트");
		}
		return "addition/boardWriteFrm";
	}

	// 글쓰기
	@RequestMapping(value = "/boardWrite.do")
	public String boardWrite(Board b, MultipartFile addFile, HttpServletRequest request, Model model) {
		if(!addFile.isEmpty()) {
		String savePath = request.getSession().getServletContext().getRealPath("/resources/additionImage/");
			String filename = addFile.getOriginalFilename();
			String onlyFilename = filename.substring(0, filename.indexOf("."));
			String extention = filename.substring(filename.indexOf("."));
			
			String filepath = null;
			int count = 0;
			while(true) {
				if(count==0) {
					filepath = onlyFilename + extention;
				}else {
					filepath = onlyFilename+"_"+count+extention;
				}
				File checkFile = new File(savePath+filepath);
				if(!checkFile.exists()) {
					break;
				}
				count++;
			}
			
			try {
				FileOutputStream fos = new FileOutputStream(new File(savePath+filepath));
				BufferedOutputStream bos = new BufferedOutputStream(fos);
				byte[] bytes = addFile.getBytes();
				bos.write(bytes);
				bos.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			b.setFilename(filename);
			b.setFilepath(filepath);
		}
		
		int result = service.insertBoard(b);
		if (result <= 0) {
			model.addAttribute("msg", "등록실패");
		} else {
			model.addAttribute("msg", "등록성공");
		}
		if (b.getBoardType() == 1) {
			model.addAttribute("loc", "/additionBoard.do?boardType=1&reqPage=1");
		} else if (b.getBoardType() == 2) {
			model.addAttribute("loc", "/additionBoard.do?boardType=2&reqPage=1");
		} else if (b.getBoardType() == 3) {
			model.addAttribute("loc", "/additionBoard.do?boardType=3&reqPage=1");
		}else {
			model.addAttribute("loc", "/discount.do");
		}
		return "common/msg";
	}

	// 글보기
	@RequestMapping(value = "/boardView.do")
	public String boardView(int boardType, int boardNo, Model model) {
		// boardNo을 이용하여 조회한 board객체,arrayList<fileVo>
		BoardNext info =service.selectNextBoard(boardNo,boardType);
		BoardViewData bvd = service.selectOneBoard(boardNo);
		model.addAttribute("b", bvd.getB());
		model.addAttribute("list", bvd.getList());
		model.addAttribute("info",info);
		model.addAttribute("l",bvd.getLikeList());
		if (boardType == 1) {
			model.addAttribute("headerText", "공지사항");
			return "addition/noticeView";
		} else if (boardType == 2) {
			model.addAttribute("headerText", "1대1문의");
			return "addition/qnaView";
		} else if (boardType == 3){
			model.addAttribute("headerText", "소통게시판");
			return "addition/freeView";
		} else {
			model.addAttribute("headerText", "이벤트");
			return "addition/eventView";
		}

	}

	// 글삭제하기
	@RequestMapping(value = "/boardDelete.do")
	public String boardDelete(@SessionAttribute Member m,String num,int boardType, int boardNo, Model model) {
		int result = service.boardDelete(boardNo,num);
		if (result > 0) {
			model.addAttribute("msg", "삭제성공");

		} else {
			model.addAttribute("msg", "삭제실패");
		}
		if (boardType == 1) {
			model.addAttribute("loc", "/additionBoard.do?boardType=1&reqPage=1");
		} else if (boardType == 2) {
			model.addAttribute("loc", "/additionBoard.do?boardType=2&reqPage=1");
		} else if (boardType == 3){
			model.addAttribute("loc", "/additionBoard.do?boardType=3&reqPage=1");
		}else if(boardType == 4){
			model.addAttribute("loc", "/myFree.do?memberId="+m.getMemberId());
		}else {
			model.addAttribute("loc", "/discount.do");
		}
		return "common/msg";
	}

	// 오시는길
	@RequestMapping(value = "/additionGuide.do")
	public String additionGuide(Model model) {
		model.addAttribute("headerText", "시설안내 • 오시는 길");
		return "addition/guide";
	}

	// 이벤트페이지
	@RequestMapping(value = "/discount.do")
	public String eventList(Model model) {
		int totalEventCount=service.totalEventCount();
		model.addAttribute("headerText", "이벤트");
		model.addAttribute("totalCount", totalEventCount);
		return "addition/event";
	}
	
	//이벤트 글조회
	@ResponseBody
	@RequestMapping(value = "/eventMore.do",produces = "application/json;charset=utf-8")
	public String eventMore(int start) {
		ArrayList<Board> list=service.eventMore(start);
		return new Gson().toJson(list);
	}
	

	// 댓글달기
	@RequestMapping(value = "/insertComment.do")
	public String insertComment(int boardType, BoardComment bc, Model model) {
		int result = service.insertComment(bc);
		if (result > 0) {
			if (boardType == 2) {
				return "redirect:/boardView.do?boardType=2&boardNo=" + bc.getBoardRef();
			} else if(boardType == 3) {
				return "redirect:/boardView.do?boardType=3&boardNo=" + bc.getBoardRef();
			}else {
				return "redirect:/boardView.do?boardType=5&boardNo=" + bc.getBoardRef();
			}
		}else {
			model.addAttribute("msg", "등록실패");
			if (boardType == 2) {
				model.addAttribute("loc", "/boardView.do?boardType=2&boardNo=" + bc.getBoardRef());
			} else if(boardType == 3) {
				model.addAttribute("loc", "/boardView.do?boardType=3&boardNo=" + bc.getBoardRef());
			}else {
				model.addAttribute("loc", "/boardView.do?boardType=5&boardNo=" + bc.getBoardRef());
			}
			
		}
		return "common/msg";
	}

	// 댓글삭제
	@RequestMapping(value = "/deleteComment.do")
	public String deleteComment(@SessionAttribute Member m,int boardType, int bcNo, int boardNo,int bcRef, Model model) {
		int result = service.deleteComment(bcNo,bcRef);
		if (result > 0) {
			model.addAttribute("msg", "삭제성공");
		} else {
			model.addAttribute("msg", "삭제실패");
		}
		if (boardType == 2) {
			model.addAttribute("loc", "/boardView.do?boardType=2&boardNo=" + boardNo);
		} else if(boardType == 3) {
			model.addAttribute("loc", "/boardView.do?boardType=3&boardNo=" + boardNo);
		}else if(boardType == 4) {
			model.addAttribute("loc", "/myFree.do?memberId="+m.getMemberId());
		}else {
			model.addAttribute("loc", "/boardView.do?boardType=5&boardNo=" + boardNo);
		}
		return "common/msg";
	}

	// 댓글수정
	@RequestMapping(value = "/updateComment.do")
	public String updateComment(int boardType, int bcNo, int boardNo, String bcContent, Model model) {
		int result = service.updateComment(bcNo, bcContent);
		if (result > 0) {
			model.addAttribute("msg", "수정성공");
		} else {
			model.addAttribute("msg", "수정실패");
		}
		if (boardType == 2) {
			model.addAttribute("loc", "/boardView.do?boardType=2&boardNo=" + boardNo);
		} else {
			model.addAttribute("loc", "/boardView.do?boardType=3&boardNo=" + boardNo);
		}
		return "common/msg";
	}

	// summernote 이미지업로드
	@ResponseBody
	@RequestMapping(value = "/uploadSummernoteImageFile.do", produces = "application/text;charset=utf-8")
	public String uploadImageBoard(MultipartFile file, HttpServletRequest request) {
		String filepath = null;
		if (file != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/additionImage/");
			String filename = file.getOriginalFilename();
			String onlyFilename = filename.substring(0, filename.indexOf("."));
			String extention = filename.substring(filename.indexOf("."));
			int count = 0;
			while (true) {
				if (count == 0) {
					filepath = onlyFilename + extention;
				} else {
					filepath = onlyFilename + "_" + count + extention;
				}
				File checkFile = new File(savePath + filepath);
				if (!checkFile.exists()) {
					break;
				}
				count++;
			}
			try {
				FileOutputStream fos = new FileOutputStream(new File(savePath + filepath));
				BufferedOutputStream bos = new BufferedOutputStream(fos);
				byte[] bytes = file.getBytes();
				bos.write(bytes);
				bos.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return "/resources/additionImage/" + filepath;
	}

	// 파일 다운로드
	@RequestMapping(value = "/fileDown.do")
	public void fileDown(String filename, String filepath, HttpServletRequest request, HttpServletResponse response) {
		String savePath = request.getSession().getServletContext().getRealPath("/resources/additionImage/");
		String file = savePath + filepath;
		FileInputStream fis;
		try {
			fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ServletOutputStream sos;
			try {
				sos = response.getOutputStream();
				BufferedOutputStream bos = new BufferedOutputStream(sos);
				String resFilename = ""; // 최종 다운로드 할 파일 이름
				boolean bool = request.getHeader("user-agent").indexOf("MSIE") != -1
						|| request.getHeader("user-agent").indexOf("Trident") != -1;
				if (bool) {// 브라우저가 IE인경우
					resFilename = URLEncoder.encode(filename, "UTF-8");
					resFilename = resFilename.replaceAll("\\\\", "%20");
				} else {// 그외 다른 브라우저인 경우
					resFilename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
				}
				// 파일다운로드를 위한 HTTP header설정(사용자 브라우저에 파일다운로드임을 선언)
				response.setContentType("application/octet-stream");
				// 다운로드할 파일 이름 지정
				response.setHeader("Content-Disposition", "attachment;filename=" + resFilename);
				// 파일전송
				while (true) {
					int read = bis.read();
					if (read != -1) {
						bos.write(read);
					} else {
						break;
					}
				}
				bis.close();
				bos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 글검색
	@RequestMapping(value = "/searchKeyword.do")
	public String searchKeyword(int boardType, int reqPage, String keyword, String type, Model model) {
		BoardPageData bpd = service.searchKeyword(reqPage, boardType, keyword, type);
		model.addAttribute("list", bpd.getList());
		model.addAttribute("pageNavi", bpd.getPageNavi());
		model.addAttribute("start", bpd.getStart());
		if (boardType == 1) {
			model.addAttribute("headerText", "공지사항");
			return "addition/noticeSearch";
		} else if (boardType == 2) {
			model.addAttribute("headerText", "1대1 문의");
			return "addition/qnaSearch";
		}else {
			model.addAttribute("headerText", "소통게시판");
			return "addition/freeSearch";
		}

	}

	// 글수정폼이동
	@RequestMapping(value = "/boardUpdateFrm.do")
	public String boardUpdateFrm(int boardType,int boardNo, Model model) {
		BoardViewData bvd = service.selectOneBoard(boardNo);
		model.addAttribute("b", bvd.getB());
		model.addAttribute("boardType", boardType);
		if(boardType==1) {
			model.addAttribute("headerText", "공지사항");
		}else if(boardType==2) {
			model.addAttribute("headerText", "1대1 문의");
		}else if(boardType==3) {
			model.addAttribute("headerText", "소통게시판");
		}else {
			model.addAttribute("headerText", "이벤트");
		}
		return "addition/boardUpdateFrm";
	}

	// 글수정
	@RequestMapping(value = "/boardUpdate.do")
	public String boardUpdate(Board b, int status, String oldFilename, String oldFilepath,
		MultipartFile addFile, HttpServletRequest request, Model model) {
		if(status == 2) {//지웠을때
			if(!addFile.isEmpty()) { //새파일있을때
				String savePath = request.getSession().getServletContext().getRealPath("/resources/additionImage/");
				String filename = addFile.getOriginalFilename();
				String onlyFilename = filename.substring(0, filename.indexOf("."));
				String extention = filename.substring(filename.indexOf("."));
				String filepath = null;
				int count = 0;
				while(true) {
					if(count==0) {
						filepath = onlyFilename + extention;
					}else {
						filepath = onlyFilename+"_"+count+extention;
					}
					File checkFile = new File(savePath+filepath);
					if(!checkFile.exists()) {
						break;
					}
					count++;
				}
				
				try {
					FileOutputStream fos = new FileOutputStream(new File(savePath+filepath));
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					byte[] bytes = addFile.getBytes();
					bos.write(bytes);
					bos.close();
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				b.setFilename(filename);
				b.setFilepath(filepath);
			}
		}else {//안지웠을때 새파일있을때 새파일 없을때
			if(!addFile.isEmpty()) {
				String savePath = request.getSession().getServletContext().getRealPath("/resources/additionImage/");
				String filename = addFile.getOriginalFilename();
				String onlyFilename = filename.substring(0, filename.indexOf("."));
				String extention = filename.substring(filename.indexOf("."));
				String filepath = null;
				int count = 0;
				while(true) {
					if(count==0) {
						filepath = onlyFilename + extention;
					}else {
						filepath = onlyFilename+"_"+count+extention;
					}
					File checkFile = new File(savePath+filepath);
					if(!checkFile.exists()) {
						break;
					}
					count++;
				}
				
				try {
					FileOutputStream fos = new FileOutputStream(new File(savePath+filepath));
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					byte[] bytes = addFile.getBytes();
					bos.write(bytes);
					bos.close();
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				b.setFilename(filename);
				b.setFilepath(filepath);
			}else {
				b.setFilepath(oldFilepath);
				b.setFilename(oldFilename);
			}
		}
		int result = service.boardUpdate(b);
		if(result>0) {
			model.addAttribute("msg", "수정 성공");			
		}else {
			model.addAttribute("msg", "수정 실패");
		}
		if (b.getBoardType() == 2) {
			model.addAttribute("loc", "/boardView.do?boardType=2&boardNo=" + b.getBoardNo());
		} else if(b.getBoardType() == 1){
			model.addAttribute("loc", "/boardView.do?boardType=1&boardNo=" + b.getBoardNo());
		} else if(b.getBoardType()==3){
			model.addAttribute("loc", "/boardView.do?boardType=3&boardNo=" + b.getBoardNo());
		}else {
			model.addAttribute("loc", "/boardView.do?boardType=5&boardNo=" + b.getBoardNo());
		}
		return "common/msg";

	}
	
	
	//규제하기
	@RequestMapping(value = "/regulationBoard.do")
	public String updateBoardLevel(int boardNo,Model model) {
		int result = service.regulationBoard(boardNo);
		if(result>0) {
			model.addAttribute("msg", "규제성공");
		}else {
			model.addAttribute("msg", "규제실패");
		}
		model.addAttribute("loc", "/additionBoard.do?boardType=3&reqPage=1");
		return "common/msg";
	}
	
	//규제풀기
	@RequestMapping(value = "/removeRegulationBoard.do")
	public String removeRegulationBoard(int boardNo,Model model) {
		int result = service.removeRegulationBoard(boardNo);
		if(result>0) {
			model.addAttribute("msg", "해제성공");
		}else {
			model.addAttribute("msg", "해제실패");
		}
		model.addAttribute("loc", "/additionBoard.do?boardType=3&reqPage=1");
		return "common/msg";
	}
	
	//좋아요
	@ResponseBody
	@RequestMapping(value = "/boardLike.do")
	public String boardLike(int checkNum,int boardNo,String memberId) {
		int result = service.boardLike(checkNum,boardNo,memberId);
		if(result>0) {
			return "0";
		}else {
			return "1";
		}
	
	}
	
	//좋아요취소
	@ResponseBody
	@RequestMapping(value = "/boardDislike.do")
	public String boardDislike(int boardNo,String memberId) {
		int result = service.boardDislike(boardNo,memberId);
		if(result>0) {
			return "0";
		}else {
			return "1";
		}
	
	}
	
	//좋아요 수 불러오기
	@ResponseBody
	@RequestMapping(value = "/selectLikeSum.do",produces = "application/json;charset=utf-8")
	public String selectLikeSum(int boardNo) {
		LikeNo l = service.selectLikeSum(boardNo);
		if(l==null) {
			return "0";
		}else {
			return new Gson().toJson(l);
		}
	
	}
	
	//좋아요 확인
	@ResponseBody
	@RequestMapping(value = "/selectLikeChk.do",produces = "application/json;charset=utf-8")
	public String selectLikeChk(int boardNo,String memberId) {
		LikeNo chk = service.selectLikeChk(boardNo,memberId);
		if(chk==null) {
			return "0";
		}else {
			return new Gson().toJson(chk);
		}
	}
	
	//마이페이지
	@RequestMapping(value = "/myFree.do")
	public String myFree(String memberId,Model model) {
		MyPageData mpd=service.myFree(memberId);
		model.addAttribute("noticeList",mpd.getNoticeList());
		model.addAttribute("freeList",mpd.getFreeList());
		model.addAttribute("qnaList",mpd.getQnaList());
		model.addAttribute("commentList",mpd.getCommentList());
		model.addAttribute("headerText", "내가 쓴 글•댓글");
		return "addition/myFree";
	}
	

}
