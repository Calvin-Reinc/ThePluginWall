<%-- 
    Document   : viewer_feed
    Updated on : 13 May 2026
    Author     : VUKONA
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="za.ac.the.plugin.wall.model.entity.ArtistProfile"%>
<%@page import="za.ac.the.plugin.wall.model.entity.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Community Feed | The Plugin Wall</title>
        <link rel="stylesheet" type="text/css" href="css.css">
    </head>
    <body>
        <%
            // Security check: Ensure we know who is viewing
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("sign_in.jsp");
                return;
            }
        %>

        <div class="dashboard-header">
            <h1>The Plugin Wall Feed</h1>
            <p>Welcome back, <strong>@<%= user.getFirstName() + " " + user.getLastName() %></strong>! Discover what's new in the studio.</p>
            <div style="margin-top: 10px;">
                <a href="index.jsp" style="color: #4CAF50; font-weight: bold;">← Back to Global Board</a>
            </div>
        </div>

        <%-- Debug message kept as requested but styled slightly --%>
        <div style="text-align: center; color: #888; font-size: 12px; margin-bottom: 20px;">
            ${posts != null ? "✔ Feed Synchronization Active" : "✖ Error: Feed Data NULL"}
        </div>

        <div style="max-width: 800px; margin: auto;">
            <c:forEach var="post" items="${posts}">
                <div class="profile-links" style="margin-bottom: 30px;">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <h3 style="margin: 0; color: #4CAF50;">@${post.artist.user.username}</h3>
                        <small style="color: #888;">${post.creationDate}</small>
                    </div>
                    
                    <p style="font-size: 1.1rem; margin: 20px 0;">${post.content}</p>

                    <hr style="border: 0; border-top: 1px solid #333; margin: 15px 0;">

                    <%-- Interaction Row --%>
                    <div style="display: flex; align-items: center; gap: 20px;">
                        <span style="font-weight: bold;">👍 ${post.likes} Likes</span>
                        
                        <form action="LikePostServlet.do" method="POST" style="margin: 0;">
                            <input type="hidden" name="postId" value="${post.id}"> 
                            <button type="submit" class="btn-save" style="padding: 5px 15px; font-size: 14px;">Like</button>
                        </form>
                        
                        <a href="PostPageServlet.do?postId=${post.id}" style="font-size: 14px;">View Full Thread</a>
                    </div>

                    <div style="background: rgba(0,0,0,0.2); padding: 15px; border-radius: 8px; margin-top: 20px;">
                        <h4 style="margin-top: 0; font-size: 0.9rem; color: #b3b3b3;">Comments</h4>
                        
                        <c:forEach var="comment" items="${post.comments}">
                            <div style="border-bottom: 1px solid #333; padding: 8px 0; font-size: 14px;">
                                <strong style="color: #4CAF50;">${comment.author.username}:</strong> ${comment.text}
                            </div>
                        </c:forEach>

                        <%-- Reply Form --%>
                        <form action="CommentServlet.do" method="POST" style="margin-top: 15px; display: flex; gap: 10px;">
                            <input type="hidden" name="postId" value="${post.id}">
                            <input type="hidden" name="source" value="feed">
                            <input type="text" name="commentText" placeholder="Write a comment..." required 
                                   style="flex: 1; margin: 0; padding: 8px;">
                            <input type="submit" value="Reply" class="btn-save" style="padding: 8px 15px; margin: 0;">
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div style="text-align: center; margin-bottom: 50px;">
            <a href="LogoutServlet.do" class="btn-logout">Logout</a>
        </div>
    </body>
</html>