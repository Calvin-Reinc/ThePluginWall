<%-- 
    Document   : sign_up
    Created on : 11 May 2026, 3:35:07 PM
    Author     : VUKONA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Plugin Wall - Sign Up Page</title>
    </head>
    <body>
        <h1>Sign Up!</h1>
        <p>
            Please provide the following details to sign up
        </p>
        <form action="UserServlet.do" method="POST">
            <table border="1">
                
                    <tr>
                        <td>First Name *</td>
                        <td><input type="text" name="fname" required></td>
                    </tr>
                    <tr>
                        <td>Last Name *</td>
                        <td><input type="text" name="lname" required></td>
                    </tr>
                    <tr>
                        <td>User Name *</td>
                        <td><input type="text" name="username" required></td>
                    </tr>
                    <tr>
                        <td>Email *</td>
                        <td><input type="email" name="email" required></td>
                    </tr>
                    <tr>
                        <td>Date of Birth *</td>
                        <td><input type="date" name="dob" required></td>
                    </tr>
                    <tr>
                        <td>Id Number *</td>
                        <td><input type="text" name="id" required></td>
                    </tr>
                    <tr>
                        <td>Bio  *</td>
                        <td><textarea name="bio" placeholder="Tell us about yourself" > </textarea></td>
                    </tr>
                    <tr>
                        <td>Location *</td>
                        <td><input type="text" name="location"></td>
                    </tr>
                    <tr>
                        <td>Password *</td>
                        <td><input type="password" name="password" required></td>
                    </tr>
                    <tr>
                        <td>Confirmation Password *</td>
                        <td><input type="password" name="password" required></td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Sign Up"></td>
                    </tr>

            </table>

            
        </form>
    </body>
</html>
