package kr.or.member.vo;

import lombok.Data;

@Data
public class Member {
	private int memberNo;
	private String memberId;
	private String memberEmail;
	private String memberPassword;
	private String memberName;
	private String memberPhone;
	private String memberBirthday;
	private int memberGender;
	private String postcode;
	private String addressRoad;
	private String addressDetail;
	private int memberLevel;
	private int memberReceiveEmail;
	private int memberReceiveSms;
	private int memberStatus;
	private String enrollDate;
	private String withdrawDate;
}
