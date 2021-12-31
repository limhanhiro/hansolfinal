package kr.or.resume.controller;

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
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.resume.service.ResumeService;
import kr.or.resume.vo.Resume;
import kr.or.resume.vo.ResumeTbl;


@Controller
public class ResumeController {

	@Autowired
	private ResumeService service;
	
	@RequestMapping(value="/resumeFrm.do")
	public String resumeFrm(Model model, String requritTitle, int requritNo) {
		model.addAttribute("requritTitle",requritTitle);
		model.addAttribute("requritNo",requritNo);
		model.addAttribute("headerText", requritTitle+"이력서 작성");
		return "resume/resumeInsert";
	}
	@RequestMapping(value="/resumeInsert.do")
	public String resumeInsert(HttpServletRequest request,MultipartFile[] upfiles,Model model,Resume r) {
		ArrayList<ResumeTbl> list = new ArrayList<ResumeTbl>();
		if (upfiles[0].isEmpty()) {
		} else {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/resume/upload/");
			for (MultipartFile file : upfiles) {
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
				ResumeTbl rt = new ResumeTbl();
				rt.setFilename(filename);
				rt.setFilepath(filepath);
				list.add(rt);
			}
		}
		int result = service.insertResume(r,list);
		if (result == -1 || result != list.size()) { // 파일 갯수 만큼 += (누적) 되게 되어 있음
			model.addAttribute("msg","등록실패");
		}else {
			model.addAttribute("msg","등록성공");
		}
		model.addAttribute("loc","/requritList.do?reqPage=1");
		return "common/msg";
	}
	@ResponseBody
	@RequestMapping(value="/uploadImageResume.do")
	public String uploadImageResume(MultipartFile file, HttpServletRequest request) {
		String filepath = null;
		if(file != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/resume/img/editor/");
			
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
		return "/resources/resume/img/editor/"+filepath;
	}
	@RequestMapping(value="/resumeList.do")
	public String resumeList(Model model, int requritNo, String requritTitle) {
		ArrayList<Resume> list = service.selectResumeList(requritNo);
		model.addAttribute("list",list);
		model.addAttribute("requritTltle",requritTitle);
		model.addAttribute("headerText", "지원자 목록");
		return "resume/resumeList";
	}
	@RequestMapping(value="/resumeView.do")
	public String resumeView(Model model, int resumeNo) {
		Resume r = service.selectOneResume(resumeNo);
		model.addAttribute("r",r);
		model.addAttribute("headerText", r.getMemberName()+"의 이력서");
		return "resume/resumeView";
	}
	@RequestMapping(value = "/resumeFileDown.do")
	//페이지 이동 x -> public void
	public void resumeFileDown(int fileNo, Model model,HttpServletRequest request, HttpServletResponse response) throws IOException {
		ResumeTbl rt = service.selectOneResumeTbl(fileNo);
		String root = request.getSession().getServletContext().getRealPath("/resources/resume/upload/");
		String file = root+rt.getFilepath();
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
			resFilename = URLEncoder.encode(rt.getFilename(),"utf-8");
			resFilename = resFilename.replace("\\\\", "20%");
		}else {//그 외 다른 브라우저 인 경우
			resFilename = new String(rt.getFilename().getBytes("UTF-8"),"ISO-8859-1");
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
	@RequestMapping(value="/updateMemberLevel.do")
	public String updateMemberLevel(int memberNo, int requritNo ,Model model) {
		int result = service.updateMemberLevel(memberNo,requritNo);
		if(result>0) {
			model.addAttribute("msg", "회원 등급 변경 성공 공고 수정 완료");			
		}else {
			model.addAttribute("msg", "실패");
		}
		model.addAttribute("loc","/requritList.do?reqPage=1");
		return "common/msg";
	}
	@RequestMapping(value="/myResumeList.do")
		public String myRequritList(int memberNo,Model model) {
			ArrayList<Resume> list = service.selectMyResumeList(memberNo);
			model.addAttribute("list",list);
			model.addAttribute("headerText", "내 지원 목록");
			return "resume/myResumeList";
		}
	
}
