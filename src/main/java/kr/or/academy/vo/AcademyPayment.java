package kr.or.academy.vo;

import lombok.Data;

@Data
public class AcademyPayment {
	private int paymentNo;
	private int paymentSelect;
	private int academyNo;
	private int exhibitionNo;
	private int paymentPrice;
	private String paymentDate;
	private int paymentCancel;
	private int paymentQuantity;
	private String academyStart;
	private String academyEnd;
	private String academyTitle;
	private String academyPhoto;
	private String academyTeacher;
	private String academyPlace;
	private String academyCategory;
	private int memberNo;
}
