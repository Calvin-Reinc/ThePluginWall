<%-- 
    Document   : create_post
    Created on : May 12, 2026, 10:51:40 AM
    Author     : khali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>create post Page</title>
    </head>
    <body>
        <h3>Share an Update</h3>
        <form action="PostServlet.do" method="POST">
            <textarea name="content" rows="4" style="width: 100%; border-radius: 5px; padding: 10px;" placeholder="What's happening in the studio?"></textarea>
            <br>
            <input type="submit" value="Post to the Wall" style="margin-top: 10px; padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
        </form>
    </body>
</html>
