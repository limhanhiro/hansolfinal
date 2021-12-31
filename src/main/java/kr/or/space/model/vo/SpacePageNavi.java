package kr.or.space.model.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class SpacePageNavi {
	private ArrayList<UseBoard> list;
	private ArrayList<SpaceReview> srList;
	private ArrayList<SpaceAdmin> rList;
	private String pageNavi;
	private int start;
}
