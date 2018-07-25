function messageBox(message,confirm) {
    var box = "<div class=\"modal fade\" id=\"message_box\" tabindex=\"-1\" role=\"dialog\">" +
        "    <div class=\"modal-dialog modal-sm\" role=\"document\">" +
        "        <div class=\"modal-content\">" +
        "            <div class=\"modal-header\">" +
        "                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" +
        "                <h4 class=\"modal-title\"></h4>" +
        "            </div>" +
        "            <div class=\"modal-body\">" +
        "                <p>"+message+"</p>" +
        "            </div>" +
        "            <div class=\"modal-footer\">" +
        "                <button type=\"button\" class=\"btn btn-primary confirm-btn btn-sm\" data-dismiss=\"modal\">OK</button>" +
        "            </div>" +
        "        </div>" +
        "    </div>" +
        "</div>";
    $('#message_box').siblings('.modal-backdrop.fade').remove();
    $('#message_box').remove();
    $('body').append(box);
    $('#message_box').modal();
    if(confirm){
        $('#message_box').on('hidden.bs.modal', function () {
            confirm();
        })
    }
}
function sAlert(message,fun) {
    messageBox(message, fun);
}


function getSideAlert(alertSideString) {
    if($('#paper_jam').length==0) return false;
    if(alertSideString=="null"||alertSideString==null) return false;
                var ret = JSON.parse(alertSideString);
                if(ret.paperJam.length>0){
                    var txt1 = '';
                    if(ret.paperJam.length > 2){
                        txt1 = '['+ret.paperJam.slice(0,2).join('][')+']...';
                    }else{
                        txt1  = '['+ret.paperJam.join('][')+']';
                    }
                    $('#paper_jam').removeClass('hidden').find('div img').on('click', function () {
                        sAlert('Paper Jam ' + '['+ret.paperJam.join('][')+']');
                    })
                    $('#paper_jam b').text(txt1);
                }
                if(ret.paperOut.length>0){
                    var txt2 = '';
                    if(ret.paperOut.length > 2){
                        txt2 = '['+ret.paperOut.slice(0,2).join('][')+']...';
                    }else{
                        txt2  = '['+ret.paperOut.join('][')+']';
                    }
                    $('#paper_out').removeClass('hidden').find('div img').on('click', function () {
                        sAlert('Out of Paper ' + '['+ret.paperOut.join('][')+']');
                    })
                    $('#paper_out b').text(txt2);
                }
                if(ret.paperNearlyRunOut.length>0){
                    var txt3 = '';
                    if(ret.paperNearlyRunOut.length > 2){
                        txt3 = '['+ret.paperNearlyRunOut.slice(0,2).join('][')+']...';
                    }else{
                        txt3  = '['+ret.paperNearlyRunOut.join('][')+']';
                    }
                    $('#paper_nearly_out').removeClass('hidden').find('div img').on('click', function () {
                        sAlert('Paper Nearly Run Out ' + '['+ret.paperNearlyRunOut.join('][')+']');
                    })
                    $('#paper_nearly_out b').text(txt3);
                }
                if(ret.printerOffline.length>0){
                    var txt4 = '';
                    if(ret.printerOffline.length > 2){
                        txt4 = '['+ret.printerOffline.slice(0,2).join('][')+']...';
                    }else{
                        txt4  = '['+ret.printerOffline.join('][')+']';
                    }
                    $('#printer_offline').removeClass('hidden').find('div img').on('click', function () {
                        sAlert('Printer Offline ' + '['+ret.printerOffline.join('][')+']');
                    })
                    $('#printer_offline b').text(txt4);
                }
                if(ret.longTimeTag.length>0){
                    var txt5 = '';
                    if(ret.longTimeTag.length > 2){
                        txt5 = '['+ret.longTimeTag.slice(0,2).join('][')+']...';
                    }else{
                        txt5  = '['+ret.longTimeTag.join('][')+']';
                    }
                    $('#long_wait_tags').removeClass('hidden').find('div img').on('click', function () {
                        sAlert('*****  Long Waiting Time Alert  ***** <br> Tag No.:' + '['+ret.longTimeTag.join('][')+']');
                    })
                    console.log(txt5)
                    $('#long_wait_tags b').text(txt5);
                }
}


function ShowMsg(title,msg) {
	var msg=title + '\n\n' +msg  ;
	    //alert(msg);
	 }
