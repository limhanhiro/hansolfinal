package kr.or.reading.model.vo;

import lombok.Data;

@Data
public class Fixtures {

	private int fixturesNo;
	private int readingNo;
	private String fixturesTime;
	private String fixturesDay;
	private int fixturesNum;
	private String fixturesId;
	private String fixturesName;
	private int fixturesCharger;
	private int fixturesTable;
	private int fixturesBlanket;
	
//	FIXTURES_NO	        number	        primary key,
//  READING_NO      	number	        NOT NULL REFERENCES READING(READING_NO),
//  FIXTURES_TIME       date            default sysdate not null,
//	FIXTURES_DAY	    char(10)        NOT NULL,
//	FIXTURES_NUM	    number	        NOT NULL,
//	FIXTURES_ID	        varchar2(20)	NOT NULL,
//	FIXTURES_NAME	    varchar2(15)	NOT NULL,
//	FIXTURES_CHARGER	number	    	DEFAULT 0 NOT NULL,	-- '0 : 대여안함 1: 대여함'
//	FIXTURES_TABLE	    number	    	DEFAULT 0 NOT NULL,	-- '0 : 대여안함 1: 대여함'
//	FIXTURES_BLANKET	number	    	DEFAULT 0 NOT NULL	-- '0 : 대여안함 1: 대여함'
}
