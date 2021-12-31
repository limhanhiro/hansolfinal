package kr.or.addition.model.vo;

import java.util.ArrayList;

public class BoardViewData {
	private ArrayList<BoardComment> list;
	private LikeNo likeList;
	private Board b;
	public BoardViewData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardViewData(ArrayList<BoardComment> list, LikeNo likeList, Board b) {
		super();
		this.list = list;
		this.likeList = likeList;
		this.b = b;
	}
	public ArrayList<BoardComment> getList() {
		return list;
	}
	public void setList(ArrayList<BoardComment> list) {
		this.list = list;
	}
	public LikeNo getLikeList() {
		return likeList;
	}
	public void setLikeList(LikeNo likeList) {
		this.likeList = likeList;
	}
	public Board getB() {
		return b;
	}
	public void setB(Board b) {
		this.b = b;
	}
	
	
	
	
}
