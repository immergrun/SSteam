package com.ss.demo.domain;

public class EventReviewVO {
	
	private int comment_number;
	private int event_number;
	private int uNo;
	private int Ratio;
	
	private String comment_content;
	private String comment_title;
	
	
	public int getComment_number() {
		return comment_number;
	}
	public int getEvent_number() {
		return event_number;
	}
	public int getuNo() {
		return uNo;
	}
	public int getRatio() {
		return Ratio;
	}
	public String getComment_content() {
		return comment_content;
	}
	public String getComment_title() {
		return comment_title;
	}
	
	
	
	
	public void setComment_number(int comment_number) {
		this.comment_number = comment_number;
	}
	public void setEvent_number(int event_number) {
		this.event_number = event_number;
	}
	public void setuNo(int uNo) {
		this.uNo = uNo;
	}
	public void setRatio(int ratio) {
		Ratio = ratio;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public void setComment_title(String comment_title) {
		this.comment_title = comment_title;
	}
	
	
	@Override
	public String toString() {
		return "EventReviewVO [comment_number=" + comment_number + ", event_number=" + event_number + ", uNo=" + uNo
				+ ", Ratio=" + Ratio + ", comment_content=" + comment_content + ", comment_title=" + comment_title
				+ "]";
	}
	
	
	
}
