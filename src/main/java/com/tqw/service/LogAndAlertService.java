package com.tqw.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.NamingException;

import com.tqw.Util.ConnectionUtil;
import com.tqw.Util.Constants;
import com.tqw.Util.LogEntity;
import com.tqw.entity.AlertSide;
import com.tqw.entity.PrinterStatus;
import com.tqw.entity.SystemParameter;

public class LogAndAlertService {
	public AlertSide getAlertSide(String location_id,Vector<String>loginData) throws Exception
	{
		 LogEntity.setTractionMap();
	//	SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	//	String date=df.format(System.currentTimeMillis());
		//String JsonData="{\"funcname\":\"" + "PaperJam" + "\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" +location_id+"||"+date+"\\\"}\"}";
	  // 	this.saveRequestOrReponseParamsLog(JsonData, loginData);
		 AlertSide alertside=new AlertSide();
		ArrayList<PrinterStatus>pss=searchPrinterStatusByLocationId(location_id);
		if(pss==null||pss.size()==0)return null;
		SystemParameter sp=searchSystemParameterByLocationId(location_id);
		if(sp==null)throw new Exception("Please Config System Parameters First!");
		int near;
		int mt;
		near=Integer.parseInt(sp.getTag_no_left_in_stik_trigger_paper_near_end_alert());
		mt=Integer.parseInt(sp.getLong_queue_time_alert_tqw());
		String paperJam="";
		String paperOut="";
		String paperNearlyRunOut="";
		String printerOffline="";
		String longTimeTag="";
		for(PrinterStatus ps:pss)
		{
			if(Constants.ENABLE.equals(ps.getPaperJam()))
			{
				alertside.getPaperJam().add(ps.getStikTerminalId());
				paperJam=paperJam+ps.getStikTerminalId()+"-";
			}
			if(Constants.ENABLE.equals(ps.getPaperEnd()))
			{
				alertside.getPaperOut().add(ps.getStikTerminalId());
				paperOut=paperOut+ps.getStikTerminalId()+"-";
			}
			if(ps.getPrintCount()<=near)
			{
				alertside.getPaperNearlyRunOut().add(ps.getStikTerminalId());
				paperNearlyRunOut=paperNearlyRunOut+ps.getStikTerminalId()+"-";
			}
			if(Constants.DISABLE.equals(ps.getPrinterOnline()))
			{
				alertside.getPrinterOffline().add(ps.getStikTerminalId());
				printerOffline=printerOffline+ps.getStikTerminalId()+"-";
			}

		}
		alertside.getLongTimeTag().addAll(searchTagNoByTagstatusAndTime("3", mt));
		for(int i=0;i<alertside.getLongTimeTag().size();i++)
		{
			longTimeTag=longTimeTag+alertside.getLongTimeTag().get(i)+"-";
		}
		String Result_PaperJam="{\"alloutpara\":\"MSG=GETASIDE||"+paperJam+"\",\"funcname\":\"PaperJam\",\"return_code\":\"0\"}";	
		String Result_PaperOut="{\"alloutpara\":\"MSG=GETASIDE||"+paperOut+"\",\"funcname\":\"PaperOut\",\"return_code\":\"0\"}";	
		String Result_PaperNearlyRunOut="{\"alloutpara\":\"MSG=GETASIDE||"+paperNearlyRunOut+"\",\"funcname\":\"PaperNearlyRunOut\",\"return_code\":\"0\"}";
		String Result_PrinterOffline="{\"alloutpara\":\"MSG=GETASIDE||"+printerOffline+"\",\"funcname\":\"PrinterOffline\",\"return_code\":\"0\"}";	
		String Result_LongTimeTag="{\"alloutpara\":\"MSG=GETASIDE||"+longTimeTag+"\",\"funcname\":\"LongTimeTag\",\"return_code\":\"0\"}";	
        this.saveRequestOrReponseParamsLog(Result_PaperJam, loginData);
        this.saveRequestOrReponseParamsLog(Result_PaperOut, loginData);
        this.saveRequestOrReponseParamsLog(Result_PaperNearlyRunOut, loginData);
        this.saveRequestOrReponseParamsLog(Result_PrinterOffline, loginData);
        this.saveRequestOrReponseParamsLog(Result_LongTimeTag, loginData);
		return alertside;
	}


