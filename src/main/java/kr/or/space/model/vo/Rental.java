package kr.or.space.model.vo;

import lombok.Data;

@Data
public class Rental {
	private int rentalNo;
	private int spaceNo;
	private String spaceName;
	private String memberId;
	private int stNo;
	private String rentalDate;
	private String rentalPeople;
	private String rentalStatus;
	private String usedBoard;
}
