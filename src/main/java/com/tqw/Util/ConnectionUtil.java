package com.tqw.Util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
public class ConnectionUtil {
	 public static Connection getCon(Context ctx) {
		 Connection conn=null;
		try {
			ctx = new InitialContext();
			DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/mySQLDS");
	         conn=ds.getConnection();
	     }catch(Exception e){
	         e.printStackTrace();
	     }
	     return conn;
	 }  
	 
	 public static void  closeConnection(ResultSet rs,PreparedStatement pst,Connection con,Context ctx) throws SQLException, NamingException
	 {
		 if(rs!=null)
		   {
			   rs.close();
			   rs=null;
		   }
		   if(pst!=null)
		   {
			   pst.close();
			   pst=null;
		   }
		   if(con!=null)
		   {
			   con.close();
			   con=null;
		   }
		   if(ctx!=null)
		   {
			   ctx.close();
			   ctx=null;
		   }
	 }
}
