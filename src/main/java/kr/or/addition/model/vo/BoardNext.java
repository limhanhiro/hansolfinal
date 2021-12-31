package kr.or.addition.model.vo;

import lombok.Data;

@Data
public class BoardNext {
private int rnum;
private int boardNo;
private String boardTitle;
private int nextNo;
private int prevNo;
private String nextTitle;
private String prevTitle;
}
