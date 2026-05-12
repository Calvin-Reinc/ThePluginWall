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
                        <td>Location *</td>
                        <td><input type="text" name="location"></td>
                    </tr>
                    <tr>
                        <td>Roles: </td>
                        <td>
                            <select name="type">
                                <option value="user">Default User</option>
                                <option value="artist">Artist</option>
                            </select>
                        </td>
                        
                    </tr>
                    <tr>
                        <td>Password *</td>
                        <!-- Added id="password" -->
                        <td><input type="password" id="password" name="password" required></td>
                    </tr>
                    <tr>
                        <td>Confirmation Password *</td>
                        <td>
                            <!-- Added id="confirmPassword" and onkeyup event -->
                            <input type="password" id="confirmPassword" name="confirmPassword" onkeyup="checkPasswordMatch();" required>
                            <br>
                            <span id="message" style="font-size: 12px;"></span>
                        </td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Sign Up"></td>
                    </tr>
                    

            </table>

            
        </form>
        <script>
    function checkPasswordMatch() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var message = document.getElementById("message");
        var submitBtn = document.querySelector('input[type="submit"]');

        if (password === "" || confirmPassword === "") {
            message.innerHTML = "";
            return;
        }

        if (password === confirmPassword) {
            message.style.color = "green";
            message.innerHTML = "✔ Passwords match";
            submitBtn.disabled = false; // Enable the button
        } else {
            message.style.color = "red";
            message.innerHTML = "✖ Passwords do not match";
            submitBtn.disabled = true; // Disable the button to prevent submission
        }
    }
</script>
    </body>
</html>