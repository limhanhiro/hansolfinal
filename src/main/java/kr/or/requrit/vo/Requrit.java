package kr.or.requrit.vo;

import lombok.Data;

@Data
public class Requrit {
	private int requritNo;
	private String requritTitle;
	private String requritStart;
	private String requritEnd;
	private String requritCareer;
	private String requritGender;
	private String requritField;
	private String requritDetail;
	private String employeeType;
	private long period; 
	private int requritCancel;
}
