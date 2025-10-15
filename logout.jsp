<%@ page session="true" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <title>Logout</title>
</head>
<body>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
</body>
</html>
