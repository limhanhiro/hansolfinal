package kr.or.academy.vo;

import lombok.Data;

@Data
public class Academy {
	private int academyNo;
	private String academyTitle;
	private String academyStart;
	private String academyEnd;
	private String academyPhoto;
	private String academyTeacher;
	private String academyPlace;
	private int academyPrice;
	private String academyDetail;
	private String academyCategory;
	private int totalCount;
	private int academyCancel;
}
