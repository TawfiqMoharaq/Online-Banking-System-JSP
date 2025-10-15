<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<html>
<head>
    <title>Transfer Money</title>
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
        form input[type="text"], form input[type="number"] {
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
        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #c3e6cb;
            margin: 20px auto;
            text-align: center;
            max-width: 400px;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #f5c6cb;
            margin: 20px auto;
            text-align: center;
            max-width: 400px;
        }
    </style>
</head>
<body>
    <header>
        <h1>Transfer Money</h1>
    </header>
    <nav>
        <a href="home.jsp">Home</a>
        <a href="history.jsp">Transaction History</a>
        <a href="balance.jsp">View Balance</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <form action="transfer.jsp" method="post">
        <h2>Make a Transfer</h2>
        <input type="text" name="recipient" placeholder="Recipient Username" required>
        <input type="number" name="amount" placeholder="Amount" required>
        <input type="submit" value="Transfer">
    </form>
<%
    String recipient = request.getParameter("recipient");
    String amountStr = request.getParameter("amount");

    if (recipient != null && amountStr != null) {
        double amount = Double.parseDouble(amountStr);
        int userId = (int) session.getAttribute("user_id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBanking", "root", "");

            con.setAutoCommit(false);

            PreparedStatement ps1 = con.prepareStatement("SELECT balance FROM Users WHERE user_id=?");
            ps1.setInt(1, userId);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next() && rs1.getDouble("balance") >= amount) {
                PreparedStatement ps2 = con.prepareStatement("UPDATE Users SET balance = balance - ? WHERE user_id=?");
                ps2.setDouble(1, amount);
                ps2.setInt(2, userId);
                ps2.executeUpdate();

                PreparedStatement ps3 = con.prepareStatement("UPDATE Users SET balance = balance + ? WHERE username=?");
                ps3.setDouble(1, amount);
                ps3.setString(2, recipient);
                ps3.executeUpdate();

                PreparedStatement ps4 = con.prepareStatement("INSERT INTO Transactions (user_id, recipient, amount) VALUES (?, ?, ?)");
                ps4.setInt(1, userId);
                ps4.setString(2, recipient);
                ps4.setDouble(3, amount);
                ps4.executeUpdate();

                con.commit();
                out.println("<div class='success'>Transfer successful!</div>");
            } else {
                out.println("<div class='error'>Insufficient balance or invalid recipient.</div>");
            }
        } catch (Exception e) {
            out.println("<div class='error'>Error: " + e.getMessage() + "</div>");
        }
    }
%>
</body>
</html>
