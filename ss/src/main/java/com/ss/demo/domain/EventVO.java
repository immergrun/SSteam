package com.ss.demo.domain;

public class EventVO {
	
	private int event_number;
	private int uNo;
	private int hit_count;
	
	private String  event_title;
	private String  event_content;
	private String event_discript;
	private String  write_date;
	private String  event_tel;
	private String  event_start;
	private String  event_end;
	private String  event_local;
	private String  LType;
	
	private int attach_number;
	private String Thumbnail;
	private String attach_logical_name;
	private String attach_physical_name;
	
	//get
	public int getEvent_number() {
		return event_number;
	}
	public int getuNo() {
		return uNo;
	}
	
	public String getEvent_title() {
		return event_title;
	}
	public String getEvent_content() {
		return event_content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public String getEvent_tel() {
		return event_tel;
	}
	public String getEvent_start() {
		return event_start;
	}
	public String getEvent_end() {
		return event_end;
	}
	public String getEvent_local() {
		return event_local;
	}
	public String getLType() {
		return LType;
	}
	public int getAttach_number() {
		return attach_number;
	}
	public String getAttach_logical_name() {
		return attach_logical_name;
	}
	public String getAttach_physical_name() {
		return attach_physical_name;
	}
	public int getHit_count() {
		return hit_count;
	}
	public String getThumbnail() {
		return Thumbnail;
	}
	public String getEvent_discript() {
		return event_discript;
	}
	
	
	
	//set
	public void setEvent_discript(String event_discript) {
		this.event_discript = event_discript;
	}
	public void setEvent_number(int event_number) {
		this.event_number = event_number;
	}
	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public void setEvent_tel(String event_tel) {
		this.event_tel = event_tel;
	}
	public void setEvent_start(String event_start) {
		this.event_start = event_start;
	}
	public void setEvent_end(String event_end) {
		this.event_end = event_end;
	}
	public void setEvent_local(String event_local) {
		this.event_local = event_local;
	}
	public void setLType(String lType) {
		LType = lType;
	}
	public void setAttach_number(int attach_number) {
		this.attach_number = attach_number;
	}
	public void setAttach_logical_name(String attach_logical_name) {
		this.attach_logical_name = attach_logical_name;
	}
	public void setAttach_physical_name(String attach_physical_name) {
		this.attach_physical_name = attach_physical_name;
	}
	public void setHit_count(int hit_count) {
		this.hit_count = hit_count;
	}
	public void setThumbnail(String thumbnail) {
		Thumbnail = thumbnail;
	}
	

	
	@Override
	public String toString() {
		return "EventVO [event_number=" + event_number + ", uNo=" + uNo + ", hit_count=" + hit_count + ", event_title="
				+ event_title + ", event_content=" + event_content + ", event_discript=" + event_discript
				+ ", write_date=" + write_date + ", event_tel=" + event_tel + ", event_start=" + event_start
				+ ", event_end=" + event_end + ", event_local=" + event_local + ", LType=" + LType + ", attach_number="
				+ attach_number + ", Thumbnail=" + Thumbnail + ", attach_logical_name=" + attach_logical_name
				+ ", attach_physical_name=" + attach_physical_name + "]";
	}
	
	
	public String getTypeStr()
	{
		String result = "";
		switch(LType)
		{
			case "TT" : result = "전체"; break;
			case "GG" : result = "경기"; break;
			case "GW" : result = "강원"; break;
			case "CB" : result = "충북"; break;
			case "CN" : result = "충남"; break;
			case "GB" : result = "경북"; break;
			case "GN" : result = "경남"; break;
			case "JB" : result = "전북"; break;
			case "JN" : result = "전남"; break;
			case "JJ" : result = "제주"; break;
			
		}
		return result;
	}
	
	
	
	
}
