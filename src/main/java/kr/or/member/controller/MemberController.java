package kr.or.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.academy.service.AcademyService;
import kr.or.academy.vo.Academy;
import kr.or.addition.model.service.AdditionService;
import kr.or.addition.model.vo.Board;
import kr.or.addition.model.vo.BoardPageData;
import kr.or.exhibition.service.ExhibitionService;
import kr.or.exhibition.vo.Exhibition;
import kr.or.member.service.MemberService;
import kr.or.member.service.SendMail;
import kr.or.member.vo.DeleteMember;
import kr.or.member.vo.Member;
import kr.or.member.vo.MemberPage;
import kr.or.reading.model.service.ReadingService;
import kr.or.requrit.service.RequritService;
import kr.or.requrit.vo.Requrit;
import kr.or.requrit.vo.RequritPageData;
import kr.or.space.model.service.SpaceService;
import show.service.ShowService;
import show.vo.Show;

@Controller
public class MemberController {
	
	@Autowired//스프링이 서버 시작시 자동으로 생성한 객체중 아래 변수와 일치하는 데이터타입의 객체를 찾다서 변수에 저장 의존성 주입(DI)
	private MemberService service;
	@Autowired
	private SendMail sendMailservice;
	@Autowired
	private ReadingService readingservice;
	@Autowired
	private ShowService showservice;
	@Autowired
	private ExhibitionService exhibitionService;
	@Autowired
	private AcademyService academyService;
	@Autowired
	private SpaceService spaceService;
	@Autowired
	private AdditionService additionService;
	@Autowired
	private RequritService requritservice;

	
	public MemberController() {
		super();
		System.out.println("객체 생성");
	}
	@RequestMapping(value="/main.do")
	public String main(Model model,HttpSession session) {
		ArrayList<Show> showlist = showservice.selectShowList();
		model.addAttribute("showlist", showlist);
		ArrayList<Exhibition> artlist1 = exhibitionService.selectExhibitionList(4);
		ArrayList<Exhibition> artlist2 = exhibitionService.selectExhibitionList(8);
		ArrayList<Exhibition> artlist3 = exhibitionService.selectExhibitionList(12);
		ArrayList<Exhibition> artlist = new ArrayList<Exhibition>();
		artlist.addAll(artlist1);
		artlist.addAll(artlist2);
		artlist.addAll(artlist3);
		model.addAttribute("artlist", artlist);
		ArrayList<Academy>  academy =  academyService.selectAcademyList(4,"all");
		model.addAttribute("academy",academy);
		RequritPageData rpd = requritservice.selectRequritPageData(1);
		model.addAttribute("requrit",rpd.getList());
		return "common/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeBoard.do",produces = "application/json;charset=utf-8;")
	public String noticeBoard() {
		BoardPageData bpd = additionService.selectNoticeList(1, 1);
		return new Gson().toJson(bpd.getList());
	}
	@RequestMapping(value="/loginFrm.do")
	public String loginFrm(Model model) {
		model.addAttribute("headerText", "로그인");
		return "member/login";
	}
	@RequestMapping(value="/mypage.do")
	public String mypage(Model model) {
		model.addAttribute("headerText", "마이페이지");
		model.addAttribute("selectmenu",5);
		return "member/mypage";
	}
	@RequestMapping(value="/adminpage.do")
	public String adminpage() {
		return "common/adminpage";
	}
	@RequestMapping(value="/login.do")
	public String login(Member member, HttpSession session, Model model ) {
		Member m = service.selectOneMemberPw(member);
		if(m != null) {
			session.setAttribute("m", m);
			model.addAttribute("msg","로그인성공");
		}else {
			model.addAttribute("msg","아이디 또는 비밀번호를 확인 하세요");
		}
		model.addAttribute("loc","/");
		return "common/msg";
	}
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping(value="/joinFrm.do")
	public String joinFrm(Model model) {
		model.addAttribute("headerText", "회원가입");
		return "member/joinFrm";
	}
	@RequestMapping(value="/join.do")
	public String join(Member m,String email1, String email2, String memberPhone1,String memberPhone2,String memberPhone3,Model model) {
		String email = email1+"@"+email2;
		String phone = memberPhone1+"-"+memberPhone2+"-"+memberPhone3;
		m.setMemberPhone(phone);
		m.setMemberEmail(email);
		int result = service.insertMemberPw(m);
		if(result>0) {
			model.addAttribute("msg","회원가입성공");
			model.addAttribute("loc","/");
		}else {
			model.addAttribute("msg","회원가입실패");
			model.addAttribute("loc","/joinFrm.do");
		}
		return "common/msg";
	}
	@RequestMapping(value="/idCheck.do")
	@ResponseBody
	public int idchk(String memberId) {
		Member m = service.selectOneMemberId(memberId);
		if(m == null) {
			return 0;
		}else {
			return 1;
		}
	}
	
	@RequestMapping(value="/pwCheck.do")
	public String pwchk(Member member, Model model) {
		Member m = service.selectOneMemberPw(member);
		if(m != null) {
			String memberEmail = m.getMemberEmail();
			String[] email = memberEmail.split("@");
			System.out.println(email);
			model.addAttribute("email1",email[0]);
			model.addAttribute("email2",email[1]);
			model.addAttribute("selectmenu",5);
			model.addAttribute("headerText", "개인정보관리");
			return "member/memberUpdate";
		}else {
			model.addAttribute("headerText", "개인정보관리");
			model.addAttribute("msg","비밀번호를 확인 하세요");
			model.addAttribute("loc","/");
			return "common/msg";
		}
		
	}
	
