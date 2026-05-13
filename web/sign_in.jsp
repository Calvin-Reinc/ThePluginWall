<%-- 
    Document   : sign_in
    Updated on : 13 May 2026
    Author     : VUKONA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In | The Plugin Wall</title>
        <%-- Link to your NetBeans-compatible CSS --%>
        <link rel="stylesheet" type="text/css" href="css.css">
    </head>
    <body>
        <div class="dashboard-header">
            <h1>Welcome Back!</h1>
            <p>Please provide your details to sign in to the Wall.</p>
        </div>

        <div class="profile-links" style="max-width: 400px; margin: auto;">
            <form action="LoginServlet.do" method="POST">
                <%-- Display error message if login fails --%>
                <% if(request.getParameter("error") != null) { %>
                    <p style="color: #ff4444; font-weight: bold;">Invalid Email or Password.</p>
                <% } %>

                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required placeholder="producer@example.com">

                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="••••••••">

                <div style="margin-top: 20px;">
                    <input type="submit" value="Sign In" class="btn-save" style="width: 100%;">
                </div>
            </form>
            
            <p style="margin-top: 20px; text-align: center; font-size: 0.9rem; color: #b3b3b3;">
                Don't have an account? <a href="sign_up.jsp">Join the Wall</a>
            </p>
        </div>
    </body>
</html>