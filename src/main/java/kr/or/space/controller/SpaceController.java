package kr.or.space.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

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

import kr.or.academy.vo.Academy;
import kr.or.member.service.MemberService;
import kr.or.member.vo.Member;
import kr.or.space.model.service.MailSend;
import kr.or.space.model.service.SpaceService;
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

@Controller
public class SpaceController {
	@Autowired
	private SpaceService service;
	@Autowired
	private MailSend mailService;

	@RequestMapping(value = "/test.do")
	public String test() {
		return "space/test";
	}

	// 공간메인 이동
	@RequestMapping(value = "/spaceMain.do")
	public String spaceMain(Model model) {
		model.addAttribute("headerText", "공간 · 대관"); 
		ArrayList<Space> list = service.selectAllSpace();
		ArrayList<FileVO> fList = service.selectFile();
		model.addAttribute("list", list);
		model.addAttribute("fList", fList);
		return "space/spaceMain";
	}

	// 공간 전체 조회
	@RequestMapping(value = "/spaceList.do")
	public String spaceList(Model model) {
		model.addAttribute("headerText", "공간 소개"); 
		ArrayList<Space> spaceList = service.selectAllSpace();
		ArrayList<FileVO> fileList = service.selectFile();
		model.addAttribute("spaceList", spaceList);
		model.addAttribute("fileList", fileList);
		return "space/spaceList";
	}

	// 공간 등록페이지로 이동
	@RequestMapping(value = "/spaceInsertFrm.do")
	public String spaceInsertFrm(Model model) {
		return "space/spaceInsert";
	}

	// 공간 수정 페이지로 이동
	@RequestMapping(value = "/spaceUpdate.do")
	public String spaceUpdate(int spaceNo, Model model) {
		Space space = service.selectOneSpace(spaceNo);
		ArrayList<FileVO> fv = service.selectSpaceFile(spaceNo);
		FileVO t = service.selectThumbnail(spaceNo);
		ArrayList<SpaceTime> st = service.selectSpaceTime(spaceNo);
		model.addAttribute("s", space);
		model.addAttribute("fv", fv);
		model.addAttribute("t", t);
		model.addAttribute("st", st);
		return "space/spaceUpdateFrm";
	}

	// 신청 현황 페이지로 이동
	@RequestMapping(value = "/spaceRes.do")
	public String spaceRes(int spaceNo, Model model, @SessionAttribute(required = false) Member m) {
		model.addAttribute("headerText", "신청 현황"); 
		ArrayList<Space> list = service.selectAllSpace();
		if(spaceNo == 0) {
			spaceNo = list.get(0).getSpaceNo();
		}
		Space s = service.selectOneSpace(spaceNo);
		ArrayList<SpaceTime> st = service.selectSpaceTime(spaceNo);
		ArrayList<FileVO> fv = service.selectFileList(spaceNo);
		
		//세션이 로그인 되지 않으면 false
		int blackCount  = 0;
		if(m!=null) {
			blackCount = service.selectBalckCount(m.getMemberId());
		}
		/* blackCount = m==null?0:service.selectBalckCount(m.getMemberId()); */
		model.addAttribute("list", list);
		model.addAttribute("s", s);
		model.addAttribute("st", st);
		model.addAttribute("fv", fv);
		model.addAttribute("blackCount", blackCount);
		return "space/spaceRes";
	}

