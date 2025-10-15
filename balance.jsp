<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<html>
<head>
    <title>View Balance</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }
        header {
            background-color: #0077cc;
            color: #fff;
            padding: 15px 0;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        nav {
            background-color: #005fa3;
            overflow: hidden;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
        }
        nav a {
            float: left;
            display: block;
            color: #fff;
            text-decoration: none;
            padding: 14px 20px;
            font-weight: bold;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        nav a:hover {
            background-color: #004080;
        }
        .balance {
            background: #fff;
            padding: 20px;
            margin: 50px auto;
            max-width: 400px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .balance h2 {
            color: #005fa3;
        }
    </style>
</head>
<body>
    <header>
        <h1>View Balance</h1>
    </header>
    <nav>
        <a href="home.jsp">Home</a>
        <a href="transfer.jsp">Transfer Money</a>
        <a href="history.jsp">Transaction History</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <div class="balance">
        <h2>Your Balance</h2>
<%
    int userId = (int) session.getAttribute("user_id");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBanking", "root", "");

        PreparedStatement ps = con.prepareStatement("SELECT balance FROM Users WHERE user_id=?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            double balance = rs.getDouble("balance");
            out.println("<p>Balance: $" + balance + "</p>");
        } else {
            out.println("<p>Error retrieving balance!</p>");
        }
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
    }
%>
    </div>
</body>
</html>
