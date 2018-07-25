package com.tqw.Util;

import java.text.SimpleDateFormat;
import java.util.Vector;

import org.apache.commons.collections.map.HashedMap;

public class LogEntity {
	public static HashedMap tractionId_val_map=new HashedMap();
	public String data;
	public Vector<String> params;
	public static void setTractionMap() {
		tractionId_val_map.put("PrintTag","T11");
	}
	public String getData() 
	{
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	public LogEntity()
	{

	}
	public LogEntity(String data)
	{
		this.data=data;
	}
	//loginData location_id termin_id user_Id
	// JSON Data : {"funcname":"PrintTag","allinputpara":"{"dummy" :"||REGDesk||TD||k111111||2111||1||1||2408||tag2||smartics2||location id"}" 
	public void getParameterFromRequest(String data,Vector<String>loginData)
	{
		params=new Vector<String>();
		if(data!=null&&data.length()>2)
		{
			SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			params.add(df.format(System.currentTimeMillis()));
			String trac_Id="";
			Vector<String> paras=new Vector<String>();
			data=data.replaceAll("\"", "");
 
			data=data.substring(1, data.length()-3);	
		 
			String[]datas=data.split(",");
			for(int i=0;i<datas.length;i++)
			{
				if(datas[i].indexOf("funcname")!=-1)
				{
					trac_Id= (String) tractionId_val_map.get(datas[i].split(":")[1].replaceAll(" ", ""));
				}
				else if(datas[i].indexOf("allinputpara")!=-1)
				{
					String allinputpara=datas[i].split(":")[2];
					System.out.println(allinputpara);
					allinputpara=allinputpara.substring(allinputpara.indexOf("||")+2);
					System.out.println(allinputpara);
					String []allinput=allinputpara.split("\\|\\|");


					for(int p=0;p<allinput.length;p++)
					{
						for(int j=0;j<loginData.size();j++)
						{
							if(allinput[p]!=null&&allinput[p].equals(loginData.get(j)))
							{
								allinput[p]="";
							}
						}
					}
				for(int q=0;q<allinput.length;q++)
				{
					if(allinput[q]!="")
					{
						paras.add(allinput[q]);
						System.out.print(allinput[q]+",");
					}
				}
			}
		}
		for(int n=0;n<loginData.size();n++)
		{
			params.add(loginData.get(n));
		}
		params.add(trac_Id);
		for(int k=0;k<paras.size();k++)
		{
			params.add(paras.get(k));
		}
		
	}
}

public Vector<String> getParams() {
	return params;
}
public void getParameterFromResponse(String data,Vector<String>loginData)
{

	params=new Vector<String>();
	if(data!=null&&data.length()>2)
	{
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
		params.add(df.format(System.currentTimeMillis()));
		//11111111111111111111
		data=data.replaceAll("\"", "");
		 
		System.out.println(data);
		data=data.substring(1, data.length()-1);	
		Vector<String>paras=new Vector<String>();
		String result="";
		String funcname="";
		String return_code="";
		String trac_Id=null;

		String[]datas=data.split(",");

		for(int i=0;i<datas.length;i++)
		{
			if(datas[i].indexOf("alloutpara")!=-1)
			{
				String alloutpara=datas[i].split(":")[1];
				result=alloutpara.substring(alloutpara.indexOf("=")+1, alloutpara.indexOf("||"));
				alloutpara=alloutpara.substring(alloutpara.indexOf("||")+2);
				String []allout=alloutpara.split("\\|\\|");
				for(int p=0;p<allout.length;p++)
				{
						if(allout[p]!=null&&allout[p].equals(loginData.get(1)))
						{
							allout[p]="";
						}
					
				}
			for(int q=0;q<allout.length;q++)
			{
				if(allout[q]!="")
				{
					paras.add(allout[q]);
				 
				}
			}
			
			}
			else if(datas[i].indexOf("funcname")!=-1)
			{
				funcname=datas[i].split(":")[1];
			}
			else if(datas[i].indexOf("return_code")!=-1)
			{
 
				return_code=(datas[i].split(":"))[1];
			
			}
		}
	 
	
		for(int n=0;n<loginData.size();n++)
		{
			params.add(loginData.get(n));
		}
		params.add(trac_Id);
		params.add(funcname);
		params.add(result);
		params.add(return_code);
		for(int k=0;k<paras.size();k++)
		{
			params.add(paras.get(k));
		}
	}
}

}
