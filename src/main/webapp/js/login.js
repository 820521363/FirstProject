function loadTerminal() {
    var URL = "https://localhost/terminal/immdini";
    $.ajax({
        url: URL,
        type: "GET",
        success: function (mdata) {
            $.each(mdata, function (key, data) {
                // console.log(key + " value ["+JSON.stringify(data)+"]");
                if(key === 'common'){
                    console.log(data.terminalID);
                    if(data.terminalID){
                        $('#inputTerminalId').val(data.terminalID);
                        $('#inputTerminalId').prop('readonly',true);
                    }else{
                        $('#inputTerminalId').prop('readonly',false);
                    }
                }
            });
        },
        error: function () {
            $('#inputTerminalId').prop('readonly',false);
        }
    });
}

$(function () {
    loadTerminal();
    if($('#inputTerminalId').val() == ''){
        $('#inputTerminalId').removeAttr("readonly");
    }
})