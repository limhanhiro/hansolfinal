package kr.or.space.model.vo;

import lombok.Data;

@Data
public class FileVO {
	private int fileNo;
	private int spaceNo;
	private String filename;
	private String filepath;
	private String thumbnail;
}
