package kr.or.member.vo;
import java.util.ArrayList;

import lombok.Data;

@Data
public class MemberPage {
	private ArrayList<Member> list;
	private String pageNavi;
	private int start;
	private int end;
	private int totalCount;
}
