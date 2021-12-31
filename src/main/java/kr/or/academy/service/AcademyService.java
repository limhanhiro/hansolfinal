package kr.or.academy.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.member.vo.Member;
import kr.or.academy.dao.AcademyDao;
import kr.or.academy.vo.Academy;
import kr.or.academy.vo.AcademyCategory;
import kr.or.academy.vo.AcademyPagingVo;
import kr.or.academy.vo.AcademyPayment;
import kr.or.academy.vo.StudentList;
import kr.or.exhibition.vo.ExhibitionRefund;

@Service
public class AcademyService {

	@Autowired
	private AcademyDao dao;

	public int academyInsert(Academy a) {
		int result = dao.academyInsert(a);
		return result;
	}

	public int academyTotal() {
		int totalCount = dao.academyTotal();
		return totalCount;
	}

	public ArrayList<Academy> selectAcademyList(int reqPage ,String category) {
		String all = "all";
		int end = reqPage;
		int start = end - 3;
		AcademyPagingVo ap = new AcademyPagingVo();
		if(category.equals(all)) {
			ap.setStart(start);
			ap.setEnd(end);
			ap.setCategory(category);
			ArrayList<Academy> list = dao.selectAcademy(ap);
			return list;
		}else {
			ap.setStart(start);
			ap.setEnd(end);
			ap.setCategory(category);
			int totalCount = dao.totalCountAcademy(category);
			ArrayList<Academy> list = dao.selectCategoryAcademy(ap);
			for(Academy a : list) {
				a.setTotalCount(totalCount);
			}
			return list;
		}
	}
	//더보기
	public ArrayList<Academy> moreAcademy(int start,String category) {
		start = start+1;
		int end = start +1;
		String all = "all";
		AcademyPagingVo ap = new AcademyPagingVo();
		if(category.equals(all)) {
			ap.setStart(start);
			ap.setEnd(end);
			ap.setCategory(category);
			ArrayList<Academy> list = dao.selectAcademy(ap);
			return list;
		}else {
			ap.setStart(start);
			ap.setEnd(end);
			ap.setCategory(category);
			ArrayList<Academy> list = dao.selectCategoryAcademy(ap);
			return list;
		}
	}
	//검색으로 조회 처음에 4개 해오기
	public ArrayList<Academy> searchAcademyList(int reqPage, String keyWord) {
		int end = reqPage;
		int start = end - 3;
		ArrayList<Academy> list = new ArrayList<Academy>();
		if(keyWord.equals("")) {
			return list;
		}else {
			AcademyPagingVo ap = new AcademyPagingVo();
			ap.setStart(start);
			ap.setEnd(end);
			ap.setCategory(keyWord);
			list = dao.searchAcademyList(ap);
			if(list.size() < 1) {
				return list;
			}else {
				int totalCount = dao.searchAcademyTotal(keyWord);
				for(Academy a : list) {
					a.setTotalCount(totalCount);
				}
				return list;
			}
		}
	}
	public Academy selectOneAcademy(int academyNo) {
		Academy a = dao.selectOneAcademy(academyNo);
		return a;
	}

	public int academyCredit(AcademyPayment acp) {
		int result = dao.academyCredit(acp);
		return result;
	}

	public ArrayList<AcademyCategory> selectAcademyCategory() {
		ArrayList<AcademyCategory> acList = dao.selectAcademyCategory();
		return acList;
	}
	public ArrayList<Academy> searchMoreAcademy(int start, String category) {
		start = start+1;
		int end = start +1;
		AcademyPagingVo ap = new AcademyPagingVo();
		ap.setCategory(category);
		ap.setEnd(end);
		ap.setStart(start);
		ArrayList<Academy> list = dao.searchAcademyList(ap);
		return list;
	}

	public int academyUpdate(Academy a) {
		int result = dao.academyUpdate(a);
		return result;
	}

	public HashMap<String, Object> academyAdminList() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<Academy> list = dao.acadeyAdminList();
		ArrayList<Academy> last = dao.academyAdminListLast();
		ArrayList<Academy> cancel = dao.academyAdminListCancel();
		map.put("list", list);
		map.put("last", last);
		map.put("cancel", cancel);
		return map;
	}

	public int countingStar(int academyNo) {
		int studentCount = dao.countingStar(academyNo);
		return studentCount;
	}

	public HashMap<String, Object> academyMypage(int memberNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<AcademyPayment> list = dao.selecAcademtPaymentList(memberNo);
		ArrayList<AcademyPayment> last = dao.selecAcademtPaymentListLast(memberNo);
		int totalCount = list.size();
		map.put("list",list);
		map.put("last",last);
		map.put("totalCount",totalCount);
		return map;
	}
	@Transactional
	public int deleteAcPayment(int paymentNo) {
		int result = dao.deleteAcPayment(paymentNo);
		return result;
	}

	public ArrayList<StudentList> studentViewList(int academyNo) {
		ArrayList<StudentList> list = dao.studentViewList(academyNo);
		return list;
	}
	@Transactional
	public int deleteAcademy(int academyNo) {
		int result = dao.deleteAcademy(academyNo);
		if(result > 0) {
			int count = dao.countCancelQuan(academyNo);
			if(count == 0) {
				return result;
			}else {
				result = dao.updateAcademyStatus(academyNo);
				return result;
			}
		}else {
			return result;
		}
		
	}

	public int revivalAcademy(int academyNo) {
		int result = dao.revivalAcademy(academyNo);
		return result;
	}

	public ArrayList<ExhibitionRefund> refundStudentView(int academyNo) {
		ArrayList<ExhibitionRefund> list = dao.refundStudentView(academyNo);
		return list;
	}


	public Member selectMyPage(String academyTeacher) {
		Member m = dao.teacherCheck(academyTeacher);
		return m;
	}

	public ArrayList<Academy> selectTeacherAcademyList(String academyTeacher) {
		ArrayList<Academy> list = dao.selectTeacherAcademyList(academyTeacher);
		return list;
	}


}
