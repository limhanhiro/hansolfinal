package kr.or.exhibition.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.academy.vo.Academy;
import kr.or.exhibition.service.ExhibitionService;
import kr.or.exhibition.service.TicketMailSend;
import kr.or.exhibition.vo.Exhibition;
import kr.or.exhibition.vo.ExhibitionPayment;
import kr.or.exhibition.vo.ExhibitionPaymentMypage;
import kr.or.exhibition.vo.ExhibitionRefund;
import kr.or.exhibition.vo.ExhibitionReview;
import kr.or.space.model.service.MailSend;
import kr.or.space.model.vo.SpacePageNavi;

@Controller
public class ExhibitionController {
	@Autowired
	private ExhibitionService service;
	@Autowired
	private TicketMailSend ticketMailService;
	//전시등록 폼
	@RequestMapping(value="/exhibitionFrm.do")
	public String exhibitionFrm(Model model) {
		model.addAttribute("headerText", "전시 등록");
		return "exhibition/exhibitionInsert";
	}
	//전시 뷰
	@RequestMapping(value="/exhibitionView.do")
	public String exhibitionView(int exhibitionNo, Model model) {
		Exhibition exb = service.selectOneExhibition(exhibitionNo);
		ArrayList<ExhibitionReview> list = service.selectListExReview(exhibitionNo);
		ArrayList<ExhibitionPayment> payment = service.paymentList(exhibitionNo);
		model.addAttribute("exb",exb);
		model.addAttribute("list",list);
		model.addAttribute("payment",payment);
		model.addAttribute("headerText", exb.getExhibitionTitle());
		return "exhibition/exhibitionView";
	}
	//전시 결제 페이지로 이동
		@RequestMapping(value="/exhibitionPaymentFrm.do")
		public String exhibitionpaymentFrm(ExhibitionPayment exbp,Model model) {
			model.addAttribute("exbp",exbp);
			model.addAttribute("headerText", "전시 결제");
			return "exhibition/exhibitionPayment";
		}
	//전시 등록
	@RequestMapping(value="/exhibitionInsert.do")
	public String exhibitionInsert (Exhibition exb,MultipartFile upfile, HttpServletRequest request, Model model) {
		if(upfile != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/exhibitionImage/upload/");
			
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
			String exhibitionPhoto = "/resources/exhibitionImage/upload/"+filepath;
			exb.setExhibitionPhoto(exhibitionPhoto);
		}
		int result = service.exhibitionInsert(exb);
		if(result>0) {
			model.addAttribute("msg", "전시 등록 성공");			
		}else {
			model.addAttribute("msg", "전시 등록 실패");
		}
		model.addAttribute("loc", "/exhibitionList.do?reqPage=4");
		return "common/msg";
	}
	//전시 결제
	@ResponseBody
	@RequestMapping(value="exhibitionCredit.do",produces = "application/json;charset=utf-8")
	public String exhibitionCredit (ExhibitionPayment exbp) {
		int result = service.exhibitionCredit(exbp);
		return new Gson().toJson(result);
	}
	//전시 리스트 출력
	@RequestMapping(value="/exhibitionList.do")
	public String exhibitionList (Exhibition exb,Model model,int reqPage) {
		int totalCount = service.exhibitionTotal();
		ArrayList<Exhibition> list = service.selectExhibitionList(reqPage);
		int count = list.size();
		model.addAttribute("list",list);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("count",count);
		model.addAttribute("headerText", "전시 목록");
		return "exhibition/exhibitionList";
	}
	//더보기 버튼
	@ResponseBody
	@RequestMapping(value="moreExhibition.do",produces="application/json;charset=utf-8")
	public String moreExhibition(int start) {
		ArrayList<Exhibition> list = service.moreExhibition(start);
		return new Gson().toJson(list);
	}
	@ResponseBody
	@RequestMapping(value = "/uploadImageExhibition.do")
	public String uploadImage(MultipartFile file, HttpServletRequest request) {
		String filepath = null;
		if(file != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/exhibitionImage/editor/");
			
			String filename = file.getOriginalFilename();
			String onlyFilename = filename.substring(0, filename.indexOf("."));
			String extention = filename.substring(filename.indexOf("."));
			
			
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
		return "/resources/exhibitionImage/editor/"+filepath;
	}
	@RequestMapping(value = "/insertExReview.do")
	public String insertExReview(ExhibitionReview exr,Model model) {
		int result = service.insertExReview(exr);
		if(result>0) {
			model.addAttribute("msg", "등록 성공");			
		}else {
			model.addAttribute("msg", "등록 실패");
		}
		model.addAttribute("loc", "/exhibitionView.do?exhibitionNo="+exr.getExhibitionNo());
		return "common/msg";
	}
	@RequestMapping(value ="/deleteExReview.do")
	public String deleteExReview(ExhibitionReview exr,Model model) {
		int result = service.deleteExReview(exr);
		if(result>0) {
			model.addAttribute("msg", "등록 성공");			
		}else {
			model.addAttribute("msg", "등록 실패");
		}
		model.addAttribute("loc", "/exhibitionView.do?exhibitionNo="+exr.getExhibitionNo());
		return "common/msg";
	}
	@RequestMapping(value ="updateExReview.do")
	public String updateExReview(ExhibitionReview exr,Model model) {
		int result = service.updateExReview(exr);
		if(result>0) {
			model.addAttribute("msg", "수정 성공");			
		}else {
			model.addAttribute("msg", "수정 실패");
		}
		model.addAttribute("loc", "/exhibitionView.do?exhibitionNo="+exr.getExhibitionNo());
		return "common/msg";
	}
	@RequestMapping(value="/exhibitionUpdateFrm.do")
	public String exhibitionUpdateFrm (int exhibitionNo, Model model) {
		Exhibition ex = service.selectOneExhibition(exhibitionNo);
		model.addAttribute("ex",ex);
		model.addAttribute("headerText", "전시 수정");
		return "exhibition/exhibitionUpdateFrm";
	}
	@RequestMapping(value="/exhibitionUpdate.do")
	public String academyUpdate(Exhibition ex,MultipartFile upfile, HttpServletRequest request,Model model) {
		if(upfile.getSize() > 0) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/academyImage/upload/");
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
			String exhibitionPhoto = "/resources/academyImage/upload/"+filepath;
			ex.setExhibitionPhoto(exhibitionPhoto);
		}
		int result = service.exhibitionUpdate(ex);
		if(result>0) {
			model.addAttribute("msg", "전시 수정 성공");			
		}else {
			model.addAttribute("msg", "전시 수정 실패");
		}
		model.addAttribute("loc", "/exhibitionList.do?reqPage=4");
		return "common/msg";
	}
	//전시 관리자 페이지로 이동
	@RequestMapping(value="/exhibitionAdmin.do")
	public String exhibitionAdmin (Model model) {
		HashMap<String, Object> map  = service.selectExhibitionAdmin();
		model.addAttribute("list", map.get("list"));
		model.addAttribute("last", map.get("last"));
		model.addAttribute("cancel", map.get("cancel"));
		model.addAttribute("selectmenu",1);
		model.addAttribute("headerText", "전시 관리자 페이지");
		return "exhibition/exhibitionAdmin";
	}
	@ResponseBody
	@RequestMapping(value="/checkPaymentExhibition.do")
	public String checkTotalCount(String exhibitionDate, int exhibitionNo) {
		int totalCount = service.checkTotalCount(exhibitionDate,exhibitionNo);
		if(totalCount == 0) {
			return "0";
		}else {
			String count = Integer.toString(totalCount);
			return count;
		}
	}
	@RequestMapping(value="/exhibitionMypage.do")
	public String exhibitionMyPage(int memberNo,Model model) {
		HashMap<String, Object> map = service.selectExhibitionPaymentList(memberNo);
		model.addAttribute("list",map.get("list"));
		model.addAttribute("last",map.get("last"));
		model.addAttribute("selectmenu",1);
		model.addAttribute("totalCount",map.get("totalCount"));
		model.addAttribute("headerText", "전시 마이페이지");
		return "exhibition/exhibitionMypage";
	}
	
