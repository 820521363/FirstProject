package com.tqw.entity;

import java.util.ArrayList;
import java.util.List;

public class AlertSide {

	List<String> paperJam;

    List<String> paperOut;

    List<String> paperNearlyRunOut;

    List<String> printerOffline;

    List<String> longTimeTag;
    public AlertSide(){
        paperJam = new ArrayList<String>();
        paperOut = new ArrayList<String>();
        paperNearlyRunOut = new ArrayList<String>();
        printerOffline = new ArrayList<String>();
        longTimeTag = new ArrayList<String>();
    }
	public List<String> getPaperJam() {
		return paperJam;
	}
	public void setPaperJam(List<String> paperJam) {
		this.paperJam = paperJam;
	}
	public List<String> getPaperOut() {
		return paperOut;
	}
	public void setPaperOut(List<String> paperOut) {
		this.paperOut = paperOut;
	}
	public List<String> getPaperNearlyRunOut() {
		return paperNearlyRunOut;
	}
	public void setPaperNearlyRunOut(List<String> paperNearlyRunOut) {
		this.paperNearlyRunOut = paperNearlyRunOut;
	}
	public List<String> getPrinterOffline() {
		return printerOffline;
	}
	public void setPrinterOffline(List<String> printerOffline) {
		this.printerOffline = printerOffline;
	}
	public List<String> getLongTimeTag() {
		return longTimeTag;
	}
	public void setLongTimeTag(List<String> longTimeTag) {
		this.longTimeTag = longTimeTag;
	}
    
    
}
