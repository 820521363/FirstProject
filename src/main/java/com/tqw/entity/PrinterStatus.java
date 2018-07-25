package com.tqw.entity;
 
public class PrinterStatus {
 
    private int idx; 
    public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	private String locationId;

    private String stikTerminalId;

     
    private String paperJam;
   
    private String paperEnd;

    
    private String printerOnline;

     
    private int printCount;

    private int paperNearEndPrintCount;

	public String getLocationId() {
		return locationId;
	}

	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}

	public String getStikTerminalId() {
		return stikTerminalId;
	}

	public void setStikTerminalId(String stikTerminalId) {
		this.stikTerminalId = stikTerminalId;
	}

	public String getPaperJam() {
		return paperJam;
	}

	public void setPaperJam(String paperJam) {
		this.paperJam = paperJam;
	}

	public String getPaperEnd() {
		return paperEnd;
	}

	public void setPaperEnd(String paperEnd) {
		this.paperEnd = paperEnd;
	}

	public String getPrinterOnline() {
		return printerOnline;
	}

	public void setPrinterOnline(String printerOnline) {
		this.printerOnline = printerOnline;
	}

	public int getPrintCount() {
		return printCount;
	}

	public void setPrintCount(int printCount) {
		this.printCount = printCount;
	}

	public int getPaperNearEndPrintCount() {
		return paperNearEndPrintCount;
	}

	public void setPaperNearEndPrintCount(int paperNearEndPrintCount) {
		this.paperNearEndPrintCount = paperNearEndPrintCount;
	}    
}
