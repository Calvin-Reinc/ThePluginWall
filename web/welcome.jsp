<%-- 
    Document   : welcome
    Created on : 11 May 2026, 4:33:24 PM
    Author     : VUKONA
--%>

<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome - The Plugin Wall</title>
        <style>
            body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #121212; color: white; padding: 50px; }
            .profile-card { background-color: #1e1e1e; border: 1px solid #333; padding: 20px; border-radius: 10px; max-width: 500px; margin: auto; }
            .artist-name { color: #4CAF50; font-size: 24px; margin-bottom: 10px; }
            .meta { color: #888; font-size: 14px; }
            .bio { margin-top: 20px; font-style: italic; border-left: 3px solid #4CAF50; padding-left: 10px; }
            .btn { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px; }
        </style>
    </head>
    <body>
        <%
            // 1. Retrieve the object we attached in the UserServlet
            User artist = (User) request.getAttribute("registeredUser");
            
            if (artist != null) {
        %>
        <div class="profile-card">
            <h1>Welcome to the Wall!</h1>
            <p class="meta">You have successfully registered as:</p>
            <div class="artist-name">@<%= artist.getUsername() %></div>
            <p class="meta">Member since: <%= artist.getCreation_date()%></p>
            <p><strong>Full Name:</strong> <%= artist.getFirstName() %> <%= artist.getLastName() %></p>
            <p><strong>Location:</strong> <%= artist.getLocation() %></p>
            
            <div class="bio">
                "<%= artist.getBio() %>"
            </div>

            <p class="meta">Your profile is now pending upload to the cloud.</p>
            
            <a href="index.jsp" class="btn">View Global Board</a>
            <p>test</p>
        </div>
        <%
            } else {
                // If someone tries to access this page directly without signing up
                out.println("<h2>Access Denied: Please sign up first.</h2>");
                out.println("<a href='sign_up.jsp'>Go to Sign Up</a>");
            }
        %>
    </body>
</html>