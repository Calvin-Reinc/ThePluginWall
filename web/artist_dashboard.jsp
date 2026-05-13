<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="za.ac.the.plugin.wall.model.entity.ArtistProfile"%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artist Dashboard Page</title>
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
            <h1>Producer Dashboard</h1>
            <p>Welcome back, @<%= user.getUsername() %></p>
            <p>Location: <%= user.getLocation() %></p> 
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

        <div class="profile-links">
            <h2>Manage Your Wall Presence</h2>
            
            <% if(request.getParameter("status") != null) { %>
                <p style="color: #4CAF50;">Profile updated successfully!</p>
            <% } %>

            <form action="UpdateArtistServlet.do" method="POST">
                <label>Spotify URL</label>
                <input type="url" name="spotify" 
                       value="<%= (artist.getSpotifyUrl() != null) ? artist.getSpotifyUrl() : "" %>" 
                       placeholder="http://spotify.com/artist/...">

                <label>SoundCloud URL</label>
                <input type="url" name="soundcloud" 
                       value="<%= (artist.getSoundCloudUrl() != null) ? artist.getSoundCloudUrl() : "" %>" 
                       placeholder="https://soundcloud.com/...">

                <label>YouTube URL</label>
                <input type="url" name="youtube" 
                       value="<%= (artist.getYoutubeUrl() != null) ? artist.getYoutubeUrl() : "" %>" 
                       placeholder="https://youtube.com/...">

                <label>Artist Bio / Genre</label>
                <textarea name="bio" rows="4"><%= (artist.getBio() != null) ? artist.getBio() : "" %></textarea>

                <input type="submit" value="Save Changes" class="btn-save">
            </form>
            
            <div style="margin-top: 20px;">
                <a href="create_post.jsp" class="btn-save" style="text-decoration: none; display: inline-block;">+ Create New Post</a>
            </div>
        </div>

        <div style="margin-top: 40px;">
            <h3>Your Recent Activity</h3>
            <table>
                <thead>
                    <tr>
                        <th>Post Content</th>
                        <th>Engagement</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${posts}">
                        <tr>
                            <td>${p.content}</td>
                            <td>❤️ ${p.likes} | 💬 ${p.comments.size()}</td>
                            <td>
                                <a href="PostPageServlet.do?postId=${p.id}">View</a> | 
                                <a href="DeletePostServlet.do?postId=${p.id}" 
                                   style="color: #ff4444;" 
                                   onclick="return confirm('Delete this post?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <a href="LogoutServlet.do" class="btn-logout">Secure Logout</a>
    </body>
</html>