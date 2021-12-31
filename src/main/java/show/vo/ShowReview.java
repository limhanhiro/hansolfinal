package show.vo;

import lombok.Data;

@Data
public class ShowReview {
	private int reviewNo;
	private int showNo;
	private String reviewWriter;
	private String reviewContent;
	private int star;
	private String reviewDate;
	private int reservNo;
	
	public String getReviewContentBr() {
		return reviewContent.replaceAll("\r\n", "<br>");
	}
	
}
