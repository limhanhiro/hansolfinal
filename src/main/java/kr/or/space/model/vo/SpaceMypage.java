package kr.or.space.model.vo;

import lombok.Data;

@Data
public class SpaceMypage {
	private int rentalNo;
	private String spaceName;
	private String startTime;
	private String endTime;
	private String rentalDate;
	private String spacePurpose;
	private String mainFacility;
	private String mainProduct;
	private int maxPeople;
	private int price;
	private int rentalPeople;
	private int rentalStatus;
	private int usedBoard;
	private int srNo;
	private String delYn;
}
