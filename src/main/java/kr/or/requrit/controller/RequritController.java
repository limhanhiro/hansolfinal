package kr.or.requrit.controller;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.requrit.service.RequritService;
import kr.or.requrit.vo.Requrit;
import kr.or.requrit.vo.RequritPageData;
import kr.or.resume.vo.ResumeTbl;


@Controller
public class RequritController {
	@Autowired
	private RequritService service;
	//공지 작성 페이지로 이동
	@RequestMapping(value="/requritFrm.do")
	public String resumerFrm(Model model) {
		model.addAttribute("headerText", "모집 공고 등록");
		return "requrit/requritInsert";
	}
	//공지 리스트 페이지로 이동
	@RequestMapping(value="/requritList.do")
	public String requritList(Model model , int reqPage) {
		RequritPageData rpd = service.selectRequritPageData(reqPage);
		model.addAttribute("list",rpd.getList());
		model.addAttribute("pageNavi",rpd.getPageNavi());
		model.addAttribute("start",rpd.getStart());
		model.addAttribute("headerText", "모집 공고 목록");
		return "requrit/requritList";
	}
	@RequestMapping(value="/requritInsert.do")
	public String requritInsert (Requrit r, HttpServletRequest request, Model model ) {
		int result = service.requritInsert(r);
		if(result>0) {
			model.addAttribute("msg", "공고 등록 성공");			
		}else {
			model.addAttribute("msg", "공고 등록 실패");
		}
		model.addAttribute("loc", "/requritList.do?reqPage=1");
		return "common/msg";
	}
	@RequestMapping(value="/requritView.do")
	public String requritView(int requritNo,Model model) {
		Requrit r = service.selectOneRequrit(requritNo);
		model.addAttribute("r",r);
		model.addAttribute("headerText", r.getRequritTitle());
		return "requrit/requritView";
	}
	@ResponseBody
	@RequestMapping(value="/uploadImageRequrit.do")
	public String uploadImageResume(MultipartFile file, HttpServletRequest request) {
		String filepath = null;
		if(file != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/requritimage/editor/");
			
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
		return "/resources/requritimage/editor/"+filepath;
	}
	@RequestMapping(value="/deleteRequrit2.do")
		public String deleteRequrit2(int requritNo,Model model) {
			int result = service.deleteRequrit2(requritNo);
			if(result>0) {
				model.addAttribute("msg", "삭제 성공");			
			}else {
				model.addAttribute("msg", "삭제 실패");
			}
			model.addAttribute("loc", "/requritList.do?reqPage=1");
			return "common/msg";
		}
	@RequestMapping(value="/updateRequritFrm.do")
	public String updateRequritFrm(int requritNo,Model model) {
		Requrit r = service.updateRequritFrm(requritNo);
		model.addAttribute("r",r);
		return "requrit/requritUpdateFrm";
	}
	@RequestMapping(value="/requritUpdate.do")
	public String requritUpdate(Requrit r,Model model) {
		int result = service.updateRequritFrm(r);
		if(result>0) {
			model.addAttribute("msg", "수정 성공");			
		}else {
			model.addAttribute("msg", "수정 실패");
		}
		model.addAttribute("loc", "/requritView.do?requritNo="+r.getRequritNo());
		return "common/msg";
	}
	@RequestMapping(value="/deleteRequritList.do")
	public String deleteRequritList(int reqPage, Model model) {
		RequritPageData rpd = service.selectRequritPageDataLast(reqPage);
		model.addAttribute("list",rpd.getList());
		model.addAttribute("pageNavi",rpd.getPageNavi());
		model.addAttribute("start",rpd.getStart());
		model.addAttribute("headerText", "삭제한 공고 목록");
		return "requrit/requritListDelete";
	}
	@RequestMapping(value="/revivalRequritFrm.do")
	public String revivalRequritFrm (int requritNo, Model model) {
		Requrit r = service.updateRequritFrm(requritNo);
		model.addAttribute("r",r);
		return "requrit/requritRevivalFrm";
	}
	@RequestMapping(value="/requritRevival.do")
	public String requritRevival (Requrit r,Model model) {
		int result = service.RevivalrequritFrm(r);
		if(result>0) {
			model.addAttribute("msg", "수정 성공");			
		}else {
			model.addAttribute("msg", "수정 실패");
		}
		model.addAttribute("loc", "/requritView.do?requritNo="+r.getRequritNo());
		return "common/msg";
	}
	@RequestMapping(value = "/attacheFileDown.do")
	//페이지 이동 x -> public void
	public void attacheFileDown(String fileName, Model model,HttpServletRequest request, HttpServletResponse response) throws IOException {
		String root = request.getSession().getServletContext().getRealPath("/resources/resume/upload/");
		String file = root+fileName;
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
			resFilename = URLEncoder.encode(fileName,"utf-8");
			resFilename = resFilename.replace("\\\\", "20%");
		}else {//그 외 다른 브라우저 인 경우
			resFilename = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
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
	
}
