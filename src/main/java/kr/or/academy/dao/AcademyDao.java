package kr.or.academy.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.academy.vo.Academy;
import kr.or.academy.vo.AcademyCategory;
import kr.or.academy.vo.AcademyPagingVo;
import kr.or.academy.vo.AcademyPayment;
import kr.or.academy.vo.StudentList;
import kr.or.exhibition.vo.ExhibitionRefund;
import kr.or.member.vo.Member;

@Repository
public class AcademyDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int academyInsert(Academy a) {
		int result = sqlSession.insert("academy.academyInsert",a);
		return result;
	}

	public int academyTotal() {
		int totalCount = sqlSession.selectOne("academy.acadeyTotal");
		return totalCount;
	}
	//전체 리스트 최신순 출력
	public ArrayList<Academy> selectAcademy(AcademyPagingVo ap) {
		List<Academy> list = sqlSession.selectList("academy.academyList",ap);
		return (ArrayList<Academy>)list;
	}
	//카테고리별 최신순 출력
	public ArrayList<Academy> selectCategoryAcademy(AcademyPagingVo ap) {
		List<Academy> list = sqlSession.selectList("academy.selectCategoryList",ap);
		return (ArrayList<Academy>)list;
	}

	public Academy selectOneAcademy(int academyNo) {
		Academy a = sqlSession.selectOne("academy.selectOneAcademy",academyNo);
		return a;
	}

	public int academyCredit(AcademyPayment acp) {
		int result = sqlSession.insert("academy.academyCredit",acp);
		return result;
	}

	public ArrayList<AcademyCategory> selectAcademyCategory() {
		List<AcademyCategory> acList = sqlSession.selectList("academy.academyCategory");
		return (ArrayList<AcademyCategory>)acList;
	}

	public int totalCountAcademy(String category) {
		int totalCount = sqlSession.selectOne("academy.totalCountAcademy",category);
		return totalCount;
	}

	public ArrayList<Academy> searchAcademyList(AcademyPagingVo ap) {
		List<Academy> list = sqlSession.selectList("academy.searchAcademyList",ap);
		return (ArrayList<Academy>)list;
	}

	public int searchAcademyTotal(String keyWord) {
		int totalCount = sqlSession.selectOne("academy.searchAcademyTotal",keyWord);
		return totalCount;
	}

	public int academyUpdate(Academy a) {
		int result = sqlSession.update("academy.academyUpdate",a);
		return result;
	}

	public ArrayList<Academy> acadeyAdminList() {
		List<Academy> list = sqlSession.selectList("academy.academyAdminList");
		return (ArrayList<Academy>)list;
	}

	public ArrayList<Academy> academyAdminListLast() {
		List<Academy> last = sqlSession.selectList("academy.academyAdminListLast");
		return (ArrayList<Academy>)last;
	}
	public ArrayList<Academy> academyAdminListCancel() {
		List<Academy> cancel = sqlSession.selectList("academy.academyAdminListCancel");
		return (ArrayList<Academy>)cancel;
	}
	public int countingStar(int academyNo) {
		int studentCount = sqlSession.selectOne("academy.countingStar",academyNo);
		return studentCount;
	}

	public ArrayList<AcademyPayment> selecAcademtPaymentList(int memberNo) {
		List<AcademyPayment> list = sqlSession.selectList("academy.selecAcademtPaymentList",memberNo);
		return (ArrayList<AcademyPayment>)list;
	}

	public ArrayList<AcademyPayment> selecAcademtPaymentListLast(int memberNo) {
		List<AcademyPayment> last = sqlSession.selectList("academy.selecAcademtPaymentListLast",memberNo);
		return (ArrayList<AcademyPayment>)last;
	}

	public int deleteAcPayment(int paymentNo) {
		int result = sqlSession.update("academy.deleteAcPayment",paymentNo);
		return result;
	}

	public ArrayList<StudentList> studentViewList(int academyNo) {
		List<StudentList> list = sqlSession.selectList("academy.studentList",academyNo);
		return (ArrayList<StudentList>)list;
	}

	public int deleteAcademy(int academyNo) {
		int result = sqlSession.update("academy.deleteAcademy",academyNo);
		return result;
	}

	public int countCancelQuan(int academyNo) {
		int count = sqlSession.selectOne("academy.countCancelQuan",academyNo);
		return count;
	}

	public int updateAcademyStatus(int academyNo) {
		int result = sqlSession.update("academy.updateAcademyStatus",academyNo);
		return result;
	}

	public int revivalAcademy(int academyNo) {
		int result = sqlSession.update("academy.revivalAcademy",academyNo);
		return result;
	}

	public ArrayList<ExhibitionRefund> refundStudentView(int academyNo) {
		List<ExhibitionRefund> list = sqlSession.selectList("academy.refundStudentView",academyNo);
		return (ArrayList<ExhibitionRefund>)list;
	}

	public Member teacherCheck(String academyTeacher) {
		Member m = sqlSession.selectOne("academy.teacherCheck",academyTeacher);
		return m;
	}

	public ArrayList<Academy> selectTeacherAcademyList(String academyTeacher) {
		List<Academy> list = sqlSession.selectList("academy.teacherAcademyList",academyTeacher);
		return (ArrayList<Academy>)list;
	}



	//public int academyUpdate(Academy a) {
	//	int result = sqlSession.update("academy.academyUpdate",a);
	//	return result;
	//}
}
