package kr.or.reading.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.reading.model.service.ReadingService;
import kr.or.reading.model.vo.Fixtures;
import kr.or.reading.model.vo.Reading;
import kr.or.reading.model.vo.ReadingBlack;

@Controller
public class ReadingController {
	
	@Autowired
	private ReadingService service;
	
	@RequestMapping(value="/readingNotice.do")
	public String readingNotice(Model model) {
		model.addAttribute("headerText", "열람실 안내");
		return "reading/readingNotice";
	}
	
//	@RequestMapping(value="/readingList.do")
//	public String readingList(HttpSession session, String readingId, Model model) {
//		//안내->예약 넘어갈때
//		//로그인부터 확인
//		//넘어가기전에 블랙리스트에 등록되어있는지 확인
//		//등록되어있다면 alert으로 언제까지 블랙리스트인지 보여주고 메인으로
//		//등록되어있지 않다면 예약페이지로 넘어감
//		if(session.getAttribute("m")==null) {
//			model.addAttribute("msg","로그인이 필요한 서비스입니다.");
//			model.addAttribute("loc", "/loginFrm.do");
//			return "common/msg";		
//		}else {
//			ReadingBlack rb = service.selectOneBlackList(readingId);
//			if(rb==null) {
//				return "reading/readingList";
//			}else {
//				model.addAttribute("msg","당신은 "+rb.getBlackEnd()+"까지 열람실 예약을 이용할 수 없습니다.");
//				model.addAttribute("loc", "/");
//				return "common/msg";
//			}
//		}
//	}
	
	@RequestMapping(value="/readingSeat.do")
	public String readingSeat(HttpSession session, Reading re, Model model) {
		model.addAttribute("headerText", "좌석 선택");
		//날짜 넘겨줌
		if(session.getAttribute("m")==null) {
			model.addAttribute("msg","로그인이 필요한 서비스입니다.");
			model.addAttribute("loc", "/loginFrm.do");
			return "common/msg";		
		}else {
			ReadingBlack rb = service.selectOneBlackList(re.getReadingId());
			if(rb==null) {
				model.addAttribute("re", re);
				return "reading/readingSeat";
			}else {
				model.addAttribute("msg","당신은 "+rb.getBlackEnd()+"까지 열람실 예약을 이용할 수 없습니다.");
				model.addAttribute("loc", "/");
				return "common/msg";
			}
		}
	}
	
	@RequestMapping(value="/readingOption.do")
	public String readingOption(Reading re, Model model) {
		model.addAttribute("headerText", "예약 내역");
		//선 좌석조회 후 insert
		//같은날 같은 좌석 선택시 이선좌출력
		//선택사항은 update로 selectOneId
		Reading re1 = service.selectOneNum(re);
		Reading re2 = service.selectOneId(re);
		if(re1!=null) {
			model.addAttribute("msg","이미 선택된 좌석입니다.");
			model.addAttribute("loc", "/readingNotice.do");
		}else if(re2!=null){
			//좌석 선택으로 넘어갈때로 옮길예정
			//이 문구 뜨고 예매내역으로 이동예정
			model.addAttribute("msg",re.getReadingDay()+"일은 이미 예약하셨습니다.");
			model.addAttribute("loc", "/readingNotice.do");
		}else {
			int result = service.insertReading(re);
			if(result>0){
				Reading re3 = service.selectOneNum(re);
				model.addAttribute("re", re3);
				Fixtures fi = new Fixtures();
				fi.setFixturesNo(0);
				model.addAttribute("fi", fi);
				return "reading/readingOption";
				//model.addAttribute("msg",re.getReadingDay()+"일 "+re.getReadingNum()+"번 좌석을 예약하셨습니다.");
				//model.addAttribute("loc", "/readingOption.do");
			}else {
				model.addAttribute("msg","예약 오류. 다시 시도해주세요.");
				model.addAttribute("loc", "/readingNotice.do");
			}
		}
		return "common/msg";
	}
	
