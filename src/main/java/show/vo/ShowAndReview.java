package show.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class ShowAndReview {
	private Show s;
	private ArrayList<ShowReview> list;
}
