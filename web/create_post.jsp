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
        <h3>Share an Update</h3>
        <form action="PostServlet.do" method="POST" enctype="multipart/form-data">
            <textarea name="content" rows="4" style="width: 100%; border-radius: 5px; padding: 10px;" placeholder="What's happening in the studio?"></textarea>
            <br>
            <input type="file" name="file" accept="image/*">
            <input type="submit" value="Post to the Feed" style="margin-top: 10px; padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
        </form>
    </body>
</html>
