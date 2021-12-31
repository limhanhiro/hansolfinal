package kr.or.exhibition.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.exhibition.dao.ExhibitionDao;
import kr.or.exhibition.vo.Exhibition;
import kr.or.exhibition.vo.ExhibitionPagingVo;
import kr.or.exhibition.vo.ExhibitionPayment;
import kr.or.exhibition.vo.ExhibitionPaymentMypage;
import kr.or.exhibition.vo.ExhibitionRefund;
import kr.or.exhibition.vo.ExhibitionReview;

@Service
public class ExhibitionService {
	
	@Autowired
	private ExhibitionDao dao;

	public int exhibitionInsert(Exhibition exb) {
		int result = dao.exhibitionInsert(exb);
		return result;
	}

	public Exhibition selectOneExhibition(int exhibitionNo) {
		Exhibition exb = dao.selectOneExhibition(exhibitionNo);
		double starAvg = dao.selectStarAvg(exhibitionNo);
		exb.setStarAvg(starAvg);
		return exb;
	}

	public int exhibitionCredit(ExhibitionPayment exbp) {
		int result = dao.exhibitionCredit(exbp);
		return result;
	}

	public int exhibitionTotal() {
		int totalCount = dao.exhibitionTotal();
		return totalCount;
	}

	public ArrayList<Exhibition> selectExhibitionList(int reqPage) {
		int end = reqPage;
		int start = end -3;
		ExhibitionPagingVo ep = new ExhibitionPagingVo();
		ep.setStart(start);
		ep.setEnd(end);
		ArrayList<Exhibition> list = dao.selectExhibition(ep);
		return list;
	}
	public ArrayList<Exhibition> selectExhibitionListMain() {
		int start = 1;
		int end = 9;
		ExhibitionPagingVo ep = new ExhibitionPagingVo();
		ep.setStart(start);
		ep.setEnd(end);
		ArrayList<Exhibition> list = dao.selectExhibition(ep);
		return list;
	}

	public ArrayList<Exhibition> moreExhibition(int start) {
		int end = start +2;
		ExhibitionPagingVo ep = new ExhibitionPagingVo();
		ep.setStart(start+1);
		ep.setEnd(end);
		ArrayList<Exhibition> list = dao.selectExhibition(ep);
		return list;
	}

	public int insertExReview(ExhibitionReview exr) {
		int result = dao.insertExReview(exr);
		return result;
	}
	public int deleteExReview(ExhibitionReview exr) {
		int result = dao.deleteExReview(exr);
		return result;
	}

	public int updateExReview(ExhibitionReview exr) {
		int result = dao.updateExReview(exr);
		return result;
	}

	public ArrayList<ExhibitionReview> selectListExReview(int exhibitionNo) {
		ArrayList<ExhibitionReview> list = dao.selectExReview(exhibitionNo);
		return list;
	}
	@Transactional
	public int exhibitionUpdate(Exhibition ex) {
		int result = dao.exhibitionUpdate(ex);
		return result;
	}

	public HashMap<String, Object> selectExhibitionAdmin() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<Exhibition> list = dao.selectExhibitionAdmin();
		ArrayList<Exhibition> last = dao.selectExhibitionAdminLast();
		ArrayList<Exhibition> cancel = dao.selectExhibitionAdminCancel();
		map.put("list", list);
		map.put("last", last);
		map.put("cancel", cancel);
		return map;
	}

	public int checkTotalCount(String exhibitionDate, int exhibitionNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("exhibitionDate", exhibitionDate);
		map.put("exhibitionNo", exhibitionNo);
		int totalCount = dao.checkTotalCount(map);
		return totalCount;
	}

	public HashMap<String, Object> selectExhibitionPaymentList(int memberNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<ExhibitionPayment>  list = dao.selectExhibitionPaymentList(memberNo);
		ArrayList<ExhibitionPayment> last = dao.selectExhibitionPaymentListLast(memberNo);
		int totalCount = list.size();
		map.put("list", list);
		map.put("last", last);
		map.put("totalCount", totalCount);
		return map;
	}
	@Transactional
	public int deletePayment(int paymentNo) {
		int result = dao.deletePayment(paymentNo);
		return result;
	}

	public ArrayList<ExhibitionPayment> paymentList(int exhibitionNo) {
		ArrayList<ExhibitionPayment> payment = dao.paymentList(exhibitionNo);
		return payment;
	}

	public int realDelete(int reserveNo) {
		int result = dao.realDelete(reserveNo); 
		return result;
	}

	public String selectEmail(int memberNo) {
		String memberEmail = dao.selectEmail(memberNo);
		return memberEmail;
	}

	public int updateEmailStatus(int paymentNo) {
		int result1 = dao.updateEmailStatus(paymentNo);
		return result1;
	}

	public ExhibitionPaymentMypage selectOneExhibitionPayment(int paymentNo) {
		ExhibitionPaymentMypage expm = dao.selectOneExhibitionPayment(paymentNo);
		return expm;
	}
	@Transactional
	public int deleteExhibition(int exhibitionNo) {
		int result = dao.deleteExhibition(exhibitionNo);
		if(result>0) {
			int count = dao.countCancelQuanEx(exhibitionNo);
			if(count == 0) {
				return result;
			}else {
				result = dao.updatePaymentStatus(exhibitionNo);
				return result;
			}
		}else {
			return result;
		}
		
	}

	public int revivalExhibition(int exhibitionNo) {
		int result = dao.revivalExhibition(exhibitionNo);
		return result;
	}

	public ArrayList<ExhibitionRefund> refundMemberView(int exhibitionNo) {
		 ArrayList<ExhibitionRefund> list = dao.refundMemberView(exhibitionNo);
		return list;
	}
}
