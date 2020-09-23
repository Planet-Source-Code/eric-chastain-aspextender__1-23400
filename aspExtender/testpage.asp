<%
	dim oExtender : set oExtender = server.CreateObject ("aspExtender.net")
%>
<html>
	<head>
		<title>
			net include test
		</title>
	</head>
<body bgcolor="white" text="black">
	<!--brinkster rocks, check them out for banner ad free web hosting w/asp capabilities-->
	<%=oExtender.outerInclude("http://www16.brinkster.com/ericchastain/menu.txt")%>
</body>
</html>