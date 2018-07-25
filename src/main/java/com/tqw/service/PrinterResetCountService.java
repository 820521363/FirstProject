package com.tqw.service;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.NamingException;

import com.tqw.Util.ConnectionUtil;
import com.tqw.Util.PropertiesUtil;
import com.tqw.entity.PrinterStatus;

public class PrinterResetCountService {
	
	public  ArrayList<PrinterStatus> searchPrinterStatusByLocationId(String location_id) throws NamingException
	{
		Context ctx=null;
		Connection  con=ConnectionUtil.getCon(ctx);
		 String sql="select idx, location_id, stik_terminal_id,print_count, paper_near_end_print_count from  printer_status where location_id=?";
		 PreparedStatement  pst=null;
	     ResultSet rs=null;
	    ArrayList<PrinterStatus> pss=new ArrayList<PrinterStatus>();
	   try {
			pst=con.prepareStatement(sql);
			pst.setString(1, location_id);
		    rs=pst.executeQuery();
		    while(rs.next())
		    {
		    	PrinterStatus ps=new PrinterStatus();
		    	ps.setIdx(rs.getInt("idx"));
		    	ps.setLocationId(rs.getString("location_id"));
		    	ps.setStikTerminalId(rs.getString("stik_terminal_id"));
		    	ps.setPrintCount(rs.getInt("print_count"));
		    	ps.setPaperNearEndPrintCount(rs.getInt("paper_near_end_print_count"));
		    	pss.add(ps);
		    }
		    ConnectionUtil.closeConnection(rs, pst, con, ctx);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pss ;
	}
	public  int  resetPrinterCountById(int id) throws NamingException
	{
		
		int defaultPrintCount=1000;
		String value=null;
		try {
			value = PropertiesUtil.getDefaultResetCountFromProperties("WebContent/printer_reset_default-config.properties");
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(value!=null)
		{
			defaultPrintCount=Integer.parseInt(value);
		}
		int result=-1;
		Context ctx=null;
		Connection  con=ConnectionUtil.getCon(ctx);
		 ResultSet rs=null;
		 String sql="update printer_status set print_count=? where idx=?";
		 PreparedStatement ps=null;
	 
	   try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, defaultPrintCount);
			ps.setInt(2, id);
			result=ps.executeUpdate();
		    ConnectionUtil.closeConnection(rs, ps, con, ctx);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 return result;

	}

}
