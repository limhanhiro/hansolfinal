package kr.or.exhibition.vo;

import lombok.Data;

@Data
public class ExhibitionReview {
	private int exReviewNo;
	private int exhibitionNo;
	private String exReviewWriter;
	private String exReviewContent;
	private int exReviewStar;
	private String exReviewDate;
	private int exReviewStatus;
	
	public String getexReviewContentBr() {
		return exReviewContent.replaceAll("\r\n", "<br>");
	}
}
