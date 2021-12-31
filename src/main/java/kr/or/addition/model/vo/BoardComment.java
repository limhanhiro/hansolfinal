package kr.or.addition.model.vo;

import java.security.KeyStore.PrivateKeyEntry;

import lombok.Data;

@Data
public class BoardComment {
	private int bcNo;
	private int bcLevel;
	private String bcWriter;
	private String bcContent;
	private String regDate;
	private int boardRef;
	private Integer bcRef;
	private String bcidRef;
	private String boardTitle;
	private int boardType;
	private int bcDel;
	
	
	public String getBcContentBr() {
		return bcContent.replace("\r\n", "<br>");
	}
}