	// 공간 등록
	@RequestMapping(value = "/spaceInsert.do")
	public String spaceInsert(Space s, MultipartFile[] files, int thumbnail, String[] startTime, String[] endTime,
			HttpServletRequest request, Model model) {
		ArrayList<FileVO> list = new ArrayList<FileVO>();
		ArrayList<SpaceTime> stList = new ArrayList<SpaceTime>();
		if (files[0].isEmpty()) {
		} else {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/spaceImage/upload/");
			for (MultipartFile file : files) {
				String filename = file.getOriginalFilename();
				String onlyFilename = filename.substring(0, filename.indexOf("."));
				String extention = filename.substring(filename.indexOf("."));
				String filepath = null;
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
				FileVO fv = new FileVO();
				fv.setFilename(filename);
				fv.setFilepath(filepath);

				list.add(fv);

			}
		}
		list.get(thumbnail).setThumbnail("Y");
		// 시간 셋팅
		for (int i = 0; i < startTime.length; i++) {
			SpaceTime st = new SpaceTime();
			st.setStartTime(startTime[i]);
			st.setEndTime(endTime[i]);
			stList.add(st);
		}
		int result = service.insertSpace(s, list, stList);
		if (result == -1 || result != list.size()) {
			model.addAttribute("msg", "등록실패");
		} else {
			model.addAttribute("msg", "등록성공");
		}
		model.addAttribute("loc", "/");
		return "common/msg";

	}
	// 공간 수정
	@RequestMapping(value = "/updateSpace.do")
	public String spaceUpdate(Space s, MultipartFile[] files, int thumbnail,int[] stNo, String[] startTime, String[] endTime,
			HttpServletRequest request, Model model) {
		ArrayList<FileVO> list = new ArrayList<FileVO>();
		ArrayList<SpaceTime> stList = new ArrayList<SpaceTime>();
		if (files[0].isEmpty()) {
		} else {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/spaceImage/upload/");
			for (MultipartFile file : files) {
				String filename = file.getOriginalFilename();
				String onlyFilename = filename.substring(0, filename.indexOf("."));
				String extention = filename.substring(filename.indexOf("."));
				String filepath = null;
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
				FileVO fv = new FileVO();
				fv.setFilename(filename);
				fv.setFilepath(filepath);
				
				list.add(fv);
				
			}
		}
		list.get(thumbnail).setThumbnail("Y");
		// 시간 셋팅
		for (int i = 0; i < startTime.length; i++) {
			SpaceTime st = new SpaceTime();
			st.setStartTime(startTime[i]);
			st.setEndTime(endTime[i]);
			st.setStNo(stNo[i]);
			stList.add(st);
		}
		int result = service.updateSpace(s, list, stList);
		if (result == -1 || result != list.size()) {
			model.addAttribute("msg", "수정 실패");
		} else {
			model.addAttribute("msg", "수정 성공");
		}
		model.addAttribute("loc", "/");
		return "common/msg";
		
	}

	// 공간 삭제
	@RequestMapping(value = "/spaceDelete.do")
	public String spaceDelete(int spaceNo, Model model) {
		int result = service.deleteSpace(spaceNo);
		if (result > 0) {
			model.addAttribute("msg", "삭제 한 공간은 관리자 페이지에서 찾을 수 있습니다.");
		} else {
			model.addAttribute("msg", "삭제를 실패하였습니다.");
		}
		model.addAttribute("loc", "/spaceAdmin.do?selectmenu=3&reqPage=1");
		return "common/msg";
	}

	// 공간 예약
	@RequestMapping(value = "/spaceInfo.do")
	public String spaceInfo(int spaceNo, int stNo, String rentalDate, Model model) {
		model.addAttribute("headerText", "공간 예약"); 
		Space s = service.selectOneSpace(spaceNo);
		ArrayList<FileVO> fv = service.selectFileList(spaceNo);
		SpaceTime st = service.selectOneTime(stNo);
		model.addAttribute("st", st);
		model.addAttribute("s", s);
		model.addAttribute("rentalDate", rentalDate);
		model.addAttribute("fv", fv);
		return "space/spaceInfo";
	}
	//공간 상세보기
	@RequestMapping(value = "/spaceView.do")
	public String spaceView(int spaceNo,Model model, int reqPage) {
		Space s = service.selectOneSpace(spaceNo);
		ArrayList<FileVO> fv = service.selectFileList(spaceNo);
		ArrayList<SpaceReview> list = service.selectSpaceReviewList(spaceNo, reqPage);
		int totalCount = service.selectTotalReviewCount(spaceNo);
		int count = list.size();
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("count", count);
		model.addAttribute("s", s);
		model.addAttribute("fv", fv);
		model.addAttribute("srList", list);
		return "space/spaceView";
	}
	
	//더보기
	@ResponseBody
	@RequestMapping(value ="/moreSpaceReview.do",produces = "application/json;charset=utf-8")
	public String moreSpaceReview(int start, int spaceNo) {
		//아작스 data start 값 strat 받아옴
		ArrayList<SpaceReview> list = service.moreSpaceReview(start,spaceNo);
		return new Gson().toJson(list);
	}

	// 대관
	@ResponseBody
	@RequestMapping(value = "/spaceRental.do", produces = "application/json;charset=utf-8")
	public String spaceRental(Model model, Rental r) {
		int result = service.insertRental(r);
		return new Gson().toJson(result);
	}

