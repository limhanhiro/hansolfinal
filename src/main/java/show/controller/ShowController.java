package show.controller;

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

import show.service.ShowService;
import show.vo.Seat;
import show.vo.Show;
import show.vo.ShowAndReview;
import show.vo.ShowReserv;
import show.vo.ShowReview;

@Controller
public class ShowController {
	@Autowired
	private ShowService service;
	
	@RequestMapping(value = "/showList.do")
	public String showList(Model model) {
		ArrayList<Show> list = service.selectShowList();
		model.addAttribute("list", list);
		model.addAttribute("headerImg", "/resources/uplaod/mianimg.jpg");
		model.addAttribute("headerText", "공연일정");
		return "show/showList";
	}
	
	@RequestMapping(value = "/showView.do")
	public String showView(int showNo, Model model) {
		ShowAndReview snr = service.selectShowView(showNo);
		model.addAttribute("snr",snr);
		model.addAttribute("headerText", snr.getS().getShowName());
		return "show/showView";
	}
	
	@RequestMapping(value = "/insertShowFrm.do")
	public String insertShowFrm(Model model) {
		model.addAttribute("headerText", "공연등록");
		return "show/insertShowFrm";
	}
	
	@RequestMapping(value = "/insertShow.do")
	public String insertShow(Show s, MultipartFile upfile, HttpServletRequest request, Model model) {
		if(upfile != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/showImage/upload/");
			
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
			String showFilepath = "/resources/showImage/upload/"+filepath;
			s.setFilepath(showFilepath);
		}
		int result = service.insertShow(s);
		if(result>0) {
			model.addAttribute("msg", "공연 등록 성공");			
		}else {
			model.addAttribute("msg", "공연 등록 실패");
		}
		model.addAttribute("loc", "/showList.do");
		return "common/msg";
	}
	
	@RequestMapping(value = "/updateShowFrm.do")
	public String updateShow(int showNo, Model model) {
		Show show = service.selectOneShow(showNo);
		model.addAttribute("s",show);
		model.addAttribute("headerText", "공연수정");
		return "show/showUpdateFrm";
	}
	
	@RequestMapping(value = "/deleteShow.do")
	public String deleteShow(int showNo, Model model) {
		int result = service.deleteShow(showNo);
		if(result>0) {
			model.addAttribute("msg", "삭제 성공");			
		}else {
			model.addAttribute("msg", "삭제 실패");
		}
		model.addAttribute("loc", "/showList.do");
		return "common/msg";
	}
	
	@RequestMapping(value = "/updateShow.do")
	public String updateShow(Show s, MultipartFile upfile, String oldFilepath, int status, HttpServletRequest request, Model model) {
		if(status == 2) {
			if(upfile != null) {
				String savePath = request.getSession().getServletContext().getRealPath("/resources/showImage/upload/");
				
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
				String showFilepath = "/resources/showImage/upload/"+filepath;
				s.setFilepath(showFilepath);
			}
		}else {
			s.setFilepath(oldFilepath);
		}
		int result = service.updateShow(s);
		if(result>0) {
			model.addAttribute("msg", "공연 수정 성공");			
		}else {
			model.addAttribute("msg", "공연 수정 실패");
		}
		model.addAttribute("loc", "/showView.do?showNo="+s.getShowNo());
		return "common/msg";
	}
	
	@RequestMapping(value = "/insertReview.do")
	public String insertReview(ShowReview sr, Model model) {
		int result = service.insertReview(sr);
		if(result>0) {
			model.addAttribute("msg", "등록 성공");			
		}else {
			model.addAttribute("msg", "등록 실패");
		}
		model.addAttribute("result", 2);
		return "show/reviewWriteFrm";
	}
	
	@RequestMapping(value = "/deleteReview.do")
	public String deleteReview(ShowReview sr, Model model) {
		int result = service.deleteReview(sr);
		if(result>0) {
			model.addAttribute("msg", "삭제 성공");			
		}else {
			model.addAttribute("msg", "삭제 실패");
		}
		model.addAttribute("loc", "/showView.do?showNo="+sr.getShowNo());
		return "common/msg";
	}
	
	@RequestMapping(value = "/updateReview.do")
	public String updateReview(ShowReview sr, Model model) {
		int result = service.updateReview(sr);
		if(result>0) {
			model.addAttribute("msg", "수정 성공");			
		}else {
			model.addAttribute("msg", "수정 실패");
		}
		model.addAttribute("loc", "/showView.do?showNo="+sr.getShowNo());
		return "common/msg";
	}
	
