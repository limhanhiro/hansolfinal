package kr.or.addition.model.vo;

import lombok.Data;

@Data
public class LikeNo {

private int boardRef;
private int likeSum;
private int dislikeSum;
private String memberId;
}
