<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML lang="zh-HK">
	<HEAD>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</HEAD>
	<script>
	function sendws(wsmessage){
		var string1 = wsmessage;
		//console.log(string1);
		//var exampleSocket = new WebSocket("wss://127.0.0.1:4004", string1);
		var exampleSocket = new WebSocket("wss://127.0.0.1:4004"); 
		exampleSocket.send(string1); 
		exampleSocket.close();
	}

	function sendws2(wsmessage){
		var socket = new WebSocket('wss://127.0.0.1:4004');
		// Open the socket
		socket.onopen = function(wsmessage) {	
			// Send an initial message
			socket.send(wsmessage);	
			// Listen for messages
			socket.onmessage = function(event) {
				console.log('Client received a message',event);
			};	
			// Listen for socket closes
			socket.onclose = function(event) {
				console.log('Client notified socket has closed',event);
			};	
		};
			socket.send(wsmessage);
			// To close the socket....
			socket.close();	
	};

	function sendws3(wsmessage){
		// Create WebSocket connection.
		const socket = new WebSocket('wss://127.0.0.1:4004');

		// Connection opened
		socket.addEventListener('open', function (event) {
			socket.send(wsmessage + '\n');
			socket.close();
		});

		// Listen for messages
		socket.addEventListener('message', function (event) {
			console.log('Message from server ', event.data);
		});
		alert(wsmessage);
	}
	</script>
<body>
<button onclick="sendws3('MSG=PRINTTAGNOW||元朗||Yuen Long||A1||申請香港身份證||Application for Hong Kong Identity Card||2017-09-18||09:33||30||0||2408');">ws test4</button>
<BR>元朗||Yuen Long||A1||申請香港身份證
</BODY>
</HTML>