	@ResponseBody
	@RequestMapping(value = "/uploadImage.do")
	public String uploadImage(MultipartFile file, HttpServletRequest request) {
		String filepath = null;
		if(file != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/showImage/editor/");
			
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
		return "/resources/showImage/editor/"+filepath;
	}
	
	
	@RequestMapping(value = "/selectSeat.do")
	public String selectSeat(ShowReserv sr, Model model) {
		//예약된 좌석 불러오기
		HashMap<String, Object> map = service.checkSeatList(sr);
		model.addAttribute("s", map.get("show"));
		model.addAttribute("list", map.get("list"));
		model.addAttribute("sr",sr);
		model.addAttribute("headerText", "공연예매");
		return "show/selectSeat";
	}
	
	@RequestMapping(value = "/reservation.do")
	public String reservation(Seat s, String memberId, Model model) {
		Show show = service.reservation(s, memberId);
		if(show != null) {
			model.addAttribute("seat", s);
			model.addAttribute("show", show);
			model.addAttribute("headerText", "공연예매");
			return "show/payment";
		}else {
			model.addAttribute("msg", "예매 실패");
			model.addAttribute("loc", "/showView.do?showNo="+s.getShowNo());
			return "common/msg";
		}
	}
	
	@RequestMapping(value = "/cancelPayment.do")
	public String cancelPayment(int reservNo) {
		service.deleteReserv(reservNo);
		return "redirect:/showList.do";
	}
	
	@RequestMapping(value = "/paymentSuccess.do")
	public String paymentSuccess(int reservNo, Model model) {
		HashMap<String, Object> map = service.selectReservation(reservNo);
		model.addAttribute("sr", map.get("sr"));
		model.addAttribute("show", map.get("show"));
		model.addAttribute("list", map.get("list"));
		model.addAttribute("headerText", "공연예매");
		return "show/paymentSuccess";
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkSeat.do")
	public String checkSeat(Seat s) {
		String seat = service.selectOneSeat(s);
		//아직은 결제로 넘어가야 좌석 선점
		//좌석 클릭 먼저가 선점인 경우 후에 구현해야됨
		return seat;
	}

	
	@RequestMapping(value = "/showAdmin.do")
	public String showAdmin(Model model) {
		HashMap<String, Object> map = service.selectAdminList();
		model.addAttribute("list", map.get("curr"));
		model.addAttribute("last", map.get("last"));
		model.addAttribute("selectmenu",0);
		return "show/showAdmin";
	}
	
	@RequestMapping(value = "/showMypage.do")
	public String showMypage(String memberId, Model model) {
		HashMap<String, Object> map = service.myReserv(memberId);
		model.addAttribute("list", map.get("reservs"));
		model.addAttribute("headerText", "마이페이지");
		model.addAttribute("selectmenu",0);
		return "show/showMypage";
	}
	
	@RequestMapping(value = "/reservCancel.do")
	public String reservCancel(int reservNo, String memberId, Model model) {
		int result = service.reservCancel(reservNo);
		if(result>1) {
			model.addAttribute("msg", "예매 취소 완료");			
		}else {
			model.addAttribute("msg", "취소 실패");
		}
		model.addAttribute("loc", "/showMypage.do?memberId="+memberId);
		return "common/msg";
	}
	
	@ResponseBody
	@RequestMapping(value = "/showSeat.do")
	public ArrayList<Seat> showSeat(int reservNo) {
		ArrayList<Seat> seats = service.showSeat(reservNo);
		return seats;
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkReserv.do")
	public ArrayList<ShowReserv> checkReserv(ShowReserv sr) {
		ArrayList<ShowReserv> list = service.checkReserv(sr);
		return list;
	}
	
	@RequestMapping(value = "/deleteReserv.do")
	public String deleteReserv(int reservNo, String memberId, Model model) {
		int result = service.deleteReserv(reservNo);
		if(result>0) {
			model.addAttribute("msg", "예매내역 삭제 완료");			
		}else {
			model.addAttribute("msg", "삭제 실패");
		}
		model.addAttribute("loc", "/showMypage.do?memberId="+memberId);
		return "common/msg";
	}
	
	@RequestMapping(value = "/checkReview.do")
	public String checkReview(int reservNo, Model model) {
		ShowReserv sr = service.writeReview(reservNo);
		int result = 0;
		if(sr == null) {
			result = 1;
		}else {
			sr.setReservNo(reservNo);
		}
		model.addAttribute("sr", sr);
		model.addAttribute("result", result);
		return "show/reviewWriteFrm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkSoldOut.do")
	public int checkSoldOut(ShowReserv sr) {
		int size = service.checkSoldOut(sr);
		return size;
	}
}
