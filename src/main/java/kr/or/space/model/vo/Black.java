package kr.or.space.model.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class Black {
	private ArrayList<Black> blackList;
	private int blackNo;
	private String blackStart;
	private String blackEnd;
	private String blackId;
	private int blackTy;
	private String blackDel;
	private int blackCount;
}
