package kr.or.member.vo;

import kr.or.member.vo.PwChangeVo;
import lombok.Data;

@Data
public class PwChangeVo {
	private String memberId;
	private String oldPassword;
	private String newPassword;
}
