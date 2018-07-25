package com.tqw.entity;

public class SystemParameter {
private String long_queue_time_alert_tqw ;
private String tag_no_left_in_stik_trigger_paper_near_end_alert;

public SystemParameter(String long_queue_time_alert_tqw, String tag_no_left_in_stik_trigger_paper_near_end_alert) {
	super();
	this.long_queue_time_alert_tqw = long_queue_time_alert_tqw;
	this.tag_no_left_in_stik_trigger_paper_near_end_alert = tag_no_left_in_stik_trigger_paper_near_end_alert;
}

public SystemParameter() {
	super();
	// TODO Auto-generated constructor stub
}

public String getLong_queue_time_alert_tqw() {
	return long_queue_time_alert_tqw;
}
public void setLong_queue_time_alert_tqw(String long_queue_time_alert_tqw) {
	this.long_queue_time_alert_tqw = long_queue_time_alert_tqw;
}
public String getTag_no_left_in_stik_trigger_paper_near_end_alert() {
	return tag_no_left_in_stik_trigger_paper_near_end_alert;
}
public void setTag_no_left_in_stik_trigger_paper_near_end_alert(
		String tag_no_left_in_stik_trigger_paper_near_end_alert) {
	this.tag_no_left_in_stik_trigger_paper_near_end_alert = tag_no_left_in_stik_trigger_paper_near_end_alert;
}


}
