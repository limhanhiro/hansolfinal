package kr.or.space.model.vo;

import lombok.Data;

@Data
public class SpaceReview {
	private int srNo;
	private int rentalNo;
	private String memberId;
	private String srContent;
	private String srDate;
	private String delYN;
}
