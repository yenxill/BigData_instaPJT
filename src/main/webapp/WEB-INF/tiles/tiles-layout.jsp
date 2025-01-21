<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
  <!-- <link rel="stylesheet" href="/css/egovframework/main.css"/> -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png"/>
<link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/favicon/favicon-32x32.png"/>
<link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/favicon/favicon-16x16.png"/>

<title>Instagram | Main</title>
<tiles:insertAttribute name="header"/>
</head>
<body>
	<div id="wrap" class="container">
		<div class="content">
			<tiles:insertAttribute name="body"/>
		</div>
		
	</div>
	<tiles:insertAttribute name="footer"/>
</body>
</html>