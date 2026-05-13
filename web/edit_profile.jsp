<%-- 
    Document   : edit_profile
    Updated on : 13 May 2026
    Author     : VUKONA
--%>
<%@page import="za.ac.the.plugin.wall.model.entity.ArtistProfile"%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile | The Plugin Wall</title>
        <link rel="stylesheet" type="text/css" href="css.css">
    </head>
    <body>
        <%
            // Security & Data Retrieval
            User user = (User) session.getAttribute("user");
            ArtistProfile artist = (ArtistProfile) session.getAttribute("userA");

            if (user == null || artist == null) {
                response.sendRedirect("sign_in.jsp");
                return;
            }
        %>

        <div class="dashboard-header">
            <h1>Edit Artist Profile</h1>
            <p>Update your producer details and social presence on the Wall.</p>
        </div>

        <div class="profile-links" style="max-width: 700px; margin: auto;">
            <form action="UpdateArtistServlet.do" method="POST">
                
                <h3>Basic Information</h3>
                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                        <label>First Name</label>
                        <input type="text" name="fname" value="<%= user.getFirstName() %>" required>
                    </div>
                    <div style="flex: 1;">
                        <label>Last Name</label>
                        <input type="text" name="lname" value="<%= user.getLastName() %>" required>
                    </div>
                </div>

                <label>Username (Artist Name)</label>
                <input type="text" name="username" value="<%= user.getUsername() %>" required>

                <label>Location</label>
                <input type="text" name="location" value="<%= user.getLocation() %>">

                <hr style="border: 0; border-top: 1px solid #333; margin: 25px 0;">

                <h3>Music & Social Links</h3>
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
                       placeholder="https://youtube.com/user/...">

                <label>Artist Bio / Genre Info</label>
                <textarea name="bio" rows="6" placeholder="Tell the wall about your sound..."><%= (artist.getBio() != null) ? artist.getBio() : "" %></textarea>

                <div style="margin-top: 30px; display: flex; gap: 15px; align-items: center;">
                    <input type="submit" value="Save All Changes" class="btn-save">
                    <a href="artist_dashboard.jsp" style="color: #b3b3b3; text-decoration: none;">Cancel</a>
                </div>
            </form>

            <%-- DANGER ZONE: DELETE ACCOUNT --%>
            <div style="margin-top: 50px; border-top: 2px solid #ff4444; padding-top: 20px;">
                <h3 style="color: #ff4444;">Danger Zone</h3>
                <p style="color: #888; font-size: 0.85rem; margin-bottom: 20px;">
                    Once you delete your profile, there is no going back. All your posts and data will be wiped from the wall.
                </p>
                <a href="DeleteUserServlet.do" 
                   class="btn-logout" 
                   style="text-decoration: none; display: inline-block; background-color: #ff4444;"
                   onclick="return confirm('Are you absolutely sure? This will permanently delete your account and all associated data.');">
                   Delete My Profile Permanently
                </a>
            </div>
        </div>

        <div style="text-align: center; margin-top: 30px; padding-bottom: 50px;">
             <p style="color: #555; font-size: 0.9rem;">Internal User Reference: <%= user.getId() %></p>
        </div>
    </body>
</html>