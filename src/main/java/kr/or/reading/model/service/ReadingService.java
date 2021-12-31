package kr.or.reading.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.reading.model.dao.ReadingDao;
import kr.or.reading.model.vo.Fixtures;
import kr.or.reading.model.vo.Reading;
import kr.or.reading.model.vo.ReadingBlack;

@Service
public class ReadingService {

	@Autowired
	private ReadingDao dao;


	public ReadingBlack selectOneBlackList(String readingId) {
		ReadingBlack rb = dao.selectOneBlackList(readingId);
		return rb;
	}


	public Reading selectOneNum(Reading re) {
		Reading re1 = dao.selectOneNum(re);
		return re1;
	}


	public int insertReading(Reading re) {
		return dao.insertReading(re);
	}


	public Reading selectOneId(Reading re) {
		Reading re2 = dao.selectOneId(re);
		return re2;
	}


	public int reservationCancel(Reading re) {
		return dao.reservationCancel(re);
	}


	public int countSeat(String readingDay) {
		return dao.countSeat(readingDay);
	}


	public ArrayList<Integer> chkSeat(Reading re) {
		ArrayList<Integer> list = dao.chkSeat(re);
		return list;
	}


	public ArrayList<Reading> selectWeekReading() {
		ArrayList<Reading> list = dao.selectWeekReading();
		return list;
	}

	@Transactional	//두가지가 다 처리되야 커밋을 해야됌 하나라도 안될시 롤백
	public int outAndBlackList(Reading re) {
		int count=0;
		for(int i=0; i<re.getIdList().size(); i++) {
			re.setReadingDay(re.getDayList().get(i));
			re.setReadingId(re.getIdList().get(i));
			
			int result = dao.expulsion(re);
			if(result>0) {
				int result1 = dao.insertBlackList(re);
				if(result1>0) {
					int result3 = dao.fixturesAllCancel(re);
					int result2 = dao.deleteReading(re);
					count++;
				}else {
					return -2;
				}
			}else {
				return -1;
			}
		}
		return count;
	}

	@Transactional	//두가지가 다 처리되야 커밋을 해야됌 하나라도 안될시 롤백
	public int earlyOut(Reading re) {
		int count=0;
		for(int i=0; i<re.getIdList().size(); i++) {
			re.setReadingDay(re.getDayList().get(i));
			re.setReadingId(re.getIdList().get(i));
			
			int result = dao.earlyOut(re);
			if(result>0) {
				count++;
			}else {
				return -1;
			}
		}
		return count;
	}


	public ArrayList<Reading> selectAllReading() {
		ArrayList<Reading> alllist = dao.selectAllReading();
		return alllist;
	}


	public ArrayList<ReadingBlack> selectReadingBlackList() {
		ArrayList<ReadingBlack> black = dao.selectReadingBlackList();
		return black;
	}


	public void timeOutBlackList(String time1) {
		dao.timeOutBlackList(time1);
	}


	public ArrayList<Reading> selectMyReading(String memberId) {
		ArrayList<Reading> re = dao.selectMyReading(memberId);
		return re;
	}


	public int fixturesInsert(Fixtures fi) {
		return dao.fixturesInsert(fi);
	}


	public Fixtures selectOneFixtures(Reading re) {
		Fixtures fi = dao.selectOneFixtures(re);
		return fi;
	}


	public int fixturesCancel(Reading re) {
		return dao.fixturesCancel(re);
	}

	@Transactional
	public int deleteRead(int reserveNo) {
		int count=0;
		int result1=dao.deleteFixtures(reserveNo);
		int result2=dao.deleteRead(reserveNo);
			if(result2>0) {
				count++;
			}else {
				return -1;
			}
		return count;
	}


	public ArrayList<Fixtures> selectAllFixtures() {
		ArrayList<Fixtures> fi = dao.selectAllFixtures();
		return fi;
	}




}
