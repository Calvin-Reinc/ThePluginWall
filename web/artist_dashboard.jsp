<%-- 
    Document   : artist_dashboard
    Created on : 12 May 2026, 10:17:18 PM
    Author     : VUKONA
--%>

<%@page import="za.ac.the.plugin.wall.model.entity.ArtistProfile"%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artist Dashboard Page</title>
    </head>
    <body>
        <h1>Artist Dashboard World!</h1>
        <%
            // Security check: ensure the session contains the logged-in artist
            User user = (User) session.getAttribute("user"); 
            ArtistProfile artist = (ArtistProfile) session.getAttribute("userA");

            if (user == null || artist == null) {
                response.sendRedirect("sign_in.jsp");
                return;
            }
        %>
        <div class="dashboard-header">
            <h1>Welcome, Producer <%= user.getFirstName() %>!</h1>
            <p>Location: <%= user.getLocation() %></p> 
        </div>
        <section class="profile-links" style="margin-top: 30px; padding: 20px; background: #f4f4f4; border-radius: 8px;">
            <h3>Manage Your Wall Presence</h3>
            
            <%-- Display success message if redirected after update --%>
            <% if(request.getParameter("status") != null) { %>
                <p style="color: green;">Profile updated successfully!</p>
            <% } %>
            <br>
            <a href="create_post.jsp">Create Post</a>
            <br>
            <form action="UpdateArtistServlet.do" method="POST">
                <table border="0" cellpadding="10">
                    <tr>
                        <td><strong>Spotify URL:</strong></td>
                        <td>
                            <input type="url" name="spotify" style="width: 300px;"
                                   value="<%= (artist.getSpotifyUrl() != null) ? artist.getSpotifyUrl() : "" %>" 
                                   placeholder="https://open.spotify.com/artist/...">
                        </td>
                    </tr>
                    <tr>
                        <td><strong>SoundCloud URL:</strong></td>
                        <td>
                            <input type="url" name="soundcloud" style="width: 300px;"
                                   value="<%= (artist.getSoundCloudUrl() != null) ? artist.getSoundCloudUrl() : "" %>" 
                                   placeholder="https://soundcloud.com/...">
                        </td>
                    </tr>
                    <tr>
                        <td><strong>YouTube URL:</strong></td>
                        <td>
                            <input type="url" name="youtube" style="width: 300px;"
                                   value="<%= (artist.getYoutubeUrl() != null) ? artist.getYoutubeUrl() : "" %>" 
                                   placeholder="https://youtube.com/...">
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Artist Bio / Genre:</strong></td>
                        <td>
                            <textarea name="bio" rows="4" style="width: 300px;"><%= (artist.getBio() != null) ? artist.getBio() : "" %></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" value="Save Changes" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;">
                        </td>
                    </tr>
                </table>
            </form>
        </section>

        <hr>
        <p><a href="LogoutServlet.do">Secure Logout</a></p>
        
        <div class="dashboard-header">
        <h2>Welcome back, ${user.username}!</h2>
    
        <div class="stats-row" style="display: flex; gap: 20px; margin-bottom: 30px;">
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
        </div>

        <hr>

        <h3>Your Recent Activity</h3>
        <table border="1" style="width:100%; text-align: left; border-collapse: collapse;">
            <tr style="background-color: #f2f2f2;">
                <th>Post Content</th>
                <th>Engagement</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="p" items="${posts}">
                <tr>
                    <td>${p.content}</td>
                    <td>❤️ ${p.likes} | 💬 ${p.comments.size()}</td>
                    <td>
                        <a href="PostPageServlet.do?postId=${p.id}">View</a> | 

                        <a href="DeletePostServlet.do?postId=${p.id}" 
                           style="color: red;" 
                           onclick="return confirm('Delete this post?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        
        
    </body>
</html>