	@RequestMapping(value="/ajaxEmailCheck.do")
	@ResponseBody
	public int ajaxEmailCheck(String memberEmail) {
		Member m = service.selectOneMemberEmail(memberEmail);
		System.out.println(memberEmail);
		if(m == null) {
			return 0;
		}else {
			return 1;
		}
	}
	
	@RequestMapping(value="/sendMail.do")
	@ResponseBody
	public String sendMail(String email,Model model ) {
		String result = sendMailservice.mailSend(email);
		return result;
	}
	
	@RequestMapping(value="/memberUpdate.do")
		public String updateMember(Member member,Model model,String email1, String email2) {
			//앞에서 받아오는값
			String memberEmail = email1+"@"+email2;
			member.setMemberEmail(memberEmail); 
			int result = service.updateMember(member);
			//데이터를 불러오는값
			if(result>0) {
				model.addAttribute("msg","정보변경 성공");
			}else {
				model.addAttribute("msg","정보변경 실패");
			}
			model.addAttribute("loc","/");
			return "common/msg";
		}
	@RequestMapping(value="/searchidpw.do")
	public String searchidpw(Member member,Model model) {
		System.out.println(member);
	int result = service.searchidPw(member);
	if(result>0) {
		model.addAttribute("msg","정보변경 성공");
	}else {
		model.addAttribute("msg","정보변경 실패");
	}
	model.addAttribute("loc", "/");
	return "common/msg";
}
	@RequestMapping(value="/searchId.do")
	@ResponseBody
	public String searchId(Member member,Model model) {
		Member m = service.searchId(member);
		
		String memberId = m.getMemberId();
		return memberId;
	}		
	@RequestMapping(value="/updateMemberlist.do")
	@ResponseBody
	public int updateMemberLevel(Member member) {
		int result = service.updateMemberLevel(member);
		return result;
	}
	
	@RequestMapping(value="/allMember.do")
	public String allMember(int reqPage, Model model) {
		MemberPage mpg = service.selectAllMember(reqPage);
		model.addAttribute("totalCount", mpg.getTotalCount());
		model.addAttribute("list",mpg.getList());
		model.addAttribute("selectmenu",5);
		model.addAttribute("pageNavi", mpg.getPageNavi());
		model.addAttribute("start", mpg.getStart());
		return "member/AllMember";
	}
	@RequestMapping(value = "/searchMember.do")
	public String searchMember(int[] memberLevel, String search, Model model, int reqPage) {
		MemberPage mpg = service.searchMember(search, memberLevel, reqPage);

		model.addAttribute("totalCount", mpg.getTotalCount());
		model.addAttribute("pageNavi", mpg.getPageNavi());
		model.addAttribute("list", mpg.getList());
		model.addAttribute("search", search);
		model.addAttribute("start", mpg.getStart());
		if (memberLevel != null) {
			for (int i = 0; i < memberLevel.length; i++) {
				model.addAttribute("memberLevel" + memberLevel[i], 0);
			}
		}

		System.out.println("reqPage : " + reqPage);
		System.out.println("memberLevel : " + memberLevel);
		System.out.println("search : " + search);
		return "member/AllMember";
	}

	@RequestMapping(value = "/deleteMemberFrm.do")
	public String deleteMemberFrm(int memberNo, Model model) {
		ArrayList<DeleteMember> list = service.deleteMemberFrm(memberNo);
		model.addAttribute("list", list);
		model.addAttribute("count", list.size());
		System.out.println(list);
		return "member/deleteMember";
	}

	@RequestMapping(value = "/deletemShow.do")
	@ResponseBody
	public int deletmShow(int reserveNo, Model model) {
		System.out.println(reserveNo);
		int result = showservice.deleteReserv(reserveNo);
		return result;
	}

	@RequestMapping(value = "/deletemSpace.do")
	@ResponseBody
	public int deletmSpace(int reserveNo, Model model) {
		System.out.println(reserveNo);
		int result = spaceService.deleteRental(reserveNo);
		return result;
	}

	@RequestMapping(value = "/deletemRead.do")
	@ResponseBody
	public int deletemRead(int reserveNo, Model model) {
		int result = readingservice.deleteRead(reserveNo);
		return result;
	}

	@RequestMapping(value = "/deletemAcademy.do")
	@ResponseBody
	public int deletemAcademy(int reserveNo, Model model) {
		System.out.println(reserveNo);
		int result = exhibitionService.realDelete(reserveNo);
		return result;
	}

	@RequestMapping(value = "/deletemExhibition.do")
	@ResponseBody
	public int deletemExhibition(int reserveNo, Model model) {
		System.out.println(reserveNo);
		int result = exhibitionService.realDelete(reserveNo);
		return result;
	}
	
	@RequestMapping(value="/deleteMember.do")
	public String deleteMember(int memberNo,HttpSession session,Model model) {
		int result = service.deleteMember(memberNo);
		if(result>0) {
			model.addAttribute("msg", "삭제성공");			
			session.invalidate();
		}else {
			model.addAttribute("msg", "삭제실패");
		}
		model.addAttribute("loc","/");
		return "common/msg";
	}
	@RequestMapping(value="/updatePassword.do")
	public String updatePassword(Member m,Model model) {
		System.out.println(m);
		int result = service.updatePasswordPw(m);
		if(result>0) {
			model.addAttribute("msg","정보변경 성공");
		}else {
			model.addAttribute("msg","정보변경 실패");
		}
		return "member/mypage";
	}
	
	
}
	
	
	
	
	
	
	
	


