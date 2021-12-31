package kr.or.academy.vo;

import lombok.Data;

@Data
public class StudentList {
	private int count;
	private String memberEmail;
	private String memberName;
	private int paymentCancel;
}
