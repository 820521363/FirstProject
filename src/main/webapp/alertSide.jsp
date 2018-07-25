 <div id="layer"  style="position:fixed; width:100px; height:630px; z-index:1; right: 20px; top: 180px"> 
          
  <table   id="layer1" width="100%" border="0" cellspacing="0" cellpadding="5">
    <tr> 
      <td bgcolor="#003300" > 
        <div align="center"><b><font color="#FFFF00">Alerts</font></b></div>
      </td>
    </tr>
    <tr id="paper_jam" class="hidden"> 
      <td bgcolor="#FFFFCC"> 
        <div align="center"><font size="3"><a href="#"><img src="<%=request.getContextPath()%>/images/jam.png" width="50" height="50" border="0" ></a><br>
          Paper Jam!<br>
          <font size="2" color="#6600FF"><b>[1] [2]</b></font></font></div>
        <div align="center"></div>
      </td>
    </tr>
    <tr id="paper_out" class="hidden"> 
      <td bgcolor="#FFFFCC"> 
        <div align="center"><font size="3"><a href="#"><img src="<%=request.getContextPath()%>/images/out.png" width="50" height="50"  border="0" ></a><br>
          Out of Paper!</font> <br>
          <font size="1"><font size="2" color="#6600FF"><b>[4]</b></font></font> 
        </div>
      </td>
    </tr>
    <tr id="paper_nearly_out" class="hidden"> 
      <td bgcolor="#FFFFCC"> 
        <div align="center"><font size="3"><a href="#"><img src="<%=request.getContextPath()%>/images/near_logo.png" width="50" height="50" border="0"  ></a><br>
          Paper Nearly Run Out!<br>
          <font size="2" color="#6600FF"><b>[3]</b></font></font></div>
        </td>
    </tr>
    <tr id="printer_offline" class="hidden"> 
      <td bgcolor="#FFFFCC"> 
        <div align="center"><font size="3"><a href="#"><img src="<%=request.getContextPath()%>/images/offline.png" width="50" height="50" border="0" ></a><br>
          </font><font size="3">Printer Offline!</font> <br>
          <font size="1"><font size="2" color="#6600FF"><b>[7][9]</b></font></font></div>
      </td>
    </tr>
    <tr id="long_wait_tags" class="hidden"> 
      <td bgcolor="#FFFFCC"> 
         <div align="center"><font size="3"><a href="#"><img src="<%=request.getContextPath()%>/images/long_queue.png" width="50" height="50" border="0"  ></a><br>
          Long Waiting Time! <br>
        <font size="2" color="#6600FF"><b></b></font></font></div>
      </td>
    </tr>
  </table>
        </div>  