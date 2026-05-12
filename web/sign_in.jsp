<%-- 
    Document   : sign_in
    Created on : 11 May 2026, 4:46:20 PM
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
        <h1>Sign In!</h1>
        <p>
            Please provide the details to sign in
        </p>
        <form action="LoginServlet.do" method="POST">
            <table border="1">
                
                    <tr>
                        <td>Username</td>
                        <td><input type="text" name="username" required></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="text" name="password" required></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Sign in"></td>
                    </tr>
                </tbody>
            </table>

            
            
        </form>
    </body>
</html>
