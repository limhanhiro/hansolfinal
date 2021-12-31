package kr.or.resume.service;

import java.beans.Transient;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.resume.dao.ResumeDao;
import kr.or.resume.vo.Resume;
import kr.or.resume.vo.ResumeTbl;

@Service
public class ResumeService {

	@Autowired
	private ResumeDao dao;

	public int insertResume(Resume r, ArrayList<ResumeTbl> list) {
		int resumeResult = dao.insertResume(r);
		int fileResult = 0;
		if(resumeResult>0) {
			int ResumeNo = dao.selectBoardNo(); // 방금 인설트한 보드넘버 가져오기
			for(ResumeTbl rt : list) {
				rt.setResumeNo(ResumeNo);
				fileResult += dao.insertResumeTbl(rt);
			}
		}else {
			return -1;
		}	
		return fileResult;
	}

	public ArrayList<Resume> selectResumeList(int requritNo) {
		ArrayList<Resume> list = dao.selectResumeList(requritNo);
		return list;
	}

	public Resume selectOneResume(int resumeNo) {
		Resume r = dao.selectOneResume(resumeNo);
		ArrayList<ResumeTbl> list = dao.selectFileList(resumeNo);
		r.setRtList(list);
		return r;
	}

	public ResumeTbl selectOneResumeTbl(int fileNo) {
		ResumeTbl rt = dao.selectOneResumeTbl(fileNo);
		return rt;
	}
	@Transactional
	public int updateMemberLevel(int memberNo, int requritNo) {
		int result = dao.updateMemberLevel(memberNo);
		if(result >0) {
			result = dao.deleteRequrit(requritNo);
			if(result >0) {
				return dao.deleteResume2(requritNo);
			}else {
				return 0;
			}
		}else {
			return 0;
		}
		
	}

	public ArrayList<Resume> selectMyResumeList(int memberNo) {
		ArrayList<Resume> list = dao.selectMyResumeList(memberNo);
		return list;
	
	}

}
