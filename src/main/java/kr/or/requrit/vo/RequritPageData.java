package kr.or.requrit.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class RequritPageData {
	private ArrayList<Requrit> list;
	private String pageNavi;
	private int start;
}
