package kr.or.exhibition.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.exhibition.vo.Exhibition;
import kr.or.exhibition.vo.ExhibitionPagingVo;
import kr.or.exhibition.vo.ExhibitionPayment;
import kr.or.exhibition.vo.ExhibitionPaymentMypage;
import kr.or.exhibition.vo.ExhibitionRefund;
import kr.or.exhibition.vo.ExhibitionReview;

@Repository
public class ExhibitionDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int exhibitionInsert(Exhibition exb) {
		int result = sqlSession.insert("exhibition.exhibitionInsert",exb);
		return result;
	}

	public Exhibition selectOneExhibition(int exhibitionNo) {
		Exhibition exb = sqlSession.selectOne("exhibition.selectOneExhibition",exhibitionNo);
		return exb;
	}

	public int exhibitionCredit(ExhibitionPayment exbp) {
		int result = sqlSession.insert("exhibition.exhibitionCredit",exbp);
		return result;
	}

	public int exhibitionTotal() {
		int totalCount = sqlSession.selectOne("exhibition.exhibitionTotal");
		return totalCount;
	}

	public ArrayList<Exhibition> selectExhibition(ExhibitionPagingVo ep) {
		List<Exhibition> list = sqlSession.selectList("exhibition.exhibitionList",ep);
		return (ArrayList<Exhibition>)list;
	}

	public int insertExReview(ExhibitionReview exr) {
		int result = sqlSession.insert("exhibition.insertExReview",exr);
		return result;
	}

	public int deleteExReview(ExhibitionReview exr) {
		int result = sqlSession.update("exhibition.deleteExReview",exr);
		return result;
	}

	public int updateExReview(ExhibitionReview exr) {
		int result = sqlSession.update("exhibition.updateExReveiw",exr);
		return result;
	}

	public ArrayList<ExhibitionReview> selectExReview(int exhibitionNo) {
		List<ExhibitionReview> list =sqlSession.selectList("exhibition.selectExReviewList", exhibitionNo);
		return  (ArrayList<ExhibitionReview>)list;
	}

	public double selectStarAvg(int exhibitionNo) {
		double starAvg = sqlSession.selectOne("exhibition.selectAvgStar",exhibitionNo);
		return starAvg;
	}

	public int exhibitionUpdate(Exhibition ex) {
		int result = sqlSession.update("exhibition.exhibitionUpdate",ex);
		return result;
	}

	public ArrayList<Exhibition> selectExhibitionAdmin() {
		List<Exhibition> list = sqlSession.selectList("exhibition.selectExhibitionAdmin");
		return (ArrayList<Exhibition>)list;
	}

	public ArrayList<Exhibition> selectExhibitionAdminLast() {
		List<Exhibition> last = sqlSession.selectList("exhibition.selectExhibitionAdminLast");
		return (ArrayList<Exhibition>)last;
	}
	public ArrayList<Exhibition> selectExhibitionAdminCancel() {
		List<Exhibition> cancel = sqlSession.selectList("exhibition.selectExhibitionAdminCancel");
		return (ArrayList<Exhibition>)cancel;
	}
	public int checkTotalCount(HashMap<String, Object> map) {
		int totalCount = sqlSession.selectOne("exhibition.checkTotalCount",map);
		return totalCount;
	}

	public ArrayList<ExhibitionPayment> selectExhibitionPaymentList(int memberNo) {
		List<ExhibitionPayment> list = sqlSession.selectList("exhibition.selectExhibitionPayment",memberNo);
		return (ArrayList<ExhibitionPayment>)list;
	}

	public ArrayList<ExhibitionPayment> selectExhibitionPaymentListLast(int memberNo) {
		List<ExhibitionPayment> last = sqlSession.selectList("exhibition.selectExhibitionPaymenytLast",memberNo);
		return (ArrayList<ExhibitionPayment>)last;
	}
	
	public int deletePayment(int paymentNo) {
		int result = sqlSession.update("exhibition.deletePayment",paymentNo);
		return result;
	}

	public ArrayList<ExhibitionPayment> paymentList(int exhibitionNo) {
		List<ExhibitionPayment> payment = sqlSession.selectList("exhibition.paymentList",exhibitionNo);
		return (ArrayList<ExhibitionPayment>)payment;
	}

	public int realDelete(int reserveNo) {
		int result = sqlSession.delete("exhibition.realDelete",reserveNo);
		return result;
	}

	public String selectEmail(int memberNo) {
		String memberEmail = sqlSession.selectOne("member.selectMemberEmail",memberNo);
		return memberEmail;
	}

	public int updateEmailStatus(int paymentNo) {
		int result1 = sqlSession.update("exhibition.updateEmailStatus",paymentNo);
		return result1;
	}

	public ExhibitionPaymentMypage selectOneExhibitionPayment(int paymentNo) {
		ExhibitionPaymentMypage expm = sqlSession.selectOne("exhibition.selectOneExhibitionPayment",paymentNo);
		return expm;
	}

	public int deleteExhibition(int exhibitionNo) {
		int result = sqlSession.update("exhibition.deleteExhibition",exhibitionNo);
		return result;
	}

	public int updatePaymentStatus(int exhibitionNo) {
		int result = sqlSession.update("exhibition.updatePaymentStatus",exhibitionNo);
		return result;
	}

	public int revivalExhibition(int exhibitionNo) {
		int result = sqlSession.update("exhibition.revivalExhibition",exhibitionNo);
		return result;
	}

	public ArrayList<ExhibitionRefund> refundMemberView(int exhibitionNo) {
		List<ExhibitionRefund> list = sqlSession.selectList("exhibition.refundMemberView",exhibitionNo);
		return (ArrayList<ExhibitionRefund>)list;
	}

	public int countCancelQuanEx(int exhibitionNo) {
		int count = sqlSession.selectOne("exhibition.countCancelQuanEx",exhibitionNo);
		return count;
	}
}
