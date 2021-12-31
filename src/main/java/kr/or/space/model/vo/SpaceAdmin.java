package kr.or.space.model.vo;

import lombok.Data;

@Data
public class SpaceAdmin {
	private int rentalNo;
	private String spaceName;
	private String memberId;
	private String startTime;
	private String endTime;
	private String rentalDate;
	private String rentalPeople;
	private String filename;
	private String rentalStatus;
	private String usedBoard;
}
