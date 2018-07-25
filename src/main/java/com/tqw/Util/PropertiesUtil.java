package com.tqw.Util;
import java.io.*;
import java.util.Properties;
import java.util.ResourceBundle;

public class PropertiesUtil {

	public static String getByKey(String key){
		ResourceBundle resource = ResourceBundle.getBundle("app");
		return resource.getString(key);
	}

	public static void main(String[] args) {
		System.out.println(getByKey("upms.address"));
	}

	 public static String  getDefaultResetCountFromProperties(String filePath)throws IOException{
	        Properties prop=new Properties();
	        FileInputStream inputFile=new FileInputStream(filePath);
	        prop.load(inputFile);
	        
	      /*  Iterator<String> it=prop.stringPropertyNames().iterator();
	        while(it.hasNext()){
	            String key=it.next();
	            if(key.equals("default_reset_count"))
	            {
	            	return prop.getProperty(key);
	            }
	         
	        }
	        */
			return  prop.getProperty("default_reset_count");
	    }

	    /**
	     * 生成properties属性文件
	     */
	    public static void writeProperties()  {

	        Properties prop=new Properties();
	        try{
	            //FileOutputStream oFile=new FileOutputStream("sys-config.properties",true);
	            FileOutputStream oFile=new FileOutputStream(new File("src/sys-config.properties"),true);
	            prop.setProperty("xxx","xx");
	            prop.setProperty("xx","xx");
	            prop.store(oFile,"sys-config");
	            oFile.close();
	        } catch (FileNotFoundException e) {
	            System.out.println(e);
	        } catch (IOException e) {
	            System.out.println(e);
	        }
	    }
}

