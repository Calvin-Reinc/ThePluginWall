<%-- 
    Document   : index
    Updated on : 13 May 2026
    Author     : VUKONA
--%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Plugin Wall | Home</title>
        <link rel="stylesheet" type="text/css" href="css.css">
    </head>
    <body>
        <%
            // Check if a user is already logged in for the dynamic header
            User user = (User) session.getAttribute("user");
        %>

        <div class="dashboard-header">
            <h1>The Plugin Wall</h1>
            <p>The ultimate hub for producers to share plugins, beats, and studio updates.</p>
            
            <div style="margin-top: 20px;">
                <% if (user != null) { %>
                    <span style="margin-right: 15px;">Welcome back, <strong>@<%= user.getUsername() %></strong></span>
                    <%-- Route to the correct dashboard based on role --%>
                    <a href="<%= user.getRole().equalsIgnoreCase("Artist") ? "artist_dashboard.jsp" : "viewer_feed.jsp" %>" class="btn-save" style="text-decoration: none;">Go to My Space</a>
                    <a href="LogoutServlet.do" style="margin-left: 15px; color: #ff4444;">Logout</a>
                <% } else { %>
                    <a href="sign_in.jsp" class="btn-save" style="text-decoration: none; margin-right: 10px;">Sign In</a>
                    <a href="sign_up.jsp" style="color: #4CAF50; font-weight: bold;">Join the Wall</a>
                <% } %>
            </div>
        </div>

        <div class="stats-row">
            <div class="card">
                <h3>Connect</h3>
                <p>Follow top producers from Gauteng and Limpopo.</p>
            </div>
            <div class="card">
                <h3>Discover</h3>
                <p>Find the latest plugins and VST tips.</p>
            </div>
            <div class="card">
                <h3>Share</h3>
                <p>Upload your updates to the Global Board.</p>
            </div>
        </div>

        <div class="profile-links" style="text-align: center; margin-top: 40px;">
            <h2>Explore the Community</h2>
            <p style="color: #b3b3b3;">Ready to see what others are posting?</p>
            <br>
            <a href="viewer_feed.jsp" class="btn-save" style="text-decoration: none; display: inline-block;">View Public Feed</a>
        </div>

        <footer style="margin-top: 50px; text-align: center; color: #555; font-size: 12px;">
            <p> 2026 The Plugin Wall | Moses / Khali Project</p>
        </div>
    </body>
</html>