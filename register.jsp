<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: 50px auto;
        }
        form h2 {
            text-align: center;
            color: #005fa3;
            margin-bottom: 20px;
        }
        form input[type="text"], form input[type="password"], form input[type="number"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        form input[type="submit"] {
            width: 100%;
            background-color: #0077cc;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        form input[type="submit"]:hover {
            background-color: #005fa3;
        }
        p {
            text-align: center;
            color: green;
            font-weight: bold;
        }
        p.error {
            color: red;
        }
    </style>
</head>
<body>
    <form action="register.jsp" method="post">
        <h2>Register</h2>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="number" name="balance" placeholder="Initial Balance" min="0" required>
        <input type="submit" value="Register">
    </form>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String balanceStr = request.getParameter("balance");

    if (username != null && password != null && balanceStr != null) {
        try {
            double balance = Double.parseDouble(balanceStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBanking", "root", "");

            PreparedStatement ps = con.prepareStatement("INSERT INTO Users (username, password, balance) VALUES (?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setDouble(3, balance);
            ps.executeUpdate();

            out.println("<p>Registration successful. <a href='login.jsp'>Login here</a></p>");
        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
