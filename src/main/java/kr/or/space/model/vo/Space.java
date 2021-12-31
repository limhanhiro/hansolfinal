package kr.or.space.model.vo;

import lombok.Data;

@Data
public class Space {
	private int spaceNo;
	private String spaceName;
	private String spacePurpose;
	private String mainFacility;
	private String mainProduct;
	private int maxPeople;
	private int price;
	private String filename;
}
