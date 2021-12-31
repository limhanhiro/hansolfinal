package kr.or.exhibition.vo;

import lombok.Data;

@Data
public class ExhibitionPaymentMypage {
	private int paymentNo;
	private int paymentSelect;
	private int academyNo;
	private int exhibitionNo;
	private int paymentPrice;
	private String paymentDate;
	private int paymentCancel;
	private int paymentQuantity;
	private String bookDate;
	private int memberNo;
	private int checkEmail;
	private String exhibitionTitle;
	private String exhibitionStart;
	private String exhibitionEnd;
	private String exhibitionTimeStart;
	private String exhibitionTimeEnd;
}
