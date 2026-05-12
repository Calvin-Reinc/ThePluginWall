<%-- 
    Document   : welcome
    Updated on : 12 May 2026
    Author     : VUKONA
--%>
<%@page import="za.ac.the.plugin.wall.model.entity.ArtistProfile"%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome - The Plugin Wall</title>
        <style>
            body { font-family: 'Segoe UI', sans-serif; background-color: #121212; color: white; padding: 50px; text-align: center; }
            .profile-card { background-color: #1e1e1e; border: 1px solid #4CAF50; padding: 30px; border-radius: 15px; max-width: 500px; margin: auto; box-shadow: 0 10px 20px rgba(0,0,0,0.5); }
            .artist-name { color: #4CAF50; font-size: 28px; font-weight: bold; margin: 15px 0; }
            .meta { color: #888; font-size: 14px; margin-bottom: 5px; }
            .info-text { margin: 10px 0; font-size: 16px; }
            .btn { display: inline-block; margin-top: 30px; padding: 12px 25px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px; transition: 0.3s; }
            .btn:hover { background-color: #45a049; }
        </style>
    </head>
    <body>
        <%
            // 1. Retrieve the User and ArtistProfile objects from the session 
            User user = (User) session.getAttribute("user");
            ArtistProfile artistProfile = (ArtistProfile) session.getAttribute("userA");
            
            if (user != null) {
        %>
        <div class="profile-card">
            <h1 style="margin-top:0;">Welcome to the Wall!</h1>
            <p class="meta">Account Type: <strong><%= user.getRole() %></strong></p> [cite: 88]
            
            <div class="artist-name">@<%= user.getUsername() %></div> [cite: 88]
            
            <div class="info-text">
                <p><strong>Full Name:</strong> <%= user.getFirstName() %> <%= user.getLastName() %></p> [cite: 89]
                <p><strong>Location:</strong> <%= user.getLocation() %></p> [cite: 89]
                <p class="meta">Member since: <%= user.getCreation_date() %></p> [cite: 88]
            </div>

            <p class="meta" style="margin-top: 20px;">
                Your profile is now live in the local database.
            </p>
            
            <%-- Direct the user to their specific dashboard based on role --%>
            <% if ("Artist".equalsIgnoreCase(user.getRole())) { %>
                <a href="artist_dashboard.jsp" class="btn">Go to Dashboard</a>
            <% } else { %>
                <a href="viewer_feed.jsp" class="btn">View My Feed</a>
            <% } %>
        </div>
        <%
            } else {
                // Security: Redirect to sign up if session is empty [cite: 91, 92]
                response.sendRedirect("sign_up.jsp");
            }
        %>
    </body>
</html>