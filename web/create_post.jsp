<%-- 
    Document   : create_post
    Updated on : 13 May 2026
    Author     : khali / VUKONA
--%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Post | The Plugin Wall</title>
        <%-- Link to your NetBeans-compatible CSS --%>
        <link rel="stylesheet" type="text/css" href="css.css">
    </head>
    <body>
        <%
            // Security check: Ensure the session is active
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("sign_in.jsp");
                return;
            }
        %>

        <div class="dashboard-header">
            <h1>Share with the Wall</h1>
            <p>Post an update as <strong>@<%= user.getUsername() %></strong></p>
        </div>

        <div class="profile-links">
            <h3>New Update</h3>
            <form action="PostServlet.do" method="POST">
                <%-- Hidden field to pass the User ID to the Servlet --%>
                <input type="hidden" name="userId" value="<%= user.getId() %>">
                
                <label for="content">What's happening in the studio?</label>
                <textarea id="content" name="content" rows="6" placeholder="Share a plugin tip, a new beat, or studio news..." required></textarea>
                
                <div style="margin-top: 20px;">
                    <input type="submit" value="Post to the Wall" class="btn-save">
                    <a href="artist_dashboard.jsp" style="margin-left: 15px; color: #ff4444;">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>