	@RequestMapping(value="/deletePayment.do")
	public String deletePayment(int memberNo, int paymentNo,Model model) {
		int result = service.deletePayment(paymentNo);
		if(result>0) {
			model.addAttribute("msg", "결제 취소 성공");			
		}else {
			model.addAttribute("msg", "결제 취소 실패");
		}
		model.addAttribute("loc", "/exhibitionMypage.do?memberNo="+memberNo);
		return "common/msg";
	}
	@RequestMapping(value="/sendEmailTicket.do")
	public String sendEmailTicket(int memberNo, int paymentNo,Model model) {
		ExhibitionPaymentMypage expm = service.selectOneExhibitionPayment(paymentNo);
		String memberEmail = service.selectEmail(memberNo);
		String result = ticketMailService.mailSend(expm,memberEmail);
		if(result.equals("ok")) {
			int result1 = service.updateEmailStatus(paymentNo);
			if (result1 > 0) {
				HashMap<String, Object> map = service.selectExhibitionPaymentList(memberNo);
				model.addAttribute("list",map.get("list"));
				model.addAttribute("last",map.get("last"));
				model.addAttribute("totalCount",map.get("totalCount"));
				return "exhibition/exhibitionMypage";
			} else {
				model.addAttribute("msg", "메일 발송에 실패하였습니다.");
				model.addAttribute("loc", "/exhibitionMypage.do?memberNo"+memberNo);
				return "common/msg";
			}
		}else {
			model.addAttribute("msg", "메일 발송에 실패하였습니다.");
			model.addAttribute("loc", "/exhibitionMypage.do?memberNo"+memberNo);
			return "common/msg";
		}
		
	}
	@RequestMapping(value="/deleteExhibition.do")
	public String deleteExhibition (int exhibitionNo,Model model) {
		int result = service.deleteExhibition(exhibitionNo);
			if(result>0) {
				model.addAttribute("msg", "전시 삭제 성공");			
			}else {
				model.addAttribute("msg", "전시 삭제 실패");
			}
			model.addAttribute("loc", "/exhibitionAdmin.do");
			return "common/msg";
	}
	@RequestMapping(value="/revivalExhibition.do")
	public String revivalExhibition(int exhibitionNo,Model model) {
		int result = service.revivalExhibition(exhibitionNo);
		if(result>0) {
			model.addAttribute("msg", "전시 소생 성공");			
		}else {
			model.addAttribute("msg", "전시 소생 실패");
		}
		model.addAttribute("loc", "/exhibitionAdmin.do");
		return "common/msg";
	}
	@ResponseBody
	@RequestMapping(value="/refundMemberView.do",produces="application/json;charset=utf-8")
	public String refundMemberView(int exhibitionNo) {
		ArrayList<ExhibitionRefund> list = service.refundMemberView(exhibitionNo);
		return new Gson().toJson(list);
	}
}
