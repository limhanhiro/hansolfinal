package kr.or.reading.model.vo;

import java.util.List;

import lombok.Data;

@Data
public class Reading {
	
	private int readingNo;
	private String readingTime;
	private String readingDay;
	private int readingNum;
	private String readingId;
	private String readingName;
	private int readingTy;
	private int readingCheckOut;
	private List<String> dayList;
	private List<String> idList;
	
//	READING_NO	        number	        primary key,
//  READING_TIME        date            default sysdate not null,
//	READING_DAY 	    char(10)        NOT NULL,
//	READING_NUM	        number	        NOT NULL,
//	READING_ID	        varchar2(20)	NOT NULL	REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
//	READING_NAME	    varchar2(15)	NOT NULL,
//	READING_TY	        number	        DEFAULT 0 not null,	-- '0 : 오전 1 : 오후 2 : 종일'
//	READING_CHECKOUT    number	        DEFAULT 0 not null	-- '0 : 퇴실이전 1 : 조기퇴실(현장예약가능상태)'
	
}
