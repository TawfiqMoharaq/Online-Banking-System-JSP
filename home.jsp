<%@ page session="true" %>
<html>
<head>
    <title>Home</title>
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
        .container {
            padding: 20px;
            margin: 20px auto;
            max-width: 900px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to Online Banking</h1>
    </header>
    <nav>
        <a href="transfer.jsp">Transfer Money</a>
        <a href="history.jsp">Transaction History</a>
        <a href="balance.jsp">View Balance</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <div class="container">
        <h2>Our Services</h2>
        <p>Welcome to your banking dashboard. Select a service from the menu above.</p>
    </div>
</body>
</html>
