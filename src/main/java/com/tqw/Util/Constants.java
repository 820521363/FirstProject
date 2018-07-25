package com.tqw.Util;
public class Constants {
	public static final String ENABLE="Y"; 
	public static final String DISABLE="N"; 
	
    public enum TagStatus{
        ShowUp("0","ShowUp"),No_Show("1","No Show"),
        DAFP("2","De-activated: form prefilling"),
        DANS("2","De-activated: no show"),
        DAM("2","De-activated: manual"),
        /*DeActivated("2", "Deactivated"),*/
        WIQ("3","Waiting in queue"),
        Called("4","Called"),Completed("5","Completed"),Terminated("6","Terminated"),Absent("7","Absent"),
        Buffered("8","Buffered");
        String val;
        String display;

        TagStatus(String val, String display) {
            this.val = val;
            this.display = display;
        }

        public String getVal(){
            return this.val;
        }

        public String getDisplay() {
            return display;
        }

        public static String getDisplayByVal(String val){
            if(val==null||val=="") return null;
            for(TagStatus tagStatus : TagStatus.values()){
                if(val.equals(tagStatus.getVal())){
                    return tagStatus.getDisplay();
                }
            }
            return null;
        }
    }
    
}