	@RequestMapping(value="/reservationDay.do")
	public String reservationDay(HttpSession session, Reading re, Model model) {
		model.addAttribute("headerText", "예약 내역 조회");
		if(session.getAttribute("m")==null) {
			model.addAttribute("msg","로그인이 필요한 서비스입니다.");
			model.addAttribute("loc", "/loginFrm.do");
			return "common/msg";		
		}else {
			model.addAttribute("re", re);
			return "reading/reservation";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/ajaxSearchReservation.do",produces = "application/json;charset=utf-8")
	public String ajaxSearchReservation(Reading re, Model model) {
		Reading re1 = service.selectOneId(re);
		return new Gson().toJson(re1);
	}
	
	@RequestMapping(value="/reservationInfo.do")
	public String reservationInfo(Reading re, Model model) {
		model.addAttribute("headerText", "예약 내역");
		Reading re1 = service.selectOneId(re);
		Fixtures fi = service.selectOneFixtures(re);
		model.addAttribute("re", re1);
		if(fi == null) {
			fi = new Fixtures();
			fi.setFixturesNo(0);
		}
		model.addAttribute("fi", fi);
		return "reading/readingOption";
	}
	
	@ResponseBody
	@RequestMapping(value="/reservationCancel.do",produces = "application/json;charset=utf-8")
	public String reservationCancel(Reading re, Model model) {
		int result=0;
		try {
			result = service.reservationCancel(re);
		} catch (Exception e) {
			return new Gson().toJson(0);
		}
		return new Gson().toJson(result);
	}
	
	@ResponseBody
	@RequestMapping(value="/countSeat.do",produces = "application/json;charset=utf-8")
	public String countSeat(String readingDay, Model model) {
		int result = service.countSeat(readingDay);
		return new Gson().toJson(result);
	}
	

	@ResponseBody
	@RequestMapping(value="/chkSeat.do",produces = "application/json;charset=utf-8")
	public String chkSeat(Reading re, Model model) {
		ArrayList<Integer> list = service.chkSeat(re);
		return new Gson().toJson(list);
	}
	
	@RequestMapping(value="/reservationToday.do")
	public String reservationToday(Model model) {
		model.addAttribute("headerText", "오늘 좌석 현황 보기");
		return "reading/reservationToday";
	}
	
	@RequestMapping(value="/readingAdmin.do")
	public String readingAdmin(Model model) {
		model.addAttribute("headerText", "열람실 관리");
		ArrayList<Reading> list = service.selectWeekReading();
		ArrayList<Reading> alllist = service.selectAllReading();
		ArrayList<ReadingBlack> black = service.selectReadingBlackList();
		ArrayList<Fixtures> fi = service.selectAllFixtures();
		model.addAttribute("list",list);
		model.addAttribute("alllist",alllist);
		model.addAttribute("black",black);
		model.addAttribute("fi",fi);
		model.addAttribute("selectmenu",4);
		return "reading/readingAdmin2";
	}
	
	@RequestMapping(value="/outAndBlackList.do")
	public String outAndBlackList(Reading re, Model model) {
		int result = service.outAndBlackList(re);
		if(result==-2) {
			model.addAttribute("msg","블랙리스트 처리가 실패하였습니다.");
			model.addAttribute("loc", "/readingAdmin.do");
			return "common/msg";
		}else if(result==-1) {
			model.addAttribute("msg","강제퇴실 처리가 실패하였습니다.");
			model.addAttribute("loc", "/readingAdmin.do");
			return "common/msg";
		}else {
			model.addAttribute("msg","강제퇴실 처리가 완료되었습니다.");
			model.addAttribute("loc", "/readingAdmin.do");
			return "common/msg";
		}
	}
	
	@RequestMapping(value="/earlyOut.do")
	public String earlyOut(Reading re, Model model) {
		int result = service.earlyOut(re);
		if(result>0) {
			model.addAttribute("msg","조기퇴실 처리가 완료되었습니다.");
			model.addAttribute("loc", "/readingAdmin.do");
			return "common/msg";
		}else {
			model.addAttribute("msg","조기퇴실 처리가 실패하였습니다.");
			model.addAttribute("loc", "/readingAdmin.do");
			return "common/msg";
		}
	}
	
	@RequestMapping(value="/readingMypage.do")
	public String readingMypage(String memberId, Model model) {
		model.addAttribute("headerText", "내 열람실 이용내역");
		ArrayList<Reading> mylist = service.selectMyReading(memberId);
		model.addAttribute("mylist", mylist);
		model.addAttribute("selectmenu",4);
		return "reading/readingMypage";
	}
	
	@RequestMapping(value="/fixturesInsert.do")
	public String fixtuersInsert(Fixtures fi, Model model) {
		int result = service.fixturesInsert(fi);
		if(result>0) {
			model.addAttribute("msg","비품 대여에 성공했습니다.");
			model.addAttribute("loc", "/reservationDay.do");
			return "common/msg";
		}else {
			model.addAttribute("msg","비품 대여에 실패하였습니다.");
			model.addAttribute("loc", "/reservationDay.do");
			return "common/msg";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/fixturesCancel.do",produces = "application/json;charset=utf-8")
	public String fixturesCancel(Reading re, Model model) {
		int result = service.fixturesCancel(re);
		return new Gson().toJson(result);
	}
}
