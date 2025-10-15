<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<html>
<head>
    <title>Transaction History</title>
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
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #0077cc;
            color: #fff;
            font-weight: bold;
        }
        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <header>
        <h1>Transaction History</h1>
    </header>
    <nav>
        <a href="home.jsp">Home</a>
        <a href="transfer.jsp">Transfer Money</a>
        <a href="balance.jsp">View Balance</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <table>
        <tr>
            <th>ID</th>
            <th>Recipient</th>
            <th>Amount</th>
            <th>Date</th>
        </tr>
<%
    int userId = (int) session.getAttribute("user_id");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBanking", "root", "");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM Transactions WHERE user_id=?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("transaction_id") %></td>
            <td><%= rs.getString("recipient") %></td>
            <td><%= rs.getDouble("amount") %></td>
            <td><%= rs.getTimestamp("date") %></td>
        </tr>
<%
        }
    } catch (Exception e) {
%>
        <tr>
            <td colspan="4" style="color: red; text-align: center;">Error: <%= e.getMessage() %></td>
        </tr>
<%
    }
%>
    </table>
</body>
</html>