	// 관리자페이지 - 예약 관리
	@RequestMapping(value = "/spaceAdmin.do")
	public String spaceAdmin(Model model, int reqPage) {
		SpacePageNavi spn = service.selectAllRental(reqPage);
		ArrayList<Space> space = service.selectNoDelSpace();
		ArrayList<Space> delSpace = service.selectDelSpace();
		ArrayList<Black> black = service.selectDelBlack();
		model.addAttribute("list", spn.getRList());
		model.addAttribute("pageNavi", spn.getPageNavi());
		model.addAttribute("start", spn.getStart());
		model.addAttribute("space", space);
		model.addAttribute("delSpace", delSpace);
		model.addAttribute("black", black);
		model.addAttribute("selectmenu",3);
		return "space/spaceAdmin";
	}

	// 마이페이지- 예약내역 관리
	@RequestMapping(value = "/spaceMypage.do")
	public String spaceMypage(String memberId, Model model, String ub) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		if(ub == null) {
			map.put("ub", "");
		}else {
			map.put("ub", ub);
		}
		ArrayList<SpaceMypage> list = service.selectSpaceMypage(map);
		model.addAttribute("list", list);
		model.addAttribute("selectmenu",3);
		return "space/spaceMypage";
	}

	// 대관 확정 메일 보내기
	@RequestMapping(value = "/mailSend.do")
	public String mailSend(String memberId, int rentalNo, Model model) {
		int reqPage = 1;
		String email = service.selectEmail(memberId);
		String result = mailService.mailSend(email);
		int result1 = service.updateRentalStatus(rentalNo);
		if (result1 > 0) {
			SpacePageNavi spn = service.selectAllRental(reqPage);
			model.addAttribute("list", spn.getRList());
			model.addAttribute("pageNavi", spn.getPageNavi());
			model.addAttribute("start", spn.getStart());
			return "redirect:/spaceAdmin.do?selectmenu=3&reqPage=1";
		} else {
			model.addAttribute("msg", "메일 발송에 실패하였습니다.");
			model.addAttribute("loc", "/");
			return "common/msg";
		}
	}

	// 예약 된 시간 리스트 ajax
	@ResponseBody
	@RequestMapping(value = "/selectResList.do", produces = "application/json;charset=utf-8")
	public String selectResList(String selectDate, int spaceNo, Model model) {
		ArrayList<ResSpace> list = service.selectResList(selectDate, spaceNo);
		return new Gson().toJson(list);
	}

	// 사용게시판 이동
	@RequestMapping(value = "/selectSpaceBoardList.do")
	public String selectSpaceBoardList(Model model, int reqPage) {
		model.addAttribute("headerText", "사용 게시판"); 
		SpacePageNavi page = service.selectSpacePageNavi(reqPage);
		model.addAttribute("list", page.getList());
		model.addAttribute("pageNavi", page.getPageNavi());
		model.addAttribute("start", page.getStart());
		return "space/spaceBoardList";
	}

	// 시용게시판 작성할 대관 선택
	@ResponseBody
	@RequestMapping(value = "/selectSpaceBoard.do", produces = "application/json;charset=utf-8")
	public String selectBoardList(Model model, String memberId) {
		ArrayList<Rental> rList = service.selectRentalList(memberId);
		return new Gson().toJson(rList);
	}
	// 시용게시판 작성 폼
	@RequestMapping(value = "/writeSpaceBoard.do")
	public String writeBoardList(Model model, int rentalNo) {
		Rental r = service.selectRentalNo(rentalNo);
		model.addAttribute("r", r);
		return "space/writeBoardFrm";
	}
	//사용 게시판 작성
	@RequestMapping(value = "/writeBoard.do")
	public String writeBoard(HttpServletRequest request, UseBoard ub, Model model, MultipartFile upfile) {
		if(!upfile.isEmpty()) {
		String savePath = request.getSession().getServletContext().getRealPath("/resources/useBoardFile/upload/");
			String filename = upfile.getOriginalFilename();
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
				byte[] bytes = upfile.getBytes();
				bos.write(bytes);
				bos.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ub.setFilename(filename);
			ub.setFilepath(filepath);
			System.out.println(savePath+filepath);
		}
		/*
		 * if(upfile != null) { String savePath =
		 * request.getSession().getServletContext().getRealPath(
		 * "/resources/useBoardFile/upload/");
		 * 
		 * String filename = upfile.getOriginalFilename(); String onlyFilename =
		 * filename.substring(0, filename.indexOf(".")); String extention =
		 * filename.substring(filename.indexOf("."));
		 * 
		 * String filepath = null; int count = 0; while(true) { if(count==0) { filepath
		 * = onlyFilename + extention; }else { filepath =
		 * onlyFilename+"_"+count+extention; } File checkFile = new
		 * File(savePath+filepath); if(!checkFile.exists()) { break; } count++; } try {
		 * FileOutputStream fos = new FileOutputStream(new File(savePath+filepath));
		 * BufferedOutputStream bos = new BufferedOutputStream(fos); byte[] bytes =
		 * upfile.getBytes(); bos.write(bytes); bos.close(); } catch
		 * (FileNotFoundException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); } catch (IOException e) { // TODO Auto-generated catch
		 * block e.printStackTrace(); } ub.setFilepath(filepath);
		 * ub.setFilename(filename); }
		 */
		int result = service.insertUseBoard(ub);
		if(result>0) {
			model.addAttribute("msg", "등록 성공");			
		}else {
			model.addAttribute("msg", "등록 실패");
		}
		model.addAttribute("loc", "/selectSpaceBoardList.do?reqPage=1");
		return "common/msg";
	}
	//사용게시판 상세보기
	@RequestMapping(value = "/useBoardView.do")
	public String useBoardView(int ubNo, Model model) {
		UseBoard u = service.selectOneBoardView(ubNo);
		model.addAttribute("u", u);
		return "space/useBoardView";
	}
	//사용게시판 삭제
	@RequestMapping(value = "/deleteUseBoard.do")
	public String deleteUseBoard(Model model, int ubNo) {
		int result = service.deleteUseBoard(ubNo);
		if(result >0) {
			model.addAttribute("msg", "삭제 성공");
		}else {
			model.addAttribute("msg", "삭제 실패");
		}
		model.addAttribute("loc", "/selectSpaceBoardList.do?reqPage=1");
		return "common/msg";
	}
	//시용게시판 수정 폼
	@RequestMapping(value = "/updateUseBoardFrm.do")
	public String updateUseBoardFrm(Model model, int ubNo) {
		UseBoard u = service.selectOneBoardView(ubNo);
		model.addAttribute("u", u);
		return "space/updateUseBoardFrm";
	}
	//사용게시판 수정
	@RequestMapping(value = "/updateUseBoard.do")
	public String updateUseBoard(HttpServletRequest request, UseBoard ub, Model model, MultipartFile upfile) {
		if(upfile != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/useBoardFile/upload/");
			
			String filename = upfile.getOriginalFilename();
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
				byte[] bytes = upfile.getBytes();
				bos.write(bytes);
				bos.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ub.setFilepath(filepath);
			ub.setFilename(filename);
		}
		int result = service.updateUseBoard(ub);
		if(result >0) {
			model.addAttribute("msg", "수정 성공");
		}else {
			model.addAttribute("msg", "수정 실패");
		}
		model.addAttribute("loc", "/useBoardView.do?ubNo="+ub.getUbNo());
		return "common/msg";
	}
	//파일 다운로드
	@RequestMapping(value = "/spaceFileDown.do")
	//페이지 이동 x -> public void
	public void spaceFileDown(int ubNo, Model model,HttpServletRequest request, HttpServletResponse response) throws IOException {
		UseBoard u = service.selectOneBoardView(ubNo);
		String root = request.getSession().getServletContext().getRealPath("/resources/useBoardFile/upload/");
		String file = root+u.getFilepath();
		//서버의 물리공간에서 서블릿으로 파일을 읽어오는 객체
		FileInputStream fis = new FileInputStream(file);
		//파일을 읽어오는 속도를 개선하기위한 보조 스트림
		BufferedInputStream bis = new BufferedInputStream(fis);
		
		//클라이언트로 파일을 보내주는 객체
		ServletOutputStream sos = response.getOutputStream();
		//파일 전송 속도를 개선하기위한 보조 스트림
		BufferedOutputStream bos = new BufferedOutputStream(sos);
		
		//브라우저에 따른 이름 처리
		String resFilename = "";	//최종 다운로드할 파일 이름
		//브라우저가 IE확인
		boolean bool = request.getHeader("user-agent").indexOf("MSIE")!=-1 ||
				       request.getHeader("user-agent").indexOf("Trident") != -1;
		if(bool) {//브라우저가 IE인 경우
			resFilename = URLEncoder.encode(u.getFilename(),"utf-8");
			resFilename = resFilename.replace("\\\\", "20%");
		}else {//그 외 다른 브라우저 인 경우
			resFilename = new String(u.getFilename().getBytes("UTF-8"),"ISO-8859-1");
		}
		//파일 다운로드를 위한 HTTP header설정(사용자 브라우저에 파일다운로드임을 선언)
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename="+resFilename);
		
		//파일 전송
		while(true) {
			int read = bis.read();
			if(read != -1) {
				bos.write(read);
			}else {
				break;
			}
		}
	}
	//리뷰 모달 창 열기 
	@ResponseBody
	@RequestMapping(value = "/selectRentalInfo.do", produces = "application/json;charset=utf-8")
	public String selectRentalInfo(int rentalNo) {
		Rental r = service.selectRentalInfo(rentalNo);
		return new Gson().toJson(r);
	}
	//리뷰 등록
	@RequestMapping(value = "/insertSpaceReview.do")
	public String insertSpaceReview(SpaceReview sr, Model model) {
		int result = service.insertReview(sr);
		if(result>0) {
			model.addAttribute("msg", "등록 성공");
		}else {
			model.addAttribute("msg", "등록 실패");
		}
		model.addAttribute("loc", "/spaceMypage.do?memberId="+sr.getMemberId());
		return "common/msg";
	}
	//리뷰수정 모달 창 열기 
	@ResponseBody
	@RequestMapping(value = "/selectReviewInfo.do", produces = "application/json;charset=utf-8")
	public String selectReviewInfo(int rentalNo) {
		SpaceReview s = service.selectReviewInfo(rentalNo);
		return new Gson().toJson(s);
	}
	//리뷰 수정
	@RequestMapping(value = "/updateSpaceReview.do")
	public String updateSpaceReview(SpaceReview sr, Model model) {
		int result = service.updatetReview(sr);
		if(result>0) {
			model.addAttribute("msg", "수정 성공");
		}else {
			model.addAttribute("msg", "수정 실패");
		}
		model.addAttribute("loc", "/spaceMypage.do?memberId="+sr.getMemberId());
		return "common/msg";
	}
	//리뷰 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteSpaceReview.do", produces = "application/json;charset=utf-8")
	public String deleteReview(int rentalNo) {
		int result = service.deleteReview(rentalNo);
		return new Gson().toJson(result);
	}
	//공간 완전 삭제
	@ResponseBody
	@RequestMapping(value = "/realDeleteSpace.do", produces = "application/json;charset=utf-8")
	public String realDeleteSpace(int spaceNo) {
		int result = service.realDeleteSpace(spaceNo);
		return new Gson().toJson(result);
	}
	//마이페이지 조회 아작스 (다른 페이지에 로드)
	@RequestMapping(value = "/spaceMypageAjax.do")
	public String spaceMypageAjax(String memberId, Model model, String ub) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("ub", ub);
		ArrayList<SpaceMypage> list = service.selectSpaceMypage(map);
		model.addAttribute("list", list);
		return "space/testt";
	}
	//공간 복구
	@RequestMapping(value = "/spaceRestore.do")
	public String spaceRestore(int spaceNo) {
		int result = service.spaceRestore(spaceNo);
		return "redirect:/spaceAdmin.do?selectmenu=3&reqPage=1";
	}
	/*
	  //마이페이지 조회 아작스
	  @ResponseBody
	  @RequestMapping(value = "/spaceMypageAjax.do", produces =
	  "application/json;charset=utf-8") public String spaceMypageAjax(String
	  memberId, Model model, String ub) { HashMap<String, Object> map = new
	 HashMap<String, Object>(); map.put("memberId", memberId); map.put("ub", ub);
	  ArrayList<SpaceMypage> list = service.selectSpaceMypage(map); return new
	  Gson().toJson(list); }
	 */	
	//예약 취소
	@RequestMapping(value = "/deleteRes.do")
	public String deleteRes(int rentalNo, Model model, String memberId ) {
		int result = service.deleteRental(rentalNo);
		if(result > 0) {
			model.addAttribute("msg", "예약을 취소하였습니다.");
		}else {
			model.addAttribute("msg", "다시 시도 해주십시오.");
		}
		model.addAttribute("loc", "/spaceMypage.do?memberId="+memberId);
		return "common/msg";
	}

}

