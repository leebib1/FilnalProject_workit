package com.workit.chat.model.vo;



import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MyChatroomVo {
	private String myChatroomNo;
	private String chatroomId;
	private String memberId;
//	private List<Member> member = new ArrayList<Member>();
	private int chatroomCount;
}
