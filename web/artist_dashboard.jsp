<%-- 
    Document   : artist_dashboard
    Updated on : 13 May 2026
    Author     : VUKONA
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="za.ac.the.plugin.wall.model.entity.ArtistProfile"%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artist Dashboard | The Plugin Wall</title>
        <link rel="stylesheet" type="text/css" href="css.css">
    </head>
    <body>
        <%
            // Security check
            User user = (User) session.getAttribute("user"); 
            ArtistProfile artist = (ArtistProfile) session.getAttribute("userA");

            if (user == null || artist == null) {
                response.sendRedirect("sign_in.jsp");
                return;
            }
        %>

        <div class="dashboard-header">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h1>Producer Dashboard</h1>
                    <p>Welcome back, @<%= user.getUsername() %> | <%= user.getLocation() %></p>
                </div>
                <div style="display: flex; gap: 10px;">
                    <a href="create_post.jsp" class="btn-save" style="text-decoration: none;">+ New Post</a>
                    <a href="edit_profile.jsp" class="btn-save" style="text-decoration: none; background-color: #333; border: 1px solid #4CAF50;">Edit Profile</a>
                </div>
            </div>
        </div>

        <div class="stats-row">
            <div class="card">
                <h3>${posts.size()}</h3>
                <p>Total Posts</p>
            </div>
            <div class="card">
                <h3>${totalLikes}</h3>
                <p>Total Likes</p>
            </div>
            <div class="card">
                <h3>${totalComments}</h3>
                <p>Total Comments</p>
            </div>
        </div>

        <%-- MAIN CENTER CONTENT: The Post Wall --%>
        <div style="max-width: 900px; margin: 40px auto;">
            <div class="profile-links">
                <h2 style="text-align: center; color: #4CAF50; margin-bottom: 30px;">Your Wall Feed</h2>
                
                <% if(request.getParameter("status") != null) { %>
                    <p style="text-align: center; color: #4CAF50; font-weight: bold;">✔ Action Completed Successfully</p>
                <% } %>

                <table>
                    <thead>
                        <tr>
                            <th>Content</th>
                            <th style="text-align: center;">Engagement</th>
                            <th style="text-align: right;">Management</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${posts}">
                            <tr>
                                <td style="max-width: 400px; line-height: 1.4;">
                                    <strong>${p.content}</strong><br>
                                    <small style="color: #888;">Posted: ${p.creationDate}</small>
                                </td>
                                <td style="text-align: center; white-space: nowrap;">
                                    ❤️ ${p.likes} | 💬 ${p.comments.size()}
                                </td>
                                <td style="text-align: right;">
                                    <a href="PostPageServlet.do?postId=${p.id}" style="margin-right: 10px;">View</a>
                                    <a href="DeletePostServlet.do?postId=${p.id}" 
                                       style="color: #ff4444;" 
                                       onclick="return confirm('Are you sure you want to delete this post?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty posts}">
                            <tr>
                                <td colspan="3" style="text-align: center; padding: 40px; color: #888;">
                                    You haven't posted anything to the wall yet.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="text-align: center; margin-bottom: 50px;">
            <a href="LogoutServlet.do" class="btn-logout">Secure Logout</a>
        </div>
    </body>
</html>