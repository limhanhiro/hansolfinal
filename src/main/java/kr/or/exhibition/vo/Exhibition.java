package kr.or.exhibition.vo;


import lombok.Data;

@Data
public class Exhibition {
	private int exhibitionNo;
	private String exhibitionTitle;
	private String exhibitionStart;
	private String exhibitionEnd;
	private String exhibitionPhoto;
	private String exhibitionTimeStart;
	private String exhibitionTimeEnd;
	private String exhibitionAge;
	private int exhibitionPrice;
	private String exhibitionDetail;
	private double starAvg;
	private int exhibitionCancel;
}
