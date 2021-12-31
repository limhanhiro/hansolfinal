package kr.or.reading.model.vo;

import lombok.Data;

@Data
public class ReadingBlack {

	private int blackNo;
	private String blackStart;
	private String blackEnd;
	private String blackId;
	private int blackTy;
	private String memberName;
	private String blackDel;
	
//	BLACK_NO	    number	        primary key,
//	BLACK_START	    char(17)        NOT NULL,	-- '관리자에 의해 등록된 시점'
//	BLACK_END	    char(17)        NOT NULL,	-- '등록일자+7일후 00시'
//	BLACK_ID	    varchar2(20)	NOT NULL    REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
//  BLACK_TY        number          not null    -- 0열람실 1공간대여

}
