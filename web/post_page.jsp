<%-- 
    Document   : post_page
    Created on : May 13, 2026, 4:43:46 AM
    Author     : khali
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="FeedServlet.do">← Back to Feed</a>

        <div class="full-post-container">
            <h1>${selectedPost.artist.user.username}</h1>
            <p style="font-size: 1.5em;">${selectedPost.content}</p>
            <p>Likes: ${selectedPost.likes}</p>

            <hr>
            <h3>Discussion</h3>
            <div class="comments-list">
                <c:forEach var="comm" items="${selectedPost.comments}">
                    <div class="comment">
                        <strong>${comm.author.username}:</strong> ${comm.text}
                    </div>
                </c:forEach>
            </div>

            <form action="CommentServlet.do" method="POST">
                <input type="hidden" name="postId" value="${selectedPost.id}">
                <input type="hidden" name="source" value="singlePost">
                <textarea name="commentText" placeholder="Add to the conversation..." required></textarea>
                <br>
                <button type="submit">Post Comment</button>
            </form>
        </div>
    </body>
</html>
