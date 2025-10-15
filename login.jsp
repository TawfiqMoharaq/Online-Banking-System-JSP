<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<html>
<head>
    <title>Login</title>
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
        form input[type="text"], form input[type="password"] {
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
        <h1>Online Banking System</h1>
    </header>
    <form action="login.jsp" method="post">
        <h2>Login</h2>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Login">
    </form>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBanking", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("user_id", rs.getInt("user_id"));
                response.sendRedirect("home.jsp");
            } else {
                out.println("<div class='error'>Invalid username or password!</div>");
            }
        } catch (Exception e) {
            out.println("<div class='error'>Error: " + e.getMessage() + "</div>");
        }
    }
%>
</body>
</html>
