package kr.or.addition.model.vo;

import java.util.ArrayList;

public class MyPageData {

private ArrayList<BoardComment> commentList;
private ArrayList<Board> noticeList;
private ArrayList<Board> freeList;
private ArrayList<Board> qnaList;
public MyPageData() {
	super();
	// TODO Auto-generated constructor stub
}
public MyPageData(ArrayList<BoardComment> commentList, ArrayList<Board> noticeList, ArrayList<Board> freeList,
		ArrayList<Board> qnaList) {
	super();
	this.commentList = commentList;
	this.noticeList = noticeList;
	this.freeList = freeList;
	this.qnaList = qnaList;
}
public ArrayList<BoardComment> getCommentList() {
	return commentList;
}
public void setCommentList(ArrayList<BoardComment> commentList) {
	this.commentList = commentList;
}
public ArrayList<Board> getNoticeList() {
	return noticeList;
}
public void setNoticeList(ArrayList<Board> noticeList) {
	this.noticeList = noticeList;
}
public ArrayList<Board> getFreeList() {
	return freeList;
}
public void setFreeList(ArrayList<Board> freeList) {
	this.freeList = freeList;
}
public ArrayList<Board> getQnaList() {
	return qnaList;
}
public void setQnaList(ArrayList<Board> qnaList) {
	this.qnaList = qnaList;
}

}