	public SystemParameter searchSystemParameterByLocationId(String location_id) throws NamingException
	{
		Context ctx=null;
		Connection  con=ConnectionUtil.getCon(ctx);
		String sql="select long_queue_time_alert_tqw,tag_no_left_in_stik_trigger_paper_near_end_alert  from system_parameters_configuration  where location_id=?";


		PreparedStatement  pst=null;
		ResultSet rs=null;
		SystemParameter sp=new SystemParameter();
		try {
			pst=con.prepareStatement(sql);
			pst.setString(1, location_id);
			rs=pst.executeQuery();
			sp.setLong_queue_time_alert_tqw(null);
			while(rs.next())
			{
				sp.setLong_queue_time_alert_tqw(rs.getString("long_queue_time_alert_tqw"));
				sp.setTag_no_left_in_stik_trigger_paper_near_end_alert(rs.getString("tag_no_left_in_stik_trigger_paper_near_end_alert"));
			}
			ConnectionUtil.closeConnection(rs, pst, con, ctx);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(sp.getLong_queue_time_alert_tqw()!=null)
			return sp;
		else
			return null;
	}
	public  ArrayList<PrinterStatus> searchPrinterStatusByLocationId(String location_id) throws NamingException
	{
		Context ctx=null;
		Connection  con=ConnectionUtil.getCon(ctx);
		String sql="select * from  printer_status where location_id=?";
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
				ps.setPaperJam(rs.getString("paper_jam"));
				ps.setLocationId(rs.getString("location_id"));
				ps.setPaperEnd(rs.getString("paper_end"));
				ps.setPaperNearEndPrintCount(rs.getInt("paper_near_end_print_count"));
				ps.setPrinterOnline(rs.getString("printer_online"));
				ps.setStikTerminalId(rs.getString("stik_terminal_id"));
				ps.setPrintCount(rs.getInt("print_count"));
				pss.add(ps);
			}
			ConnectionUtil.closeConnection(rs, pst, con, ctx);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pss ;
	}
	public  ArrayList<String>  searchTagNoByTagstatusAndTime( String tagstatus, int time) throws NamingException
	{
		Context ctx=null;
		Connection  con=ConnectionUtil.getCon(ctx);

		String sql="select tag_id from tag_info where tag_status = ? and TIMESTAMPDIFF(MINUTE,STR_TO_DATE(CONCAT(apm_date,queue_arrival_time),'%Y%m%d%H%i%s'),SYSDATE())>? ";
		//and  str_to_date(apm_date,'%Y%m%d%')>date_sub(curdate(),interval 1 day)
		PreparedStatement  pst=null;
		ResultSet rs=null;
		ArrayList<String> tagnos=new ArrayList<String>();
		try {
			pst=con.prepareStatement(sql);
			pst.setString(1, tagstatus);
			pst.setInt(2, time);
			rs=pst.executeQuery();
			while(rs.next())
			{
				String tagno=rs.getString("tag_id");
				if(tagno!=null&&tagno.length()<=6)
					tagnos.add(tagno);
			}
			ConnectionUtil.closeConnection(rs, pst, con, ctx);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return tagnos;

	}

	public boolean saveRequestOrReponseParamsLog(String data,Vector<String>loginData) throws SQLException, NamingException
	{
		int result=-1;
		LogEntity log=new LogEntity ();
		LogEntity.setTractionMap();
		if(data.indexOf("MSG")==-1)
		{
			log.getParameterFromRequest(data, loginData);
		}
		else
		{
			log.getParameterFromResponse(data, loginData);
		}
		Vector<String>params=log.getParams();
		System.out.println();
		for(int i=0;i<params.size();i++)
		{
			System.out.print(params.get(i)+",");
		}
		Context ctx=null;
		 
		Connection  con=ConnectionUtil.getCon(ctx);
			String sql="insert into audit_trail(action_time,location_id,terminal_id,user_id,transaction_id,";
			for(int i=5;i<params.size();i++)
			{
				if(i<14)
				{
					if(i!=params.size()-1)
					{
						sql=sql+"param_value_0"+(i-4)+",";
					}
					else
					{
						sql=sql+"param_value_0"+(i-4);
					}
				}
				else
				{
					if(i<params.size()-1)
					sql=sql+"param_value_"+(i-4)+",";
					else
					{
						sql=sql+"param_value_"+(i-4);
					}
				}
			}
	 
			sql=sql+") values(";
			for(int i=0;i<params.size()-1;i++)
			{
				sql=sql+"?,";
			}
			sql=sql+"? )";
			System.out.println(sql);
			PreparedStatement  pst=null;
			try {
				
				pst=con.prepareStatement(sql);
				for(int i=0;i<params.size();i++)
				{
					pst.setString(i+1,params.get(i));
				}
				result=pst.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();

			}
			ConnectionUtil.closeConnection(null, pst, con, ctx);
			if(result==1)
			{
				return true;
			}
			else
			{
				return false;
			}
		}






		/*
public  int  writeTQWLog(String ) throws NamingException
{
	Context ctx=null;
	Connection  con=ConnectionUtil.getCon(ctx);

	 String sql="insert into  audit_trail values( ";
	 for(int i=0;i<params.length();i++)
	 {

	 }
 //and  str_to_date(apm_date,'%Y%m%d%')>date_sub(curdate(),interval 1 day)
	 PreparedStatement  pst=null;
    ResultSet rs=null;
    ArrayList<String> tagnos=new ArrayList<String>();
   try {
		pst=con.prepareStatement(sql);
		pst.setString(1, tagstatus);
		pst.setInt(2, time);
	    rs=pst.executeQuery();
	    while(rs.next())
	    {
	    String tagno=rs.getString("tag_id");
	    if(tagno!=null&&tagno.length()<=6)
	    tagnos.add(tagno);
	    }
	    ConnectionUtil.closeConnection(rs, pst, con, ctx);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
 return tagnos;

}
		 */
	}
