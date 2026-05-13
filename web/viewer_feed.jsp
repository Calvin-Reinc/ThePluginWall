<%-- 
    Document   : viewer_feed
    Created on : 12 May 2026, 10:23:43 PM
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
        <title>Viewer Page</title>
    </head>
    <body>
        <h1>The Plugin Wall Feed(for users/all)</h1>
        ${posts != null ? "Posts object arrived" : "Posts object is NULL"}
        <c:forEach var="post" items="${posts}">
            <a href="PostPageServlet.do?postId=${post.id}">
            
                <h3>${post.artist.user.username} posted:</h3>
                <div class="post-card">
                <p>${p.content}</p>

                <c:if test="${not empty p.imageName}">
                    <div class="post-image">
                        <img src="ImageDisplayServlet?name=${p.imageName}" 
                             alt="Post Image" 
                        s     style="max-width: 100%; height: auto; border-radius: 4px; border: 1px solid #ddd;">
                    </div>
                </c:if>
                </div>
                <small>Posted on: ${post.creationDate}</small>

                <hr>
                <div class="like-section" style="margin-bottom: 15px;">
                    <span style="font-weight: bold; margin-right: 10px;">
                        👍 ${post.likes} Likes
                    </span>

                <form action="LikePostServlet.do" method="POST">
                    <input type="hidden" name="postId" value="${post.id}"> 
                    <button type="submit" style="cursor: pointer;">Like</button>
                </form>
                </div>
            </a>
                <hr>
                <h4>Comments</h4>
                <c:forEach var="comment" items="${post.comments}">
                    <div class="comment">
                        <strong>${comment.author.username}:</strong> ${comment.text}
                    </div>
                </c:forEach>

                <form action="CommentServlet.do" method="POST">
                    <input type="hidden" name="postId" value="${post.id}">
                    <input type="hidden" name="source" value="feed">
                    <input type="text" name="commentText" placeholder="Write a comment..." required>
                    <input type="submit" value="Reply">
                </form>
                
            
            
        </c:forEach>
    </body>
</html>
